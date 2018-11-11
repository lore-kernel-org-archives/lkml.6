Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B307EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3752084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs4fTyoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3752084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbeKLIUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733202AbeKLIU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:28 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C4422443;
        Sun, 11 Nov 2018 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975431;
        bh=d5SFOJNsqQ/+D1i9p9j2X/SXC3os1IjwiEUtumiHCFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hs4fTyoKgfGIwmERExsGZOtOQdp4h9Jkc8aI+6NC8n/IQH0DXwOuXa7t7uRBbR92U
         RG1L6dpl0JCAvnRvTpFNvIJcri9xTm6BuUwGVlbigPdrm5dH17qiAKGe2rJtgUL2CE
         60y68zhzygm4PVTj5UUP93NAl8WiusTFRg4bOQho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 173/350] Smack: ptrace capability use fixes
Date:   Sun, 11 Nov 2018 14:20:37 -0800
Message-Id: <20181111221715.270351368@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/smack/smack_lsm.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -420,6 +420,7 @@ static int smk_ptrace_rule_check(struct
 	struct smk_audit_info ad, *saip = NULL;
 	struct task_smack *tsp;
 	struct smack_known *tracer_known;
+	const struct cred *tracercred;
 
 	if ((mode & PTRACE_MODE_NOAUDIT) == 0) {
 		smk_ad_init(&ad, func, LSM_AUDIT_DATA_TASK);
@@ -428,7 +429,8 @@ static int smk_ptrace_rule_check(struct
 	}
 
 	rcu_read_lock();
-	tsp = __task_cred(tracer)->security;
+	tracercred = __task_cred(tracer);
+	tsp = tracercred->security;
 	tracer_known = smk_of_task(tsp);
 
 	if ((mode & PTRACE_MODE_ATTACH) &&
@@ -438,7 +440,7 @@ static int smk_ptrace_rule_check(struct
 			rc = 0;
 		else if (smack_ptrace_rule == SMACK_PTRACE_DRACONIAN)
 			rc = -EACCES;
-		else if (capable(CAP_SYS_PTRACE))
+		else if (smack_privileged_cred(CAP_SYS_PTRACE, tracercred))
 			rc = 0;
 		else
 			rc = -EACCES;
@@ -1840,6 +1842,7 @@ static int smack_file_send_sigiotask(str
 {
 	struct smack_known *skp;
 	struct smack_known *tkp = smk_of_task(tsk->cred->security);
+	const struct cred *tcred;
 	struct file *file;
 	int rc;
 	struct smk_audit_info ad;
@@ -1853,8 +1856,12 @@ static int smack_file_send_sigiotask(str
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


