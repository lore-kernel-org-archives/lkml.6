Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8409ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7BB2154F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU6aISgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7BB2154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeIVPPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeIVPPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:15:08 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B86482154C;
        Sat, 22 Sep 2018 09:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537608135;
        bh=HBA3mlHC1+8te6C24js80W7mAGEYgO4K6f8TMzrGWUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DU6aISgVDFyMXG1gc5WDiF+BDRD2yidF7IakG9ecACzOAH2fadZcbzGOL7ELyYec+
         tbFeRU/iGo/ewyi+IAQdWzhQ3MJiF3QhtcdSqBRLxA7sFUB5htI98/RBMoyMlMTW9F
         6Rpyq3hhLATfvI+zq3zJQV4hQ8JIkNl48p6pO/DM=
Date:   Sat, 22 Sep 2018 10:22:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] iio: adc: imx25-gcq: Fix leak of device_node in
 mx25_gcq_setup_cfgs()
Message-ID: <20180922102210.62576e11@archlinux>
In-Reply-To: <1537567082-7308-1-git-send-email-khoroshilov@ispras.ru>
References: <1537567082-7308-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2018 00:58:02 +0300
Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:

> Leaving for_each_child_of_node loop we should release child device node,
> if it is not stored for future use.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Seems obviously correct to me.  Given we are mid way through
the cycle and this doesn't strike me as super urgent, I'll
queue it up for the next merge window.

I added a note to the description to reflect this.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks and great to clean things like this up.

Jonathan

> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index ea264fa9e567..929c617db364 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -209,12 +209,14 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  		ret = of_property_read_u32(child, "reg", &reg);
>  		if (ret) {
>  			dev_err(dev, "Failed to get reg property\n");
> +			of_node_put(child);
>  			return ret;
>  		}
>  
>  		if (reg >= MX25_NUM_CFGS) {
>  			dev_err(dev,
>  				"reg value is greater than the number of available configuration registers\n");
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
>  
> @@ -228,6 +230,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  			if (IS_ERR(priv->vref[refp])) {
>  				dev_err(dev, "Error, trying to use external voltage reference without a vref-%s regulator.",
>  					mx25_gcq_refp_names[refp]);
> +				of_node_put(child);
>  				return PTR_ERR(priv->vref[refp]);
>  			}
>  			priv->channel_vref_mv[reg] =
> @@ -240,6 +243,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  			break;
>  		default:
>  			dev_err(dev, "Invalid positive reference %d\n", refp);
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
>  
> @@ -254,10 +258,12 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  
>  		if ((refp & MX25_ADCQ_CFG_REFP_MASK) != refp) {
>  			dev_err(dev, "Invalid fsl,adc-refp property value\n");
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
>  		if ((refn & MX25_ADCQ_CFG_REFN_MASK) != refn) {
>  			dev_err(dev, "Invalid fsl,adc-refn property value\n");
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
>  

