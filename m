Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754750AbeBNSrO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:47:14 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:44511 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162168AbeBNSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:47:11 -0500
X-Google-Smtp-Source: AH8x226aZMcrPaNpz++fkQkwDhtoVoMgZ50hy2cv/Vs67Ec1BLO7OioU7pz+0YoFpkaXZcwYrzzw2A==
Date: Wed, 14 Feb 2018 10:47:05 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com
Subject: Re: [PATCH v2 1/5] dmaengine: qcom: bam_dma: make bam clk optional
Message-ID: <20180214184705.GC93895@bjorns-mbp-2.lan>
References: <20180214144459.29813-1-srinivas.kandagatla@linaro.org>
 <20180214144459.29813-2-srinivas.kandagatla@linaro.org>
 <20180214154144.GB93895@bjorns-mbp-2.lan>
 <69c7a7e4-1a1f-e0e6-d5e9-c39ff666df64@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c7a7e4-1a1f-e0e6-d5e9-c39ff666df64@linaro.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Feb 10:19 PST 2018, Srinivas Kandagatla wrote:

> Thanks for the Review,
> 
> On 14/02/18 15:41, Bjorn Andersson wrote:
> > >   	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
> > > -	if (IS_ERR(bdev->bamclk))
> > > -		return PTR_ERR(bdev->bamclk);
> > > -
> > > -	ret = clk_prepare_enable(bdev->bamclk);
> > > -	if (ret) {
> > > -		dev_err(bdev->dev, "failed to prepare/enable clock\n");
> > > -		return ret;
> > > +	if (IS_ERR(bdev->bamclk)) {
> > In the case of !bdev->controlled_remotely I think this should still be
> > an error.
> > 
> Yep makes sense,
> 
> You mean something like this?
> 
> ------------------------->cut<------------------------
>         bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
>         if (IS_ERR(bdev->bamclk)) {
>                 if (!bdev->controlled_remotely);
>                         return PTR_ERR(bdev->bamclk);
> 
>                 bdev->bamclk = NULL;
>         }
> 
>         ret = clk_prepare_enable(bdev->bamclk);
>         if (ret) {
>                 dev_err(bdev->dev, "failed to prepare/enable clock\n");
>                 return ret;
>         }
> 
> ------------------------->cut<------------------------
> 

Yes

Regards,
Bjorn
