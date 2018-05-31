Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755761AbeEaRFh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:05:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755600AbeEaRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:05:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 618EA60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=austinwc@codeaurora.org
Subject: Re: [PATCH] i2c: qup: fix building without CONFIG_ACPI
To: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Bhumika Goyal <bhumirks@gmail.com>, Peter Rosin <peda@axentia.se>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180530213201.550467-1-arnd@arndb.de>
From: "Christ, Austin" <austinwc@codeaurora.org>
Message-ID: <ea7aa139-8043-0ffb-e534-abf137f82ef0@codeaurora.org>
Date: Thu, 31 May 2018 11:05:29 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530213201.550467-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2018 3:31 PM, Arnd Bergmann wrote:
> The added Centriq support broke compilation with CONFIG_ACPI disabled:
> 
> drivers/i2c/busses/i2c-qup.c: In function 'qup_i2c_probe':
> drivers/i2c/busses/i2c-qup.c:1707:25: error: 'qup_i2c_acpi_match' undeclared (first use in this function); did you mean 'qup_i2c_recv_data'?
> 
> This fixes it by removing the extraneous #ifdef. All ACPI specific
> code will be dropped implicitly when that option is disabled, but
> the compiler first needs to see it.
> 
> Fixes: 902a91a02bdf ("i2c: qup: add probe path for Centriq ACPI devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/i2c/busses/i2c-qup.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index 4f793b5d0c3b..9cfcc0473227 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -1657,13 +1657,11 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
>   	clk_disable_unprepare(qup->pclk);
>   }
>   
> -#if IS_ENABLED(CONFIG_ACPI)
>   static const struct acpi_device_id qup_i2c_acpi_match[] = {
>   	{ "QCOM8010"},
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(acpi, qup_i2c_acpi_match);
> -#endif
>   
>   static int qup_i2c_probe(struct platform_device *pdev)
>   {
> 

Yeah this is correct.

Reviewed-by: Austin Christ <austinwc@codeaurora.org>

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
