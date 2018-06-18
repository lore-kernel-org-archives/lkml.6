Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA06DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA4C208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA4C208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965149AbeFRIVp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:21:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965094AbeFRIVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:21:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 53942C84;
        Mon, 18 Jun 2018 08:21:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 142/279] ARM: davinci: board-dm355-evm: fix broken networking
Date:   Mon, 18 Jun 2018 10:12:07 +0200
Message-Id: <20180618080614.708539871@linuxfoundation.org>
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

[ Upstream commit 5c054de228dd6d97bf8e38962bd118953b66e5a0 ]

Since commit 09f3756bb9a8 ("dm9000: Return an ERR_PTR() in all
error conditions of dm9000_parse_dt()"), passing either non-NULL
platform data or device-tree for dm9000 driver to probe is
mandatory.

DM335 board was using none, so networking failed to initialize.
Fix it by passing non-NULL (but empty) platform data.

Fixes: 09f3756bb9a8 ("dm9000: Return an ERR_PTR() in all error conditions of dm9000_parse_dt()")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-davinci/board-dm355-evm.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -19,6 +19,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/clk.h>
+#include <linux/dm9000.h>
 #include <linux/videodev2.h>
 #include <media/i2c/tvp514x.h>
 #include <linux/spi/spi.h>
@@ -179,11 +180,16 @@ static struct resource dm355evm_dm9000_r
 	},
 };
 
+static struct dm9000_plat_data dm335evm_dm9000_platdata;
+
 static struct platform_device dm355evm_dm9000 = {
 	.name		= "dm9000",
 	.id		= -1,
 	.resource	= dm355evm_dm9000_rsrc,
 	.num_resources	= ARRAY_SIZE(dm355evm_dm9000_rsrc),
+	.dev		= {
+		.platform_data = &dm335evm_dm9000_platdata,
+	},
 };
 
 static struct tvp514x_platform_data tvp5146_pdata = {


