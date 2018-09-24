Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2434ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5749208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5749208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeIXRiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:38:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50004 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIXRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1BA111061;
        Mon, 24 Sep 2018 11:36:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 010/105] mfd: sm501: Set coherent_dma_mask when creating subdevices
Date:   Mon, 24 Sep 2018 13:32:56 +0200
Message-Id: <20180924113114.395050978@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 2f606da78230f09cf1a71fde6ee91d0c710fa2b2 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/sm501.c |    1 +
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


