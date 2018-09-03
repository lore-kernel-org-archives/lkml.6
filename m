Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF17C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E54020645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E54020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbeIDBHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:07:34 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50376 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbeIDBHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:07:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwvjA-00064M-2z; Mon, 03 Sep 2018 14:45:40 -0600
Received: from [105.225.206.69] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwvj9-0008G7-0H; Mon, 03 Sep 2018 14:45:39 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Sep 2018 22:44:28 +0200
Message-Id: <20180903204430.25473-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87musyl3fa.fsf@xmission.com>
References: <87musyl3fa.fsf@xmission.com>
X-XM-SPF: eid=1fwvj9-0008G7-0H;;;mid=<20180903204430.25473-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.225.206.69;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/AwOH91sZnV912KNIa6w1XW/T+j5v8eKk=
X-SA-Exim-Connect-IP: 105.225.206.69
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 08/10] signal: Never allocate siginfo for SIGKILL or SIGSTOP
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SIGKILL and SIGSTOP signals are never delivered to userspace so
queued siginfo for these signals can never be observed.  Therefore
remove the chance of failure by never even attempting to allocate
siginfo in those cases.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 20931a892ace..d7d1adf735f4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1054,10 +1054,11 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 
 	result = TRACE_SIGNAL_DELIVERED;
 	/*
-	 * fast-pathed signals for kernel-internal things like SIGSTOP
-	 * or SIGKILL.
+	 * Skip useless siginfo allocation for SIGKILL SIGSTOP,
+	 * and kernel threads.
 	 */
-	if ((info == SEND_SIG_FORCED) || (t->flags & PF_KTHREAD))
+	if ((info == SEND_SIG_FORCED) ||
+	    sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
 		goto out_set;
 
 	/*
-- 
2.17.1

