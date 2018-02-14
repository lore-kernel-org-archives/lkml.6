Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031616AbeBNPlv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:41:51 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34131 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031640AbeBNPls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:41:48 -0500
X-Google-Smtp-Source: AH8x227gFXZ4opQaOZIfjnRcGCYmEL+1ngaYUEjUUwQbmtT1ougKUftSFl0ILSDc8wYp5UZx2qH2wg==
Date: Wed, 14 Feb 2018 07:41:44 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com
Subject: Re: [PATCH v2 1/5] dmaengine: qcom: bam_dma: make bam clk optional
Message-ID: <20180214154144.GB93895@bjorns-mbp-2.lan>
References: <20180214144459.29813-1-srinivas.kandagatla@linaro.org>
 <20180214144459.29813-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214144459.29813-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Feb 06:44 PST 2018, Srinivas Kandagatla wrote:
> @@ -1233,13 +1233,14 @@ static int bam_dma_probe(struct platform_device *pdev)
>  						"qcom,controlled-remotely");
>  
>  	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
> -	if (IS_ERR(bdev->bamclk))
> -		return PTR_ERR(bdev->bamclk);
> -
> -	ret = clk_prepare_enable(bdev->bamclk);
> -	if (ret) {
> -		dev_err(bdev->dev, "failed to prepare/enable clock\n");
> -		return ret;
> +	if (IS_ERR(bdev->bamclk)) {

In the case of !bdev->controlled_remotely I think this should still be
an error.

> +		bdev->bamclk = NULL;
> +	} else {
> +		ret = clk_prepare_enable(bdev->bamclk);
> +		if (ret) {
> +			dev_err(bdev->dev, "failed to prepare/enable clock\n");
> +			return ret;
> +		}

The rest of the driver will keep operating the bamclk (which is okay),
so for symmetry purposes I think you should just keep the
clk_prepare_enable() block unmodified.

Regards,
Bjorn
