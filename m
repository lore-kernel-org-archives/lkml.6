Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97055C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6312520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6312520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbeLIVzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34822 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbeLIVzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:14 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002pr-5K; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003Om-MZ; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Guenter Roeck" <linux@roeck-us.net>,
        "Lee Jones" <lee.jones@linaro.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.356929859@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 142/328] mfd: sm501: Set coherent_dma_mask when
 creating subdevices
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 2f606da78230f09cf1a71fde6ee91d0c710fa2b2 upstream.

Instantiating the sm501 OHCI subdevice results in a kernel warning.

sm501-usb sm501-usb: SM501 OHCI
sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516
ohci_init+0x194/0x2d8
Modules linked in:

CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.18.0-rc7-00178-g0b5b1f9a78b5 #1
PC is at ohci_init+0x194/0x2d8
PR is at ohci_init+0x168/0x2d8
PC  : 8c27844c SP  : 8f81dd94 SR  : 40008001
TEA : 29613060
R0  : 00000000 R1  : 00000000 R2  : 00000000 R3  : 00000202
R4  : 8fa98b88 R5  : 8c277e68 R6  : 00000000 R7  : 00000000
R8  : 8f965814 R9  : 8c388100 R10 : 8fa98800 R11 : 8fa98928
R12 : 8c48302c R13 : 8fa98920 R14 : 8c48302c
MACH: 00000096 MACL: 0000017c GBR : 00000000 PR  : 8c278420

Call trace:
 [<(ptrval)>] usb_add_hcd+0x1e8/0x6ec
 [<(ptrval)>] _dev_info+0x0/0x54
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] ohci_hcd_sm501_drv_probe+0x114/0x2d8
...

Initialize coherent_dma_mask when creating SM501 subdevices to fix
the problem.

Fixes: b6d6454fdb66f ("mfd: SM501 core driver")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mfd/sm501.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -714,6 +714,7 @@ sm501_create_subdev(struct sm501_devdata
 	smdev->pdev.name = name;
 	smdev->pdev.id = sm->pdev_id;
 	smdev->pdev.dev.parent = sm->dev;
+	smdev->pdev.dev.coherent_dma_mask = 0xffffffff;
 
 	if (res_count) {
 		smdev->pdev.resource = (struct resource *)(smdev+1);

