Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE7FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A5920672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8pvuE2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A5920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504405AbeKWXfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:35:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54905 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbeKWXfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:35:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so11873463wma.4;
        Fri, 23 Nov 2018 04:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dM7IhGWOU7cShpMQLOCYVUTEHDMpuPGWtaI704Auq+Y=;
        b=k8pvuE2kPsLhMZFQV+9LZfUOHO9pSJA1+l8S+om3Ns4MU05x4twmwD2VkmmZnUSFMO
         OJQKwBlZCPC85iDJHCua6hjqHMtF+I4rqF3uFz0t6NkZEPx28eJ5jiOFmI45kP7iTYxk
         UB7hyy08yLoG1+Z+9rqu6RQkorbLC8zSlwYp5QDQEiGuOhU8pzOq53Qz57PF0HgPGcQT
         P5zmi2UzAGkiy6NkbvZf6TAGEmVJURcKDnokK1E4zInm/RJ45YiST/peL9AUfxXRm3pc
         yRleK5iZkgnDGp7Vt0pmBqgnHzrnzKOKhmUeaQ1Ar8cW2Mxx5CjeAKE6a7B1QY7O+lCe
         sw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dM7IhGWOU7cShpMQLOCYVUTEHDMpuPGWtaI704Auq+Y=;
        b=mNI2Wbha/rfU8KZVRm1/l92YUWT24B9qz+vxSMeMvbvUniR1fR48IDIdkucYSfKVGe
         WrJWgKHdLlYn2A7sXVQINi2cEP589v352y1yxWBXBy3WTTQccG4xTBGYDLl1GYJTxnni
         kLom1egQMQs8PGVUfyt71XdvqsEb7b1uDBki94OKtVsGEG1qaMz98i25O6q9YBWG1Fko
         iSjnrMifJ0ejZJNud7SXZ5AKWzHpUhshrFjDVcAY/SvIczc5tg7tnrkLaeHevySE9eM2
         OpCBOYq9kjF82cEu7SUoZ6Vcy2x2j5hTj9LMcLoaJqmgOCdO3ifrXnj1mBj+d+dhzXAF
         dMQw==
X-Gm-Message-State: AA+aEWYqZyRrMN/260mLxs4LqsKuAjKjtUpA/JKECmYkzoMAAbX76WzI
        uAnsYP3Ca09NArdCaE/U4fU=
X-Google-Smtp-Source: AFSGD/X0Jd44zhbhUdH6quxwn37TuqVVd8UqrHMyH+YO6JZJNhAIKzU6+4u4CPwJDxMjQUUNzPgIqQ==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr4651110wmc.20.1542977496859;
        Fri, 23 Nov 2018 04:51:36 -0800 (PST)
Received: from ubuntu.faroeurope.com (mail.faroeurope.com. [213.61.174.138])
        by smtp.gmail.com with ESMTPSA id 134-v6sm9170675wmp.6.2018.11.23.04.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 04:51:36 -0800 (PST)
From:   Bernd Eckstein <3erndeckstein@gmail.com>
X-Google-Original-From: Bernd Eckstein <3ernd.Eckstein@gmail.com>
To:     davem@davemloft.net
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, 3ernd.Eckstein@gmail.com,
        Oliver Zweigle <Oliver.Zweigle@faro.com>
Subject: [PATCH] usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2
Date:   Fri, 23 Nov 2018 13:51:26 +0100
Message-Id: <1542977486-15363-1-git-send-email-3ernd.Eckstein@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bug is not easily reproducable, as it may occur very infrequently
(we had machines with 20minutes heavy downloading before it occurred)
However, on a virual machine (VMWare on Windows 10 host) it occurred
pretty frequently (1-2 seconds after a speedtest was started)

dev->tx_skb mab be freed via dev_kfree_skb_irq on a callback
before it is set.

This causes the following problems:
- double free of the skb or potential memory leak
- in dmesg: 'recvmsg bug' and 'recvmsg bug 2' and eventually
  general protection fault

