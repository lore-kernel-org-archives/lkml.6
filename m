Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161829AbeBNSUL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:20:11 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38844 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161816AbeBNSUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:20:07 -0500
X-Google-Smtp-Source: AH8x227DV7nVYQagopuJBHE+DFovDwNHp6gws0nX3N6IrBhEMQ/ZYAYc85wc2lMb0HpAbVAiqDbsjQ==
Subject: Re: [PATCH v2 1/5] dmaengine: qcom: bam_dma: make bam clk optional
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com
References: <20180214144459.29813-1-srinivas.kandagatla@linaro.org>
 <20180214144459.29813-2-srinivas.kandagatla@linaro.org>
 <20180214154144.GB93895@bjorns-mbp-2.lan>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <69c7a7e4-1a1f-e0e6-d5e9-c39ff666df64@linaro.org>
Date: Wed, 14 Feb 2018 18:19:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180214154144.GB93895@bjorns-mbp-2.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the Review,

On 14/02/18 15:41, Bjorn Andersson wrote:
>>   
>>   	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
>> -	if (IS_ERR(bdev->bamclk))
>> -		return PTR_ERR(bdev->bamclk);
>> -
>> -	ret = clk_prepare_enable(bdev->bamclk);
>> -	if (ret) {
>> -		dev_err(bdev->dev, "failed to prepare/enable clock\n");
>> -		return ret;
>> +	if (IS_ERR(bdev->bamclk)) {
> In the case of !bdev->controlled_remotely I think this should still be
> an error.
> 
Yep makes sense,

You mean something like this?

------------------------->cut<------------------------
         bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
         if (IS_ERR(bdev->bamclk)) {
                 if (!bdev->controlled_remotely);
                         return PTR_ERR(bdev->bamclk);

                 bdev->bamclk = NULL;
         }

         ret = clk_prepare_enable(bdev->bamclk);
         if (ret) {
                 dev_err(bdev->dev, "failed to prepare/enable clock\n");
                 return ret;
         }

------------------------->cut<------------------------


>> +		bdev->bamclk = NULL;
>> +	} else {
>> +		ret = clk_prepare_enable(bdev->bamclk);
>> +		if (ret) {
>> +			dev_err(bdev->dev, "failed to prepare/enable clock\n");
>> +			return ret;
>> +		}
> The rest of the driver will keep operating the bamclk (which is okay),
> so for symmetry purposes I think you should just keep the
> clk_prepare_enable() block unmodified.
> 
Yep, with above change, this block should be unchanged.


--srini
> Regards,
> Bjorn
