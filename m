Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45650ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0981120864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0981120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGPICC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:02:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeGPICB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:02:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2D779CA5;
        Mon, 16 Jul 2018 07:36:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 4.17 06/67] drm/etnaviv: Fix driver unregistering
Date:   Mon, 16 Jul 2018 09:34:35 +0200
Message-Id: <20180716073444.139871619@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
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

From: Fabio Estevam <fabio.estevam@nxp.com>

commit bf6ba3aeb2962e5ee4a78e7535af579ecba630bb upstream.

Russell King reported:

"When removing and reloading the etnaviv module, the following splat
occurs:

sysfs: cannot create duplicate filename '/devices/platform/etnaviv'
CPU: 0 PID: 1471 Comm: modprobe Not tainted 4.17.0+ #1608
Hardware name: Marvell Dove (Cubox)
Backtrace:
[<c00157d4>] (dump_backtrace) from [<c0015b8c>] (show_stack+0x18/0x1c)
 r6:ef033e38 r5:ee07b340 r4:edb9d000 r3:00000000
[<c0015b74>] (show_stack) from [<c0620784>] (dump_stack+0x20/0x28)
[<c0620764>] (dump_stack) from [<c01bcd24>] (sysfs_warn_dup+0x5c/0x70)
[<c01bccc8>] (sysfs_warn_dup) from [<c01bce14>] (sysfs_create_dir_ns+0x90/0x98)
..."

Commit 246774d17fc0 ("drm/etnaviv: remove the need for a gpu-subsystem
DT node") introduced DRM registration via
platform_device_register_simple(), but missed to call
platform_device_unregister() inside etnaviv_exit().

Fix the problem by calling platform_device_unregister() inside
etnaviv_exit(). While at it, also rearrange the function calls
in the exit path to make them happen in the opposite order of
registration.

Tested on a imx6-sabresd board.

Cc: <stable@vger.kernel.org>
Fixes: 246774d17fc0 ("drm/etnaviv: remove the need for a gpu-subsystem DT node")
Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -742,8 +742,9 @@ module_init(etnaviv_init);
 
 static void __exit etnaviv_exit(void)
 {
-	platform_driver_unregister(&etnaviv_gpu_driver);
+	platform_device_unregister(etnaviv_drm);
 	platform_driver_unregister(&etnaviv_platform_driver);
+	platform_driver_unregister(&etnaviv_gpu_driver);
 }
 module_exit(etnaviv_exit);
 


