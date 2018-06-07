Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PoJMFI1KGVupVgAAmS7hNA
	; Thu, 07 Jun 2018 15:09:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 532146063F; Thu,  7 Jun 2018 15:09:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 288A7601C3;
	Thu,  7 Jun 2018 15:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 288A7601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935756AbeFGPDR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:03:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41490 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965050AbeFGPDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:12 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbr-0005Zv-Ef; Thu, 07 Jun 2018 15:09:51 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb2-0002qf-3R; Thu, 07 Jun 2018 15:09:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Olof Johansson" <olof@lixom.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.166437680@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 117/410] arm: spear13xx: Fix dmas cells
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit cdd10409914184c7eee5ae3e11beb890c9c16c61 upstream.

The "dmas" cells for the designware DMA controller need to have only 3
properties apart from the phandle: request line, src master and
destination master. But the commit 6e8887f60f60 updated it incorrectly
while moving from platform code to DT. Fix it.

Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/devicetree/bindings/dma/snps-dma.txt | 2 +-
 arch/arm/boot/dts/spear1340.dtsi                   | 4 ++--
 arch/arm/boot/dts/spear13xx.dtsi                   | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/Documentation/devicetree/bindings/dma/snps-dma.txt
+++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
@@ -58,6 +58,6 @@ Example:
 		interrupts = <0 35 0x4>;
 		status = "disabled";
 		dmas = <&dmahost 12 0 1>,
-			<&dmahost 13 0 1 0>;
+			<&dmahost 13 1 0>;
 		dma-names = "rx", "rx";
 	};
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -113,8 +113,8 @@
 				reg = <0xb4100000 0x1000>;
 				interrupts = <0 105 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 0x600 0 0 1>, /* 0xC << 11 */
-					<&dwdma0 0x680 0 1 0>; /* 0xD << 7 */
+				dmas = <&dwdma0 12 0 1>,
+					<&dwdma0 13 1 0>;
 				dma-names = "tx", "rx";
 			};
 
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -100,7 +100,7 @@
 			reg = <0xb2800000 0x1000>;
 			interrupts = <0 29 0x4>;
 			status = "disabled";
-			dmas = <&dwdma0 0 0 0 0>;
+			dmas = <&dwdma0 0 0 0>;
 			dma-names = "data";
 		};
 
@@ -283,8 +283,8 @@
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 0x2000 0 0 0>, /* 0x4 << 11 */
-					<&dwdma0 0x0280 0 0 0>;  /* 0x5 << 7 */
+				dmas = <&dwdma0 4 0 0>,
+					<&dwdma0 5 0 0>;
 				dma-names = "tx", "rx";
 			};
 
