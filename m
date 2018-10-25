Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95C6ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AC62084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="wH0fniqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AC62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeJYXkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:40:18 -0400
Received: from out002.mailprotect.be ([83.217.72.86]:49085 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeJYXkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=JiCVSCu5dQ/PuSRWj2UQxPu3Ho4ud1E2IQRaMqhV6kM=; b=wH0fniqJ5rvG
        MSvyIpafW2+CASwONjCofQzknQuBz4d5gI7kjZltqMDNt6ad3/vZHge31mA3e69qGD3R/OsoU407X
        qqVnR8H7xyibi383tnIjqIWYEoqIXrto0/ZLBROtvTKRifxpG+vBLtDfCfK00ZTOYmmwA3/LqSbY2
        1NjRjLWR8H7UMiDPTHX9x/zePjToEpaN4YM5M3aSd7oXvOCC0mNFB0Oc38pKBp8Nl5V9+WZGqteYf
        ZywNWGpmt26ivckzcuKiT3ml6rlbCmdtnuiZgVsRUmv7jNU2TISWsjLpXbc2ESlwLJmNzCLdtbT8J
        4YCtItBz448XheCbERGLJQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gFhDn-000GI6-8S; Thu, 25 Oct 2018 17:06:56 +0200
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 2A9E9C0F9B;
        Thu, 25 Oct 2018 17:06:36 +0200 (CEST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, tytso@mit.edu,
        bvanassche@acm.org
Subject: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep complaint
Date:   Thu, 25 Oct 2018 08:05:40 -0700
Message-Id: <20181025150540.259281-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181025150540.259281-1-bvanassche@acm.org>
References: <20181025150540.259281-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00971097030466)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5mVCjbDuRTJfNKPGmbOpzVl602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTZ8+YO8vChGFh3RuBr6W5W4OxXLKJYlhMSlvFrRpI1afX1e
 LdXSQEA2A8Mi+qZBNAJeQM+giwlWxLd3u9oewtfxHkDLQXsP0l4gM901I8VRelOcvqL7erI7cmyP
 F7rNKoQ6nIk9pDZAy5+Bh7H1WlayS5/54zeXko+dun95C2GNU5Zgdw/TrNerJc6iNElLjOQFAsKL
 Md4v6OvDRSTrp7f1BMmyNbDn7R5kilAhwr3KtFkEjgy2lIalT1bgV0G1B6wR6UEXs2CpqzV8tKL4
 SxeIZFs3hxL2bckpClidT6MQ5u75lAaleymDhM6q/bf6ylvMne8kEFi9whdly91uPt+NjZ/2BflP
 GJGaubsXCX08RTS5uosuJIDwx+20ECcNkg/IQ6hdCufMS9/BCap8vQGHPoGLQmyHoPQ6TB1wLqq5
 Qkv8gSmPI3hcWIP6I/UqgkkWqQcrkdncBVBujWllVdXQX7semJdl8Weuy8+tlMSTQ04uitUf42Cc
 Hl6wE8LbH+hYFX5W98JZfM4UDzp+I2t3/FxvddG4mRHKJlnoc+LvLMw4Oh2LkwsmIC+tUiJAU2Hq
 vcLZCDNz7FE5l8aegTfrXgepXw2uOkh8BWaRmYTapEnuVpgRu+5Csn5Mqn0EOmQ4zJ5Xvbj1fZ7U
 ZAcZAKRxmEeggn4dXb7yqusq0s5DtMOyZsjihayc424+pNMmxRz3zmnSAPVgRExGTJ6qC+d+zBq4
 o6xB5AMMdSDguIlqHHJIe5U4rz33MPOIlGKEX4NMFgsxYIHCku08yYLbMWIz8Sz3rXkToGgoPkqM
 hPcHscFEFmAKKS84AwX/iljz3fd1vw8CKdLIQ0mXmruaJQIiXnCWFUqE9pVJn/PkOJ5QbWgs3+2/
 x0XtM0qxQBzvy3KWgwomWRcGIJOYPo3qjuJ8Dg/kZ2rBdh8HP0IdYe7j8cOpyKA69LF1Ge2GaGfx
 mfos7YTXbqll+CkEp8Abhi88xg9tdbvxd+VhQOn2K5bYwN40eTXlWiUAYdLmsJdAoPJvtp9WlTt+
 Kq0eQx3E5oYrsjSrzniyQYOvVIVbP1OsRtMGMevVVKNikwLQ0fq/FOtFj5jedxzVymPEjnK9ocrD
 Qs1Q7QbJ8LleNweIjcZcgw==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can happen that the direct I/O queue creates and destroys an empty
workqueue from inside a work function. Avoid that this triggers the
false positive lockdep complaint shown below.

======================================================
WARNING: possible circular locking dependency detected
4.19.0-dbg+ #1 Not tainted
------------------------------------------------------
fio/4129 is trying to acquire lock:
00000000a01cfe1a ((wq_completion)"dio/%s"sb->s_id){+.+.}, at: flush_workqueue+0xd0/0x970

but task is already holding lock:
00000000a0acecf9 (&sb->s_type->i_mutex_key#14){+.+.}, at: ext4_file_write_iter+0x154/0x710

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#14){+.+.}:
       down_write+0x3d/0x80
       __generic_file_fsync+0x77/0xf0
       ext4_sync_file+0x3c9/0x780
       vfs_fsync_range+0x66/0x100
       dio_complete+0x2f5/0x360
       dio_aio_complete_work+0x1c/0x20
       process_one_work+0x481/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #1 ((work_completion)(&dio->complete_work)){+.+.}:
       process_one_work+0x447/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #0 ((wq_completion)"dio/%s"sb->s_id){+.+.}:
       lock_acquire+0xc5/0x200
       flush_workqueue+0xf3/0x970
       drain_workqueue+0xec/0x220
       destroy_workqueue+0x23/0x350
       sb_init_dio_done_wq+0x6a/0x80
       do_blockdev_direct_IO+0x1f33/0x4be0
       __blockdev_direct_IO+0x79/0x86
       ext4_direct_IO+0x5df/0xbb0
       generic_file_direct_write+0x119/0x220
       __generic_file_write_iter+0x131/0x2d0
       ext4_file_write_iter+0x3fa/0x710
       aio_write+0x235/0x330
       io_submit_one+0x510/0xeb0
       __x64_sys_io_submit+0x122/0x340
       do_syscall_64+0x71/0x220
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  (wq_completion)"dio/%s"sb->s_id --> (work_completion)(&dio->complete_work) --> &sb->s_type->i_mutex_key#14

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#14);
                               lock((work_completion)(&dio->complete_work));
                               lock(&sb->s_type->i_mutex_key#14);
  lock((wq_completion)"dio/%s"sb->s_id);

 *** DEADLOCK ***

1 lock held by fio/4129:
 #0: 00000000a0acecf9 (&sb->s_type->i_mutex_key#14){+.+.}, at: ext4_file_write_iter+0x154/0x710

stack backtrace:
CPU: 3 PID: 4129 Comm: fio Not tainted 4.19.0-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0x86/0xc5
 print_circular_bug.isra.32+0x20a/0x218
 __lock_acquire+0x1c68/0x1cf0
 lock_acquire+0xc5/0x200
 flush_workqueue+0xf3/0x970
 drain_workqueue+0xec/0x220
 destroy_workqueue+0x23/0x350
 sb_init_dio_done_wq+0x6a/0x80
 do_blockdev_direct_IO+0x1f33/0x4be0
 __blockdev_direct_IO+0x79/0x86
 ext4_direct_IO+0x5df/0xbb0
 generic_file_direct_write+0x119/0x220
 __generic_file_write_iter+0x131/0x2d0
 ext4_file_write_iter+0x3fa/0x710
 aio_write+0x235/0x330
 io_submit_one+0x510/0xeb0
 __x64_sys_io_submit+0x122/0x340
 do_syscall_64+0x71/0x220
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/workqueue.h | 1 +
 kernel/workqueue.c        | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 60d673e15632..375ec764f148 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -344,6 +344,7 @@ enum {
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
 	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
+	__WQ_HAS_BEEN_USED	= 1 << 20, /* internal: work has been queued */
 
 	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
 	WQ_MAX_UNBOUND_PER_CPU	= 4,	  /* 4 * #cpus for unbound wq */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fc9129d5909e..0ef275fe526c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1383,6 +1383,10 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	if (unlikely(wq->flags & __WQ_DRAINING) &&
 	    WARN_ON_ONCE(!is_chained_work(wq)))
 		return;
+
+	if (!(wq->flags & __WQ_HAS_BEEN_USED))
+		wq->flags |= __WQ_HAS_BEEN_USED;
+
 retry:
 	if (req_cpu == WORK_CPU_UNBOUND)
 		cpu = wq_select_unbound_cpu(raw_smp_processor_id());
@@ -2889,7 +2893,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	 * workqueues the deadlock happens when the rescuer stalls, blocking
 	 * forward progress.
 	 */
-	if (!from_cancel &&
+	if (!from_cancel && (pwq->wq->flags & __WQ_HAS_BEEN_USED) &&
 	    (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
 		lock_acquire_exclusive(&pwq->wq->lockdep_map, 0, 0, NULL,
 				       _THIS_IP_);
-- 
2.19.1.568.g152ad8e336-goog

