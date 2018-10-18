Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7175DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1791C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2Ox8ZI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1791C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeJRWaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbeJRWaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:30:19 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E9C20645;
        Thu, 18 Oct 2018 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539872942;
        bh=HubwvJaCJwKevz/JeVBoLPIhRaBcPQs2FlNlmQRb1I0=;
        h=From:To:Cc:Subject:Date:From;
        b=D2Ox8ZI0vDK4HAhKJRgJkd5zxbg+6Ho31XpVIGsiFM4jPDpGI6uVN9qiCC9kKvOYP
         wxyaUvILoDrNB77iilcZ4JeJOV+E1O8SEEdM+IAu+BDXd3uunEC9VqO45+ecdQYbW3
         Ln3MBhooB8pvnaGpWtMbUao5IuZy/IiWXCe8ZWOs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     stable@vger.kernel.org
Cc:     Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Warren <swarren@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH stable v4.4+] usb: gadget: serial: fix oops when data rx'd after close
Date:   Thu, 18 Oct 2018 16:28:20 +0200
Message-Id: <1539872900-13011-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Warren <swarren@nvidia.com>

commit daa35bd95634a2a2d72d1049c93576a02711cb1a upstream

When the gadget serial device has no associated TTY, do not pass any
received data into the TTY layer for processing; simply drop it instead.
This prevents the TTY layer from calling back into the gadget serial
driver, which will then crash in e.g. gs_write_room() due to lack of
gadget serial device to TTY association (i.e. a NULL pointer dereference).

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

This is necessary for v4.4+ to fix:

