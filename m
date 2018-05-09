Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965187AbeEIPuY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:50:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54770 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965103AbeEIPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:46:46 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 2/3] dt-bindings: rtc: update stm32-rtc documentation for stm32mp1 rtc
Date: Wed, 9 May 2018 17:46:09 +0200
Message-ID: <1525880770-22263-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
References: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC embedded in stm32mp1 SoC is slightly different from stm32h7 one, it
doesn't require to disable backup domain write protection, and rtc_ck
parent clock assignment isn't allowed.
To sum up, stm32mp1 RTC requires 2 clocks, pclk and rtc_ck, and an RTC
alarm interrupt.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
index 00f8b5d..c920e27 100644
--- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
@@ -1,25 +1,29 @@
 STM32 Real Time Clock
 
 Required properties:
-- compatible: can be either "st,stm32-rtc" or "st,stm32h7-rtc", depending on
-  the device is compatible with stm32(f4/f7) or stm32h7.
+- compatible: can be one of the following:
+  - "st,stm32-rtc" for devices compatible with stm32(f4/f7).
+  - "st,stm32h7-rtc" for devices compatible with stm32h7.
+  - "st,stm32mp1-rtc" for devices compatible with stm32mp1.
 - reg: address range of rtc register set.
 - clocks: can use up to two clocks, depending on part used:
   - "rtc_ck": RTC clock source.
-    It is required on stm32(f4/f7) and stm32h7.
   - "pclk": RTC APB interface clock.
     It is not present on stm32(f4/f7).
-    It is required on stm32h7.
+    It is required on stm32(h7/mp1).
 - clock-names: must be "rtc_ck" and "pclk".
-    It is required only on stm32h7.
+    It is required on stm32(h7/mp1).
 - interrupt-parent: phandle for the interrupt controller.
-- interrupts: rtc alarm interrupt.
+    It is required on stm32(f4/f7/h7).
+- interrupts: rtc alarm interrupt. On stm32mp1, a second interrupt is required
+  for rtc alarm wakeup interrupt.
 - st,syscfg: phandle/offset/mask triplet. The phandle to pwrcfg used to
   access control register at offset, and change the dbp (Disable Backup
   Protection) bit represented by the mask, mandatory to disable/enable backup
   domain (RTC registers) write protection.
+    It is required on stm32(f4/f7/h7).
 
-Optional properties (to override default rtc_ck parent clock):
+Optional properties (to override default rtc_ck parent clock on stm32(f4/f7/h7):
 - assigned-clocks: reference to the rtc_ck clock entry.
 - assigned-clock-parents: phandle of the new parent clock of rtc_ck.
 
@@ -48,3 +52,12 @@ Example:
 		interrupt-names = "alarm";
 		st,syscfg = <&pwrcfg 0x00 0x100>;
 	};
+
+	rtc: rtc@5c004000 {
+		compatible = "st,stm32mp1-rtc";
+		reg = <0x5c004000 0x400>;
+		clocks = <&rcc RTCAPB>, <&rcc RTC>;
+		clock-names = "pclk", "rtc_ck";
+		interrupts-extended = <&intc GIC_SPI 3 IRQ_TYPE_NONE>,
+				      <&exti 19 1>;
+	};
-- 
2.7.4
