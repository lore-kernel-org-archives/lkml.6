Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A9C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDDA218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDDA218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeHNMCN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:02:13 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45757 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeHNMCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:02:13 -0400
Received: by mail-qk0-f196.google.com with SMTP id c192-v6so12862114qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 02:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ULfL4kbohmOjWTbYP6ucBju0X8ppaJUlTN1+LV408a0=;
        b=NePzeovjcg4uRcInBRHrr2FoUmBG4tBJfa48gHBdFwcrM0BnHzmJTrcJy95fXyliJP
         ZIvIiZoaIkz8B2SERjftaQo6B46XFKeXOktKlNT9M7KORtZZR9EEHLufegWQ3AFFZtr/
         /1REzKrcKezerCS5I1OXR3pfKj6vENV7/GKJJfPT4a1PRm6/OZhQpkIz4NAmnh6LTyPV
         aaYLWnc/RzxxXxVJPbJEyRPy07IlycpO7XJXWtdlV7t/tqe6IUQ6NH+IBrFduQ2VRTKe
         +qShJ01F8RzcekIa6mutGRRZfCP7HIVQZU0hNYZr1YGMTE+PJnlPIvkfWnEbDsFRWqiU
         H8ZQ==
X-Gm-Message-State: AOUpUlFa6xBSVayijyOJviDGmyhjj1qHfpuYVpRMaVBm3GhhpyjdPN7x
        EaDOH0Jw3M5LeEwtpB2pGSm3R817W7iDC1XhzWU=
X-Google-Smtp-Source: AA+uWPxumEdwpErWJwo04Bq+kWPRUKEDZ/KihzALiGX0xGYJlwGuzH3x9XIVId/4UBl9PrVsizvUogXFi/YEpQus9kw=
X-Received: by 2002:a37:8786:: with SMTP id j128-v6mr18226690qkd.32.1534238154645;
 Tue, 14 Aug 2018 02:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180811155554.3382650-1-arnd@arndb.de> <593dd8e1-fa23-3216-3550-274401d88bcb@gmail.com>
 <CADnq5_PCyKb72-BjFG3B4p_+bctNKoswAibw8C687_fpystSJA@mail.gmail.com>
 <CAK8P3a1AGC4fFYSSDQn2snkvf5htZVffCwRLV1NBm5YeZgw+CA@mail.gmail.com> <632dceb6-27e5-869b-46a9-6b11944204fc@daenzer.net>
In-Reply-To: <632dceb6-27e5-869b-46a9-6b11944204fc@daenzer.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Aug 2018 11:15:38 +0200
Message-ID: <CAK8P3a3fDOeNWsmtXRHOF5cAMit7AMt7fS_54m7NXN0AjZYbPw@mail.gmail.com>
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
To:     michel@daenzer.net
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>,
        Jerry.Zuo@amd.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 10:54 AM Michel Dänzer <michel@daenzer.net> wrote:
>
> On 2018-08-13 05:23 PM, Arnd Bergmann wrote:
> > On Mon, Aug 13, 2018 at 4:49 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >>
> >> On Sun, Aug 12, 2018 at 3:55 AM Christian König
> >> <ckoenig.leichtzumerken@gmail.com> wrote:
> >>> Adding Harry as well.
> >>> Am 11.08.2018 um 17:54 schrieb Arnd Bergmann:
> >>>>
> >>>> Fixes: bf2e2e2e0ea9 ("drm/amd/display: Limit DCN to x86 arch")
> >>>> Fixes: 4841203102a3 ("drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86")
> >>
> >> Maybe it would be better to revert 4841203102a3 so we can limit the
> >> scope of this to DCN support.
> >
> > That would help, but we would still require the patch at
> > https://patchwork.kernel.org/patch/10090227/ or something else to avoid
> > broken randconfig builds.
>
> FWIW, please don't revert 4841203102a3 in a way which allows
> CONFIG_DRM_AMD_DC_DCN1_0 to be accidentally disabled on X86 again. If it
> is reinstated, it should be strictly derived from other options, not
> changeable by the user.

How about making all of AMDGPU depend on
" !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS) || BROKEN"
then?

     Arnd
