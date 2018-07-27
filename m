Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF400C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8599920671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8599920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbeG0LI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:08:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbeG0LI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:08:29 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1CA40BBD;
        Fri, 27 Jul 2018 09:47:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.17 05/66] clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to 1.2GHz
Date:   Fri, 27 Jul 2018 11:44:58 +0200
Message-Id: <20180727093809.622587845@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregory CLEMENT <gregory.clement@bootlin.com>

commit 61c40f35f5cd6f67ccbd7319a1722eb78c815989 upstream.

Switching the CPU from the L2 or L3 frequencies (300 and 200 Mhz
respectively) to L0 frequency (1.2 Ghz) requires a significant amount
of time to let VDD stabilize to the appropriate voltage. This amount of
time is large enough that it cannot be covered by the hardware
countdown register. Due to this, the CPU might start operating at L0
before the voltage is stabilized, leading to CPU stalls.

To work around this problem, we prevent switching directly from the
L2/L3 frequencies to the L0 frequency, and instead switch to the L1
frequency in-between. The sequence therefore becomes:

1. First switch from L2/L3(200/300MHz) to L1(600MHZ)
2. Sleep 20ms for stabling VDD voltage
3. Then switch from L1(600MHZ) to L0(1200Mhz).

It is based on the work done by Ken Ma <make@marvell.com>

Cc: stable@vger.kernel.org
Fixes: 2089dc33ea0e ("clk: mvebu: armada-37xx-periph: add DVFS support for cpu clocks")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/mvebu/armada-37xx-periph.c |   38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -35,6 +35,7 @@
 #define CLK_SEL		0x10
 #define CLK_DIS		0x14
 
+#define  ARMADA_37XX_DVFS_LOAD_1 1
 #define LOAD_LEVEL_NR	4
 
 #define ARMADA_37XX_NB_L0L1	0x18
@@ -507,6 +508,40 @@ static long clk_pm_cpu_round_rate(struct
 	return -EINVAL;
 }
 
+/*
+ * Switching the CPU from the L2 or L3 frequencies (300 and 200 Mhz
+ * respectively) to L0 frequency (1.2 Ghz) requires a significant
+ * amount of time to let VDD stabilize to the appropriate
+ * voltage. This amount of time is large enough that it cannot be
+ * covered by the hardware countdown register. Due to this, the CPU
+ * might start operating at L0 before the voltage is stabilized,
+ * leading to CPU stalls.
+ *
+ * To work around this problem, we prevent switching directly from the
+ * L2/L3 frequencies to the L0 frequency, and instead switch to the L1
+ * frequency in-between. The sequence therefore becomes:
+ * 1. First switch from L2/L3(200/300MHz) to L1(600MHZ)
+ * 2. Sleep 20ms for stabling VDD voltage
+ * 3. Then switch from L1(600MHZ) to L0(1200Mhz).
+ */
+static void clk_pm_cpu_set_rate_wa(unsigned long rate, struct regmap *base)
+{
+	unsigned int cur_level;
+
+	if (rate != 1200 * 1000 * 1000)
+		return;
+
+	regmap_read(base, ARMADA_37XX_NB_CPU_LOAD, &cur_level);
+	cur_level &= ARMADA_37XX_NB_CPU_LOAD_MASK;
+	if (cur_level <= ARMADA_37XX_DVFS_LOAD_1)
+		return;
+
+	regmap_update_bits(base, ARMADA_37XX_NB_CPU_LOAD,
+			   ARMADA_37XX_NB_CPU_LOAD_MASK,
+			   ARMADA_37XX_DVFS_LOAD_1);
+	msleep(20);
+}
+
 static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
 			       unsigned long parent_rate)
 {
@@ -537,6 +572,9 @@ static int clk_pm_cpu_set_rate(struct cl
 			 */
 			reg = ARMADA_37XX_NB_CPU_LOAD;
 			mask = ARMADA_37XX_NB_CPU_LOAD_MASK;
+
+			clk_pm_cpu_set_rate_wa(rate, base);
+
 			regmap_update_bits(base, reg, mask, load_level);
 
 			return rate;


