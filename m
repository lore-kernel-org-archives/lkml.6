Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbeCTMLQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:11:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39420 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752905AbeCTMLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:11:15 -0400
From: Sudeep Holla <sudeep.holla@arm.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: scmi: use devm_of_clk_add_hw_provider() API and drop scmi_clocks_remove
Date: Tue, 20 Mar 2018 12:11:07 +0000
Message-Id: <1521547867-23808-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-17-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-17-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aa795c41d9cd ("clk: Add devm_of_clk_add_hw_provider()/del_provider()
APIs") adds devm_of_clk_add_hw_provider which takes care of deleting the
clock provider when the clock providers device is removed.

This patch makes use of devm_of_clk_add_hw_provider() instead of
of_clk_add_hw_provider() so that we can eliminate the need of explicit
scmi_clocks_remove for just doing of_clk_del_provider()

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clk/clk-scmi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 26f1476d4a79..488c21376b55 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -172,15 +172,8 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		}
 	}

-	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
-}
-
-static void scmi_clocks_remove(struct scmi_device *sdev)
-{
-	struct device *dev = &sdev->dev;
-	struct device_node *np = dev->of_node;
-
-	of_clk_del_provider(np);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   clk_data);
 }

 static const struct scmi_device_id scmi_id_table[] = {
@@ -192,7 +185,6 @@ MODULE_DEVICE_TABLE(scmi, scmi_id_table);
 static struct scmi_driver scmi_clocks_driver = {
 	.name = "scmi-clocks",
 	.probe = scmi_clocks_probe,
-	.remove = scmi_clocks_remove,
 	.id_table = scmi_id_table,
 };
 module_scmi_driver(scmi_clocks_driver);
--
2.7.4
