Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217CDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F0C2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bym2FOtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbeLTHhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:37:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41418 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeLTHhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:37:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so620975wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jy1CRwetC6RKb1th8p4ENw+sQYr7K9Dza21ajyPLWtc=;
        b=bym2FOtPO4DUxuKJ0I41/wdxp4XtovuHYc0QSUqnThyF4qbjFgFfz0xtRtQCA/xYaq
         NpfDfJfLB32ohXiovN1Tx8fGGo/KsfUrkVpyQ8SwsjVHi8xKZ99FLlOitsVaVdZBmc1h
         kSb7TFXcMp94gB13unJkO2K2DTjYZ1vaOl4XnDEj4AhvGJJZLRQ295SH4fvJZVpRiPhP
         G2avbR5iJ5wQJ16ub+2MS6ESkk9mXtDTbZiK9ndDbY/6RG4A8anUH7+5mpCk8SDlffPd
         2/vDpxd50EFA2PMq2mGW6hNMuZlmxP9EjngmG9DdfmGf6BHqlsHPWFP+C8aLRdrNliE/
         2p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jy1CRwetC6RKb1th8p4ENw+sQYr7K9Dza21ajyPLWtc=;
        b=lkfS9nSTZtHKMcXdbKPKR+cA0JK6GYZxLhTvOGdwKF/AoKsbuXgqdAMD3Lrh4FWDV8
         HXb7yHIK8ZcVgFVlff5SomYVP+93y1+mLHItfBDA1lBM2SGHGLKqHe3MScl1eEgYyh5T
         i4yYi5xkVBZWbqM9biadyOO1DLwxKyXdSgkFv2R7pUaRMWRzgmSoTL3yASoiSa8CF1Bb
         baGxu75QxqLaV18h6InGlURjr3ZEzDbFK3Ox9eKvzmzS1dtgyGGx1HyVOFeKLdrXC89c
         muQfox3gw4I3uz4lpvmH4Q0GqM2u6eMjgXfBFFg8oA6rH5VYcbhLoEC6W5jkeKAcnEq/
         3wpQ==
X-Gm-Message-State: AA+aEWYAuVf+EeupriD0WDVG6i7wmDAHnhWM386i0IDw94vxuV9EgNKS
        C6ejcQQo5VY/2+yrEeE7SYwewkHyp7/ZbQ==
X-Google-Smtp-Source: AFSGD/W7ufmps6YVI7FnxGdSIdshvuaZDDzQe6ynuV/pjqOLt27Yf9uBd7OxXb1wxVec98uVreJxcg==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr20608918wrv.116.1545291451332;
        Wed, 19 Dec 2018 23:37:31 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:514:a0b:733a:7325? ([2a01:cb1d:4ce:ea00:514:a0b:733a:7325])
        by smtp.gmail.com with ESMTPSA id p14sm5516429wrt.37.2018.12.19.23.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 23:37:30 -0800 (PST)
Subject: Re: [PATCH RFC v2 5/8] drm/bridge: dw-hdmi: support dynamically get
 input/out color info
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     architt@codeaurora.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com, Zheng Yang <zhengyang@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181130134301.17963-1-narmstrong@baylibre.com>
 <20181130134301.17963-6-narmstrong@baylibre.com>
 <3cd791c0-8a7b-a3d1-09fa-5ddf0ea9c380@samsung.com>
 <1690671.DkqnqcUgQk@avalon>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <befba722-d410-1123-a6df-2594a5b88385@baylibre.com>
Date:   Thu, 20 Dec 2018 08:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1690671.DkqnqcUgQk@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej, Laurent,

Thanks for your review.

