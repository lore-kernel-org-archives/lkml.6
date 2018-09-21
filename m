Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2602ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9502156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9502156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391588AbeIVDtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:49:02 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42068 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391323AbeIVDtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:49:02 -0400
Received: from localhost.localdomain (unknown [85.140.186.221])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5A3FB540089;
        Sat, 22 Sep 2018 00:58:12 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] iio: adc: imx25-gcq: Fix leak of device_node in mx25_gcq_setup_cfgs()
Date:   Sat, 22 Sep 2018 00:58:02 +0300
Message-Id: <1537567082-7308-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leaving for_each_child_of_node loop we should release child device node,
if it is not stored for future use.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index ea264fa9e567..929c617db364 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -209,12 +209,14 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 		ret = of_property_read_u32(child, "reg", &reg);
 		if (ret) {
 			dev_err(dev, "Failed to get reg property\n");
+			of_node_put(child);
 			return ret;
 		}
 
 		if (reg >= MX25_NUM_CFGS) {
 			dev_err(dev,
 				"reg value is greater than the number of available configuration registers\n");
+			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -228,6 +230,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			if (IS_ERR(priv->vref[refp])) {
 				dev_err(dev, "Error, trying to use external voltage reference without a vref-%s regulator.",
 					mx25_gcq_refp_names[refp]);
+				of_node_put(child);
 				return PTR_ERR(priv->vref[refp]);
 			}
 			priv->channel_vref_mv[reg] =
@@ -240,6 +243,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			break;
 		default:
 			dev_err(dev, "Invalid positive reference %d\n", refp);
+			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -254,10 +258,12 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 
 		if ((refp & MX25_ADCQ_CFG_REFP_MASK) != refp) {
 			dev_err(dev, "Invalid fsl,adc-refp property value\n");
+			of_node_put(child);
 			return -EINVAL;
 		}
 		if ((refn & MX25_ADCQ_CFG_REFN_MASK) != refn) {
 			dev_err(dev, "Invalid fsl,adc-refn property value\n");
+			of_node_put(child);
 			return -EINVAL;
 		}
 
-- 
2.7.4

