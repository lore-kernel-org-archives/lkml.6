Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA716ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9F320866
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="upiL+8at"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9F320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbeKDXIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:08:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbeKDXIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:08:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506EC20870;
        Sun,  4 Nov 2018 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339626;
        bh=I+9mpVB2hiqVIS9/V1kkHxylATbjP0qUHJjvL2B/H9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upiL+8at9Js83KmrHezDcaiQqeYB+movBxGzoqFx7kvAGe5LRCZQX6D4eqkHIUfZL
         +damQs8e7WU5PKqImEJO2lZ+Ejyz6RNN7oeH3/GCDJ+e6XIjbfBqCrMe3QQcNJ6dsH
         6PPcg6VfHp5g1iYY3VbxbLTvIctUrVNDdFvM8SPk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 20/30] iio: adc: imx25-gcq: Fix leak of device_node in mx25_gcq_setup_cfgs()
Date:   Sun,  4 Nov 2018 08:53:15 -0500
Message-Id: <20181104135325.88524-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135325.88524-1-sashal@kernel.org>
References: <20181104135325.88524-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit d3fa21c73c391975488818b085b894c2980ea052 ]

Leaving for_each_child_of_node loop we should release child device node,
if it is not stored for future use.

Found by Linux Driver Verification project (linuxtesting.org).

JC: I'm not sending this as a quick fix as it's been wrong for years,
but good to pick up for stable after the merge window.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 6df2e98c3ea56 ("iio: adc: Add imx25-gcq ADC driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.17.1

