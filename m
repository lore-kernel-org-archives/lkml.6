Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC79C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E317C20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E317C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436522AbeHATSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:18:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390542AbeHATSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 386F0EBF;
        Wed,  1 Aug 2018 16:54:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dave Jones <dsj@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Snyder <joshs@netflix.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 007/336] delayacct: fix crash in delayacct_blkio_end() after delayacct init failure
Date:   Wed,  1 Aug 2018 18:45:42 +0200
Message-Id: <20180801165029.202299895@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Tejun Heo <tj@kernel.org>

commit b512719f771a82180211c9a315b8a7f628832b3d upstream.

While forking, if delayacct init fails due to memory shortage, it
continues expecting all delayacct users to check task->delays pointer
against NULL before dereferencing it, which all of them used to do.

Commit c96f5471ce7d ("delayacct: Account blkio completion on the correct
task"), while updating delayacct_blkio_end() to take the target task
instead of always using %current, made the function test NULL on
%current->delays and then continue to operated on @p->delays.  If
%current succeeded init while @p didn't, it leads to the following
crash.

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
 IP: __delayacct_blkio_end+0xc/0x40
 PGD 8000001fd07e1067 P4D 8000001fd07e1067 PUD 1fcffbb067 PMD 0
 Oops: 0000 [#1] SMP PTI
 CPU: 4 PID: 25774 Comm: QIOThread0 Not tainted 4.16.0-9_fbk1_rc2_1180_g6b593215b4d7 #9
 RIP: 0010:__delayacct_blkio_end+0xc/0x40
 Call Trace:
  try_to_wake_up+0x2c0/0x600
  autoremove_wake_function+0xe/0x30
  __wake_up_common+0x74/0x120
  wake_up_page_bit+0x9c/0xe0
  mpage_end_io+0x27/0x70
  blk_update_request+0x78/0x2c0
  scsi_end_request+0x2c/0x1e0
  scsi_io_completion+0x20b/0x5f0
  blk_mq_complete_request+0xa2/0x100
  ata_scsi_qc_complete+0x79/0x400
  ata_qc_complete_multiple+0x86/0xd0
  ahci_handle_port_interrupt+0xc9/0x5c0
  ahci_handle_port_intr+0x54/0xb0
  ahci_single_level_irq_intr+0x3b/0x60
  __handle_irq_event_percpu+0x43/0x190
  handle_irq_event_percpu+0x20/0x50
  handle_irq_event+0x2a/0x50
  handle_edge_irq+0x80/0x1c0
  handle_irq+0xaf/0x120
  do_IRQ+0x41/0xc0
  common_interrupt+0xf/0xf

Fix it by updating delayacct_blkio_end() check @p->delays instead.

Link: http://lkml.kernel.org/r/20180724175542.GP1934745@devbig577.frc2.facebook.com
Fixes: c96f5471ce7d ("delayacct: Account blkio completion on the correct task")
Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Dave Jones <dsj@fb.com>
Debugged-by: Dave Jones <dsj@fb.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Snyder <joshs@netflix.com>
Cc: <stable@vger.kernel.org>	[4.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/delayacct.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -124,7 +124,7 @@ static inline void delayacct_blkio_start
 
 static inline void delayacct_blkio_end(struct task_struct *p)
 {
-	if (current->delays)
+	if (p->delays)
 		__delayacct_blkio_end(p);
 	delayacct_clear_flag(DELAYACCT_PF_BLKIO);
 }