Example dmesg output:
[  134.841986] ------------[ cut here ]------------
[  134.841987] recvmsg bug: copied 9C24A555 seq 9C24B557 rcvnxt 9C25A6B3 fl 0
[  134.841993] WARNING: CPU: 7 PID: 2629 at /build/linux-hwe-On9fm7/linux-hwe-4.15.0/net/ipv4/tcp.c:1865 tcp_recvmsg+0x44d/0xab0
[  134.841994] Modules linked in: ipheth(OE) kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd glue_helper cryptd vmw_balloon intel_rapl_perf joydev input_leds serio_raw vmw_vsock_vmci_transport vsock shpchp i2c_piix4 mac_hid binfmt_misc vmw_vmci parport_pc ppdev lp parport autofs4 vmw_pvscsi vmxnet3 hid_generic usbhid hid vmwgfx ttm drm_kms_helper syscopyarea sysfillrect mptspi mptscsih sysimgblt ahci psmouse fb_sys_fops pata_acpi mptbase libahci e1000 drm scsi_transport_spi
[  134.842046] CPU: 7 PID: 2629 Comm: python Tainted: G        W  OE    4.15.0-34-generic #37~16.04.1-Ubuntu
[  134.842046] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[  134.842048] RIP: 0010:tcp_recvmsg+0x44d/0xab0
[  134.842048] RSP: 0018:ffffa6630422bcc8 EFLAGS: 00010286
[  134.842049] RAX: 0000000000000000 RBX: ffff997616f4f200 RCX: 0000000000000006
[  134.842049] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff9976257d6490
[  134.842050] RBP: ffffa6630422bd98 R08: 0000000000000001 R09: 000000000004bba4
[  134.842050] R10: 0000000001e00c6f R11: 000000000004bba4 R12: ffff99760dee3000
[  134.842051] R13: 0000000000000000 R14: ffff99760dee3514 R15: 0000000000000000
[  134.842051] FS:  00007fe332347700(0000) GS:ffff9976257c0000(0000) knlGS:0000000000000000
[  134.842052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  134.842053] CR2: 0000000001e41000 CR3: 000000020e9b4006 CR4: 00000000003606e0
[  134.842055] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  134.842055] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  134.842057] Call Trace:
[  134.842060]  ? aa_sk_perm+0x53/0x1a0
[  134.842064]  inet_recvmsg+0x51/0xc0
[  134.842066]  sock_recvmsg+0x43/0x50
[  134.842070]  SYSC_recvfrom+0xe4/0x160
[  134.842072]  ? __schedule+0x3de/0x8b0
[  134.842075]  ? ktime_get_ts64+0x4c/0xf0
[  134.842079]  SyS_recvfrom+0xe/0x10
[  134.842082]  do_syscall_64+0x73/0x130
[  134.842086]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  134.842086] RIP: 0033:0x7fe331f5a81d
[  134.842088] RSP: 002b:00007ffe8da98398 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
[  134.842090] RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 00007fe331f5a81d
[  134.842094] RDX: 00000000000003fb RSI: 0000000001e00874 RDI: 0000000000000003
[  134.842095] RBP: 00007fe32f642c70 R08: 0000000000000000 R09: 0000000000000000
[  134.842097] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe332347698
[  134.842099] R13: 0000000001b7e0a0 R14: 0000000001e00874 R15: 0000000000000000
[  134.842103] Code: 24 fd ff ff e9 cc fe ff ff 48 89 d8 41 8b 8c 24 10 05 00 00 44 8b 45 80 48 c7 c7 08 bd 59 8b 48 89 85 68 ff ff ff e8 b3 c4 7d ff <0f> 0b 48 8b 85 68 ff ff ff e9 e9 fe ff ff 41 8b 8c 24 10 05 00
[  134.842126] ---[ end trace b7138fc08c83147f ]---
[  134.842144] general protection fault: 0000 [#1] SMP PTI
[  134.842145] Modules linked in: ipheth(OE) kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd glue_helper cryptd vmw_balloon intel_rapl_perf joydev input_leds serio_raw vmw_vsock_vmci_transport vsock shpchp i2c_piix4 mac_hid binfmt_misc vmw_vmci parport_pc ppdev lp parport autofs4 vmw_pvscsi vmxnet3 hid_generic usbhid hid vmwgfx ttm drm_kms_helper syscopyarea sysfillrect mptspi mptscsih sysimgblt ahci psmouse fb_sys_fops pata_acpi mptbase libahci e1000 drm scsi_transport_spi
[  134.842161] CPU: 7 PID: 2629 Comm: python Tainted: G        W  OE    4.15.0-34-generic #37~16.04.1-Ubuntu
[  134.842162] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[  134.842164] RIP: 0010:tcp_close+0x2c6/0x440
[  134.842165] RSP: 0018:ffffa6630422bde8 EFLAGS: 00010202
[  134.842167] RAX: 0000000000000000 RBX: ffff99760dee3000 RCX: 0000000180400034
[  134.842168] RDX: 5c4afd407207a6c4 RSI: ffffe868495bd300 RDI: ffff997616f4f200
[  134.842169] RBP: ffffa6630422be08 R08: 0000000016f4d401 R09: 0000000180400034
[  134.842169] R10: ffffa6630422bd98 R11: 0000000000000000 R12: 000000000000600c
[  134.842170] R13: 0000000000000000 R14: ffff99760dee30c8 R15: ffff9975bd44fe00
[  134.842171] FS:  00007fe332347700(0000) GS:ffff9976257c0000(0000) knlGS:0000000000000000
[  134.842173] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  134.842174] CR2: 0000000001e41000 CR3: 000000020e9b4006 CR4: 00000000003606e0
[  134.842177] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  134.842178] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  134.842179] Call Trace:
[  134.842181]  inet_release+0x42/0x70
[  134.842183]  __sock_release+0x42/0xb0
[  134.842184]  sock_close+0x15/0x20
[  134.842187]  __fput+0xea/0x220
[  134.842189]  ____fput+0xe/0x10
[  134.842191]  task_work_run+0x8a/0xb0
[  134.842193]  exit_to_usermode_loop+0xc4/0xd0
[  134.842195]  do_syscall_64+0xf4/0x130
[  134.842197]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  134.842197] RIP: 0033:0x7fe331f5a560
[  134.842198] RSP: 002b:00007ffe8da982e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  134.842200] RAX: 0000000000000000 RBX: 00007fe32f642c70 RCX: 00007fe331f5a560
[  134.842201] RDX: 00000000008f5320 RSI: 0000000001cd4b50 RDI: 0000000000000003
[  134.842202] RBP: 00007fe32f6500f8 R08: 000000000000003c R09: 00000000009343c0
[  134.842203] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe32f6500d0
[  134.842204] R13: 00000000008f5320 R14: 00000000008f5320 R15: 0000000001cd4770
[  134.842205] Code: c8 00 00 00 45 31 e4 49 39 fe 75 4d eb 50 83 ab d8 00 00 00 01 48 8b 17 48 8b 47 08 48 c7 07 00 00 00 00 48 c7 47 08 00 00 00 00 <48> 89 42 08 48 89 10 0f b6 57 34 8b 47 2c 2b 47 28 83 e2 01 80
[  134.842226] RIP: tcp_close+0x2c6/0x440 RSP: ffffa6630422bde8
[  134.842227] ---[ end trace b7138fc08c831480 ]---

