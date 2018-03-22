Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeCVIdt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 04:33:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52622 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751768AbeCVIdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 04:33:46 -0400
Subject: Re: [PATCH v2] i2c: i2c-stm32f7: fix no check on returned setup
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1521650920-11578-1-git-send-email-pierre-yves.mordret@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f6763dfd-9535-1206-fed0-a611b9ea81b7@st.com>
Date: Thu, 22 Mar 2018 09:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521650920-11578-1-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/21/2018 05:48 PM, Pierre-Yves MORDRET wrote:
> Before assigning returned setup structure check if not null
> 
> Fixes: 463a9215f3ca7600b5ff ("i2c: stm32f7: fix setup structure")
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>    Version history:
>       v1:
>           * Initial
>       v2:
>           * fill "ret" with error statement before go to "clk_free"
> ---
> ---
>   drivers/i2c/busses/i2c-stm32f7.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index b445b3b..f273e28 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -888,6 +888,11 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>   	}
>   
>   	setup = of_device_get_match_data(&pdev->dev);
> +	if (!setup) {
> +		dev_err(&pdev->dev, "Can't get device data\n");
> +		ret = -ENODEV;
> +		goto clk_free;
> +	}
>   	i2c_dev->setup = *setup;
>   
>   	ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-rising-time-ns",
> 
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
