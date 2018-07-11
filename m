Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59E2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70500208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d4Ml8RwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70500208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbeGKLzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:55:08 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54999 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeGKLzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:55:08 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so3169611itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UMyl+7eMVhoJe82mLlfKA5i2hhnu2JlOHvhdvL0gSME=;
        b=d4Ml8RwNma1cUq7qG0oUaxFxW4mRbdd0JRU8FaUr7FUhj+8DB/jO69fVna1CEd6ofM
         mvCVAU+tPVHmjOeIjGQeetg3lLB08Qu+uRjogIgXY0XZPDHa/ICkDLtAnb2MNNEUCqh9
         JDJ3OtzfkIZ95J9Z2ZHpKF5p6CiqV+hiDF5KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UMyl+7eMVhoJe82mLlfKA5i2hhnu2JlOHvhdvL0gSME=;
        b=Gk1bBqXVHzEC7nWFMhcKxlVPrapAV+vxy/vDALB4SC2+105DyiYsGfQDbozXD4++Cp
         g7nkyI0GeqJrbG23IafFm1aHyJq7QESBhzlpV5SdZXTPH0/ZZ/imfMmDm70/KtIX4gKJ
         +qdmxE9bRMqmQGekHmVdVy3/shncj7p2lpQikptaoONPkonci3CQITCowj56BkbKCS+Y
         w5klo/O5Oxk3KrTB3wxI+dlxS5hBNUn9ElzQluEQZoSVWjcsA/OsBZqOT3iwK3AWzA6H
         a/KKDVYBpwultcoR8EUZxU7Tj99R+z2fIXaBidpshIpwh51Nin8CE6eZfaJWNn44gFJD
         yX3w==
X-Gm-Message-State: APt69E3dIrD4KNFsdsLt5mQOH6jQhEerzT9vNLEMteUjpME+Q35RHBrH
        F/Qkz570iU9GditW2uOPs8B2ZrgmyRYXYxDUmZjgmA==
X-Google-Smtp-Source: AAOMgpdDcdbX//Akcvii/eo42s4OIGWdStT3J56hYD4dXG/qnmR6pwUDkeyeIrXinT/IOqzTu7SIl/Iz90LsddjV9OM=
X-Received: by 2002:a24:52:: with SMTP id 79-v6mr22984107ita.58.1531309869167;
 Wed, 11 Jul 2018 04:51:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 04:51:08
 -0700 (PDT)
X-Originating-IP: [212.51.149.109]
In-Reply-To: <871scbwfd4.fsf@notabene.neil.brown.name>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709162509.29343-1-daniel.vetter@ffwll.ch> <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org>
 <20180710075328.GG3008@phenom.ffwll.local> <871scbwfd4.fsf@notabene.neil.brown.name>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 11 Jul 2018 13:51:08 +0200
X-Google-Sender-Auth: 7Clwz2lAPTu5AbNIS497KBVxgvw
Message-ID: <CAKMK7uFEYyD2ChWnO_0PS_rkK180dDoQ1g4J0UWRfchnYQxOTA@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: Add for_each_if()
To:     NeilBrown <neilb@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Wang <wvw@google.com>, Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:32 PM, NeilBrown <neilb@suse.com> wrote:
> On Tue, Jul 10 2018, Daniel Vetter wrote:
>
>> On Mon, Jul 09, 2018 at 04:30:01PM -0700, Andrew Morton wrote:
>>> On Mon,  9 Jul 2018 18:25:09 +0200 Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>>>
>>> > To avoid compilers complainig about ambigious else blocks when putting
>>> > an if condition into a for_each macro one needs to invert the
>>> > condition and add a dummy else. We have a nice little convenience
>>> > macro for that in drm headers, let's move it out. Subsequent patches
>>> > will roll it out to other places.
>>> >
>>> > The issue the compilers complain about are nested if with an else
>>> > block and no {} to disambiguate which if the else belongs to. The C
>>> > standard is clear, but in practice people forget:
>>> >
>>> > if (foo)
>>> >    if (bar)
>>> >            /* something */
>>> >    else
>>> >            /* something else
>>>
>>> um, yeah, don't do that.  Kernel coding style is very much to do
>>>
>>>      if (foo) {
>>>              if (bar)
>>>                      /* something */
>>>              else
>>>                      /* something else
>>>      }
>>>
>>> And if not doing that generates a warning then, well, do that.
>>>
>>> > The same can happen in a for_each macro when it also contains an if
>>> > condition at the end, except the compiler message is now really
>>> > confusing since there's only 1 if:
>>> >
>>> > for_each_something()
>>> >    if (bar)
>>> >            /* something */
>>> >    else
>>> >            /* something else
>>> >
>>> > The for_each_if() macro, by inverting the condition and adding an
>>> > else, avoids the compiler warning.
>>>
>>> Ditto.
>>>
>>> > Motivated by a discussion with Andy and Yisheng, who want to add
>>> > another for_each_macro which would benefit from for_each_if() instead
>>> > of hand-rolling it.
>>>
>>> Ditto.
>>>
>>> > v2: Explain a bit better what this is good for, after the discussion
>>> > with Peter Z.
>>>
>>> Presumably the above was discussed in whatever-thread-that-was.
>>
>> So there's a bunch of open coded versions of this already in kernel
>> headers (at least the ones I've found). Not counting the big pile of
>> existing users in drm. They are all wrong and should be reverted to a
>> plain if? That why there's a bunch more patches in this series.
>>
>> And yes I made it clear in the discussion that if you sprinkle enough {}
>> there's no warning, should have probably captured this here.
>>
>> Aka a formal Nack-pls-keep-your-stuff-in-drm: would be appreciated so I
>> can stop bothering with this.
>
> I think is it problematic to have macros like
>
> #define for_each_foo(...) for (......) if (....)
>
> because
>    for_each_foo(...)
>       if (x) ....; else ......;
>
> is handled badly.
> So in that sense, your work seems like a good thing.
>
> However it isn't clear to me that you need a new macro.
> The above macro could simply be changed to
>
> #define for_each_foo(...) for (......) if (!....);else
>
> Clearly people don't always think to do this, but would adding a macro
> help people to think?
>
> If we were to have a macro, it isn't clear to me that for_each_if() is a
> good name.
> Every other macro I've seen that starts "for_each_" causes the body to
> loop.  This one doesn't.  If someone doesn't know what for_each_if()
> does and sees it in code, they are unlikely to jump to the right
> conclusion.
> I would suggest that "__if" would be a better choice.  I think most
> people would guess that means "like 'if', but a bit different", which is
> fairly accurate.
>
> I think the only sure way to avoid bad macros being written is to teach
> some static checker to warn about any macro with a dangling "if".
> Possibly checkpatch.pl could do that (but I'm not volunteering).
>
> I do agree that it would be good to do something, and if people find
> for_each_fi() to actually reduce the number of poorly written macros,
> then I don't object to it.

There's also the proposal of if_noelse() which I think fares a bit
better than the __if().

But I still have the situation that a bunch of maintainers acked this
and Andrew Morton defacto nacked it, which I guess means I'll keep the
macro in drm? The common way to go about this seems to be to just push
the patch series with the ack in some pull request to Linus and ignore
the people who raised questions, but not really my thing.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
