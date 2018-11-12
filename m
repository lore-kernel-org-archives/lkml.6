Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6084DC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3330D20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3330D20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbeKLLTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:19:30 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:26527 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729694AbeKLLT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:19:29 -0500
X-UUID: 47729ef156614660a8f08258a4e16968-20181112
X-UUID: 47729ef156614660a8f08258a4e16968-20181112
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 467778218; Mon, 12 Nov 2018 09:28:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 12 Nov 2018 09:28:19 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 12 Nov 2018 09:28:19 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Weijie Gao <weijie.gao@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH v1 3/3] arm64: dts: mt7622: Drop the general purpose timer node
Date:   Mon, 12 Nov 2018 09:28:08 +0800
Message-ID: <17fde639c7d37f9cfabab230379913e652cf869a.1541643419.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <30f4a4110190a175307ac4dfebc98ffe96c44b90.1541643419.git.ryder.lee@mediatek.com>
References: <30f4a4110190a175307ac4dfebc98ffe96c44b90.1541643419.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash http://termbin.com/zitb is caused by the timer register
into system in early pahse during kernel boot, but the clock
sources didn't get ready at that time.

A better way is to switch to use CLK_OF_DECLARE() in driver for things
that need them early, but this node is actually useless in MT7622.
So we drop it.

Fixes: 9cc7f0de9e67 ("arm64: dts: mt7622: add timer, CCI-400 and PMU nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index fe0c875..14a1028 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -227,16 +227,6 @@
 		#reset-cells = <1>;
 	};
 
-	timer: timer@10004000 {
-		compatible = "mediatek,mt7622-timer",
-			     "mediatek,mt6577-timer";
-		reg = <0 0x10004000 0 0x80>;
-		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&infracfg CLK_INFRA_APXGPT_PD>,
-			 <&topckgen CLK_TOP_RTC>;
-		clock-names = "system-clk", "rtc-clk";
-	};
-
 	scpsys: scpsys@10006000 {
 		compatible = "mediatek,mt7622-scpsys",
 			     "syscon";
-- 
1.9.1