On 19/12/2018 08:50, Laurent Pinchart wrote:
> Hello,
> 
> On Wednesday, 19 December 2018 09:26:08 EET Andrzej Hajda wrote:
>> On 30.11.2018 14:42, Neil Armstrong wrote:
>>> From: Zheng Yang <zhengyang@rock-chips.com>
>>>
>>> To get input/output bus_format/enc_format dynamically, this patch
>>>
>>> introduce following funstion in plat_data:
>>> 	- get_input_bus_format
>>> 	- get_output_bus_format
>>> 	- get_enc_in_encoding
>>> 	- get_enc_out_encoding
>>
>> It seems fishy. On one side description says about dynamic resolution of
>> formats and encodings.
>>
>> On the other side these functions as only argument takes platform_data
>> which should be rather static.

They are callbacks to the "glue" code, similar the PHY and HPD callbacks,
they will return different encodings and formats depending on the current mode
being atomically set.

>>
>> Where is this "dynamic" thing? The only usage of these callbacks I have
>> found in next patches is also not dynamic, the functions just return
>> some static value.

in patch 7 & 8 we return the current glue dw_hdmi->input_bus_format
and dw_hdmi->output_bus_format set during the encoder atomic_check()

>>
>> Moreover function takes void* argument, which is again something
>> suspicious, why cannot you pass know structure?

Yes, we should also pass dw_hdmi along the dw_plat_data->phy_data we
already pass.

>>
>> And finally encoding usually should depend on display mode, it should
>> not depend only static data.

It does not, there are fallbacks already in place, where you can override
with static data (the bus encoding and format can be fixed) or dynamic
to solve the yuv420 format.
Amlogic pipeline can *only* output in YUV (444, 422 or 420) so I pushed
support for statically describing the input format and encoding using
V4L2 definitions.

>>
>>
>> What kind of problems do you want to solve here?

We try to solve 2 things :
- The YUV420 HDMI2.0 mode, but the DW-HDMI CSC cannot convert to/from YUV420, so
it's in passthrought only. So the encoder must output in yuv420 and the controller
must know the input format and the output format, and this dynamically.
- Today the DW-HDMI forces RGB 8bit output, but we may prefer YUV444 or YU422 depending
on the sink and eventually output in 10, 12 or 16bit mode. This logic should
not be in the controller bridge code.

To solve these uses case, we put the logic in the encoder to determine what is
the DW-HDMI input format+encoding and the needed output format+encoding.

Today, the encoding callbacks are not used in this patchset, but they follow the
same scheme.

> 
> I would add that this doesn't seem to be specific to dw-hdmi in any way. I'd 
> prefer an API at the drm_bridge level to handle this.

Can you point me what you have in mind ? I'll be happy to implement it.

These callbacks are only an extension of the hdmi->plat_data->input_bus_format
and hdmi->plat_data->input_bus_encoding I introduced a few times ago.

I'd really like to solve this correctly, but still solve it at some point !
The YUV420 support is handy to easily support 4k60 for cheap and older TVs
without the hassle of SCDC and TMDS scrambling.

Neil

