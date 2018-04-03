Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755031AbeDCHRZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:17:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43704 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752845AbeDCHQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:16:12 -0400
X-UUID: f256c21335124e59a93e97c1c294b6a5-20180403
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Weiyi Lu" <weiyi.lu@mediatek.com>
Subject: [PATCH v1 3/7] soc: mediatek: reuse read[l,x]_poll_timeout helpers
Date: Tue, 3 Apr 2018 15:15:53 +0800
Message-ID: <2c0d233c658fa6093a18a54e82a3e51340251bc9.1522736996.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1522736996.git.sean.wang@mediatek.com>
References: <cover.1522736996.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23760.005
X-TM-AS-Result: No-4.829000-8.000000-10
X-TMASE-MatchedRID: Ei0WBMmFdJikwTZnxyBJ8wPZZctd3P4BCt59Uh3p/NXTNpsvj7/hy8EY
        HnJZxFh9E4XSoP7sKf/0p/NaRJTHE5pOsuuafTEbjtK7dC6UBnn/GH6wnR4D5rKMPhGFsui/Tjh
        be5bZI0g1aWq/d65GNYBStp5jwgJ5HxPMjOKY7A8LbigRnpKlKZvjAepGmdoORau7mly9HNQaJx
        7Ynm9myhUImKtMZOWWaYov/6JcruQ/kA3Verb7Mm+Nqft+LUuWii2bTHk7bARygIJR9gUu5JcKK
        5LU6un15APDq2B3cAxn2JWP8qFf9FKehBzm9vnO5B2Qzud0EsI35c5BnKCu9g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.829000-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23760.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Reuse the common helpers read[l,x]_poll_timeout provided by Linux core
instead of an open-coded handling. The name of the local variable
sram_pdn_ack in scpsys_power_on is renamed to pdn_ack in order to be
consistent with the one used in scpsys_power_off.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 91 ++++++++++-----------------------------
 1 file changed, 23 insertions(+), 68 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index d762a46..f9b7248 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -27,6 +28,9 @@
 #include <dt-bindings/power/mt7623a-power.h>
 #include <dt-bindings/power/mt8173-power.h>
 
+#define MTK_POLL_DELAY_US   10
+#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
+
 #define SPM_VDE_PWR_CON			0x0210
 #define SPM_MFG_PWR_CON			0x0214
 #define SPM_VEN_PWR_CON			0x0230
@@ -184,12 +188,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
 	struct scp *scp = scpd->scp;
-	unsigned long timeout;
-	bool expired;
 	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
-	u32 sram_pdn_ack = scpd->data->sram_pdn_ack_bits;
+	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
 	u32 val;
-	int ret;
+	int ret, tmp;
 	int i;
 
 	if (scpd->supply) {
@@ -215,23 +217,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	writel(val, ctl_addr);
 
 	/* wait until PWR_ACK = 1 */
-	timeout = jiffies + HZ;
-	expired = false;
-	while (1) {
-		ret = scpsys_domain_is_on(scpd);
-		if (ret > 0)
-			break;
-
-		if (expired) {
-			ret = -ETIMEDOUT;
-			goto err_pwr_ack;
-		}
-
-		cpu_relax();
-
-		if (time_after(jiffies, timeout))
-			expired = true;
-	}
+	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp > 0,
+				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		goto err_pwr_ack;
 
 	val &= ~PWR_CLK_DIS_BIT;
 	writel(val, ctl_addr);
@@ -246,20 +235,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	writel(val, ctl_addr);
 
 	/* wait until SRAM_PDN_ACK all 0 */
-	timeout = jiffies + HZ;
-	expired = false;
-	while (sram_pdn_ack && (readl(ctl_addr) & sram_pdn_ack)) {
-
-		if (expired) {
-			ret = -ETIMEDOUT;
-			goto err_pwr_ack;
-		}
-
-		cpu_relax();
-
-		if (time_after(jiffies, timeout))
-			expired = true;
-	}
+	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
+				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		goto err_pwr_ack;
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
@@ -289,12 +268,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 {
 	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
 	struct scp *scp = scpd->scp;
-	unsigned long timeout;
-	bool expired;
 	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
 	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
 	u32 val;
-	int ret;
+	int ret, tmp;
 	int i;
 
 	if (scpd->data->bus_prot_mask) {
@@ -310,19 +287,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	writel(val, ctl_addr);
 
 	/* wait until SRAM_PDN_ACK all 1 */
-	timeout = jiffies + HZ;
-	expired = false;
-	while (pdn_ack && (readl(ctl_addr) & pdn_ack) != pdn_ack) {
-		if (expired) {
-			ret = -ETIMEDOUT;
-			goto out;
-		}
-
-		cpu_relax();
-
-		if (time_after(jiffies, timeout))
-			expired = true;
-	}
+	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack,
+				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		goto out;
 
 	val |= PWR_ISO_BIT;
 	writel(val, ctl_addr);
@@ -340,23 +308,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	writel(val, ctl_addr);
 
 	/* wait until PWR_ACK = 0 */
-	timeout = jiffies + HZ;
-	expired = false;
-	while (1) {
-		ret = scpsys_domain_is_on(scpd);
-		if (ret == 0)
-			break;
-
-		if (expired) {
-			ret = -ETIMEDOUT;
-			goto out;
-		}
-
-		cpu_relax();
-
-		if (time_after(jiffies, timeout))
-			expired = true;
-	}
+	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp == 0,
+				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		goto out;
 
 	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
 		clk_disable_unprepare(scpd->clk[i]);
-- 
2.7.4
