Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F76C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8548020878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfAKWL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:11:26 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42546 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfAKWL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:11:26 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E9061A0200;
        Fri, 11 Jan 2019 23:11:24 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D891D1A01FC;
        Fri, 11 Jan 2019 23:11:23 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.33.49])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id F0C5D40CAF;
        Fri, 11 Jan 2019 15:11:22 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Scott Wood <oss@buserror.net>
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH] soc: fsl: guts: reuse machine name from device tree
Date:   Fri, 11 Jan 2019 16:11:07 -0600
Message-Id: <20190111221107.952-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the string machine from the device tree data structure instead
of duplicating the data again.  This also prevents a potential memory
allocation failure that was not handled previously.  Also fixes an early
put of root device node.

Reported-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/guts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8d69d9..4f9655087bd7 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -32,6 +32,7 @@ struct fsl_soc_die_attr {
 static struct guts *guts;
 static struct soc_device_attribute soc_dev_attr;
 static struct soc_device *soc_dev;
+static struct device_node *root;
 
 
 /* SoC die attribute definition for QorIQ platform */
@@ -132,7 +133,7 @@ EXPORT_SYMBOL(fsl_guts_get_svr);
 
 static int fsl_guts_probe(struct platform_device *pdev)
 {
-	struct device_node *root, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	const struct fsl_soc_die_attr *soc_die;
@@ -155,9 +156,8 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	root = of_find_node_by_path("/");
 	if (of_property_read_string(root, "model", &machine))
 		of_property_read_string_index(root, "compatible", 0, &machine);
-	of_node_put(root);
 	if (machine)
-		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		soc_dev_attr.machine = machine;
 
 	svr = fsl_guts_get_svr();
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
@@ -192,6 +192,7 @@ static int fsl_guts_probe(struct platform_device *pdev)
 static int fsl_guts_remove(struct platform_device *dev)
 {
 	soc_device_unregister(soc_dev);
+	of_node_put(root);
 	return 0;
 }
 
-- 
2.17.1

