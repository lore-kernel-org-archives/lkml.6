Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeDRQFl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:05:41 -0400
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:38314 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbeDRQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:05:39 -0400
X-Authority-Analysis: v=2.3 cv=OeS28CbY c=1 sm=1 tr=0
 a=IfKG9KDHjPrX0SZ8gMoyrg==:117 a=IfKG9KDHjPrX0SZ8gMoyrg==:17
 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=XW4pkaav5ZQx9IFfAeAA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
From: Markus Mayer <code@mmayer.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: Jim Quinlan <jim2101024@gmail.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Power Management List <linux-pm@vger.kernel.org>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if supported
Date: Wed, 18 Apr 2018 08:56:43 -0700
Message-Id: <20180418155643.36464-3-code@mmayer.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180418155643.36464-1-code@mmayer.net>
References: <20180418155643.36464-1-code@mmayer.net>
X-CMAE-Envelope: MS4wfI7G2cWSXehu2rOtki/wOTMDEpmKOxM7RtnOULAht0YItSq65Wqsw+lz8c025yGGXNNIVOnoGBbzcDKYY8S3zdmoyy0fKlb5p1WTd/BrZ4JYXr0ZqbkX
 ou7vLufXngcH4rlm2bEDIZlR8zEfaeiquMxwHhfi63yBWZqho9PWt2bJ55lsZqJpFySqEyCdiNfoJqZXVz8K5ZJE/NimLXC9oi2IPCUiBqIW2l98NBkyyfpR
 1wnPIkiStonciztMZRupmsAdV+cldr1bwUjN0aisV3h2mFY03RtBXzfUw25tc/4wBk1WaHyc0kPeLdmKvq38gVv96U4Dhet5MEj4DEnz6TBdrEPN40yPKdRd
 zzmTfW5v5CLjisbeEiJ33B4+MdHGh0s/iTdmjAmchst/sc7bOR3L4r4E4T0hm0FvaVClexawBm/qFHS62h8GWRUpX73qOZfA9EAwg3Wq7FaJC7ZtczEFZ+O3
 GVdNyxg/1AAOnDj/yktO+mgVOBNaZHScxpVkL4owx951CgS7eu/zBeoyYUUAoe4zdxyqOkM1UdH3oW2H
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Quinlan <jim2101024@gmail.com>

If the SCMI cpufreq driver is supported, we bail, so that the new
approach can be used.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index b07559b9ed99..b4861a730162 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -164,6 +164,8 @@
 #define BRCM_AVS_CPU_INTR	"brcm,avs-cpu-l2-intr"
 #define BRCM_AVS_HOST_INTR	"sw_intr"
 
+#define ARM_SCMI_COMPAT		"arm,scmi"
+
 struct pmap {
 	unsigned int mode;
 	unsigned int p1;
@@ -511,6 +513,20 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
 	struct device *dev;
 	int host_irq, ret;
 
+	/*
+	 * If the SCMI cpufreq driver is supported, we bail, so that the more
+	 * modern approach can be used.
+	 */
+	if (IS_ENABLED(CONFIG_ARM_SCMI_PROTOCOL)) {
+		struct device_node *np;
+
+		np = of_find_compatible_node(NULL, NULL, ARM_SCMI_COMPAT);
+		if (np) {
+			of_node_put(np);
+			return -ENXIO;
+		}
+	}
+
 	dev = &pdev->dev;
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
-- 
2.7.4
