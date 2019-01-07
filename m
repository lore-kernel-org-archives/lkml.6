Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE707C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCEB20665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864993;
	bh=/F81EFuYuIQnhjdODuPpZsP7wFKTh9oITLGamMdjWOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ouWhswc3mzrQF34kfFYTTC4jZtqFu2I+bgiSCyVUv8zpaNuXoLyYuXTSQnG2umHv
	 IX6T3/GRT9aFf5Q2Ic0k1XhACsHxCZS0So3kvYAA+jMW+hjlogLaNZT5Ot/z67sD1a
	 m+u6C4BpmpBoItGl91c32LptqxjlzcbpqpceNoZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfAGMnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbfAGMnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF5E020449;
        Mon,  7 Jan 2019 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864990;
        bh=/F81EFuYuIQnhjdODuPpZsP7wFKTh9oITLGamMdjWOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9Dg//9i/T+LlTk7AEzec3uX+V7RBw/OzcJ11Fy2qykUtpSzzHhJQeAosVtoPwtU/
         yFDCSgec/kR2IUbv3K3Y4O7BsMMIlWtu2LNqIxTJwxO811c2Gs5ViK340Wfu+lvhaH
         +wop61g3vivAJP1BFMBY4Rt+bL8FpmOFxEslIIUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 112/145] media: rc: cec devices do not have a lirc chardev
Date:   Mon,  7 Jan 2019 13:32:29 +0100
Message-Id: <20190107104451.829283511@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Young <sean@mess.org>

commit e5bb9d3d755f128956ed467ae50b41d22bb680c6 upstream.

This fixes an oops in ir_lirc_scancode_event().

BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 9 PID: 27687 Comm: kworker/9:2 Tainted: P           OE 4.18.12-200.fc28.x86_64 #1
Hardware name: Supermicro C7X99-OCE-F/C7X99-OCE-F, BIOS 2.1a 06/15/2018
Workqueue: events pulse8_irq_work_handler [pulse8_cec]
RIP: 0010:ir_lirc_scancode_event+0x3d/0xb0 [rc_core]
Code: 8d ae b4 07 00 00 49 81 c6 b8 07 00 00 53 e8 4a df c3 d5 48 89 ef 49 89 45 00 e8 4e 84 41 d6 49 8b 1e 49 89 c4 4c 39 f3 74 58 <8b> 43 38 8b 53 40 89 c1 2b 4b 3c 39 ca 72 41 21 d0 49 8b 7d 00 49
RSP: 0018:ffffaa10e3c07d58 EFLAGS: 00010017
RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000018
RDX: 0000000000000001 RSI: 00316245397fa93c RDI: ffff966d31c8d7b4
RBP: ffff966d31c8d7b4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: ffffaa10e3c07e28 R12: 0000000000000002
R13: ffffaa10e3c07d88 R14: ffff966d31c8d7b8 R15: 0000000000000073
FS:  0000000000000000(0000) GS:ffff966d3f440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000038 CR3: 00000009d820a003 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ir_do_keydown+0x75/0x260 [rc_core]
 rc_keydown+0x54/0xc0 [rc_core]
 cec_received_msg_ts+0xaa8/0xaf0 [cec]
 process_one_work+0x1a1/0x350
 worker_thread+0x30/0x380
 ? pwq_unbound_release_workfn+0xd0/0xd0
 kthread+0x112/0x130
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x35/0x40
Modules linked in: rc_tt_1500 dvb_usb_dvbsky dvb_usb_v2 uas usb_storage fuse vhost_net vhost tap xt_CHECKSUM iptable_mangle ip6t_REJECT nf_reject_ipv6 tun 8021q garp mrp xt_nat macvlan xfs devlink ebta
 si2157 si2168 cx25840 cx23885 kvm altera_ci tda18271 joydev ir_rc6_decoder rc_rc6_mce crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore altera_stapl m88ds3103 tveeprom cx2341
 mxm_wmi igb crc32c_intel megaraid_sas dca i2c_algo_bit wmi vfio_pci irqbypass vfio_virqfd vfio_iommu_type1 vfio i2c_dev
CR2: 0000000000000038

Cc: <stable@vger.kernel.org> # v4.16+
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/rc/rc-main.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -695,7 +695,8 @@ void rc_repeat(struct rc_dev *dev)
 			 (dev->last_toggle ? LIRC_SCANCODE_FLAG_TOGGLE : 0)
 	};
 
-	ir_lirc_scancode_event(dev, &sc);
+	if (dev->allowed_protocols != RC_PROTO_BIT_CEC)
+		ir_lirc_scancode_event(dev, &sc);
 
 	spin_lock_irqsave(&dev->keylock, flags);
 
@@ -735,7 +736,8 @@ static void ir_do_keydown(struct rc_dev
 		.keycode = keycode
 	};
 
-	ir_lirc_scancode_event(dev, &sc);
+	if (dev->allowed_protocols != RC_PROTO_BIT_CEC)
+		ir_lirc_scancode_event(dev, &sc);
 
 	if (new_event && dev->keypressed)
 		ir_do_keyup(dev, false);


