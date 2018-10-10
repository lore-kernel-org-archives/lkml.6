Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373BC2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-iscsi.org header.i=@linux-iscsi.org header.b="Bg+HkRiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373BC2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-iscsi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJJKv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:51:28 -0400
Received: from mail.linux-iscsi.org ([67.23.28.174]:53475 "EHLO
        linux-iscsi.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeJJKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:51:18 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 06:51:17 EDT
Received: from linux-iscsi.org (localhost [127.0.0.1])
        by linux-iscsi.org (Postfix) with ESMTP id C213840AC0;
        Wed, 10 Oct 2018 03:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=linux-iscsi.org;
        s=default.private; t=1539141798; bh=9KFzkNgbj5gmfIPZzxxtkKAmcouZOh4
        GheAoMqHu/Uw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
         References; b=Bg+HkRiNy4ngWO2JVVH+pElIj1lZ8KZ2CCBEH4VeB/lg/6UL66U3
        tJufVDYanP90/mcGXJgCQ3gKBNLs0pl+taJ5m/sOsljKGSBT/lGm6a14FyXduU2jgIB
        MP2kASpLUxon3Coi7eQVsxvXzRdTjKOenB71nOrT1cVzC2G2oiXE=
From:   "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To:     target-devel <target-devel@vger.kernel.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/2] sched/wait: Add wait_event_lock_irq_timeout for TASK_UNINTERRUPTIBLE usage
Date:   Wed, 10 Oct 2018 03:23:09 +0000
Message-Id: <1539141790-13557-2-git-send-email-nab@linux-iscsi.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

Short of reverting commit 00d909a107 for v4.19, target-core needs a
wait_event_t marco can be executed using TASK_UNINTERRUPTIBLE to
function correctly with existing fabric drivers that expect to run
with signals pending during session shutdown and active se_cmd I/O
quiesce.

The most notable is iscsi-target/iser-target, while ibmvscsi_tgt invokes
session shutdown logic from userspace via configfs attribute that could
also potentially have signals pending.

So go ahead and introduce wait_event_lock_irq_timeout() to achieve this,
and update + rename __wait_event_lock_irq_timeout() to make it accept
'state' as a parameter.

Fixes: 00d909a107 ("scsi: target: Make the session shutdown code also wait for commands that are being aborted")
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 include/linux/wait.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index d9f131e..ed7c122 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1052,10 +1052,9 @@ void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 	__ret;									\
 })
 
-#define __wait_event_interruptible_lock_irq_timeout(wq_head, condition,		\
-						    lock, timeout)		\
+#define __wait_event_lock_irq_timeout(wq_head, condition, lock, timeout, state)	\
 	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
-		      TASK_INTERRUPTIBLE, 0, timeout,				\
+		      state, 0, timeout,					\
 		      spin_unlock_irq(&lock);					\
 		      __ret = schedule_timeout(__ret);				\
 		      spin_lock_irq(&lock));
@@ -1089,8 +1088,19 @@ void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 ({										\
 	long __ret = timeout;							\
 	if (!___wait_cond_timeout(condition))					\
-		__ret = __wait_event_interruptible_lock_irq_timeout(		\
-					wq_head, condition, lock, timeout);	\
+		__ret = __wait_event_lock_irq_timeout(				\
+					wq_head, condition, lock, timeout,	\
+					TASK_INTERRUPTIBLE);			\
+	__ret;									\
+})
+
+#define wait_event_lock_irq_timeout(wq_head, condition, lock, timeout)		\
+({										\
+	long __ret = timeout;							\
+	if (!___wait_cond_timeout(condition))					\
+		__ret = __wait_event_lock_irq_timeout(				\
+					wq_head, condition, lock, timeout,	\
+					TASK_UNINTERRUPTIBLE);			\
 	__ret;									\
 })
 
-- 
1.9.1