[  134.015750] Unable to handle kernel NULL pointer dereference at virtual address 000000a8
[  134.023988] pgd = 80004000
[  134.026749] [000000a8] *pgd=00000000
[  134.030417] Internal error: Oops: 17 [#1] ARM
[  134.034826] Modules linked in: ctr ccm usb_f_acm u_serial ath9k_htc ath9k_common ath9k_hw ath mac80211 cfg80211 libcomposite configfs
[  134.047166] CPU: 0 PID: 51 Comm: kworker/u2:1 Not tainted 4.9.133 #60
[  134.053664] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
[  134.060195] Workqueue: events_unbound flush_to_ldisc
[  134.065244] task: 86a42140 task.stack: 86a9a000
[  134.069872] PC is at gs_flush_chars+0x18/0x30 [u_serial]
[  134.075261] LR is at n_tty_receive_buf_common+0x648/0xa54
[  134.080726] pc : [<7f169d4c>]    lr : [<803cce74>]    psr: 200f0093
[  134.080726] sp : 86a9be08  ip : 86a9be20  fp : 86a9be1c
[  134.092310] r10: 86bff600  r9 : 862240cc  r8 : 00000000
[  134.097589] r7 : 862240cc  r6 : 00000000  r5 : 00000000  r4 : 200f0013
[  134.104177] r3 : 7f169d34  r2 : 0000000a  r1 : 0000003c  r0 : 00000000
[  134.110763] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  134.118081] Control: 10c5387d  Table: 85fb8059  DAC: 00000051
[  134.123882] Process kworker/u2:1 (pid: 51, stack limit = 0x86a9a208)
[  134.130293] Stack: (0x86a9be08 to 0x86a9c000)
[  134.134717] be00:                   89f0b000 00000000 86a9be8c 86a9be20 803cce74 7f169d40
[  134.143000] be20: 86bff658 00020001 86bff73c 86a9be38 55555556 89f0b000 86a9be6c 8061f090
[  134.151282] be40: 89f0b018 89f0d000 89f0b000 00000000 86224090 0000003c 00000000 0000003c
[  134.159567] be60: 86a9be94 0000003c 803cd280 86be5e00 8604ea40 86be5e14 00000000 86802014
[  134.167852] be80: 86a9bea4 86a9be90 803cd29c 803cc838 00000001 80101438 86a9bebc 86a9bea8
[  134.176135] bea0: 803d00c4 803cd28c 86224000 86be5e04 86a9bee4 86a9bec0 803d05fc 803d00a8
[  134.184419] bec0: 86be5e04 86acf980 00000000 86808700 86802000 00000000 86a9bf1c 86a9bee8
[  134.192703] bee0: 8012ef38 803d054c 00000088 8090cac0 86a9a000 86acf980 86802000 86acf998
[  134.200988] bf00: 00000088 8090cac0 86a9a000 86802014 86a9bf5c 86a9bf20 8012f260 8012ee20
[  134.209270] bf20: 86ad1dc0 8070ee70 8092c91c 86802000 00000000 00000000 86ad1dc0 86a9a000
[  134.217554] bf40: 86acf980 8012f1f4 00000000 00000000 86a9bfac 86a9bf60 80134a78 8012f200
[  134.225838] bf60: 00000000 00000000 86ad1dc0 86acf980 00000000 86a9bf74 86a9bf74 00000000
[  134.234122] bf80: 86a9bf80 86a9bf80 8013b048 86ad1dc0 80134980 00000000 00000000 00000000
[  134.242406] bfa0: 00000000 86a9bfb0 80107990 8013498c 00000000 00000000 00000000 00000000
[  134.250688] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  134.258970] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[  134.267228] Backtrace:
[  134.269785] [<7f169d34>] (gs_flush_chars [u_serial]) from [<803cce74>] (n_tty_receive_buf_common+0x648/0xa54)
[  134.279800]  r5:00000000 r4:89f0b000
[  134.283449] [<803cc82c>] (n_tty_receive_buf_common) from [<803cd29c>] (n_tty_receive_buf2+0x1c/0x24)
[  134.292695]  r10:86802014 r9:00000000 r8:86be5e14 r7:8604ea40 r6:86be5e00 r5:803cd280
[  134.300610]  r4:0000003c
[  134.303216] [<803cd280>] (n_tty_receive_buf2) from [<803d00c4>] (tty_ldisc_receive_buf+0x28/0x64)
[  134.312201] [<803d009c>] (tty_ldisc_receive_buf) from [<803d05fc>] (flush_to_ldisc+0xbc/0xd4)
[  134.320822]  r5:86be5e04 r4:86224000
[  134.324476] [<803d0540>] (flush_to_ldisc) from [<8012ef38>] (process_one_work+0x124/0x3e0)
[  134.332851]  r9:00000000 r8:86802000 r7:86808700 r6:00000000 r5:86acf980 r4:86be5e04
[  134.340706] [<8012ee14>] (process_one_work) from [<8012f260>] (worker_thread+0x6c/0x5a8)
[  134.348905]  r10:86802014 r9:86a9a000 r8:8090cac0 r7:00000088 r6:86acf998 r5:86802000
[  134.356828]  r4:86acf980
[  134.359431] [<8012f1f4>] (worker_thread) from [<80134a78>] (kthread+0xf8/0x110)
[  134.366847]  r10:00000000 r9:00000000 r8:8012f1f4 r7:86acf980 r6:86a9a000 r5:86ad1dc0
[  134.374765]  r4:00000000
[  134.377375] [<80134980>] (kthread) from [<80107990>] (ret_from_fork+0x14/0x24)
[  134.384708]  r8:00000000 r7:00000000 r6:00000000 r5:80134980 r4:86ad1dc0
[  134.391483] Code: e24cb004 e5900168 e10f4000 f10c0080 (e59030a8)
[  134.397643] ---[ end trace 6d6c0a94eccf9fda ]---

Reproduction:
1. Set up USB serial gadget and connect to device.
2. On device:
   while true; do echo "abcdefgh01234567890" > /dev/ttyGS0; done
3. On PC, execute simultaneously:
   while true; do cat /dev/ttyACM0 >> /tmp/tmp-dl; done
   for i in `seq 10000` ; do echo "XXXXXXXXXXXXXX" > /dev/ttyACM0 ; done
---
 drivers/usb/gadget/function/u_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index f7771d86ad6c..4ea44f7122ee 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -518,7 +518,7 @@ static void gs_rx_push(unsigned long _port)
 		}
 
 		/* push data to (open) tty */
-		if (req->actual) {
+		if (req->actual && tty) {
 			char		*packet = req->buf;
 			unsigned	size = req->actual;
 			unsigned	n;
-- 
2.7.4

