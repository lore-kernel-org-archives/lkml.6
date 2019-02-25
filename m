Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C5A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131098;
	bh=wIY9TFHPYzMQCPeDiIw7Oc6DXgQGKBSCb8OzncThEK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xy+7ros+360P19tTDzktyW7i8z52DWgXygaTbmGFCU59R+1LFiRKYf3sC+4ZOJ2Al
	 kUCOucqr8WMm2niDm1gL//P6gfSyDhteXw/Way/eer7zrIPS3XedSoaS2V81z4cUDY
	 qzF6h4gMAROMZwpzPhMIdNlfpoRJQfia1HZ1jpak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfBYV3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:29:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731485AbfBYV3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BBC32146F;
        Mon, 25 Feb 2019 21:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130182;
        bh=wIY9TFHPYzMQCPeDiIw7Oc6DXgQGKBSCb8OzncThEK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHRgScoXC7D0sfIFJCSIfj6+3jirfKK1T8h06zEwtqlktnWFpbJt0NjWnCfUTyV4u
         j/dVca2FMw1V0CToq5xoedbwqkbrBdYb8oiSxSdaR33Y1Ldu9+gNJlKDXkCLLRSMTB
         MDe6RdDyPL0yrJIUh0YCyV62djtQ5N/diqCSr/aU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Zhao Qiang <qiang.zhao@nxp.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 040/183] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
Date:   Mon, 25 Feb 2019 22:10:13 +0100
Message-Id: <20190225195101.411722480@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8d68100ab4ad92560a16a68b72e068613ac4d573 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 62 +++++++++++++++++++++++++++++++++-
 drivers/soc/fsl/qe/qe_tdm.c    | 55 ------------------------------
 2 files changed, 61 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 4d6409605207c..af13d8cf94ad4 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1049,6 +1049,54 @@ static const struct net_device_ops uhdlc_ops = {
 	.ndo_tx_timeout	= uhdlc_tx_timeout,
 };
 
+static int hdlc_map_iomem(char *name, int init_flag, void __iomem **ptr)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	struct resource *res;
+	static int siram_init_flag;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL, name);
+	if (!np)
+		return -EINVAL;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		pr_err("%pOFn: failed to lookup pdev\n", np);
+		of_node_put(np);
+		return -EINVAL;
+	}
+
+	of_node_put(np);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -EINVAL;
+		goto error_put_device;
+	}
+	*ptr = ioremap(res->start, resource_size(res));
+	if (!*ptr) {
+		ret = -ENOMEM;
+		goto error_put_device;
+	}
+
+	/* We've remapped the addresses, and we don't need the device any
+	 * more, so we should release it.
+	 */
+	put_device(&pdev->dev);
+
+	if (init_flag && siram_init_flag == 0) {
+		memset_io(*ptr, 0, resource_size(res));
+		siram_init_flag = 1;
+	}
+	return  0;
+
+error_put_device:
+	put_device(&pdev->dev);
+
+	return ret;
+}
+
 static int ucc_hdlc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1143,6 +1191,15 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 		ret = ucc_of_parse_tdm(np, utdm, ut_info);
 		if (ret)
 			goto free_utdm;
+
+		ret = hdlc_map_iomem("fsl,t1040-qe-si", 0,
+				     (void __iomem **)&utdm->si_regs);
+		if (ret)
+			goto free_utdm;
+		ret = hdlc_map_iomem("fsl,t1040-qe-siram", 1,
+				     (void __iomem **)&utdm->siram);
+		if (ret)
+			goto unmap_si_regs;
 	}
 
 	if (of_property_read_u16(np, "fsl,hmask", &uhdlc_priv->hmask))
@@ -1151,7 +1208,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	ret = uhdlc_init(uhdlc_priv);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to init uhdlc\n");
-		goto free_utdm;
+		goto undo_uhdlc_init;
 	}
 
 	dev = alloc_hdlcdev(uhdlc_priv);
@@ -1181,6 +1238,9 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
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
index f78c34647ca2d..76480df195a87 100644
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
2.19.1



