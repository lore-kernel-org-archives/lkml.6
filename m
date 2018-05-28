Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163269AbeE1NdY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162824AbeE1KqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:46:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 116/496] soc: imx: gpc: de-register power domains only if initialized
Date: Mon, 28 May 2018 11:58:21 +0200
Message-Id: <20180528100324.818021501@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit 7801c545e706674aeed40256eb806ad37b18ad71 ]

If power domain information are missing in the device tree, no
power domains get initialized. However, imx_gpc_remove tries to
remove power domains always in the old DT binding case. Only
remove power domains when imx_gpc_probe initialized them in
first place.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/imx/gpc.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -456,13 +456,21 @@ static int imx_gpc_probe(struct platform
 
 static int imx_gpc_remove(struct platform_device *pdev)
 {
+	struct device_node *pgc_node;
 	int ret;
 
+	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
+
+	/* bail out if DT too old and doesn't provide the necessary info */
+	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
+	    !pgc_node)
+		return 0;
+
 	/*
 	 * If the old DT binding is used the toplevel driver needs to
 	 * de-register the power domains
 	 */
-	if (!of_get_child_by_name(pdev->dev.of_node, "pgc")) {
+	if (!pgc_node) {
 		of_genpd_del_provider(pdev->dev.of_node);
 
 		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
