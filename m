Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7CFC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E645F24FC9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E645F24FC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeGAQM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:12:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60014 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932083AbeGAQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:12:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 556324A3;
        Sun,  1 Jul 2018 16:12:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 18/85] ARM: davinci: board-dm355-evm: fix broken networking
Date:   Sun,  1 Jul 2018 18:01:36 +0200
Message-Id: <20180701153123.081777113@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
+#include <linux/dm9000.h>
 #include <linux/videodev2.h>
 #include <media/tvp514x.h>
 #include <linux/spi/spi.h>
@@ -170,11 +171,16 @@ static struct resource dm355evm_dm9000_r
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


