Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030607AbeEYVhc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:37:32 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030216AbeEYVh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:37:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Hemanth Puranik <hpuranik@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH, net-next] qcom-emag: hide ACPI specific functions
Date: Fri, 25 May 2018 23:37:10 +0200
Message-Id: <20180525213714.2120604-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:JPcAZwiNhgkavDN4Bhbk/23Cw2ovy58EOQxA6F2SAFu0GgyFDtP
 Omm2Kow9Tl7wz6EiYtaG1l7zy2PgPpxKdl3BqHGYTrYr2UQJcXiotF9/FEiS2afQyo9z7tg
 CR83l6vOKfn8a8gmSYuZfzOElbejpF60LEzWVkzX/VSXplVh/0ZbaFsZpo1ZGcCqClciCxe
 9YEN6nqN3HiAjZff9uDDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:69QVh6dSxvg=:igmiAMIV/BrVqUjhyriCM0
 YFjkoCnwGc2Q3/jSRoL0I1bdTQjOSlu11IY8mdkgqIpnyzNm1Tx7RxveqKfPTAg3ifzdOOSqu
 GzYzkRUp5hWV4bU4Gos0s4zVh7tpU01/u16yfzwfrvS8PRf+X5Z8EUBiP1q49xRcMOpqTWgNN
 YniXCT+s2hy0BXCc3cuWX5qHD1r7xbyTSlxmbZzgA+Q2h7SzlFuFKYvbpUM+v2mBAqxNgMTw+
 ueRXZVQqkNIYrTWpsj2sbwVfQjxfVxgaL+x5srRQX7ORCScIJt2Ehelkf2q6vFy0XVL0hjZpt
 ZMpXz/n3K3Z1CCqHZTJ/biKe1UrFnUuX6A1P/DWOEy5ByUQyt/VXhQIr7KKKklAdtLhCTkboJ
 wLVq1uH7HgFHqvdE9Q5JiVJSAHw+iGo30AoISyvAVk75MSmd+T5BtayAGXit/Q7j0/zUWSORR
 sb7TUJh8IjcwXozRaxA2CyTvar2Hr844/7vYQjrfnLHfq9/J660z2+Ibek9GV0oH/CU8Q6pne
 tkNY2y9YsXUKTHbeYLdbDE+GKrHoDsW5IOl91UTG2yGYBo0hEPf2r31VqZmXGhwKyANAtSCdA
 zfMCBIflmCf8rWgz8Tejn4QUPT8qGO74m1aFgtN7JpUkcGKKpzt3YXQds5Vf7ZcNn7xU7U9Bk
 LqiXD91ft6evQMT8Bfli5ICMzM+dkeALBCf3XYxLbdm1A1o4iFV0LtmEKqzngeKAiaOk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of functions in this file are only used when building with
ACPI enabled, leading to a build warning on most architectures:

drivers/net/ethernet/qualcomm/emac/emac-sgmii.c:284:25: error: 'qdf2400_ops' defined but not used [-Werror=unused-variable]
 static struct sgmii_ops qdf2400_ops = {
                         ^~~~~~~~~~~
drivers/net/ethernet/qualcomm/emac/emac-sgmii.c:276:25: error: 'qdf2432_ops' defined but not used [-Werror=unused-variable]
 static struct sgmii_ops qdf2432_ops = {

This hides all the unused functions by putting them into the
corresponding #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
index 562420b834df..01b80e0a5367 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
@@ -108,6 +108,7 @@ static void emac_sgmii_link_init(struct emac_adapter *adpt)
 	writel(val, phy->base + EMAC_SGMII_PHY_AUTONEG_CFG2);
 }
 
+#ifdef CONFIG_ACPI
 static int emac_sgmii_irq_clear(struct emac_adapter *adpt, u8 irq_bits)
 {
 	struct emac_sgmii *phy = &adpt->phy;
@@ -288,6 +289,7 @@ static struct sgmii_ops qdf2400_ops = {
 	.link_change = emac_sgmii_common_link_change,
 	.reset = emac_sgmii_common_reset,
 };
+#endif
 
 static int emac_sgmii_acpi_match(struct device *dev, void *data)
 {
-- 
2.9.0
