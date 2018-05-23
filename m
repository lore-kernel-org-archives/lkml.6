Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754263AbeEWHTk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:19:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20630 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754024AbeEWHTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:19:38 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] rtc: st-lpc: fix possible race condition
Thread-Topic: [PATCH 1/2] rtc: st-lpc: fix possible race condition
Thread-Index: AQHT8DbOL5DtmjZB0kuylYhbBYW1Z6Q8ysIA
Date: Wed, 23 May 2018 07:19:16 +0000
Message-ID: <21f4fd1a-1744-b46f-eb0f-09d6af04247b@st.com>
References: <20180520123337.14856-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20180520123337.14856-1-alexandre.belloni@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEDBAF998764A3409534836086B623A1@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4N7Jiee007083

Hi Alexandre

On 05/20/2018 02:33 PM, Alexandre Belloni wrote:
> The IRQ is requested before the struct rtc is allocated and registered, but
> this struct is used in the IRQ handler. This may lead to a NULL pointer
> dereference.
> 
> Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
> before requesting the IRQ.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/rtc/rtc-st-lpc.c | 24 +++++++++---------------
>   1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
> index d5222667f892..2f1ef2c28740 100644
> --- a/drivers/rtc/rtc-st-lpc.c
> +++ b/drivers/rtc/rtc-st-lpc.c
> @@ -212,6 +212,10 @@ static int st_rtc_probe(struct platform_device *pdev)
>   	if (!rtc)
>   		return -ENOMEM;
>   
> +	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(rtc->rtc_dev))
> +		return PTR_ERR(rtc->rtc_dev);
> +
>   	spin_lock_init(&rtc->lock);
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -253,26 +257,17 @@ static int st_rtc_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, rtc);
>   
> -	rtc->rtc_dev = rtc_device_register("st-lpc-rtc", &pdev->dev,
> -					   &st_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rtc->rtc_dev)) {
> +	rtc->rtc_dev->ops = &st_rtc_ops;
> +
> +	ret = rtc_register_device(rtc->rtc_dev);
> +	if (ret) {
>   		clk_disable_unprepare(rtc->clk);
> -		return PTR_ERR(rtc->rtc_dev);
> +		return ret;
>   	}
>   
>   	return 0;
>   }
>   
> -static int st_rtc_remove(struct platform_device *pdev)
> -{
> -	struct st_rtc *rtc = platform_get_drvdata(pdev);
> -
> -	if (likely(rtc->rtc_dev))
> -		rtc_device_unregister(rtc->rtc_dev);
> -
> -	return 0;
> -}
> -
>   #ifdef CONFIG_PM_SLEEP
>   static int st_rtc_suspend(struct device *dev)
>   {
> @@ -325,7 +320,6 @@ static struct platform_driver st_rtc_platform_driver = {
>   		.of_match_table = st_rtc_match,
>   	},
>   	.probe = st_rtc_probe,
> -	.remove = st_rtc_remove,
>   };
>   
>   module_platform_driver(st_rtc_platform_driver);
> 

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks

Patrice
