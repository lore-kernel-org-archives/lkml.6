Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA69C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D492086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ufKcEV09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfANP0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:26:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37542 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfANP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:26:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so23340941wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sTTzeO8m1Id1UGNvqucxuX+eg7mPinyJrVlTnA9mEWY=;
        b=ufKcEV09k6V/koHwAGp2Ic8BU5oclkxwMq2JdWj4Sdr0mA5txTkJuYDPKU60tixwdt
         vtfawlM8Ds73Rb7u9xYWVGuspry/ltN5KWsVK3aha58iAHfLRTbGdHNN+1CD3dW7gHsR
         caSaRRVc76A/QtDVdyKwwveerP7isNEz16xS2X5cEHUA2b3Ql17wZ/5xjNoM102M9YCO
         rA4514gD5Me71PtHywTrDbFwN9lvJ3IjRgz2Cw4MknfY/4rfZOxBHyFF4KO4O7ws/zXq
         7RFrL6zo75/KXHA7hTMTzJ/I0CYz+AKpzI3ZccAAFKEA425iu/EmHwxKb7QTb38/+TrM
         bLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sTTzeO8m1Id1UGNvqucxuX+eg7mPinyJrVlTnA9mEWY=;
        b=ui73lyzJoY3DZWI3AyZVifq+BiBjAIgFEYFRksYprvmp+b4NukD0ehGLBMMdDwgT2u
         if6IWy8R7VOCliHc4Nai7VSUVJSfxDa2BSF83OUJ9/2zoi+MHQL03jnGhL8buJtVn8Xj
         tE2CyCTO2a8uUjgrJXIbPya6n1d0bK+rbWon+0XnfM9CT6r+TMFEKmE/Eni1eiIqt8PX
         4w84Y44RcKmJptpU/CT8CSrMlbMVykPy4V4wtNAWmtMxrPcBYaVNP1YuVCj02tB63jbj
         cVK5lmSdCiM5H6Rok92SsFIKp+9n7KpFGMMyGYK9NNjlwytS4eOegJmZy+eCzu8zLiLG
         YxQw==
X-Gm-Message-State: AJcUukc0Mh1fo+qC8EMwa/NDYziwGJO8TzVl6NqQks9juCQVD1GYL22C
        yAoMFd9IxmbQwvbSQ8GBgt8mnA==
X-Google-Smtp-Source: ALg8bN7MT4oMt4Ru24uyQ/KzffTg0dgAllD5jISu+ZQpwEPl/HX+4EZOyv2dV1X7ho8WGiBQ403SeA==
X-Received: by 2002:adf:9bda:: with SMTP id e26mr23743489wrc.295.1547479560992;
        Mon, 14 Jan 2019 07:26:00 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 125sm48588530wmm.26.2019.01.14.07.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 07:25:59 -0800 (PST)
Subject: Re: [PATCH] drm/meson: Fix atomic mode switching regression
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     daniel@ffwll.ch, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190109133644.27459-1-narmstrong@baylibre.com>
 <CAFBinCAGGDx_9g3Y16fczUPGaBC0Ep=ULkY__n3WdrQRnDSsyA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <a3d36c98-9d90-ff63-7ca8-77aff89f7f1a@baylibre.com>
Date:   Mon, 14 Jan 2019 16:25:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCAGGDx_9g3Y16fczUPGaBC0Ep=ULkY__n3WdrQRnDSsyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 09/01/2019 23:18, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Wed, Jan 9, 2019 at 2:36 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Since commit 2bcd3ecab773 when switching mode from X11 (ubuntu mate for
>> example) the display gets blurry, looking like an invalid framebuffer width.
>>
>> This commit fixed atomic crtc modesetting but didn't update the display
>> parameters when changing mode, but only when starting a mode setting after
>> a crtc disable.
>>
>> This commit setups the crctc parameter in _begin() and _enable() to
>> take in account the current ctrc parameters.
>>
>> Reported-by: Tony McKahan <tonymckahan@gmail.com>
>> Fixes: 2bcd3ecab773 ("drm/meson: Fixes for drm_crtc_vblank_on/off support")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_crtc.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
>> index 75d97f1b2e8f..5bb432021caf 100644
>> --- a/drivers/gpu/drm/meson/meson_crtc.c
>> +++ b/drivers/gpu/drm/meson/meson_crtc.c
>> @@ -82,14 +82,12 @@ static const struct drm_crtc_funcs meson_crtc_funcs = {
>>
>>  };
>>
>> -static void meson_crtc_enable(struct drm_crtc *crtc)
>> +static void meson_crtc_setup(struct drm_crtc *crtc)
>>  {
>>         struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>>         struct drm_crtc_state *crtc_state = crtc->state;
>>         struct meson_drm *priv = meson_crtc->priv;
>>
>> -       DRM_DEBUG_DRIVER("\n");
>> -
>>         if (!crtc_state) {
>>                 DRM_ERROR("Invalid crtc_state\n");
>>                 return;
>> @@ -98,6 +96,16 @@ static void meson_crtc_enable(struct drm_crtc *crtc)
>>         /* Enable VPP Postblend */
> nit-pick: this "enable" comment is now in meson_crtc_setup().
> I would drop it because my interpretation of the following lines is
> now "setting VPP_POSTBLEND_H_SIZE enables the VPP postblend"
> 
>>         writel(crtc_state->mode.hdisplay,
>>                priv->io_base + _REG(VPP_POSTBLEND_H_SIZE));
>> +}
>> +
>> +static void meson_crtc_enable(struct drm_crtc *crtc)
>> +{
>> +       struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>> +       struct meson_drm *priv = meson_crtc->priv;
>> +
>> +       DRM_DEBUG_DRIVER("\n");
>> +
>> +       meson_crtc_setup(crtc);
>>
>>         /* VD1 Preblend vertical start/end */
>>         writel(FIELD_PREP(GENMASK(11, 0), 2303),
>> @@ -121,6 +129,8 @@ static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
>>
>>         if (!meson_crtc->enabled)
>>                 meson_crtc_enable(crtc);
>> +       else
>> +               meson_crtc_setup(crtc);
> it's probably only personal preference, but have you thought about
> re-ordering this:
>   meson_crtc_setup(crtc);
> 
>   if (!meson_crtc->enabled)
>     meson_crtc_enable(crtc);
> 
> with that you could get rid of the meson_crtc_setup() call in
> meson_crtc_enable(), leaving only one code-path (instead of two) which
> calls meson_crtc_setup()

All of this is wrong, I only needed to use `atomic_commit_tail = drm_atomic_helper_commit_tail_rpm`
in meson_drv for the fbdev.

This fix is wrong, pushing a right one.

Neil

> 
> 
> Regards
> Martin
> 

