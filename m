Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A5BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D777F20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="EPA1PIPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfBYTud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:50:33 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:57648 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfBYTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HlmyqiQIe4FH7KcASSfs3QTQWckSP8oQFuf1Xx7vRQg=; b=EPA1PIPJWVS4CDQidYySTqzT6r
        h3lx+kCDeHKhRfLIIcIDATxiYVu57j03+1iu081jPh6yzaNuD6Cnrz2yih24Ya3xkIEeEqQn4IQjD
        kIfn35AcBOZLarDEBQMi+mK4u2UzR9s+uqSCBVbMwzUgyyorGRldKXxn+oi+1t4hYWfE=;
Received: from p200300ccfbce97001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbce:9700:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gyMGh-0000eV-C8; Mon, 25 Feb 2019 20:50:27 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gyMGh-0008Pm-DO; Mon, 25 Feb 2019 20:50:27 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        josua.mayer@jm0.eu
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] Bluetooth: hci_bcm: fix double-free irq on removal
Date:   Mon, 25 Feb 2019 20:50:10 +0100
Message-Id: <20190225195010.32277-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after rmmod hci_uart a warning about doubly freed
interrupts appears, so do it only once. Instead disable it.
It is already implicitely freed by the devm framework.

[  230.782948] ------------[ cut here ]------------
[  230.787708] WARNING: CPU: 0 PID: 2715 at kernel/irq/devres.c:146 devm_free_irq+0x59/0x60
[  230.798345] Modules linked in: usb_f_ecm u_ether libcomposite spidev hidp rfcomm hci_uart(-) btbcm bluetooth ecdh_generic brcmfmac brcmutil cfg80211 rfkill evdev sun8i_codec_analog sun8i_adda_pr_regmap snd_soc_core snd_pcm_dmaengine pwrseq_simple snd_pcm snd_timer snd soundcore hih6130 cpufreq_dt uio_pdrv_genirq gpio_keys uio thermal_sys
[  230.828282] CPU: 0 PID: 2715 Comm: rmmod Not tainted 5.0.0-rc8+ #14
[  230.834540] Hardware name: Allwinner sun8i Family
[  230.839266] [<c010d4dd>] (unwind_backtrace) from [<c010a189>] (show_stack+0x11/0x14)
[  230.847014] [<c010a189>] (show_stack) from [<c085867b>] (dump_stack+0x67/0x74)
[  230.854240] [<c085867b>] (dump_stack) from [<c011afd1>] (__warn+0xb9/0xcc)
[  230.861115] [<c011afd1>] (__warn) from [<c011b0ab>] (warn_slowpath_null+0x2f/0x34)
[  230.868681] [<c011b0ab>] (warn_slowpath_null) from [<c0163889>] (devm_free_irq+0x59/0x60)
[  230.876881] [<c0163889>] (devm_free_irq) from [<bfb101b1>] (bcm_close+0x35/0xa8 [hci_uart])
[  230.885264] [<bfb101b1>] (bcm_close [hci_uart]) from [<bfb0cd3f>] (hci_uart_unregister_device+0x33/0x3c [hci_uart])
[  230.895708] [<bfb0cd3f>] (hci_uart_unregister_device [hci_uart]) from [<bfb0f9b7>] (bcm_serdev_remove+0xf/0x10 [hci_uart])
[  230.906755] [<bfb0f9b7>] (bcm_serdev_remove [hci_uart]) from [<c057896f>] (serdev_drv_remove+0x13/0x20)
[  230.916150] [<c057896f>] (serdev_drv_remove) from [<c05c1597>] (device_release_driver_internal+0xf7/0x158)
[  230.925799] [<c05c1597>] (device_release_driver_internal) from [<c05c1651>] (driver_detach+0x49/0x78)
[  230.935013] [<c05c1651>] (driver_detach) from [<c05c08f1>] (bus_remove_driver+0x31/0x70)
[  230.943108] [<c05c08f1>] (bus_remove_driver) from [<bfb10357>] (bcm_deinit+0x1b/0xcc4 [hci_uart])
[  230.951994] [<bfb10357>] (bcm_deinit [hci_uart]) from [<bfb102bb>] (hci_uart_exit+0x1b/0x34 [hci_uart])
[  230.961389] [<bfb102bb>] (hci_uart_exit [hci_uart]) from [<c0185f09>] (sys_delete_module+0x135/0x178)
[  230.970603] [<c0185f09>] (sys_delete_module) from [<c0101001>] (ret_fast_syscall+0x1/0x62)
[  230.978855] Exception stack(0xd66b7fa8 to 0xd66b7ff0)
[  230.983906] 7fa0:                   00c3dd00 00000000 00c3dd3c 00000800 88297c00 88297c00
[  230.992078] 7fc0: 00c3dd00 00000000 bef05e82 00000081 bef05b88 00000001 bef05d7c 00000000
[  231.000245] 7fe0: 0045bf6c bef05b24 00441303 b6edab26
[  231.005332] ---[ end trace dc4caa46c945c790 ]---
[  231.009946] ------------[ cut here ]------------
[  231.014567] WARNING: CPU: 0 PID: 2715 at kernel/irq/manage.c:1600 __free_irq+0x83/0x20c
[  231.025070] Trying to free already-free IRQ 92
[  231.029505] Modules linked in: usb_f_ecm u_ether libcomposite spidev hidp rfcomm hci_uart(-) btbcm bluetooth ecdh_generic brcmfmac brcmutil cfg80211 rfkill evdev sun8i_codec_analog sun8i_adda_pr_regmap snd_soc_core snd_pcm_dmaengine pwrseq_simple snd_pcm snd_timer snd soundcore hih6130 cpufreq_dt uio_pdrv_genirq gpio_keys uio thermal_sys
[  231.059389] CPU: 0 PID: 2715 Comm: rmmod Tainted: G        W         5.0.0-rc8+ #14
[  231.067032] Hardware name: Allwinner sun8i Family
[  231.071740] [<c010d4dd>] (unwind_backtrace) from [<c010a189>] (show_stack+0x11/0x14)
[  231.079481] [<c010a189>] (show_stack) from [<c085867b>] (dump_stack+0x67/0x74)
[  231.086701] [<c085867b>] (dump_stack) from [<c011afd1>] (__warn+0xb9/0xcc)
[  231.093574] [<c011afd1>] (__warn) from [<c011b017>] (warn_slowpath_fmt+0x33/0x48)
[  231.101054] [<c011b017>] (warn_slowpath_fmt) from [<c0160a03>] (__free_irq+0x83/0x20c)
[  231.108966] [<c0160a03>] (__free_irq) from [<c0160be7>] (free_irq+0x27/0x5c)
[  231.116012] [<c0160be7>] (free_irq) from [<c016386f>] (devm_free_irq+0x3f/0x60)
[  231.123326] [<c016386f>] (devm_free_irq) from [<bfb101b1>] (bcm_close+0x35/0xa8 [hci_uart])
[  231.131690] [<bfb101b1>] (bcm_close [hci_uart]) from [<bfb0cd3f>] (hci_uart_unregister_device+0x33/0x3c [hci_uart])
[  231.142133] [<bfb0cd3f>] (hci_uart_unregister_device [hci_uart]) from [<bfb0f9b7>] (bcm_serdev_remove+0xf/0x10 [hci_uart])
[  231.153174] [<bfb0f9b7>] (bcm_serdev_remove [hci_uart]) from [<c057896f>] (serdev_drv_remove+0x13/0x20)
[  231.162562] [<c057896f>] (serdev_drv_remove) from [<c05c1597>] (device_release_driver_internal+0xf7/0x158)
[  231.172209] [<c05c1597>] (device_release_driver_internal) from [<c05c1651>] (driver_detach+0x49/0x78)
[  231.181422] [<c05c1651>] (driver_detach) from [<c05c08f1>] (bus_remove_driver+0x31/0x70)
[  231.189517] [<c05c08f1>] (bus_remove_driver) from [<bfb10357>] (bcm_deinit+0x1b/0xcc4 [hci_uart])
[  231.198399] [<bfb10357>] (bcm_deinit [hci_uart]) from [<bfb102bb>] (hci_uart_exit+0x1b/0x34 [hci_uart])
[  231.207793] [<bfb102bb>] (hci_uart_exit [hci_uart]) from [<c0185f09>] (sys_delete_module+0x135/0x178)
[  231.217005] [<c0185f09>] (sys_delete_module) from [<c0101001>] (ret_fast_syscall+0x1/0x62)
[  231.225256] Exception stack(0xd66b7fa8 to 0xd66b7ff0)
[  231.230305] 7fa0:                   00c3dd00 00000000 00c3dd3c 00000800 88297c00 88297c00
[  231.238476] 7fc0: 00c3dd00 00000000 bef05e82 00000081 bef05b88 00000001 bef05d7c 00000000
[  231.246644] 7fe0: 0045bf6c bef05b24 00441303 b6edab26
[  231.251688] ---[ end trace dc4caa46c945c791 ]---

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbe518c3e5b..97a8ba607d0c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -488,7 +488,7 @@ static int bcm_close(struct hci_uart *hu)
 
 	if (bdev) {
 		if (IS_ENABLED(CONFIG_PM) && bdev->irq > 0) {
-			devm_free_irq(bdev->dev, bdev->irq, bdev);
+			disable_irq(bdev->irq);
 			device_init_wakeup(bdev->dev, false);
 			pm_runtime_disable(bdev->dev);
 		}
-- 
2.11.0

