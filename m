Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C15C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 08:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C2220855
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 08:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeL2I1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 03:27:01 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:36484 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbeL2I1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 03:27:01 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 85FDB54A5E255E6E00F8;
        Sat, 29 Dec 2018 16:26:57 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBT8Qk1H063195;
        Sat, 29 Dec 2018 16:26:46 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018122916273201-19500989 ;
          Sat, 29 Dec 2018 16:27:32 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     qiang.zhao@nxp.com, leoyang.li@nxp.com
Cc:     linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
Date:   Sat, 29 Dec 2018 16:47:32 +0800
Message-Id: <1546073252-98777-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-29 16:27:32,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-29 16:26:26,
        Serialize complete at 2018-12-29 16:26:26
X-MAIL: mse01.zte.com.cn wBT8Qk1H063195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

Currently there are some issues with the ucc_of_parse_tdm function:
1, a possible null pointer dereference in ucc_of_parse_tdm,
detected by the semantic patch deref_null.cocci,
with the following warning:
drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
2, dev gets modified, so in any case that devm_iounmap() will fail
even when the new pdev is valid, because the iomap was done with a
 different pdev.
3, there is no driver bind with the "fsl,t1040-qe-si" or
"fsl,t1040-qe-siram" device. So allocating resources using devm_*()
with these devices won't provide a cleanup path for these resources
when the caller fails.

This patch fixes them.

Suggested-by: Li Yang <leoyang.li@nxp.com>
Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Zhao Qiang <qiang.zhao@nxp.com>
CC: David S. Miller <davem@davemloft.net>
CC: netdev@vger.kernel.org
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
---
 drivers/net/wan/fsl_ucc_hdlc.c | 52 ++++++++++++++++++++++++++++++++++++++-
 drivers/soc/fsl/qe/qe_tdm.c    | 55 ------------------------------------------
 2 files changed, 51 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 839fa77..07a496c 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1057,6 +1057,26 @@ static const struct net_device_ops uhdlc_ops = {
 	.ndo_tx_timeout	= uhdlc_tx_timeout,
 };
 
+static struct resource *ucc_get_resource_by_nodename(char *name)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+
+	np = of_find_compatible_node(NULL, NULL, name);
+	if (!np)
+		return ERR_PTR(-EINVAL);
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		pr_err("%pOFn: failed to lookup pdev\n", np);
+		of_node_put(np);
+		return ERR_PTR(-EINVAL);
+	}
+
+	of_node_put(np);
+	return platform_get_resource(pdev, IORESOURCE_MEM, 0);
+}
+
 static int ucc_hdlc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1070,6 +1090,8 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	const char *sprop;
 	int ret;
 	u32 val;
+	struct resource *r_mem;
+	static int siram_init_flag;
 
 	ret = of_property_read_u32_index(np, "cell-index", 0, &val);
 	if (ret) {
@@ -1151,6 +1173,31 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 		ret = ucc_of_parse_tdm(np, utdm, ut_info);
 		if (ret)
 			goto free_utdm;
+
+		r_mem = ucc_get_resource_by_nodename("fsl,t1040-qe-si");
+		if (IS_ERR_OR_NULL(r_mem)) {
+			ret = -EINVAL;
+			goto free_utdm;
+		}
+		utdm->si_regs = ioremap(r_mem->start, resource_size(r_mem));
+		if (!utdm->si_regs) {
+			ret = -ENOMEM;
+			goto free_utdm;
+		}
+		r_mem = ucc_get_resource_by_nodename("fsl,t1040-qe-siram");
+		if (IS_ERR_OR_NULL(r_mem)) {
+			ret = -EINVAL;
+			goto unmap_si_regs;
+		}
+		utdm->siram = ioremap(r_mem->start, resource_size(r_mem));
+		if (!utdm->siram) {
+			ret = -ENOMEM;
+			goto unmap_si_regs;
+		}
+		if (siram_init_flag == 0) {
+			memset_io(utdm->siram, 0,  resource_size(r_mem));
+			siram_init_flag = 1;
+		}
 	}
 
 	if (of_property_read_u16(np, "fsl,hmask", &uhdlc_priv->hmask))
@@ -1159,7 +1206,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	ret = uhdlc_init(uhdlc_priv);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to init uhdlc\n");
-		goto free_utdm;
+		goto undo_uhdlc_init;
 	}
 
 	dev = alloc_hdlcdev(uhdlc_priv);
@@ -1188,6 +1235,9 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 free_dev:
 	free_netdev(dev);
 undo_uhdlc_init:
+	iounmap(utdm->siram);
+unmap_si_regs:
+	iounmap(utdm->si_regs);
 free_utdm:
 	if (uhdlc_priv->tsa)
 		kfree(utdm);
diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index f78c346..76480df 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -44,10 +44,6 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	const char *sprop;
 	int ret = 0;
 	u32 val;
-	struct resource *res;
-	struct device_node *np2;
-	static int siram_init_flag;
-	struct platform_device *pdev;
 
 	sprop = of_get_property(np, "fsl,rx-sync-clock", NULL);
 	if (sprop) {
@@ -124,57 +120,6 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	utdm->siram_entry_id = val;
 
 	set_si_param(utdm, ut_info);
-
-	np2 = of_find_compatible_node(NULL, NULL, "fsl,t1040-qe-si");
-	if (!np2)
-		return -EINVAL;
-
-	pdev = of_find_device_by_node(np2);
-	if (!pdev) {
-		pr_err("%pOFn: failed to lookup pdev\n", np2);
-		of_node_put(np2);
-		return -EINVAL;
-	}
-
-	of_node_put(np2);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	utdm->si_regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(utdm->si_regs)) {
-		ret = PTR_ERR(utdm->si_regs);
-		goto err_miss_siram_property;
-	}
-
-	np2 = of_find_compatible_node(NULL, NULL, "fsl,t1040-qe-siram");
-	if (!np2) {
-		ret = -EINVAL;
-		goto err_miss_siram_property;
-	}
-
-	pdev = of_find_device_by_node(np2);
-	if (!pdev) {
-		ret = -EINVAL;
-		pr_err("%pOFn: failed to lookup pdev\n", np2);
-		of_node_put(np2);
-		goto err_miss_siram_property;
-	}
-
-	of_node_put(np2);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	utdm->siram = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(utdm->siram)) {
-		ret = PTR_ERR(utdm->siram);
-		goto err_miss_siram_property;
-	}
-
-	if (siram_init_flag == 0) {
-		memset_io(utdm->siram, 0,  resource_size(res));
-		siram_init_flag = 1;
-	}
-
-	return ret;
-
-err_miss_siram_property:
-	devm_iounmap(&pdev->dev, utdm->si_regs);
 	return ret;
 }
 EXPORT_SYMBOL(ucc_of_parse_tdm);
-- 
2.9.5

