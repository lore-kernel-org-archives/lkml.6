Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeEVHe7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:34:59 -0400
Received: from 4.mo7.mail-out.ovh.net ([178.32.122.254]:43957 "EHLO
        4.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbeEVHe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:34:58 -0400
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?=
        <sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?=
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
Date: Tue, 22 May 2018 08:28:51 +0200
Message-Id: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13126867014484710652
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedrgedtgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the max speed supported from the fuses for i.MX6ULL and update the
operating points table accordingly.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---

Changes for v3:
 - none

Changes for v2:
 - none

 drivers/cpufreq/imx6q-cpufreq.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 83cf631fc9bc..f094687cae52 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -266,6 +266,8 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
 }
 
 #define OCOTP_CFG3_6UL_SPEED_696MHZ	0x2
+#define OCOTP_CFG3_6ULL_SPEED_792MHZ	0x2
+#define OCOTP_CFG3_6ULL_SPEED_900MHZ	0x3
 
 static void imx6ul_opp_check_speed_grading(struct device *dev)
 {
@@ -287,16 +289,30 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
 	 * Speed GRADING[1:0] defines the max speed of ARM:
 	 * 2b'00: Reserved;
 	 * 2b'01: 528000000Hz;
-	 * 2b'10: 696000000Hz;
-	 * 2b'11: Reserved;
+	 * 2b'10: 696000000Hz on i.MX6UL, 792000000Hz on i.MX6ULL;
+	 * 2b'11: 900000000Hz on i.MX6ULL only;
 	 * We need to set the max speed of ARM according to fuse map.
 	 */
 	val = readl_relaxed(base + OCOTP_CFG3);
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
-	if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
-		if (dev_pm_opp_disable(dev, 696000000))
-			dev_warn(dev, "failed to disable 696MHz OPP\n");
+
+	if (of_machine_is_compatible("fsl,imx6ul")) {
+		if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
+			if (dev_pm_opp_disable(dev, 696000000))
+				dev_warn(dev, "failed to disable 696MHz OPP\n");
+	}
+
+	if (of_machine_is_compatible("fsl,imx6ull")) {
+		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
+			if (dev_pm_opp_disable(dev, 792000000))
+				dev_warn(dev, "failed to disable 792MHz OPP\n");
+
+		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
+			if (dev_pm_opp_disable(dev, 900000000))
+				dev_warn(dev, "failed to disable 900MHz OPP\n");
+	}
+
 	iounmap(base);
 put_node:
 	of_node_put(np);
@@ -356,7 +372,8 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_reg;
 	}
 
-	if (of_machine_is_compatible("fsl,imx6ul"))
+	if (of_machine_is_compatible("fsl,imx6ul") ||
+	    of_machine_is_compatible("fsl,imx6ull"))
 		imx6ul_opp_check_speed_grading(cpu_dev);
 	else
 		imx6q_opp_check_speed_grading(cpu_dev);
-- 
2.16.1
