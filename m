Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3382FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFD520664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYyKMLTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFD520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbeKAInP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbeKAIHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9468C20840;
        Wed, 31 Oct 2018 23:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027259;
        bh=xabz9EZSl4Bi8I4yTd1ERkZFSI1yeG7rjxrQv/i/IeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYyKMLTjaq2Lp+UzoofZWQlCaKhXc8AkovPzYGLeBHrdP9Iy4yyZJUbzXJykSVq8f
         Gh0/haEaqBvBUbs9mOK44uXQlSXbFDN09T60UL+fsjb5LyBcPc4T1jF1cvr2tTLMs+
         E2mzCGs435cxY7xSkhPIe8rE374cQPVbbqurGoHw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Casey Schaufler <casey.schaufler@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 130/146] Smack: ptrace capability use fixes
Date:   Wed, 31 Oct 2018 19:05:25 -0400
Message-Id: <20181031230541.28822-130-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey.schaufler@intel.com>

[ Upstream commit dcb569cf6ac99ca899b8109c128b6ae52477a015 ]

This fixes a pair of problems in the Smack ptrace checks
related to checking capabilities. In both cases, as reported
by Lukasz Pawelczyk, the raw capability calls are used rather
than the Smack wrapper that check addition restrictions.
In one case, as reported by Jann Horn, the wrong task is being
checked for capabilities.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 340fc30ad85d..70d3066e69fe 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -421,6 +421,7 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
 	struct smk_audit_info ad, *saip = NULL;
 	struct task_smack *tsp;
 	struct smack_known *tracer_known;
+	const struct cred *tracercred;
 
 	if ((mode & PTRACE_MODE_NOAUDIT) == 0) {
 		smk_ad_init(&ad, func, LSM_AUDIT_DATA_TASK);
@@ -429,7 +430,8 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
 	}
 
 	rcu_read_lock();
-	tsp = __task_cred(tracer)->security;
+	tracercred = __task_cred(tracer);
+	tsp = tracercred->security;
 	tracer_known = smk_of_task(tsp);
 
 	if ((mode & PTRACE_MODE_ATTACH) &&
@@ -439,7 +441,7 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
 			rc = 0;
 		else if (smack_ptrace_rule == SMACK_PTRACE_DRACONIAN)
 			rc = -EACCES;
-		else if (capable(CAP_SYS_PTRACE))
+		else if (smack_privileged_cred(CAP_SYS_PTRACE, tracercred))
 			rc = 0;
 		else
 			rc = -EACCES;
@@ -1841,6 +1843,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 {
 	struct smack_known *skp;
 	struct smack_known *tkp = smk_of_task(tsk->cred->security);
+	const struct cred *tcred;
 	struct file *file;
 	int rc;
 	struct smk_audit_info ad;
@@ -1854,8 +1857,12 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	skp = file->f_security;
 	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
 	rc = smk_bu_note("sigiotask", skp, tkp, MAY_DELIVER, rc);
-	if (rc != 0 && has_capability(tsk, CAP_MAC_OVERRIDE))
+
+	rcu_read_lock();
+	tcred = __task_cred(tsk);
+	if (rc != 0 && smack_privileged_cred(CAP_MAC_OVERRIDE, tcred))
 		rc = 0;
+	rcu_read_unlock();
 
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_TASK);
 	smk_ad_setfield_u_tsk(&ad, tsk);
-- 
2.17.1

