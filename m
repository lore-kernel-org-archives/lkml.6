Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C0CFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5244620881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5244620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeG3LtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:49:07 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51448 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbeG3LtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:49:06 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B1EC200059;
        Mon, 30 Jul 2018 12:14:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C15A20004B;
        Mon, 30 Jul 2018 12:14:41 +0200 (CEST)
Received: from Tank.ap.freescale.net (tank.ap.freescale.net [10.193.20.104])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1D040402FC;
        Mon, 30 Jul 2018 18:14:34 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 3/3] ptp_qoriq: convert to use module parameters for initialization
Date:   Mon, 30 Jul 2018 18:01:54 +0800
Message-Id: <20180730100154.27906-3-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180730100154.27906-1-yangbo.lu@nxp.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ptp_qoriq driver initialized the 1588 timer with the
configurations provided by the properties of device tree
node. For example,

  fsl,tclk-period = <5>;
  fsl,tmr-prsc    = <2>;
  fsl,tmr-add     = <0xaaaaaaab>;
  fsl,tmr-fiper1  = <999999995>;
  fsl,tmr-fiper2  = <99990>;
  fsl,max-adj     = <499999999>;

These things actually were runtime configurations which
were not proper to be put into dts. This patch is to convert
to use module parameters for 1588 timer initialization, and
to support initial register values calculation.
If the parameters are not provided, the driver will calculate
register values with a set of default parameters. With this
patch, those dts properties are no longer needed for new
platform to support 1588 timer, and many QorIQ DPAA platforms
(some P series and T series platforms of PowerPC, and some
LS series platforms of ARM64) could use this driver for their
fman ptp timer with default module parameters. However, this
patch didn't remove the dts method. Because there were still
many old platforms using the dts method. We need to clean up
their dts files, verify module parameters on them, and convert
them to the new method gradually in case of breaking any
function.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/ptp/ptp_qoriq.c       |  117 +++++++++++++++++++++++++++++++++++++++-
 include/linux/fsl/ptp_qoriq.h |    1 +
 2 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index a14c317..22baf83 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -29,9 +29,30 @@
 #include <linux/of_platform.h>
 #include <linux/timex.h>
 #include <linux/slab.h>
+#include <linux/clk.h>
 
 #include <linux/fsl/ptp_qoriq.h>
 
+static unsigned int cksel = DEFAULT_CKSEL;
+module_param(cksel, uint, 0644);
+MODULE_PARM_DESC(cksel, "Select reference clock");
+
+static unsigned int clk_src;
+module_param(clk_src, uint, 0644);
+MODULE_PARM_DESC(clk_src, "Reference clock frequency (if clocks property not provided in dts)");
+
+static unsigned int tmr_prsc = 2;
+module_param(tmr_prsc, uint, 0644);
+MODULE_PARM_DESC(tmr_prsc, "Output clock division/prescale factor");
+
+static unsigned int tmr_fiper1 = 1000000000;
+module_param(tmr_fiper1, uint, 0644);
+MODULE_PARM_DESC(tmr_fiper1, "Desired fixed interval pulse period (ns)");
+
+static unsigned int tmr_fiper2 = 100000;
+module_param(tmr_fiper2, uint, 0644);
+MODULE_PARM_DESC(tmr_fiper2, "Desired fixed interval pulse period (ns)");
+
 /*
  * Register access functions
  */
@@ -317,6 +338,91 @@ static int ptp_qoriq_enable(struct ptp_clock_info *ptp,
 	.enable		= ptp_qoriq_enable,
 };
 
