Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C9C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B7C20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B7C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGI2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:28:36 -0500
Received: from www.osadl.org ([62.245.132.105]:54898 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeLGI2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:28:36 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB78PpRI010223;
        Fri, 7 Dec 2018 09:25:51 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
Date:   Fri,  7 Dec 2018 09:22:43 +0100
Message-Id: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kstrdup() may return NULL if internal allocation failed, but
as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
can be used here, which will only copy the reference.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
---

Problem located by experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)

Patch is against 4.20-rc5 (localversion-next is next-20181207)

 drivers/soc/fsl/guts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..15071ec 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -157,7 +157,8 @@ static int fsl_guts_probe(struct platform_device *pdev)
 		of_property_read_string_index(root, "compatible", 0, &machine);
 	of_node_put(root);
 	if (machine)
-		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		soc_dev_attr.machine = devm_kstrdup_const(dev, machine,
+							  GFP_KERNEL);
 
 	svr = fsl_guts_get_svr();
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
-- 
2.1.4

