Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E5DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198AF2174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198AF2174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404039AbeHGVJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:09:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbeHGVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:09:05 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7F4B0D07;
        Tue,  7 Aug 2018 18:53:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 15/18] Partially revert "block: fail op_is_write() requests to read-only partitions"
Date:   Tue,  7 Aug 2018 20:51:18 +0200
Message-Id: <20180807172313.528528886@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172312.964272530@linuxfoundation.org>
References: <20180807172312.964272530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit a32e236eb93e62a0f692e79b7c3c9636689559b9 upstream.

It turns out that commit 721c7fc701c7 ("block: fail op_is_write()
requests to read-only partitions"), while obviously correct, causes
problems for some older lvm2 installations.

The reason is that the lvm snapshotting will continue to write to the
snapshow COW volume, even after the volume has been marked read-only.
End result: snapshot failure.

This has actually been fixed in newer version of the lvm2 tool, but the
old tools still exist, and the breakage was reported both in the kernel
bugzilla and in the Debian bugzilla:

  https://bugzilla.kernel.org/show_bug.cgi?id=200439
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=900442

The lvm2 fix is here

  https://sourceware.org/git/?p=lvm2.git;a=commit;h=a6fdb9d9d70f51c49ad11a87ab4243344e6701a3

but until everybody has updated to recent versions, we'll have to weaken
the "never write to read-only partitions" check.  It now allows the
write to happen, but causes a warning, something like this:

  generic_make_request: Trying to write to read-only block-device dm-3 (partno X)
  Modules linked in: nf_tables xt_cgroup xt_owner kvm_intel iwlmvm kvm irqbypass iwlwifi
  CPU: 1 PID: 77 Comm: kworker/1:1 Not tainted 4.17.9-gentoo #3
  Hardware name: LENOVO 20B6A019RT/20B6A019RT, BIOS GJET91WW (2.41 ) 09/21/2016
  Workqueue: ksnaphd do_metadata
  RIP: 0010:generic_make_request_checks+0x4ac/0x600
  ...
  Call Trace:
   generic_make_request+0x64/0x400
   submit_bio+0x6c/0x140
   dispatch_io+0x287/0x430
   sync_io+0xc3/0x120
   dm_io+0x1f8/0x220
   do_metadata+0x1d/0x30
   process_one_work+0x1b9/0x3e0
   worker_thread+0x2b/0x3c0
   kthread+0x113/0x130
   ret_from_fork+0x35/0x40

Note that this is a "revert" in behavior only.  I'm leaving alone the
actual code cleanups in commit 721c7fc701c7, but letting the previously
uncaught request go through with a warning instead of stopping it.

Fixes: 721c7fc701c7 ("block: fail op_is_write() requests to read-only partitions")
Reported-and-tested-by: WGH <wgh@torlan.ru>
Acked-by: Mike Snitzer <snitzer@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Zdenek Kabelac <zkabelac@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2174,11 +2174,12 @@ static inline bool bio_check_ro(struct b
 	if (part->policy && op_is_write(bio_op(bio))) {
 		char b[BDEVNAME_SIZE];
 
-		printk(KERN_ERR
+		WARN_ONCE(1,
 		       "generic_make_request: Trying to write "
 			"to read-only block-device %s (partno %d)\n",
 			bio_devname(bio, b), part->partno);
-		return true;
+		/* Older lvm-tools actually trigger this */
+		return false;
 	}
 
 	return false;


