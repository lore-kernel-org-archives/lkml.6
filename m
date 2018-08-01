Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72764C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3BC2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3BC2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbeHAUMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:12:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404338AbeHATDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 860FC11B0;
        Wed,  1 Aug 2018 17:07:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 269/336] soc: imx: gpcv2: Do not pass static memory as platform data
Date:   Wed,  1 Aug 2018 18:50:04 +0200
Message-Id: <20180801165039.336372110@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Andrey Smirnov <andrew.smirnov@gmail.com>

[ Upstream commit 050f810e238f268670f14a8f8b793ba2dbf2e92f ]

Platform device core assumes the ownership of dev.platform_data as
well as that it is dynamically allocated and it will try to kfree it
as a part of platform_device_release(). Change the code to use
platform_device_add_data() n instead of a pointer to a static memory
to avoid causing a BUG() when calling platform_device_put().

The problem can be reproduced by artificially enabling the error path
of platform_device_add() call (around line 357).

Note that this change also allows us to constify imx7_pgc_domains,
since we no longer need to be able to modify it.

Cc: Stefan Agner <stefan@agner.ch>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/imx/gpcv2.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -155,7 +155,7 @@ static int imx7_gpc_pu_pgc_sw_pdn_req(st
 	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
 }
 
-static struct imx7_pgc_domain imx7_pgc_domains[] = {
+static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 	[IMX7_POWER_DOMAIN_MIPI_PHY] = {
 		.genpd = {
 			.name      = "mipi-phy",
@@ -321,11 +321,6 @@ static int imx_gpcv2_probe(struct platfo
 			continue;
 		}
 
-		domain = &imx7_pgc_domains[domain_index];
-		domain->regmap = regmap;
-		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
-		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
-
 		pd_pdev = platform_device_alloc("imx7-pgc-domain",
 						domain_index);
 		if (!pd_pdev) {
@@ -334,7 +329,20 @@ static int imx_gpcv2_probe(struct platfo
 			return -ENOMEM;
 		}
 
-		pd_pdev->dev.platform_data = domain;
+		ret = platform_device_add_data(pd_pdev,
+					       &imx7_pgc_domains[domain_index],
+					       sizeof(imx7_pgc_domains[domain_index]));
+		if (ret) {
+			platform_device_put(pd_pdev);
+			of_node_put(np);
+			return ret;
+		}
+
+		domain = pd_pdev->dev.platform_data;
+		domain->regmap = regmap;
+		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
+		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
+
 		pd_pdev->dev.parent = dev;
 		pd_pdev->dev.of_node = np;
 