+/**
+ * qoriq_ptp_nominal_freq - calculate nominal frequency by reference clock
+ *			    frequency
+ *
+ * @clk_src: reference clock frequency
+ *
+ * The nominal frequency is the desired clock frequency.
+ * It should be less than the reference clock frequency.
+ * It should be a factor of 1000MHz.
+ *
+ * Return the nominal frequency
+ */
+static u32 qoriq_ptp_nominal_freq(u32 clk_src)
+{
+	u32 remainder = 0;
+
+	clk_src /= 1000000;
+	remainder = clk_src % 100;
+	if (remainder) {
+		clk_src -= remainder;
+		clk_src += 100;
+	}
+
+	do {
+		clk_src -= 100;
+
+	} while (1000 % clk_src);
+
+	return clk_src * 1000000;
+}
+
+static int qoriq_ptp_config(struct qoriq_ptp *qoriq_ptp,
+			    struct device_node *node)
+{
+	struct clk *clk;
+	u64 freq_comp;
+	u64 max_adj;
+	u32 nominal_freq;
+
+	qoriq_ptp->cksel = cksel;
+
+	if (clk_src) {
+		qoriq_ptp->clk_src = clk_src;
+	} else {
+		clk = of_clk_get(node, 0);
+		if (!IS_ERR(clk)) {
+			qoriq_ptp->clk_src = clk_get_rate(clk);
+			clk_put(clk);
+		}
+	}
+
+	if (qoriq_ptp->clk_src <= 100000000UL) {
+		pr_err("error reference clock value, or lower than 100MHz\n");
+		return -EINVAL;
+	}
+
+	nominal_freq = qoriq_ptp_nominal_freq(qoriq_ptp->clk_src);
+	if (!nominal_freq)
+		return -EINVAL;
+
+	qoriq_ptp->tclk_period = 1000000000UL / nominal_freq;
+	qoriq_ptp->tmr_prsc = tmr_prsc;
+
+	/* Calculate initial frequency compensation value for TMR_ADD register.
+	 * freq_comp = ceil(2^32 / freq_ratio)
+	 * freq_ratio = reference_clock_freq / nominal_freq
+	 */
+	freq_comp = ((u64)1 << 32) * nominal_freq;
+	if (do_div(freq_comp, qoriq_ptp->clk_src))
+		freq_comp++;
+
+	qoriq_ptp->tmr_add = freq_comp;
+	qoriq_ptp->tmr_fiper1 = tmr_fiper1 - qoriq_ptp->tclk_period;
+	qoriq_ptp->tmr_fiper2 = tmr_fiper2 - qoriq_ptp->tclk_period;
+
+	/* max_adj = 1000000000 * (freq_ratio - 1.0) - 1
+	 * freq_ratio = reference_clock_freq / nominal_freq
+	 */
+	max_adj = 1000000000ULL * (qoriq_ptp->clk_src - nominal_freq);
+	max_adj = max_adj / nominal_freq - 1;
+	qoriq_ptp->caps.max_adj = max_adj;
+
+	return 0;
+}
+
 static int qoriq_ptp_probe(struct platform_device *dev)
 {
 	struct device_node *node = dev->dev.of_node;
@@ -332,7 +438,7 @@ static int qoriq_ptp_probe(struct platform_device *dev)
 	if (!qoriq_ptp)
 		goto no_memory;
 
-	err = -ENODEV;
+	err = -EINVAL;
 
 	qoriq_ptp->caps = ptp_qoriq_caps;
 
@@ -351,10 +457,14 @@ static int qoriq_ptp_probe(struct platform_device *dev)
 				 "fsl,tmr-fiper2", &qoriq_ptp->tmr_fiper2) ||
 	    of_property_read_u32(node,
 				 "fsl,max-adj", &qoriq_ptp->caps.max_adj)) {
-		pr_err("device tree node missing required elements\n");
-		goto no_node;
+		pr_warn("device tree node missing required elements, try module param\n");
+
+		if (qoriq_ptp_config(qoriq_ptp, node))
+			goto no_param;
 	}
 
+	err = -ENODEV;
+
 	qoriq_ptp->irq = platform_get_irq(dev, 0);
 
 	if (qoriq_ptp->irq < 0) {
@@ -436,6 +546,7 @@ static int qoriq_ptp_probe(struct platform_device *dev)
 	release_resource(qoriq_ptp->rsrc);
 no_resource:
 	free_irq(qoriq_ptp->irq, qoriq_ptp);
+no_param:
 no_node:
 	kfree(qoriq_ptp);
 no_memory:
diff --git a/include/linux/fsl/ptp_qoriq.h b/include/linux/fsl/ptp_qoriq.h
index dc3dac4..586d430 100644
--- a/include/linux/fsl/ptp_qoriq.h
+++ b/include/linux/fsl/ptp_qoriq.h
@@ -147,6 +147,7 @@ struct qoriq_ptp {
 	u32 cksel;
 	u32 tmr_fiper1;
 	u32 tmr_fiper2;
+	u32 clk_src;
 };
 
 static inline u32 qoriq_read(unsigned __iomem *addr)
-- 
1.7.1

