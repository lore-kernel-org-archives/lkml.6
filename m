Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeC3KCo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:02:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43861 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751215AbeC3KCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:02:40 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <thierry.reding@gmail.com>,
        <alexandre.torgue@st.com>
CC: <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH v3 1/6] dt-bindings: mfd: stm32-timers: add support for dmas
Date: Fri, 30 Mar 2018 12:01:19 +0200
Message-ID: <1522404084-24903-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
References: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-30_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DMAs to STM32 timers. STM32 Timers can support up to 7
dma requests: up to 4 channels, update, compare and trigger.
DMAs may be used to transfer data from pwm capture for instance.
DMA support is made optional, PWM capture support is also an option.
This is much more wise system-wide to avoid shortage on DMA request
lines as there's significant amount of timer instances that can
request up to 7 channels.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 .../devicetree/bindings/mfd/stm32-timers.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
index 1db6e00..0e900b5 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -19,6 +19,11 @@ Required parameters:
 Optional parameters:
 - resets:		Phandle to the parent reset controller.
 			See ../reset/st,stm32-rcc.txt
+- dmas:			List of phandle to dma channels that can be used for
+			this timer instance. There may be up to 7 dma channels.
+- dma-names:		List of dma names. Must match 'dmas' property. Valid
+			names are: "ch1", "ch2", "ch3", "ch4", "up", "trig",
+			"com".
 
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32.txt
@@ -44,3 +49,18 @@ Example:
 			reg = <0>;
 		};
 	};
+
+Example with all dmas:
+	timer@40010000 {
+		...
+		dmas = <&dmamux1 11 0x400 0x0>,
+		       <&dmamux1 12 0x400 0x0>,
+		       <&dmamux1 13 0x400 0x0>,
+		       <&dmamux1 14 0x400 0x0>,
+		       <&dmamux1 15 0x400 0x0>,
+		       <&dmamux1 16 0x400 0x0>,
+		       <&dmamux1 17 0x400 0x0>;
+		dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig", "com";
+		...
+		child nodes...
+	};
-- 
1.9.1
