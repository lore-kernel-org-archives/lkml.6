Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68336ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A17F20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A17F20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeGPIB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:01:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46576 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeGPIB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:01:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 739F1CAF;
        Mon, 16 Jul 2018 07:35:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 4.17 05/67] drm/etnaviv: Check for platform_device_register_simple() failure
Date:   Mon, 16 Jul 2018 09:34:34 +0200
Message-Id: <20180716073443.982040755@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
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

From: Fabio Estevam <fabio.estevam@nxp.com>

commit 45a0faaba9c8c5ba1e31a08a391aed0bad327167 upstream.

platform_device_register_simple() may fail, so we should better
check its return value and propagate it in the case of error.

Cc: <stable@vger.kernel.org>
Fixes: 246774d17fc0 ("drm/etnaviv: remove the need for a gpu-subsystem DT node")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -693,8 +693,11 @@ static struct platform_driver etnaviv_pl
 	},
 };
 
+static struct platform_device *etnaviv_drm;
+
 static int __init etnaviv_init(void)
 {
+	struct platform_device *pdev;
 	int ret;
 	struct device_node *np;
 
@@ -706,7 +709,7 @@ static int __init etnaviv_init(void)
 
 	ret = platform_driver_register(&etnaviv_platform_driver);
 	if (ret != 0)
-		platform_driver_unregister(&etnaviv_gpu_driver);
+		goto unregister_gpu_driver;
 
 	/*
 	 * If the DT contains at least one available GPU device, instantiate
@@ -715,12 +718,24 @@ static int __init etnaviv_init(void)
 	for_each_compatible_node(np, NULL, "vivante,gc") {
 		if (!of_device_is_available(np))
 			continue;
-
-		platform_device_register_simple("etnaviv", -1, NULL, 0);
+		pdev = platform_device_register_simple("etnaviv", -1,
+						       NULL, 0);
+		if (IS_ERR(pdev)) {
+			ret = PTR_ERR(pdev);
+			of_node_put(np);
+			goto unregister_platform_driver;
+		}
+		etnaviv_drm = pdev;
 		of_node_put(np);
 		break;
 	}
 
+	return 0;
+
+unregister_platform_driver:
+	platform_driver_unregister(&etnaviv_platform_driver);
+unregister_gpu_driver:
+	platform_driver_unregister(&etnaviv_gpu_driver);
 	return ret;
 }
 module_init(etnaviv_init);


