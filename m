Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71BEC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4D921C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4D921C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeHIJUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:20:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43850 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIJUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:20:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnesy-0008Iu-3p; Thu, 09 Aug 2018 00:57:28 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnesi-00054s-O5; Thu, 09 Aug 2018 00:57:27 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu,  9 Aug 2018 01:56:01 -0500
Message-Id: <20180809065605.32345-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87wot0yqsx.fsf_-_@xmission.com>
References: <87wot0yqsx.fsf_-_@xmission.com>
X-XM-SPF: eid=1fnesi-00054s-O5;;;mid=<20180809065605.32345-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1878QsZtDqGDNGqZNTE9hguniNML2oWnEA=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v5 2/6] fork: Unconditionally exit if a fatal signal is pending
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In practice this does not change anything as testing for fatal_signal_pending
and exiting for with an error code duplicates the work of the next clause
which recalculates pending signals and then exits fork if any are pending.
In both cases the pending signal will trigger the slow path when existing
to userspace, and the fatal signal will cause do_exit to be called.

The advantage of making this a separate test is that it makes it clear
processing the fatal signal will terminate the fork, and it allows the
rest of the signal logic to be updated without fear that this important
case will be lost.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/fork.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index b9c54318a292..22d4cdb9a7ca 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1928,6 +1928,12 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 	}
 
+	/* Let kill terminate clone/fork in the middle */
+	if (fatal_signal_pending(current)) {
+		retval = -EINTR;
+		goto bad_fork_cancel_cgroup;
+	}
+
 	/*
 	 * Process group and session signals need to be delivered to just the
 	 * parent before the fork or both the parent and the child after the
-- 
2.17.1

