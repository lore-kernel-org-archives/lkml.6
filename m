Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28314C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E165B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E165B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965699AbeFRIZW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:25:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935774AbeFRIZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:25:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1ABDFC7A;
        Mon, 18 Jun 2018 08:25:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Graeme Smecher <gsmecher@threespeedlogic.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 170/279] ARM: dts: correct missing "compatible" entry for ti81xx SoCs
Date:   Mon, 18 Jun 2018 10:12:35 +0200
Message-Id: <20180618080615.853866984@linuxfoundation.org>
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

From: Graeme Smecher <gsmecher@threespeedlogic.com>

[ Upstream commit 647efef69de483f1dd7944ede31b4cae16acb124 ]

The missing "compatible" entries are needed by drivers/clk/ti/clkctrl.c,
and without them the structures initialized in drivers/clk/ti/clk-814x.c
are not passed to configuration code. The result is a "not found from
clkctrl data" error message, although boot proceeds anyway.

The reason why the compatible is not found is because the board specific
files override the SoC compatible without including it. This did not
cause any issues until with the clkctrl nodes got introduced.

Very lightly tested on a (lurching) AM3874 design that's in the middle
of a kernel upgrade from TI's abandoned 2.6.37 tree.

Also tested on j5eco-evm and hp-t410 to verify the clkctrl clocks are
found.

Fixes: bb30465b5902 ("ARM: dts: dm814x: add clkctrl nodes")
Fixes: 80a06c0d8357 ("ARM: dts: dm816x: add clkctrl nodes")
Signed-off-by: Graeme Smecher <gsmecher@threespeedlogic.com>
[tony: updated to fix for 8168-evm, updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/dm8148-evm.dts       |    2 +-
 arch/arm/boot/dts/dm8148-t410.dts      |    2 +-
 arch/arm/boot/dts/dm8168-evm.dts       |    2 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "DM8148 EVM";
-	compatible = "ti,dm8148-evm", "ti,dm8148";
+	compatible = "ti,dm8148-evm", "ti,dm8148", "ti,dm814";
 
 	memory@80000000 {
 		device_type = "memory";
--- a/arch/arm/boot/dts/dm8148-t410.dts
+++ b/arch/arm/boot/dts/dm8148-t410.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "HP t410 Smart Zero Client";
-	compatible = "hp,t410", "ti,dm8148";
+	compatible = "hp,t410", "ti,dm8148", "ti,dm814";
 
 	memory@80000000 {
 		device_type = "memory";
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "DM8168 EVM";
-	compatible = "ti,dm8168-evm", "ti,dm8168";
+	compatible = "ti,dm8168-evm", "ti,dm8168", "ti,dm816";
 
 	memory@80000000 {
 		device_type = "memory";
--- a/arch/arm/boot/dts/dra62x-j5eco-evm.dts
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "DRA62x J5 Eco EVM";
-	compatible = "ti,dra62x-j5eco-evm", "ti,dra62x", "ti,dm8148";
+	compatible = "ti,dra62x-j5eco-evm", "ti,dra62x", "ti,dm8148", "ti,dm814";
 
 	memory@80000000 {
 		device_type = "memory";


