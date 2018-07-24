Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1401AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A4E20779
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A4E20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbeGXEcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:32:36 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41966 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388130AbeGXEbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:31:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnz3-00032p-RB; Mon, 23 Jul 2018 21:27:33 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxb-0008AK-7S; Mon, 23 Jul 2018 21:26:03 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:15 -0500
Message-Id: <20180724032419.20231-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxb-0008AK-7S;;;mid=<20180724032419.20231-16-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+gVvQKuYty13MjHAmMSqbkaV3j2WuD1hA=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 16/20] fork: Move and describe why the code examines PIDNS_ADDING
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally this would be something that would be handled by handling
signals that are sent to a group of processes but in this case the
forking process is not a member of the group being signaled.  Thus
special code is needed to prevent a race with pid namespaces exiting,
and fork adding new processes within them.

Move this test up before the signal restart just in case signals are
also pending.  Fatal conditions should take presedence over restarts.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/fork.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cc5be0d01ce6..b9c54318a292 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1922,6 +1922,12 @@ static __latent_entropy struct task_struct *copy_process(
 
 	rseq_fork(p, clone_flags);
 
+	/* Don't start children in a dying pid namespace */
+	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
+		retval = -ENOMEM;
+		goto bad_fork_cancel_cgroup;
+	}
+
 	/*
 	 * Process group and session signals need to be delivered to just the
 	 * parent before the fork or both the parent and the child after the
@@ -1935,10 +1941,7 @@ static __latent_entropy struct task_struct *copy_process(
 		retval = -ERESTARTNOINTR;
 		goto bad_fork_cancel_cgroup;
 	}
-	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
-		retval = -ENOMEM;
-		goto bad_fork_cancel_cgroup;
-	}
+
 
 	init_task_pid_links(p);
 	if (likely(p->pid)) {
-- 
2.17.1

