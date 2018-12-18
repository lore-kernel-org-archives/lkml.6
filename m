Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AEAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4855D21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bfp5VJyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeLRNT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:19:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLRNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:19:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so14909501wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L1afcgE9DRTtzBvdu1f+Heu20KwLsQvyQvLwTy1YDeI=;
        b=bfp5VJyfo14xV3DpfzU8mycWbNEfY53guB2iUbwR8q34LGKHzEm+CZgn7NOuFrV7Ib
         vJC/Xqt+YiRkK/KzJBqAuC34+ew/TwdbvVDf62FBkHtFoVjo3hutRi9GTaUyGPFvXBcw
         +UyjwLn2+bpF21CqxcCcqkordh3WZwVoGQDMllZ1MFCTZ4nVUycrc547OgVyfj9HgOwB
         fFmOnQVAEHNcplDBm0T/7bZz0BxqQ7/sIzbvff5wnjuOWovttPp3cbjxH4xtlpg+5E4a
         KBncIVefEPmJWuXFQbGHCdW/rRErop9mdl8Knjnyvye4W42+k+PD0BiC6aYtyyYGKHta
         YLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L1afcgE9DRTtzBvdu1f+Heu20KwLsQvyQvLwTy1YDeI=;
        b=DeytsfaD5jSt64kizjOIDQgldUGFWvcgMdZen9RuW5rAX46/of7BpBwsE5UPYjIU7X
         FxqrqH+mByTtzaX1chXapMJcbzJEOJSgOEftKGnJ/ziv2KvwxCEI9MfVbBz+nw2eIvha
         mQ0yIwrZHE4VVU4DkFDf+1UdPNU+jznV8/RiLjDbVsDkJGZEp05Ecj+HiyCEtbdJhC2Y
         KgAQgbaZZiSGHCIBKnmzzRmYM+RWR9NxWFdjhLv2FOawJa24VXog0fb6DOrjjeERulGw
         ojrOgAjZ+Vjw8JQVDXG+TWRYVqfPcZjnL+71suOMxjmfnb6DTm0ZYTEuueCxz5+y0n+L
         2wYQ==
X-Gm-Message-State: AA+aEWY9e+m5ZixnClVB5Y94o44kjYv50yTIhXJwjMZIsb189ZUK8C94
        8+/0JhyARifBQtb4RJ8g1UMfcFNcXBsauQ==
X-Google-Smtp-Source: AFSGD/UXtpb1vh19FzP96+omjFFa2lP6UAVFaGm0JwQntvvfdk0QIUACHoEAdseI1sicannIgtB4tg==
X-Received: by 2002:adf:d146:: with SMTP id b6mr14795249wri.156.1545139193769;
        Tue, 18 Dec 2018 05:19:53 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i186sm2775280wmd.19.2018.12.18.05.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 05:19:53 -0800 (PST)
Subject: Re: [PATCH RFC v2 2/8] drm/meson: add HDMI div40 TMDS mode
To:     Andrzej Hajda <a.hajda@samsung.com>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181130134301.17963-1-narmstrong@baylibre.com>
 <CGME20181130134341epcas3p47020dea94fe298a3a58ab3007bfd5d75@epcas3p4.samsung.com>
 <20181130134301.17963-3-narmstrong@baylibre.com>
 <d63e5df4-2250-178e-2b1e-3a8ac8dcb6df@samsung.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <2738985d-e2c6-905e-4148-69344fb50cc3@baylibre.com>
Date:   Tue, 18 Dec 2018 14:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d63e5df4-2250-178e-2b1e-3a8ac8dcb6df@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2018 13:36, Andrzej Hajda wrote:
> On 30.11.2018 14:42, Neil Armstrong wrote:
>> Add support for TMDS Clock > 3.4GHz for HDMI2.0 display modes.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> index 807111ebfdd9..b8775102b100 100644
>> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> @@ -365,7 +365,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>>  	unsigned int wr_clk =
>>  		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
>>  
>> -	DRM_DEBUG_DRIVER("%d:\"%s\"\n", mode->base.id, mode->name);
>> +	DRM_DEBUG_DRIVER("%d:\"%s\" div%d\n", mode->base.id, mode->name,
>> +			 mode->clock > 340000 ? 40 : 10);
>>  
>>  	/* Enable clocks */
>>  	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
>> @@ -385,9 +386,17 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>>  	/* Enable normal output to PHY */
>>  	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
>>  
>> -	/* TMDS pattern setup (TOFIX pattern for 4k2k scrambling) */
>> -	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, 0x001f001f);
>> -	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23, 0x001f001f);
>> +	/* TMDS pattern setup (TOFIX Handle the YUV420 case) */
>> +	if (mode->clock > 340000) {
>> +		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, 0);
>> +		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
>> +				  0x03ff03ff);
>> +	} else {
>> +		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
>> +				  0x001f001f);
>> +		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
>> +				  0x001f001f);
>> +	}
>>  
>>  	/* Load TMDS pattern */
>>  	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_CNTL, 0x1);
>> @@ -413,6 +422,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>>  	/* Disable clock, fifo, fifo_wr */
>>  	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1, 0xf, 0);
>>  
>> +	dw_hdmi_set_high_tmds_clock_ratio(hdmi);
>> +
>>  	msleep(100);
>>  
>>  	/* Reset PHY 3 times in a row */
>> @@ -562,6 +573,11 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>>  		mode->vdisplay, mode->vsync_start,
>>  		mode->vsync_end, mode->vtotal, mode->type, mode->flags);
>>  
>> +	/* If sink max TMDS clock < 340MHz, we reject the HDMI2.0 modes */
>> +	if (mode->clock > 340000 &&
>> +	    connector->display_info.max_tmds_clock < 340000)
>> +		return MODE_BAD;
>> +
> 
> 
> Why not just:
> 
> if (mode->clock > connector->display_info.max_tmds_clock)
> 	return MODE_BAD;

Hmm, let me check, it may be better indeed.

Neil

> 
> 
> Regards
> 
> Andrzej
> 
> 
>>  	/* Check against non-VIC supported modes */
>>  	if (!vic) {
>>  		status = meson_venc_hdmi_supported_mode(mode);
> 
> 

