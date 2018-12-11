Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E4C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9684B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543093;
	bh=g1HZYsYwSzEHS4H1m+thTD4Y/QRUHhVUn+s3EgbuGBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TVdboq337ZSYxehIgfGubHonHK9oGQoJp8Q6JHrROlBBjCPHHYqrS3nvZiey51WP4
	 MttvXKH9CumaBw9unZQeJH20SDT9xuMmtWo/v91VB53frhlaQxPWv8lJFcRtCKNSGp
	 QqB6Chm3P1HX2Gx8nXBXjwM/vgNcy9csu3TfVUJM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9684B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeLKPow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbeLKPov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1862082F;
        Tue, 11 Dec 2018 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543090;
        bh=g1HZYsYwSzEHS4H1m+thTD4Y/QRUHhVUn+s3EgbuGBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgSC+4NB3C/8e1uQLzqabQ89147QMfl40+pbRJHBBa/nRGseklDgLtyWwedc/0LNl
         76X5uudI8vs/Qhk1PZB4+HXUjV++cyMZjl1T+VadbPrnMy2revOB3F4ouHH74s2eMS
         t7rTU2Xqkw2RpuHL/9+nVIuXrT7JgvMm+we66kW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Schwarzott <zzam@gentoo.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 01/91] media: em28xx: Fix use-after-free when disconnecting
Date:   Tue, 11 Dec 2018 16:40:20 +0100
Message-Id: <20181211151606.096881193@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 910b0797fa9e8af09c44a3fa36cb310ba7a7218d ]

Fix bug by moving the i2c_unregister_device calls after deregistration
of dvb frontend.

The new style i2c drivers already destroys the frontend object at
i2c_unregister_device time.
When the dvb frontend is unregistered afterwards it leads to this oops:

  [ 6058.866459] BUG: unable to handle kernel NULL pointer dereference at 00000000000001f8
  [ 6058.866578] IP: dvb_frontend_stop+0x30/0xd0 [dvb_core]
  [ 6058.866644] PGD 0
  [ 6058.866646] P4D 0

  [ 6058.866726] Oops: 0000 [#1] SMP
  [ 6058.866768] Modules linked in: rc_pinnacle_pctv_hd(O) em28xx_rc(O) si2157(O) si2168(O) em28xx_dvb(O) em28xx(O) si2165(O) a8293(O) tda10071(O) tea5767(O) tuner(O) cx23885(O) tda18271(O) videobuf2_dvb(O) videobuf2_dma_sg(O) m88ds3103(O) tveeprom(O) cx2341x(O) v4l2_common(O) dvb_core(O) rc_core(O) videobuf2_memops(O) videobuf2_v4l2(O) videobuf2_core(O) videodev(O) media(O) bluetooth ecdh_generic ums_realtek uas rtl8192cu rtl_usb rtl8192c_common rtlwifi usb_storage snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic i2c_mux snd_hda_intel snd_hda_codec snd_hwdep x86_pkg_temp_thermal snd_hda_core kvm_intel kvm irqbypass [last unloaded: videobuf2_memops]
  [ 6058.867497] CPU: 2 PID: 7349 Comm: kworker/2:0 Tainted: G        W  O    4.13.9-gentoo #1
  [ 6058.867595] Hardware name: MEDION E2050 2391/H81H3-EM2, BIOS H81EM2W08.308 08/25/2014
  [ 6058.867692] Workqueue: usb_hub_wq hub_event
  [ 6058.867746] task: ffff88011a15e040 task.stack: ffffc90003074000
  [ 6058.867825] RIP: 0010:dvb_frontend_stop+0x30/0xd0 [dvb_core]
  [ 6058.867896] RSP: 0018:ffffc90003077b58 EFLAGS: 00010293
  [ 6058.867964] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000010040001f
  [ 6058.868056] RDX: ffff88011a15e040 RSI: ffffea000464e400 RDI: ffff88001cbe3028
  [ 6058.868150] RBP: ffffc90003077b68 R08: ffff880119390380 R09: 000000010040001f
  [ 6058.868241] R10: ffffc90003077b18 R11: 000000000001e200 R12: ffff88001cbe3028
  [ 6058.868330] R13: ffff88001cbe68d0 R14: ffff8800cf734000 R15: ffff8800cf734098
  [ 6058.868419] FS:  0000000000000000(0000) GS:ffff88011fb00000(0000) knlGS:0000000000000000
  [ 6058.868511] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 6058.868578] CR2: 00000000000001f8 CR3: 00000001113c5000 CR4: 00000000001406e0
  [ 6058.868662] Call Trace:
  [ 6058.868705]  dvb_unregister_frontend+0x2a/0x80 [dvb_core]
  [ 6058.868774]  em28xx_dvb_fini+0x132/0x220 [em28xx_dvb]
  [ 6058.868840]  em28xx_close_extension+0x34/0x90 [em28xx]
  [ 6058.868902]  em28xx_usb_disconnect+0x4e/0x70 [em28xx]
  [ 6058.868968]  usb_unbind_interface+0x6d/0x260
  [ 6058.869025]  device_release_driver_internal+0x150/0x210
  [ 6058.869094]  device_release_driver+0xd/0x10
  [ 6058.869150]  bus_remove_device+0xe4/0x160
  [ 6058.869204]  device_del+0x1ce/0x2f0
  [ 6058.869253]  usb_disable_device+0x99/0x270
  [ 6058.869306]  usb_disconnect+0x8d/0x260
  [ 6058.869359]  hub_event+0x93d/0x1520
  [ 6058.869408]  ? dequeue_task_fair+0xae5/0xd20
  [ 6058.869467]  process_one_work+0x1d9/0x3e0
  [ 6058.869522]  worker_thread+0x43/0x3e0
  [ 6058.869576]  kthread+0x104/0x140
  [ 6058.869602]  ? trace_event_raw_event_workqueue_work+0x80/0x80
  [ 6058.869640]  ? kthread_create_on_node+0x40/0x40
  [ 6058.869673]  ret_from_fork+0x22/0x30
  [ 6058.869698] Code: 54 49 89 fc 53 48 8b 9f 18 03 00 00 0f 1f 44 00 00 41 83 bc 24 04 05 00 00 02 74 0c 41 c7 84 24 04 05 00 00 01 00 00 00 0f ae f0 <48> 8b bb f8 01 00 00 48 85 ff 74 5c e8 df 40 f0 e0 48 8b 93 f8
  [ 6058.869850] RIP: dvb_frontend_stop+0x30/0xd0 [dvb_core] RSP: ffffc90003077b58
  [ 6058.869894] CR2: 00000000000001f8
  [ 6058.875880] ---[ end trace 717eecf7193b3fc6 ]---

Signed-off-by: Matthias Schwarzott <zzam@gentoo.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx-dvb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/usb/em28xx/em28xx-dvb.c
+++ b/drivers/media/usb/em28xx/em28xx-dvb.c
@@ -1806,6 +1806,8 @@ static int em28xx_dvb_fini(struct em28xx
 		}
 	}
 
+	em28xx_unregister_dvb(dvb);
+
 	/* remove I2C SEC */
 	client = dvb->i2c_client_sec;
 	if (client) {
@@ -1827,7 +1829,6 @@ static int em28xx_dvb_fini(struct em28xx
 		i2c_unregister_device(client);
 	}
 
-	em28xx_unregister_dvb(dvb);
 	kfree(dvb);
 	dev->dvb = NULL;
 	kref_put(&dev->ref, em28xx_free_device);


