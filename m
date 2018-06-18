Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB11EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E09208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E09208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967591AbeFRJAS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:00:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966965AbeFRIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:33:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C1D47BBE;
        Mon, 18 Jun 2018 08:33:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 092/189] ARM: davinci: board-da850-evm: fix GPIO lookup for MMC/SD
Date:   Mon, 18 Jun 2018 10:13:08 +0200
Message-Id: <20180618081212.924840775@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sekhar Nori <nsekhar@ti.com>

[ Upstream commit 67c6b6ff221f807180aea6dd597246f87e1dd98a ]

The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
mmc can correctly lookup the wp and cp gpios. Also fix the GPIO numbers
as they are not offsets within a bank.

Note that it is the gpio-davinci driver that sets the gpiochip label to
davinci_gpio.0.

Fixes: bdf0e8364fd3 ("ARM: davinci: da850-evm: use gpio descriptor for mmc pins")
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-davinci/board-da850-evm.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -763,12 +763,17 @@ static const short da850_evm_mcasp_pins[
 	-1
 };
 
+#define DA850_MMCSD_CD_PIN		GPIO_TO_PIN(4, 0)
+#define DA850_MMCSD_WP_PIN		GPIO_TO_PIN(4, 1)
+
 static struct gpiod_lookup_table mmc_gpios_table = {
 	.dev_id = "da830-mmc.0",
 	.table = {
 		/* gpio chip 2 contains gpio range 64-95 */
-		GPIO_LOOKUP("davinci_gpio.2", 0, "cd", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.2", 1, "wp", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_CD_PIN, "cd",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_WP_PIN, "wp",
+			    GPIO_ACTIVE_LOW),
 	},
 };
 