The proposed patch eliminates a potential racing condition.
Before, usb_submit_urb was called and _after_ that, the skb was attached
(dev->tx_skb). So, on a callback it was possible, however unlikely that the
skb was freed before it was set. That way (because dev->tx_skb was not set
to NULL after it was freed), it could happen that a skb from a earlier
transmission was freed a second time (and the skb we should have freed did
not get freed at all)

Now we free the skb directly in ipheth_tx(). It is not passed to the
callback anymore, eliminating the posibility of a double free of the same
skb. Depending on the retval of usb_submit_urb() we use dev_kfree_skb_any()
respectively dev_consume_skb_any() to free the skb.

Signed-off-by: Oliver Zweigle <Oliver.Zweigle@faro.com>
Signed-off-by: Bernd Eckstein <3ernd.Eckstein@gmail.com>
---
 drivers/net/usb/ipheth.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 7275761..3d8a70d 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -140,7 +140,6 @@ struct ipheth_device {
 	struct usb_device *udev;
 	struct usb_interface *intf;
 	struct net_device *net;
-	struct sk_buff *tx_skb;
 	struct urb *tx_urb;
 	struct urb *rx_urb;
 	unsigned char *tx_buf;
@@ -230,6 +229,7 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 	case -ENOENT:
 	case -ECONNRESET:
 	case -ESHUTDOWN:
+	case -EPROTO:
 		return;
 	case 0:
 		break;
@@ -281,7 +281,6 @@ static void ipheth_sndbulk_callback(struct urb *urb)
 		dev_err(&dev->intf->dev, "%s: urb status: %d\n",
 		__func__, status);
 
-	dev_kfree_skb_irq(dev->tx_skb);
 	if (status == 0)
 		netif_wake_queue(dev->net);
 	else
@@ -423,7 +422,7 @@ static int ipheth_tx(struct sk_buff *skb, struct net_device *net)
 	if (skb->len > IPHETH_BUF_SIZE) {
 		WARN(1, "%s: skb too large: %d bytes\n", __func__, skb->len);
 		dev->net->stats.tx_dropped++;
-		dev_kfree_skb_irq(skb);
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 
@@ -443,12 +442,11 @@ static int ipheth_tx(struct sk_buff *skb, struct net_device *net)
 		dev_err(&dev->intf->dev, "%s: usb_submit_urb: %d\n",
 			__func__, retval);
 		dev->net->stats.tx_errors++;
-		dev_kfree_skb_irq(skb);
+		dev_kfree_skb_any(skb);
 	} else {
-		dev->tx_skb = skb;
-
 		dev->net->stats.tx_packets++;
 		dev->net->stats.tx_bytes += skb->len;
+		dev_consume_skb_any(skb);
 		netif_stop_queue(net);
 	}
 
-- 
2.7.4

