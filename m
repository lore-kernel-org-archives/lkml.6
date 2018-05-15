Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeEOHC6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:02:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42432 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeEOHC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:02:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD8B460540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 2/2] phy: qcom-qusb2: Quiet -EPROBE_DEFER from
 qusb2_phy_probe()
To: Douglas Anderson <dianders@chromium.org>, kishon@ti.com
Cc: linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20180514224222.54495-1-dianders@chromium.org>
 <20180514224222.54495-2-dianders@chromium.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <80918639-ca58-aa1c-a288-a5fd56ff78cb@codeaurora.org>
Date: Tue, 15 May 2018 12:32:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514224222.54495-2-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,


On 5/15/2018 4:12 AM, Douglas Anderson wrote:
> The -EPROBE_DEFER virus demands special case code to avoid printing
> error messages when the error is only -EPROBE_DEFER.  Spread the virus
> to a new host: qusb2_phy_probe().  Specifically handle when our
> regulators might not be ready yet.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   drivers/phy/qualcomm/phy-qcom-qusb2.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index 94afeac1a19e..26354618fd45 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -711,7 +711,9 @@ static int qusb2_phy_probe(struct platform_device *pdev)
>   
>   	ret = devm_regulator_bulk_get(dev, num, qphy->vregs);
>   	if (ret) {
> -		dev_err(dev, "failed to get regulator supplies\n");
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get regulator supplies: %d\n",
> +				ret);
>   		return ret;
>   	}
>   
Thanks for the patch.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

regards
Vivek
