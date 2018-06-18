Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C7C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEB620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEB620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755192AbeFRIXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:23:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbeFRIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4082CBAD;
        Mon, 18 Jun 2018 08:23:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 139/279] ARM: davinci: board-da830-evm: fix GPIO lookup for MMC/SD
Date:   Mon, 18 Jun 2018 10:12:04 +0200
Message-Id: <20180618080614.587703496@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sekhar Nori <nsekhar@ti.com>

[ Upstream commit 51e9f12163223546bd3aa9f7af6817931f980da8 ]

The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
mmc can correctly lookup the wp and cp gpios. Also fix the GPIO numbers
as they are not offsets within a bank.

Note that it is the gpio-davinci driver that sets the gpiochip label to
davinci_gpio.0.

Fixes: b5e1438cf98a ("ARM: davinci: da830-evm: use gpio descriptor for mmc pins")
Reported-by: David Lechner <david@lechnology.com>
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-davinci/board-da830-evm.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -205,12 +205,17 @@ static const short da830_evm_mmc_sd_pins
 	-1
 };
 
+#define DA830_MMCSD_WP_PIN		GPIO_TO_PIN(2, 1)
+#define DA830_MMCSD_CD_PIN		GPIO_TO_PIN(2, 2)
+
 static struct gpiod_lookup_table mmc_gpios_table = {
 	.dev_id = "da830-mmc.0",
 	.table = {
 		/* gpio chip 1 contains gpio range 32-63 */
-		GPIO_LOOKUP("davinci_gpio.1", 2, "cd", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.1", 1, "wp", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.0", DA830_MMCSD_CD_PIN, "cd",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.0", DA830_MMCSD_WP_PIN, "wp",
+			    GPIO_ACTIVE_LOW),
 	},
 };
 


