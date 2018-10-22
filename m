Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D015CC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9605120663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="lz5fu4Jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9605120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeJVXhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:37:43 -0400
Received: from com-out001.mailprotect.be ([83.217.72.83]:41741 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeJVXhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=uKqkswxG0Kkc850Id1pugsrIQkWBTlNja29VF/AlRLw=; b=lz5fu4Jb0Ovc
        k7JYpVIP1fUL+eaZcQUDqN1JgQXsLiZNTHUnc8YQXGcUEsDVpKG+SY512p0tMA8lqjk6z7lEkgwbS
        PxW2oft2HB4aJM0YoDVFqS7RH9fUI3d5TVeMpxtJcB/nwno0Q/YcQlCmG60deAtpDLh7bNQNuAewA
        W/AjRUJECK4IAZPwcsEKG5OlQd7mBipEp1nXLTVFwKAzAlywovJCtpVeAov4O/HRxcRgnF3RmXvUh
        ChZ/5TnspqNnbqq3nMH3haPNBHO07SxUA9+0E++ATUudKqKXw6mfG3+5+RqzQibHJECMYVqrOjq69
        joEyRQInnn+rlm+66bskHA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gEbyT-0003ZA-3M; Mon, 22 Oct 2018 17:18:34 +0200
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 9CBFAC0517;
        Mon, 22 Oct 2018 17:18:25 +0200 (CEST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for flushing"
Date:   Mon, 22 Oct 2018 08:18:18 -0700
Message-Id: <20181022151818.135163-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5odnGd02HOwZWAgfjBgObOl602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTZ8+YO8vChGFh3RuBr6W5W4OxXLKJYlhMSlvFrRpI1afX1e
 LdXSQEA2A8Mi+qZBNAJeQM+giwlWxLd3u9oewtfxiSo6N4bNutapy8SI+mBhdrE5PSGrfDxec1nI
 xo+RcWWZJ3e+S6vG/yeQaEs5oHmRQ9UhMubR7eOj0hdfPqeU6onTJYQp6P0LGGk5YcssJBnOp8QH
 ng7F5iWXXWLbM5w1zUgjrCVGUEX27LHFutWuCeKVse1sVhWabI0/+PN3sIJWn36REjnVhy/JnBfG
 H14WKbOaRLNcoh0gQwm21S8Yfv2p7chPBr9Suc7XsfyyMyRTlkm+kaR+xhFhhRdcSRBoLX4i2bdm
 Lrt/fdDS9Ii3kT56E8BDh3LicTPGRp/qbfic8SCayvohmtqmsdHgH3ur6jDOCpJyjVjbMrDdHDSf
 q5OtesVSw7fL+67Pn4oJmpdYbuQrf2k+DKrsx9JdAdbfIjmWspaNNq3zk8Wc70B1UEDHGLIWRRxh
 sHQ45wxaPsAIa/9gbANbtDrZMN7BmTC4MjMm/D2rEPnNAuCCnt9B994MM58XyunompyDEbzUL2Qg
 r/U0flMcy2Vi/IcBgY4a4nD4ixtEBgLUs9VA8/4/8xQgoW7Jlml5bhJtfEFIJGtCL01hSmyW6+yK
 TJkXbSzQ8AdfksiOt8sA+15KkDdUa21S+8/rP1RV3ZeaIUJHttNpYwIOD40LiO7QllDHryTqvluZ
 t+AdLVW+A29GYjZvX22kwtZHnrpVFi5UaZpS2Aj8NihtvUb6BtvE9xCq3hmf4dmSgxuEYsiuIl7s
 vCGuHlBrMyfpYuyanAZpMXssfrVwKw0pt1dgpmCfB8CoGcZDFN4ukSbp61sNhnSifTsFOYcrB0sm
 jrRvNB2jpdF4791JYiIOmp03ips8dzXXFjKaA/g/USyvHbCV6fq3UCvk1OuO5TcDeKjrEmYPn2IV
 WRuDpMTkyD+NxVY5OCCRCHPe1ieilyEZ0gabF2xMCPBYgFtIDpT88TEiAnXgl0Wd2i38XG910biZ
 EcomWehz4u8szDg6HYuTCyYgL61SIkBTYZACk+V/V60H6JfJnsg72wHk2EPy497nssgnoMkIb3rM
 R7d4CWpSt/sm/gYhmNcISA==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep is a tool that developers rely on to find actual bugs. False
positive lockdep warnings are very annoying because it takes time to
analyze these and to verify that the warning is really a false positive
report. Since commit 87915adc3f0a ("workqueue: re-add lockdep
dependencies for flushing") causes lockdep to produce multiple false
positive reports, revert that commit. An example of a false positive
report produced by that commit:

======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc1-dbg+ #1 Not tainted
------------------------------------------------------
fio/29348 is trying to acquire lock:
00000000f1894b1d ((wq_completion)"dio/%s"sb->s_id){+.+.}, at: flush_workqueue+0xd0/0x970

but task is already holding lock:
000000007d8b84da (&sb->s_type->i_mutex_key#16){++++}, at: ext4_file_write_iter+0x154/0x710

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#16){++++}:
       down_write+0x3d/0x80
       __generic_file_fsync+0x77/0xf0
       ext4_sync_file+0x3c9/0x780
       vfs_fsync_range+0x66/0x100
       dio_complete+0x2f5/0x360
       dio_aio_complete_work+0x1c/0x20
       process_one_work+0x4ae/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #1 ((work_completion)(&dio->complete_work)){+.+.}:
       process_one_work+0x474/0xa20
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #0 ((wq_completion)"dio/%s"sb->s_id){+.+.}:
       lock_acquire+0xc5/0x200
       flush_workqueue+0xf3/0x970
       drain_workqueue+0xec/0x220
       destroy_workqueue+0x23/0x350
       sb_init_dio_done_wq+0x6a/0x80
       do_blockdev_direct_IO+0x3b8/0x3d00
       __blockdev_direct_IO+0x79/0x86
       ext4_direct_IO+0x5df/0xbc0
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
  (wq_completion)"dio/%s"sb->s_id --> (work_completion)(&dio->complete_work) --> &sb->s_type->i_mutex_key#16

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#16);
                               lock((work_completion)(&dio->complete_work));
                               lock(&sb->s_type->i_mutex_key#16);
  lock((wq_completion)"dio/%s"sb->s_id);

 *** DEADLOCK ***

1 lock held by fio/29348:
 #0: 000000007d8b84da (&sb->s_type->i_mutex_key#16){++++}, at: ext4_file_write_iter+0x154/0x710

stack backtrace:
CPU: 4 PID: 29348 Comm: fio Not tainted 4.19.0-rc1-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0x86/0xc5
 print_circular_bug.isra.32+0x20a/0x218
 __lock_acquire+0x1a54/0x1b20
 lock_acquire+0xc5/0x200
 flush_workqueue+0xf3/0x970
 drain_workqueue+0xec/0x220
 destroy_workqueue+0x23/0x350
 sb_init_dio_done_wq+0x6a/0x80
 do_blockdev_direct_IO+0x3b8/0x3d00
 __blockdev_direct_IO+0x79/0x86
 ext4_direct_IO+0x5df/0xbc0
 generic_file_direct_write+0x119/0x220
 __generic_file_write_iter+0x131/0x2d0
 ext4_file_write_iter+0x3fa/0x710
 aio_write+0x235/0x330
 io_submit_one+0x510/0xeb0
 __x64_sys_io_submit+0x122/0x340
 do_syscall_64+0x71/0x220
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing")
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org <linux-nvme@lists.infradead.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/workqueue.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 60e80198c3df..a6c2b823f348 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2652,9 +2652,6 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
-	lock_map_acquire(&wq->lockdep_map);
-	lock_map_release(&wq->lockdep_map);
-
 	mutex_lock(&wq->mutex);
 
 	/*
@@ -2908,11 +2905,6 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!wq_online))
 		return false;
 
-	if (!from_cancel) {
-		lock_map_acquire(&work->lockdep_map);
-		lock_map_release(&work->lockdep_map);
-	}
-
 	if (start_flush_work(work, &barr, from_cancel)) {
 		wait_for_completion(&barr.done);
 		destroy_work_on_stack(&barr.work);
-- 
2.19.1.568.g152ad8e336-goog

