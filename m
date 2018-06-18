Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89749C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AFD20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AFD20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967483AbeFRId2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:33:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967091AbeFRId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:33:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8EB72C50;
        Mon, 18 Jun 2018 08:33:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 093/189] ARM: davinci: board-omapl138-hawk: fix GPIO numbers for MMC/SD lookup
Date:   Mon, 18 Jun 2018 10:13:09 +0200
Message-Id: <20180618081212.965197289@linuxfoundation.org>
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

[ Upstream commit d45622c0eaa5992a1a2248cbe93e1ff7a2da7be4 ]

commit c4dc56be7e26 ("ARM: davinci: fix the GPIO lookup for omapl138-hawk")
fixed the GPIO chip name for look-up of MMC/SD CD and WP pins, but forgot
to change the GPIO numbers passed.

The GPIO numbers are not offsets from within a 32 GPIO bank. Fix the
GPIO numbers as well as remove the misleading comment.

Fixes: c4dc56be7e26 ("ARM: davinci: fix the GPIO lookup for omapl138-hawk")
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -123,12 +123,16 @@ static const short hawk_mmcsd0_pins[] =
 	-1
 };
 
+#define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
+#define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
+
 static struct gpiod_lookup_table mmc_gpios_table = {
 	.dev_id = "da830-mmc.0",
 	.table = {
-		/* CD: gpio3_12: gpio60: chip 1 contains gpio range 32-63*/
-		GPIO_LOOKUP("davinci_gpio.0", 28, "cd", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.0", 29, "wp", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.0", DA850_HAWK_MMCSD_CD_PIN, "cd",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.0", DA850_HAWK_MMCSD_WP_PIN, "wp",
+			    GPIO_ACTIVE_LOW),
 	},
 };
 


