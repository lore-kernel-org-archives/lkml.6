Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933608AbeE2KoS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:44:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933596AbeE2KoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:44:13 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <timur@codeaurora.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: qcom/emac: fix unused variable
Date: Tue, 29 May 2018 18:43:43 +0800
Message-ID: <20180529104343.19448-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ACPI isn't set, variable qdf2400_ops/qdf2432_ops isn't used.
drivers/net/ethernet/qualcomm/emac/emac-sgmii.c:284:25: warning: ‘qdf2400_ops’ defined but not used [-Wunused-variable]
 static struct sgmii_ops qdf2400_ops = {
                         ^~~~~~~~~~~
drivers/net/ethernet/qualcomm/emac/emac-sgmii.c:276:25: warning: ‘qdf2432_ops’ defined but not used [-Wunused-variable]
 static struct sgmii_ops qdf2432_ops = {
                         ^~~~~~~~~~~

Move the declaration and functions inside the CONFIG_ACPI ifdef 
to fix the warning.
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
index 562420b..15609cb 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
@@ -108,6 +108,7 @@ static void emac_sgmii_link_init(struct emac_adapter *adpt)
 	writel(val, phy->base + EMAC_SGMII_PHY_AUTONEG_CFG2);
 }
 
+#ifdef CONFIG_ACPI
 static int emac_sgmii_irq_clear(struct emac_adapter *adpt, u8 irq_bits)
 {
 	struct emac_sgmii *phy = &adpt->phy;
@@ -291,7 +292,6 @@ static struct sgmii_ops qdf2400_ops = {
 
 static int emac_sgmii_acpi_match(struct device *dev, void *data)
 {
-#ifdef CONFIG_ACPI
 	static const struct acpi_device_id match_table[] = {
 		{
 			.id = "QCOM8071",
@@ -327,10 +327,16 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
 			return 1;
 		}
 	}
-#endif
 
 	return 0;
 }
+#else
+static int emac_sgmii_acpi_match(struct device *dev, void *data)
+{
+	return 0;
+}
+
+#endif
 
 static const struct of_device_id emac_sgmii_dt_match[] = {
 	{
-- 
2.7.0
