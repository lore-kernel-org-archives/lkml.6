Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C855C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D7D2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D7D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeKCT3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:29:09 -0400
Received: from foss.arm.com ([217.140.101.70]:51674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbeKCT3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:29:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B351880D;
        Sat,  3 Nov 2018 03:18:19 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A480A3F6A8;
        Sat,  3 Nov 2018 03:18:18 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2] iov_iter: Fix 9p virtio breakage
Date:   Sat,  3 Nov 2018 10:18:06 +0000
Message-Id: <20181103101806.133880-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching to the new iovec accessors, a negation got subtly
dropped, leading to 9p being remarkably broken (here with kvmtool):

[    7.430941] VFS: Mounted root (9p filesystem) on device 0:15.
[    7.432080] devtmpfs: mounted
[    7.432717] Freeing unused kernel memory: 1344K
[    7.433658] Run /virt/init as init process
  Warning: unable to translate guest address 0x7e00902ff000 to host
  Warning: unable to translate guest address 0x7e00902fefc0 to host
  Warning: unable to translate guest address 0x7e00902ff000 to host
  Warning: unable to translate guest address 0x7e008febef80 to host
  Warning: unable to translate guest address 0x7e008febf000 to host
  Warning: unable to translate guest address 0x7e008febef00 to host
  Warning: unable to translate guest address 0x7e008febf000 to host
[    7.436376] Kernel panic - not syncing: Requested init /virt/init failed (error -8).
[    7.437554] CPU: 29 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc8-02267-g00e23707442a #291
[    7.439006] Hardware name: linux,dummy-virt (DT)
[    7.439902] Call trace:
[    7.440387]  dump_backtrace+0x0/0x148
[    7.441104]  show_stack+0x14/0x20
[    7.441768]  dump_stack+0x90/0xb4
[    7.442425]  panic+0x120/0x27c
[    7.443036]  kernel_init+0xa4/0x100
[    7.443725]  ret_from_fork+0x10/0x18
[    7.444444] SMP: stopping secondary CPUs
[    7.445391] Kernel Offset: disabled
[    7.446169] CPU features: 0x0,23000438
[    7.446974] Memory Limit: none
[    7.447645] ---[ end Kernel panic - not syncing: Requested init /virt/init failed (error -8). ]---

Restoring the missing "!" brings the guest back to life.

Fixes: 00e23707442a ("iov_iter: Use accessor function")
Reported-by: Will Deacon <will.deacon@arm.com>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
Reposting with Al's ack, for Linus to pick up
as per https://lore.kernel.org/lkml/20181102190433.GZ32577@ZenIV.linux.org.uk/

 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 91981970f542..b1d39cabf125 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -329,7 +329,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 	if (!iov_iter_count(data))
 		return 0;
 
-	if (iov_iter_is_kvec(data)) {
+	if (!iov_iter_is_kvec(data)) {
 		int n;
 		/*
 		 * We allow only p9_max_pages pinned. We wait for the
-- 
2.19.1

