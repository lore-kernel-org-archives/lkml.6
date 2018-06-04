Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeFDNIZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:08:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41972 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFDNIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:08:23 -0400
X-Google-Smtp-Source: ADUXVKJByV9yQ3MyNcOuAJWR0jXzoqk3/i2/clvpfUnJLoucwt4Mu2LoM6UNOY22iCqDO9ZvUxl45A==
Subject: Re: [PATCH v3 01/10] mfd: da9063: Fix failpath in core
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180604122410.GA21163@dell>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <8b76fcb6-87fc-36da-63af-4b77a09e6e59@gmail.com>
Date: Mon, 4 Jun 2018 15:08:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604122410.GA21163@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 02:24 PM, Lee Jones wrote:
> On Sat, 02 Jun 2018, Marek Vasut wrote:
> 
>> In case mfd_add_devices() fails, da9063_irq_exit() is not called to
>> undo the IRQchip setup done by da9063_irq_init(). Fix this by adding
>> the missing fail path.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> V3: New patch
>> ---
>>  drivers/mfd/da9063-core.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
>> index 6c2870d4e754..8226ebd8b96d 100644
>> --- a/drivers/mfd/da9063-core.c
>> +++ b/drivers/mfd/da9063-core.c
>> @@ -229,10 +229,16 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>>  	ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
>>  			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
>>  			      NULL);
>> -	if (ret)
>> +	if (ret) {
>>  		dev_err(da9063->dev, "Cannot add MFD cells\n");
>> +		goto err_irq_exit;
>> +	}
>>  
>>  	return ret;
>> +
>> +err_irq_exit:
>> +	da9063_irq_exit(da9063);
>> +	return ret;
>>  }
>>  
>>  void da9063_device_exit(struct da9063 *da9063)
> 
> I haven't seen the later patches yet, so maybe the goto label expanded
> on, but if it's not, then this would be better:
> 
>  -	if (ret)
>  +	if (ret) {
>   		dev_err(da9063->dev, "Cannot add MFD cells\n");
>  +		da9063_irq_exit(da9063);
>  +	}
>   
>   	return ret;
>   }

It did expand in the later patches, yes.

-- 
Best regards,
Marek Vasut
