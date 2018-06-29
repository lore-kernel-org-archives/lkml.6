Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF5C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AA027CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="g16kx5LH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AA027CE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755403AbeF2Ufg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:35:36 -0400
Received: from vern.gendns.com ([206.190.152.46]:58670 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753148AbeF2Ufe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YFQEbfEYE6M51isFvAxZ9Nu90M0/JYeZL36AcfrnRUM=; b=g16kx5LHQrXJ82Wt7f7byPyz2c
        A6bbrn8Fwr1vXXQ1029fY3cS6Y24SYKKyN0dTuuyK2BHSj9bkO1d05bPkXci5F/20aGvEUWcA1jfA
        3WDl55bDGHm8dBkWliQ2NdYc5NFzMpHb4y5pW8T+XqKuDFOhAFMrCoUt3XwpqBNvZUoYSD0drcG+t
        sGY6+XKNl9GOi7r/0uCb1m9JV0Yw5gvn7h6ascvt/0fTVCDQQUNS6RPPrAZcg1bDBFLbXvL2AD4F2
        anue2ljXC+igw1biSp3NQT1XfFTn8npfXg469oyPzXDEsUrIQiKYYScPScPmGb89JnWRZWzcF3wze
        upS+fvMg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:43054 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fZ078-0030w0-2j; Fri, 29 Jun 2018 16:35:30 -0400
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
From:   David Lechner <david@lechnology.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <e2579b81-7c66-8be6-fcad-ab7a3a5b0765@lechnology.com>
Message-ID: <ee49a8de-0812-a619-25be-4c6d8a35cc81@lechnology.com>
Date:   Fri, 29 Jun 2018 15:35:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e2579b81-7c66-8be6-fcad-ab7a3a5b0765@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 03:09 PM, David Lechner wrote:
> On 06/29/2018 04:40 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> On da850-evm board we can read the MAC address from MTD. It's currently
>> done in the relevant board file, but we want to get rid of all the MAC
>> reading callbacks from the board file (SPI and NAND). Move the reading
>> of the MAC address from SPI to the emac driver's probe function.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/net/ethernet/ti/davinci_emac.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
>> index a1a6445b5a7e..48e6a7755811 100644
>> --- a/drivers/net/ethernet/ti/davinci_emac.c
>> +++ b/drivers/net/ethernet/ti/davinci_emac.c
>> @@ -67,7 +67,7 @@
>>   #include <linux/of_irq.h>
>>   #include <linux/of_net.h>
>>   #include <linux/mfd/syscon.h>
>> -
>> +#include <linux/mtd/mtd.h>
>>   #include <asm/irq.h>
>>   #include <asm/page.h>
>> @@ -1783,7 +1783,10 @@ static int davinci_emac_probe(struct platform_device *pdev)
>>       struct cpdma_params dma_params;
>>       struct clk *emac_clk;
>>       unsigned long emac_bus_frequency;
>> -
>> +#ifdef CONFIG_MTD
>> +    size_t mac_addr_len;
>> +    struct mtd_info *mtd;
>> +#endif /* CONFIG_MTD */
>>       /* obtain emac clock from kernel */
>>       emac_clk = devm_clk_get(&pdev->dev, NULL);
>> @@ -1815,6 +1818,19 @@ static int davinci_emac_probe(struct platform_device *pdev)
>>           goto err_free_netdev;
>>       }
>> +#ifdef CONFIG_MTD
> 
> What about the case when MTD is compiled as a module?
> 
>> +    mtd = get_mtd_device_nm("MAC-Address");
> 
> What about the case when PTR_ERR(mtd) == -EPROBE_DEFER?

To answer my own question: because get_mtd_device_nm() doesn't
ever return -EPROBE_DEFER.

I'm trying to make this work on LCDK, but the emac driver probes
before any mtd device is registered, so, I just get -ENODEV even
though I've added a partition to the device tree labeled
"MAC-Address". You can see in the kernel messages that MTD is
not probed until later.

> 
>> +    if (!IS_ERR(mtd)) {
>> +        rc = mtd_read(mtd, 0, ETH_ALEN,
>> +                  &mac_addr_len, priv->mac_addr);
>> +        if (rc == 0)
>> +            dev_info(&pdev->dev,
>> +                 "Read MAC addr from SPI Flash: %pM\n",
>> +                 priv->mac_addr);
>> +        put_mtd_device(mtd);
>> +    }
>> +#endif /* CONFIG_MTD */
>> +
>>       /* MAC addr and PHY mask , RMII enable info from platform_data */
>>       memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
>>       priv->phy_id = pdata->phy_id;
>>
> 

