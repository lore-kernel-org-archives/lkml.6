Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934965AbeCEMxY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:53:24 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:10767 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934693AbeCEMxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:53:22 -0500
Subject: Re: [PATCHv3] tlv320dac33: Add device tree bindings
To: Pavel Machek <pavel@ucw.cz>, Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <bhumirks@gmail.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pali.rohar@gmail.com>,
        <sre@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>, <khilman@kernel.org>,
        <aaro.koskinen@iki.fi>, <ivo.g.dimitrov.75@gmail.com>,
        <patrikbachan@gmail.com>, <serge@hallyn.com>, <abcloriens@gmail.com>,
        <clayton@craftyguy.net>, <martijn@brixit.nl>,
        <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>
References: <20180129230539.GA18280@amd> <20180131190112.GA31608@amd>
 <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com> <20180205082445.GA18274@amd>
 <20180206121122.GG5681@sirena.org.uk> <20180206134906.GA7842@amd>
 <20180206152722.GH5681@sirena.org.uk> <20180224205704.GB5132@amd>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <3edfbd7c-c8f8-f031-30d2-90b441e63688@ti.com>
Date: Mon, 5 Mar 2018 14:52:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180224205704.GB5132@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-02-24 22:57, Pavel Machek wrote:
> On Tue 2018-02-06 15:27:22, Mark Brown wrote:
>> On Tue, Feb 06, 2018 at 02:49:06PM +0100, Pavel Machek wrote:
>>> On Tue 2018-02-06 12:11:22, Mark Brown wrote:
>>
>>>> Please submit patches using subject lines reflecting the style for the
>>>> subsystem.  This makes it easier for people to identify relevant
>>>> patches.  Look at what existing commits in the area you're changing are
>>>> doing and make sure your subject lines visually resemble what they're
>>>> doing.
>>
>>> AFAICT this goes to Documentation, not sound.
>>
>> Even if that were the case you're not following the commonly accepted
>> practice there either.
>>
>>> If you have any comments on V1 of this patch, that would be nice, I'd
>>> like to get that merged once we are finished with the bindings.
>>
>> It is the middle of the merge window, please be a bit more patient.
> 
> For the record, patch currently looks like this. If you have some
> comments on the code, I'd like to hear them.
> 
> Best regards,
> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
> index 8c71d2f..7302789 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c

...

> @@ -1511,10 +1509,26 @@ static int dac33_i2c_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, dac33);
>  
> -	dac33->power_gpio = pdata->power_gpio;
> -	dac33->burst_bclkdiv = pdata->burst_bclkdiv;
> -	dac33->keep_bclk = pdata->keep_bclk;
> -	dac33->mode1_latency = pdata->mode1_latency;
> +	if (pdata) {
> +		dac33->power_gpio = pdata->power_gpio;
> +		dac33->burst_bclkdiv = pdata->burst_bclkdiv;
> +		dac33->keep_bclk = pdata->keep_bclk;
> +		dac33->mode1_latency = pdata->mode1_latency;
> +	} else if (np) {
> +		ret = of_get_named_gpio(np, "power-gpios", 0);
> +		if (ret >= 0)
> +			dac33->power_gpio = ret;
> +		else
> +			dac33->power_gpio = -1;

the code checks for (dac33->power_gpio >= 0) in live path, I guess you
can just skip the power_gpio = -1 in case we don't have GPIO
Handling of EPROBE_DEFER might be something we might want for the GPIO.

> +
> +		if (of_property_read_bool(np, "ti,keep-bclk"))
> +			dac33->keep_bclk = true;
> +
> +		of_property_read_u32(np, "ti,burst-bclkdiv", &dac33->burst_bclkdiv);
> +	} else {
> +		dev_err(&client->dev, "Platform data not set\n");
> +		return -ENODEV;
> +	}
>  	if (!dac33->mode1_latency)
>  		dac33->mode1_latency = 10000; /* 10ms */
>  	dac33->irq = client->irq;
> @@ -1580,9 +1594,16 @@ static const struct i2c_device_id tlv320dac33_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, tlv320dac33_i2c_id);
>  
> +static const struct of_device_id tlv320dac33_of_match[] = {
> +	{ .compatible = "ti,tlv320dac33", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, tlv320dac33_of_match);
> +
>  static struct i2c_driver tlv320dac33_i2c_driver = {
>  	.driver = {
>  		.name = "tlv320dac33-codec",
> +		.of_match_table = of_match_ptr(tlv320dac33_of_match),
>  	},
>  	.probe		= dac33_i2c_probe,
>  	.remove		= dac33_i2c_remove,
> 
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
