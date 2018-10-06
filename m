Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6978CC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 10:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314092087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 10:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGwrLDu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314092087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJFRcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 13:32:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43587 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeJFRcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 13:32:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id r8-v6so13740964ljc.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 03:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GkitgwVOaBiGLhA6bOg8KnxM4w9A7/FAtXvjf3KYTkQ=;
        b=fGwrLDu1Rbj+VaWLZadLY/w6kq6h05MHIO8SI8KUKUeCn3AaT3/F2iZICOGLIAZMfn
         m9zAd3cnb7b8kDspflwYh7iymt54fFlVEqr418ieYWTEiebTat416cidwDYW8GA5ky13
         RupQTnb4+M5m1dW0z0voFGj5ZbkXjUyPYYKhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GkitgwVOaBiGLhA6bOg8KnxM4w9A7/FAtXvjf3KYTkQ=;
        b=mV5+3hmIlY41vOyHrEk6ehOQ+SoPgn41hfB08RQ+Rx89bXPLxZ8KEUL16T58CtTBsm
         wlSAp4pxJO5sBLB36X1TyObdJgvgVveSuBW6+Q1ZEnzMtVh7VBqWLjCHUkGftdACw4Gk
         pAASMyYmZy2qHkYqCAfKaHxR+3Rmn3+12qAjZJ0ENY3G17T9dCLppS4olR9Dly845+Wq
         Bcqt8PjXGgDLik78QcKfQoR5R4G8fcfyf9JxWG9GWiXpCQhScv53/kPq9iCmrHdPzrAX
         N7ND/O8t5THqGGaT91cn16fLvzUBBLkeWmidSsEtbMXHjlApgIu46s1iox1aIKpSiBXm
         7F2w==
X-Gm-Message-State: ABuFfoiTdoRc1jqrik9kS/IetMKfJ4XIoGuPMJE8sMichp70Sx0S3sqx
        9fDgMysV+4VBkKPBSoWBWsu21363jk+LYP/cXJfwLQ==
X-Google-Smtp-Source: ACcGV60gOfDghU1PnCo3OwFZdol/uxd4Uzfan7S0satGy48zoAP0bARZloa0jTXf0TZ/Dj9alTq06njBNbLaTsSP0eA=
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr4408240ljj.80.1538821774798;
 Sat, 06 Oct 2018 03:29:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:92c8:0:0:0:0:0 with HTTP; Sat, 6 Oct 2018 03:29:33 -0700 (PDT)
In-Reply-To: <5b236e95-b737-51b3-df4f-eea41a36735e@xs4all.nl>
References: <20181003070656.193854-1-keiichiw@chromium.org>
 <CAD90VcbBUcpwLsY0sHim+mML6esSjZA2ocX0Ff-YiZxBsLTZ+w@mail.gmail.com> <5b236e95-b737-51b3-df4f-eea41a36735e@xs4all.nl>
From:   Keiichi Watanabe <keiichiw@chromium.org>
Date:   Sat, 6 Oct 2018 19:29:33 +0900
Message-ID: <CAD90VcaexKNsRE9s32UanzE32YM2EXFySCArkt_Zo2V3-eRnqQ@mail.gmail.com>
Subject: Re: [PATCH] media: vivid: Support 480p for webcam capture
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Shik Chen <shik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Oct 5, 2018 at 6:18 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> On 10/03/18 09:08, Keiichi Watanabe wrote:
>> I think 480p is a common frame size and it's worth supporting in vivid.
>> But, my patch might be ad-hoc. Actually, I'm not sure which values are
>> suitable for the intervals.
>
> I can apply this ad-hoc patch as-is.
>
> Or do you want to postpone this and work on a more generic solution?
> Although I am not sure what that would look like.

I prefer providing a more flexible way rather than this ad-hoc patch.
It would be helpful if there is a way of changing supported frame sizes easily.
Perhaps, Kieran and me would use it, at least:)

>
> Proposals are welcome!
>
> The main purpose of this code is to have something that kind of acts like
> a real webcam that has various resolutions, and a slower framerate for
> higher resolutions (as you would expect).

This sounds reasonable, so I guess we can keep this way as default and
provide a way for specifying extra frame sizes as an option.

For example, how about a module option like this?
"webcam_sizes=640x480@15,320x240@30"

If this parameter is passed to vivid, vivid works like a webcam that
supports the following 7 pairs of frame size and fps:
- 5 pairs of frame sizes and fps, as with the current implementation
- 640x480 (15fps)
- 320x240 (30fps)

If this parameter is not passed, vivid's behavior won't change from
the current one.

How do you think?

We might want to stop using the default framesizes, i.e. vivid only
supports framesize/fps that passed as the option.
But, if we do so, the parameter will become mandatory and it would be annoying.
So, I personally like to keep the default framesizes.

Best regards,
Kei

>
> Regards,
>
>         Hans
>
>>
>> We might want to add a more flexible/extensible way to specify frame sizes.
>> e.g. passing frame sizes and intervals as module parameters
>>
>> Kei
>>
>> On Wed, Oct 3, 2018 at 4:06 PM, Keiichi Watanabe <keiichiw@chromium.org> wrote:
>>> Support 640x480 as a frame size for video input devices of vivid.
>>>
>>> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
>>> ---
>>>  drivers/media/platform/vivid/vivid-vid-cap.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/vivid/vivid-vid-cap.c b/drivers/media/platform/vivid/vivid-vid-cap.c
>>> index 58e14dd1dcd3..da80bf4bc365 100644
>>> --- a/drivers/media/platform/vivid/vivid-vid-cap.c
>>> +++ b/drivers/media/platform/vivid/vivid-vid-cap.c
>>> @@ -51,7 +51,7 @@ static const struct vivid_fmt formats_ovl[] = {
>>>  };
>>>
>>>  /* The number of discrete webcam framesizes */
>>> -#define VIVID_WEBCAM_SIZES 5
>>> +#define VIVID_WEBCAM_SIZES 6
>>>  /* The number of discrete webcam frameintervals */
>>>  #define VIVID_WEBCAM_IVALS (VIVID_WEBCAM_SIZES * 2)
>>>
>>> @@ -59,6 +59,7 @@ static const struct vivid_fmt formats_ovl[] = {
>>>  static const struct v4l2_frmsize_discrete webcam_sizes[VIVID_WEBCAM_SIZES] = {
>>>         {  320, 180 },
>>>         {  640, 360 },
>>> +       {  640, 480 },
>>>         { 1280, 720 },
>>>         { 1920, 1080 },
>>>         { 3840, 2160 },
>>> @@ -75,6 +76,8 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
>>>         {  1, 5 },
>>>         {  1, 10 },
>>>         {  1, 15 },
>>> +       {  1, 15 },
>>> +       {  1, 25 },
>>>         {  1, 25 },
>>>         {  1, 30 },
>>>         {  1, 50 },
>>> --
>>> 2.19.0.605.g01d371f741-goog
>>>
>
