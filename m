Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10785208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pp4g9KuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10785208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbeHBJF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:05:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50716 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeHBJF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:05:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w727EtKk172588;
        Thu, 2 Aug 2018 07:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=XJGLfhDF/x1PdEfphU192OxjdgnDSm23kKxar9I2a2c=;
 b=pp4g9KuN7f/ZhK2eExsy+Q6mggk0xZI8zqYEWF9VKEThU84C2iK2IVpBMmmFISBSeyOV
 FITbjMP45mJxHreTScbjcQRJmet3q45h6BVBGJXsdpVemLWmkX8t6nnfulwZWfozEBpw
 E1tNc5WI676Wra8ZnpBnZCmwntoyfEMfenezyqMDaeEpuFc/C/UNgyd8bpl16uRHP2mG
 qWtDozZgxHMiREZM5s96E1BdspayGBIqqj0IXLcFQwVe98RsdmA1DQGloGsZBB+nOp/C
 cL0UtA5/AGBLbUFDvtAFt/CwtumFERr9hEId6Bdzktiq3SL4sp7LcLSZIzDvQlIfWETG cQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kggep9w37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Aug 2018 07:16:07 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w727G5B0014562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Aug 2018 07:16:06 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w727G573022280;
        Thu, 2 Aug 2018 07:16:05 GMT
Received: from kili.mountain (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Aug 2018 00:16:05 -0700
Date:   Thu, 2 Aug 2018 10:15:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] uio: pruss: fix error handling in probe
Message-ID: <20180802071558.p6p6pmzsrkz26rjr@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8972 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=881
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808020078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two bugs here.  First the error codes weren't set on several
paths.  And second, if the call to request_threaded_irq() inside
uio_register_device() fails then it would lead to a double free when
we call uio_unregister_device() inside pruss_cleanup().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 91aea8823af5..1cc175d3c25c 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -122,7 +122,7 @@ static int pruss_probe(struct platform_device *pdev)
 	struct uio_pruss_dev *gdev;
 	struct resource *regs_prussio;
 	struct device *dev = &pdev->dev;
-	int ret = -ENODEV, cnt = 0, len;
+	int ret, cnt, i, len;
 	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
 
 	gdev = kzalloc(sizeof(struct uio_pruss_dev), GFP_KERNEL);
@@ -131,8 +131,8 @@ static int pruss_probe(struct platform_device *pdev)
 
 	gdev->info = kcalloc(MAX_PRUSS_EVT, sizeof(*p), GFP_KERNEL);
 	if (!gdev->info) {
-		kfree(gdev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_free_gdev;
 	}
 
 	/* Power on PRU in case its not done as part of boot-loader */
@@ -140,29 +140,26 @@ static int pruss_probe(struct platform_device *pdev)
 	if (IS_ERR(gdev->pruss_clk)) {
 		dev_err(dev, "Failed to get clock\n");
 		ret = PTR_ERR(gdev->pruss_clk);
-		kfree(gdev->info);
-		kfree(gdev);
-		return ret;
-	} else {
-		ret = clk_enable(gdev->pruss_clk);
-		if (ret) {
-			dev_err(dev, "Failed to enable clock\n");
-			clk_put(gdev->pruss_clk);
-			kfree(gdev->info);
-			kfree(gdev);
-			return ret;
-		}
+		goto err_free_info;
+	}
+
+	ret = clk_enable(gdev->pruss_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock\n");
+		goto err_clk_put;
 	}
 
 	regs_prussio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs_prussio) {
 		dev_err(dev, "No PRUSS I/O resource specified\n");
-		goto out_free;
+		ret = -EIO;
+		goto err_clk_disable;
 	}
 
 	if (!regs_prussio->start) {
 		dev_err(dev, "Invalid memory resource\n");
-		goto out_free;
+		ret = -EIO;
+		goto err_clk_disable;
 	}
 
 	if (pdata->sram_pool) {
@@ -172,7 +169,8 @@ static int pruss_probe(struct platform_device *pdev)
 					sram_pool_sz, &gdev->sram_paddr);
 		if (!gdev->sram_vaddr) {
 			dev_err(dev, "Could not allocate SRAM pool\n");
-			goto out_free;
+			ret = -ENOMEM;
+			goto err_clk_disable;
 		}
 	}
 
@@ -180,14 +178,16 @@ static int pruss_probe(struct platform_device *pdev)
 				&(gdev->ddr_paddr), GFP_KERNEL | GFP_DMA);
 	if (!gdev->ddr_vaddr) {
 		dev_err(dev, "Could not allocate external memory\n");
-		goto out_free;
+		ret = -ENOMEM;
+		goto err_free_sram;
 	}
 
 	len = resource_size(regs_prussio);
 	gdev->prussio_vaddr = ioremap(regs_prussio->start, len);
 	if (!gdev->prussio_vaddr) {
 		dev_err(dev, "Can't remap PRUSS I/O  address range\n");
-		goto out_free;
+		ret = -ENOMEM;
+		goto err_free_ddr_vaddr;
 	}
 
 	gdev->pintc_base = pdata->pintc_base;
@@ -215,15 +215,36 @@ static int pruss_probe(struct platform_device *pdev)
 		p->priv = gdev;
 
 		ret = uio_register_device(dev, p);
-		if (ret < 0)
-			goto out_free;
+		if (ret < 0) {
+			kfree(p->name);
+			goto err_unloop;
+		}
 	}
 
 	platform_set_drvdata(pdev, gdev);
 	return 0;
 
-out_free:
-	pruss_cleanup(dev, gdev);
+err_unloop:
+	for (i = 0, p = gdev->info; i < cnt; i++, p++) {
+		uio_unregister_device(p);
+		kfree(p->name);
+	}
+	iounmap(gdev->prussio_vaddr);
+err_free_ddr_vaddr:
+	dma_free_coherent(dev, extram_pool_sz, gdev->ddr_vaddr,
+			  gdev->ddr_paddr);
+err_free_sram:
+	if (pdata->sram_pool)
+		gen_pool_free(gdev->sram_pool, gdev->sram_vaddr, sram_pool_sz);
+err_clk_disable:
+	clk_disable(gdev->pruss_clk);
+err_clk_put:
+	clk_put(gdev->pruss_clk);
+err_free_info:
+	kfree(gdev->info);
+err_free_gdev:
+	kfree(gdev);
+
 	return ret;
 }
 