> 
>>> Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>
>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 28 +++++++++++++++++------
>>>  include/drm/bridge/dw_hdmi.h              |  5 ++++
>>>  2 files changed, 26 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
>>> 4a9a24e854db..bd564ffdf18b 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> @@ -1810,6 +1810,7 @@ static void hdmi_disable_overflow_interrupts(struct
>>> dw_hdmi *hdmi)> 
>>>  static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode
>>>  *mode) {
>>>  
>>>  	int ret;
>>>
>>> +	void *data = hdmi->plat_data->phy_data;
>>>
>>>  	hdmi_disable_overflow_interrupts(hdmi);
>>>
>>> @@ -1821,10 +1822,13 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
>>> struct drm_display_mode *mode)> 
>>>  		dev_dbg(hdmi->dev, "CEA mode used vic=%d\n", hdmi->vic);
>>>  	
>>>  	}
>>>
>>> -	if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
>>> -	    (hdmi->vic == 21) || (hdmi->vic == 22) ||
>>> -	    (hdmi->vic == 2) || (hdmi->vic == 3) ||
>>> -	    (hdmi->vic == 17) || (hdmi->vic == 18))
>>> +	if (hdmi->plat_data->get_enc_out_encoding)
>>> +		hdmi->hdmi_data.enc_out_encoding =
>>> +			hdmi->plat_data->get_enc_out_encoding(data);
>>> +	else if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
>>> +		 (hdmi->vic == 21) || (hdmi->vic == 22) ||
>>> +		 (hdmi->vic == 2) || (hdmi->vic == 3) ||
>>> +		 (hdmi->vic == 17) || (hdmi->vic == 18))
>>>
>>>  		hdmi->hdmi_data.enc_out_encoding = V4L2_YCBCR_ENC_601;
>>>  	
>>>  	else
>>>  	
>>>  		hdmi->hdmi_data.enc_out_encoding = V4L2_YCBCR_ENC_709;
>>>
>>> @@ -1833,21 +1837,31 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
>>> struct drm_display_mode *mode)> 
>>>  	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
>>>  	
>>>  	/* TOFIX: Get input format from plat data or fallback to RGB888 */
>>>
>>> -	if (hdmi->plat_data->input_bus_format)
>>> +	if (hdmi->plat_data->get_input_bus_format)
>>> +		hdmi->hdmi_data.enc_in_bus_format =
>>> +			hdmi->plat_data->get_input_bus_format(data);
>>> +	else if (hdmi->plat_data->input_bus_format)
>>>
>>>  		hdmi->hdmi_data.enc_in_bus_format =
>>>  		
>>>  			hdmi->plat_data->input_bus_format;
>>>  	
>>>  	else
>>>  	
>>>  		hdmi->hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>>>  	
>>>  	/* TOFIX: Get input encoding from plat data or fallback to none */
>>>
>>> -	if (hdmi->plat_data->input_bus_encoding)
>>> +	if (hdmi->plat_data->get_enc_in_encoding)
>>> +		hdmi->hdmi_data.enc_in_encoding =
>>> +			hdmi->plat_data->get_enc_in_encoding(data);
>>> +	else if (hdmi->plat_data->input_bus_encoding)
>>>
>>>  		hdmi->hdmi_data.enc_in_encoding =
>>>  		
>>>  			hdmi->plat_data->input_bus_encoding;
>>>  	
>>>  	else
>>>  	
>>>  		hdmi->hdmi_data.enc_in_encoding = V4L2_YCBCR_ENC_DEFAULT;
>>>  	
>>>  	/* TOFIX: Default to RGB888 output format */
>>>
>>> -	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>>> +	if (hdmi->plat_data->get_output_bus_format)
>>> +		hdmi->hdmi_data.enc_out_bus_format =
>>> +			hdmi->plat_data->get_output_bus_format(data);
>>> +	else
>>> +		hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>>>
>>>  	hdmi->hdmi_data.pix_repet_factor = 0;
>>>  	hdmi->hdmi_data.hdcp_enable = 0;
>>>
>>> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
>>> index 7a02744ce0bc..2e797f782c51 100644
>>> --- a/include/drm/bridge/dw_hdmi.h
>>> +++ b/include/drm/bridge/dw_hdmi.h
>>> @@ -142,6 +142,11 @@ struct dw_hdmi_plat_data {
>>>
>>>  	int (*configure_phy)(struct dw_hdmi *hdmi,
>>>  	
>>>  			     const struct dw_hdmi_plat_data *pdata,
>>>  			     unsigned long mpixelclock);
>>>
>>> +
>>> +	unsigned long (*get_input_bus_format)(void *data);
>>> +	unsigned long (*get_output_bus_format)(void *data);
>>> +	unsigned long (*get_enc_in_encoding)(void *data);
>>> +	unsigned long (*get_enc_out_encoding)(void *data);
>>>
>>>  };
>>>  
>>>  struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
> 
> 

