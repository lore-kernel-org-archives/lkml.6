Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99304C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBBB20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9TE/H/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBBB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbeKLIVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387734AbeKLIVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:08 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 920E0216FD;
        Sun, 11 Nov 2018 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975471;
        bh=St1rT1LO6VvadK/OuVQXs4g93qzZUOZUSID8GCZtvt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9TE/H/WREz2J1VQxs3UfxliEFbmLC6CMK3yJgoRI2Vq6jYkivOcgE74QEwYFY/4P
         dbxVu194ilAoPCLpWJOh53ZVtMAgwCieTOZfG475UdT71rh54RhBEj9YfassCIn01+
         nbdfhvL3wqmYT1BEwY2XKie8aKR5W88IQz1z3aK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.18 252/350] iio: adc: imx25-gcq: Fix leak of device_node in mx25_gcq_setup_cfgs()
Date:   Sun, 11 Nov 2018 14:21:56 -0800
Message-Id: <20181111221718.581461565@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

commit d3fa21c73c391975488818b085b894c2980ea052 upstream.

Leaving for_each_child_of_node loop we should release child device node,
if it is not stored for future use.

Found by Linux Driver Verification project (linuxtesting.org).

JC: I'm not sending this as a quick fix as it's been wrong for years,
but good to pick up for stable after the merge window.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 6df2e98c3ea56 ("iio: adc: Add imx25-gcq ADC driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/fsl-imx25-gcq.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -209,12 +209,14 @@ static int mx25_gcq_setup_cfgs(struct pl
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
 
@@ -228,6 +230,7 @@ static int mx25_gcq_setup_cfgs(struct pl
 			if (IS_ERR(priv->vref[refp])) {
 				dev_err(dev, "Error, trying to use external voltage reference without a vref-%s regulator.",
 					mx25_gcq_refp_names[refp]);
+				of_node_put(child);
 				return PTR_ERR(priv->vref[refp]);
 			}
 			priv->channel_vref_mv[reg] =
@@ -240,6 +243,7 @@ static int mx25_gcq_setup_cfgs(struct pl
 			break;
 		default:
 			dev_err(dev, "Invalid positive reference %d\n", refp);
+			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -254,10 +258,12 @@ static int mx25_gcq_setup_cfgs(struct pl
 
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
 


