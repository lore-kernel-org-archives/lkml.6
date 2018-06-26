Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AB226BC2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTIikVTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AB226BC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965736AbeFZN4F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:56:05 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40013 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965685AbeFZN4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:56:00 -0400
Received: by mail-oi0-f65.google.com with SMTP id f79-v6so16069787oib.7;
        Tue, 26 Jun 2018 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=u2xbGF/xfz+R2O49dK4C66j8pwvaXaAVtUenJprPdGg=;
        b=aTIikVTLda1E8hAevU2D2hQ3JA4UFYBS/ZkF4XbzZ2Bh9CgfeGlcD68QfVF9wK6N/5
         c8sI/ca34HJF0sb20KephQjqOT5VMVnq4T9VD7A0RqZUlMkwxvstd+YJBq/qWKrI8sD/
         7BCrkwfem3jHd8yw/DAZctaP/mLvqXjgD2tCgGsWGpYK/W28Q5Xd8R17L1zdtliAZlJW
         ZjqjJ2fuptxX7SnG1i7vDmAaQ7tY1XqAeMsp2XuDG3/chEDQN4ZIeYP5FkHEw6iXIHG5
         7bWTAdM0XUXKvZQ+2oxKyegU8ihwTlK5UmGiIxjKWz8mFM9jbUGXgyfD9Zwr73OT3F0r
         LgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=u2xbGF/xfz+R2O49dK4C66j8pwvaXaAVtUenJprPdGg=;
        b=T8w/L3enMEPTcjcoKchwB/RheLlUzOgfVvZ+1XOkClptwLnRYNfHSrgPR1+3Tlib2S
         /R8xV8J0VXUV0ec1u3NE4ctBno5XsaCa17KbylIIgzo5J2Kala0FKdVCVvmomaCPEloo
         oOfCeZVJjvweK7FVDiSYpkVgPMGIOSzG+HejWbMwuDO3gBYCVN39ZU4I+21dhCWr9R6Y
         EVJpCoh0h/+ZE3V8gY4eUoA5dy8dXN71dN/F8PF3rqQu0ln/2Lfj5t/v4hgVeXIQKXYI
         Q8KcNB2ui1qnEHtyNODbDXEAjDE2hi4y/b7ajOx9/kL6TMzARqXc4ULudXlIzeZanWOR
         lOmA==
X-Gm-Message-State: APt69E1RhHf1wNok6iOIE6ZWXzOIi/6c8cFlA2is4uwZWM7K7knH/uWK
        8a/pHyMZnu86OY+Fi5XMSq2IQrTkrdR9yNYA7KE=
X-Google-Smtp-Source: AAOMgpf/dRr+0r97KFqvI3P9SPiPseX+CuJxOleGmU1LRlpWWUlYRCpgebqDskHKqXAfvmaovMX+WC9aq4K/w8L5h1s=
X-Received: by 2002:aca:ec0c:: with SMTP id k12-v6mr954411oih.227.1530021359446;
 Tue, 26 Jun 2018 06:55:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 06:55:58
 -0700 (PDT)
In-Reply-To: <CAMuHMdUYtao4fgQUwBArZG1y+yfbwHE0SHuM6v2NGnhY7GSjkA@mail.gmail.com>
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <20180620132507.GE6242@sirena.org.uk> <CAMuHMdXYL+=mBOofUqQ06Ld4zUF7BWqt+S2dFTw6AEAPuDsZPQ@mail.gmail.com>
 <1705903.rOAenNWc8f@aspire.rjw.lan> <CAMuHMdUYtao4fgQUwBArZG1y+yfbwHE0SHuM6v2NGnhY7GSjkA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jun 2018 15:55:58 +0200
X-Google-Sender-Auth: HNQWrn9QMStbyIhNBGrr8Td5-kc
Message-ID: <CAJZ5v0gAnDKe=S916ZB4489H3Sx26gkBVPqpKD45jY2f4G4wng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Jun 26, 2018 at 12:29 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Rafael,
>
> On Tue, Jun 26, 2018 at 12:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, June 26, 2018 12:06:16 PM CEST Geert Uytterhoeven wrote:
>> > On Wed, Jun 20, 2018 at 3:25 PM Mark Brown <broonie@kernel.org> wrote:
>> > > On Wed, Jun 20, 2018 at 02:15:38PM +0200, Rafael J. Wysocki wrote:
>> > > > On Wed, Jun 20, 2018 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:
>> > >
>> > > > > The flip side of that is that either suspend and resume or poweroff are
>> > > > > broken for userspace unless they know about this magic sysfs file which
>> > > > > isn't great either.
>> > >
>> > > > But to me that isn't that much different from an RTC wake alarm, say.
>> > >
>> > > > Enabling it to wake up the system in general isn't sufficient, you
>> > > > also need to actually set the alarm using a different interface.
>> >
>> > The RTC wake alarm time is indeed different, as it is not a simple boolean flag.
>> > It is also more natural for the user, who expects to need to find some way to
>> > configure the wake-up time.
>>
>> OK, take Ethernet.  You need to configure WoL on that to wake up the system
>> in addition to setting power/wakeup for it.
>>
>> Take WiFi: You need to set up WoW on that.
>>
>> And so on.
>
> I always found it strange that you have both "ethtool wol" and and a
> "wakeup" file
> in sysfs (does "ethtool wol" predate the wakeup file in sysfs?)

Yes, it does.

> I believe originally WoL supported MagicPacket only (many systems still
> support only that), so originally it was boolean.

I don't recall the details here.  When looked at it first time
multiple options had been there already.

>> > > It seems more like hardware breakage we're trying to fix than a feature
>> > > - it's not like it's adding something we didn't have already (like
>> > > setting a time in an alarm where the alarm is an additional thing), more
>> > > just trying to execute on an existing user interface successfully.  I
>> > > can see that there's a case that it doesn't map very well onto the
>> > > standard interfaces so perhaps we have to add something on the side as
>> > > the hardware is just too horrible to fit in with the standard interfaces
>> > > and we have to do that.
>> >
>> > My main worry is usability: with a separate sysfs file, we need to document the
>> > file, and the user needs to be aware of it.
>>
>> That's right, but it will be very hard to convince me that changing the
>> meaning of the "wakeup" attribute just in order to work around this issue
>> (which arguably is a consequence of "unfortunate" hardware design) is a
>> good idea. :-)
>
> OK.
>
> Next question: where to document device-specific sysfs files for regulators?

Under Documentation/ABI/ I suppose.
