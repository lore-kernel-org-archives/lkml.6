Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BF1C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF462086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF462086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeIKMZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:25:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58860 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727384AbeIKMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:25:39 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8B7NucM011467;
        Tue, 11 Sep 2018 09:27:06 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2me8jb89mg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Sep 2018 09:27:06 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 324B63D;
        Tue, 11 Sep 2018 07:27:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 054741E3B;
        Tue, 11 Sep 2018 07:27:05 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 11 Sep 2018 09:27:04
 +0200
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 1/7] dt-bindings: stm32-dma: Add DMA/MDMA chaining support bindings
Date:   Tue, 11 Sep 2018 09:26:54 +0200
Message-ID: <1536650820-16076-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
References: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dma bindings to support DMA/MDMA chaining transfer.
1 bit is to manage both DMA FIFO Threshold
1 bit is to manage DMA/MDMA Chaining features.
2 bits are used to specify SDRAM size to use for DMA/MDMA chaining.
The size in bytes of a certain order is given by the formula:
    (2 ^ order) * PAGE_SIZE.
The order is given by those 2 bits.
For cyclic, whether chaining is chosen, any value above 1 can be set :
SRAM buffer size will rely on period size and not on this DT value.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 .../devicetree/bindings/dma/stm32-dma.txt          | 32 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
index c5f5190..163be09 100644
--- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
+++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
@@ -17,6 +17,12 @@ Optional properties:
 - resets: Reference to a reset controller asserting the DMA controller
 - st,mem2mem: boolean; if defined, it indicates that the controller supports
   memory-to-memory transfer
+- dmas: A list of eight dma specifiers, one for each entry in dma-names.
+  Refer to stm32-mdma.txt for more details.
+- dma-names: should contain "ch0", "ch1", "ch2", "ch3", "ch4", "ch5", "ch6" and
+  "ch7" and represents each STM32 DMA channel connected to a STM32 MDMA one.
+- memory-region : phandle to a node describing memory to be used for
+  M2M intermediate transfer between DMA and MDMA.
 
 Example:
 
@@ -36,6 +42,16 @@ Example:
 		st,mem2mem;
 		resets = <&rcc 150>;
 		dma-requests = <8>;
+		dmas = <&mdma1 8 0x10 0x1200000a 0x40026408 0x00000020 1>,
+		       <&mdma1 9 0x10 0x1200000a 0x40026408 0x00000800 1>,
+		       <&mdma1 10 0x10 0x1200000a 0x40026408 0x00200000 1>,
+		       <&mdma1 11 0x10 0x1200000a 0x40026408 0x08000000 1>,
+		       <&mdma1 12 0x10 0x1200000a 0x4002640C 0x00000020 1>,
+		       <&mdma1 13 0x10 0x1200000a 0x4002640C 0x00000800 1>,
+		       <&mdma1 14 0x10 0x1200000a 0x4002640C 0x00200000 1>,
+		       <&mdma1 15 0x10 0x1200000a 0x4002640C 0x08000000 1>;
+		dma-names = "ch0", "ch1", "ch2", "ch3", "ch4", "ch5", "ch6", "ch7";
+		memory-region = <&sram_dmapool>;
 	};
 
 * DMA client
@@ -62,13 +78,21 @@ channel: a phandle to the DMA controller plus the following four integer cells:
 	0x1: medium
 	0x2: high
 	0x3: very high
-4. A 32bit bitfield value specifying DMA features which are device dependent:
+4. A bitfield value specifying DMA features which are device dependent:
  -bit 0-1: DMA FIFO threshold selection
 	0x0: 1/4 full FIFO
 	0x1: 1/2 full FIFO
 	0x2: 3/4 full FIFO
 	0x3: full FIFO
-
+ -bit 2: Intermediate M2M transfer from/to DDR to/from SRAM throughout MDMA
+	0: MDMA not used to generate an intermediate M2M transfer
+	1: MDMA used to generate an intermediate M2M transfer.
+ -bit 3-4: indicated SRAM Buffer size in (2^order)*PAGE_SIZE.
+	Order is given by those 2 bits starting at 0.
+	Valid only whether Intermediate M2M transfer is set.
+	For cyclic, whether Intermediate M2M transfer is chosen, any value can
+	be set: SRAM buffer size will rely on period size and not on this DT
+	value.
 
 Example:
 
@@ -77,7 +101,7 @@ Example:
 		reg = <0x40011000 0x400>;
 		interrupts = <37>;
 		clocks = <&clk_pclk2>;
-		dmas = <&dma2 2 4 0x10400 0x3>,
-		       <&dma2 7 5 0x10200 0x3>;
+		dmas = <&dma2 2 4 0x10400 0x1>,
+		       <&dma2 7 5 0x10200 0x1>;
 		dma-names = "rx", "tx";
 	};
-- 
2.7.4

