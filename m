Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeDSJq6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:46:58 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751082AbeDSJq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:46:56 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH 2/2] drm/bridge: sii902x: add optional power supplies
Thread-Topic: [PATCH 2/2] drm/bridge: sii902x: add optional power supplies
Thread-Index: AQHT17dIuXEJMdIwqUuaIl69Iw7CLKQHtaAA
Date: Thu, 19 Apr 2018 09:46:31 +0000
Message-ID: <ea6fbdbe-6ce5-0110-5590-083c7b697a85@st.com>
References: <20180410051927.8268-1-philippe.cornu@st.com>
 <20180410051927.8268-3-philippe.cornu@st.com> <3775994.jviQhGlOpf@avalon>
In-Reply-To: <3775994.jviQhGlOpf@avalon>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.117]
Content-Type: text/plain; charset="utf-8"
Content-ID: <914B4849EBCB6F49AD69B1AFCEEFEFE9@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3J9l5D0017960

Hi Laurent :-)

On 04/19/2018 10:20 AM, Laurent Pinchart wrote:
> Hi Philippe,
> 
> Thank you for the patch.
> 
> On Tuesday, 10 April 2018 08:19:27 EEST Philippe Cornu wrote:
>> Add the 3 optional power supplies using the exact description
>> found in the document named
>> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>> drivers/gpu/drm/bridge/sii902x.c | 39 +++++++++++++++++++++++++++++++++----
>> 1 file changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c
>> b/drivers/gpu/drm/bridge/sii902x.c index 60373d7eb220..e17ba6db1ec8 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/i2c.h>
>>   #include <linux/module.h>
>>   #include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>>
>>   #include <drm/drmP.h>
>>   #include <drm/drm_atomic_helper.h>
>> @@ -86,6 +87,7 @@ struct sii902x {
>>   	struct drm_bridge bridge;
>>   	struct drm_connector connector;
>>   	struct gpio_desc *reset_gpio;
>> +	struct regulator_bulk_data supplies[3];
>>   };
>>
>>   static inline struct sii902x *bridge_to_sii902x(struct drm_bridge *bridge)
>> @@ -392,23 +394,43 @@ static int sii902x_probe(struct i2c_client *client,
>>   		return PTR_ERR(sii902x->reset_gpio);
>>   	}
>>
>> +	sii902x->supplies[0].supply = "iovcc";
>> +	sii902x->supplies[1].supply = "avcc12";
>> +	sii902x->supplies[2].supply = "cvcc12";
>> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(sii902x->supplies),
>> +				      sii902x->supplies);
>> +	if (ret) {
>> +		dev_err(dev, "regulator_bulk_get failed\n");
> 
> Maybe "failed to get power supplies" to be a bit more explicit ? And while at
> it, printing the value of ret too ?
> 

good point, I will do that in v2


>> +		return ret;
>> +	}
>> +
>> +	ret = regulator_bulk_enable(ARRAY_SIZE(sii902x->supplies),
>> +				    sii902x->supplies);
>> +	if (ret) {
>> +		dev_err(dev, "regulator_bulk_enable failed\n");
> 
> Same here ?
> 

agreed

>> +		return ret;
>> +	}
>> +
>> +	usleep_range(10000, 20000);
>> +
>>   	sii902x_reset(sii902x);
>>
>>   	ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
>>   	if (ret)
>> -		return ret;
>> +		goto err_disable_regulator;
>>
>>   	ret = regmap_bulk_read(sii902x->regmap, SII902X_REG_CHIPID(0),
>>   			       &chipid, 4);
>>   	if (ret) {
>>   		dev_err(dev, "regmap_read failed %d\n", ret);
>> -		return ret;
>> +		goto err_disable_regulator;
>>   	}
>>
>>   	if (chipid[0] != 0xb0) {
>>   		dev_err(dev, "Invalid chipid: %02x (expecting 0xb0)\n",
>>   			chipid[0]);
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto err_disable_regulator;
>>   	}
>>
>>   	/* Clear all pending interrupts */
>> @@ -424,7 +446,7 @@ static int sii902x_probe(struct i2c_client *client,
>>   						IRQF_ONESHOT, dev_name(dev),
>>   						sii902x);
>>   		if (ret)
>> -			return ret;
>> +			goto err_disable_regulator;
>>   	}
>>
>>   	sii902x->bridge.funcs = &sii902x_bridge_funcs;
>> @@ -434,6 +456,12 @@ static int sii902x_probe(struct i2c_client *client,
>>   	i2c_set_clientdata(client, sii902x);
>>
>>   	return 0;
>> +
>> +err_disable_regulator:
>> +	regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
>> +			       sii902x->supplies);
>> +
>> +	return ret;
>>   }
>>
>>   static int sii902x_remove(struct i2c_client *client)
>> @@ -443,6 +471,9 @@ static int sii902x_remove(struct i2c_client *client)
>>
>>   	drm_bridge_remove(&sii902x->bridge);
>>
>> +	regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
>> +			       sii902x->supplies);
>> +
> 
> While this seems functionally correct, would it be useful to only enable power
> supplies when needed to save power ?
> 

that is a good point. I do not know well (yet) this bridge. Maybe I can 
add a 3rd patch with bridge pre_enable() and post_disable() containing 
reset & supplies management. Or I can put reset&supplies in bridge 
enable() & disable() but it could be a little messy.

Any opinion/advice?
Many thanks,
Philippe :-)

>>   	return 0;
>>   }
> 
