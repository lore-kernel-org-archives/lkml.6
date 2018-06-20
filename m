Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFBCC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025A520871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Z8BLed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025A520871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753774AbeFTKxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:53:04 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36840 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeFTKxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:53:01 -0400
Received: by mail-lf0-f66.google.com with SMTP id n24-v6so4270516lfh.3;
        Wed, 20 Jun 2018 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iHFKqD+2seTM8qahRh+YnV7oBW10QTI/dZZBgAsRcog=;
        b=X7Z8BLedVM1j1c1M5SAEbsFwO9zSfmpGbVrs6MnVmJl/+CNczWV/X7HRAhSLnZ7Yp0
         Bl6DEGrBTAMrWM1HQcSx8CbbppG3goKJ57nFO6NXFcvtMNXiWH8doQbxxBnESWlZpQHH
         F1sCSMu42zYiEcFXiOimeWI5h0l/YxQqM/0vQ1tCTW5+4zHGOlrc0NdW60glX4YNvIOE
         eaN6QIaTb2SB99MZVTaOxQBoD7YebptGeRI5VO54TLTsrlV6UGV2JAtTLhylClBxI7VO
         RLxr7pMRSRcJbM4PgfZTdwZ/u8SJkqWcQqyO9PpRi8vDRrgsA+PxaJsZgTwUH4i4Ey+r
         lz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iHFKqD+2seTM8qahRh+YnV7oBW10QTI/dZZBgAsRcog=;
        b=iN9SyxRrlBRtgNc2iL+X8jxHutuClLbpkEBtzfVUjLluZfz89gYlhyq45K07QKYtkY
         R7GcFD/A6q9FlnqyG4FBvDrJyPG0KXKwJu6CpLTz6NikAmYXVKFtqGksszG4hDinPXLo
         Q5OUJkjNOzFVZoT9I+tbyz3W0BEk7ZYpk7tHsGklq0WgKhSpVzMKOFVH7DB+/xG7fKku
         5oE0xsutuXNKNav0y8BNJ3IbOZ3uWvchWcd/oCQlpwntYZTaGHb0atKHxGQyw2K6jLrd
         dFXXGPcbJTZXonNu7zYCFcL1aph4GRZMvU9eGUufpX9zQeydJCFCht+l+H5LVud01nf7
         8ypA==
X-Gm-Message-State: APt69E27g6RYxcTjX7Ib6v7koNa4XiiiJYZhaO3wGwBtr5s1pud1a82T
        QK3qW4zmwkQKFtGElnlJ+gw=
X-Google-Smtp-Source: ADUXVKIU9NONbH/PhvqDPrK3ZG5g56RsqMUBhbH+8xIDoKrtbhzHB78MuufGTtItL8R9yLybRyndGw==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr13505155ljf.120.1529491980190;
        Wed, 20 Jun 2018 03:53:00 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id e21-v6sm347815ljj.95.2018.06.20.03.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 03:52:59 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fVaj1-0003hf-Mn; Wed, 20 Jun 2018 12:52:31 +0200
Date:   Wed, 20 Jun 2018 12:52:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.co.uk>
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for CP2102N
Message-ID: <20180620105231.GQ32411@localhost>
References: <20180620082507.GO32411@localhost>
 <20180617182503.23080-1-pados@pados.hu>
 <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding Martyn who implemented the cp2105 gpio support. ]

[ Karoly, please avoid top-posting and trim unneeded context instead of
  copying context to the top.
  
  Also set your mailer to wrap lines at 72 columns or so that I don't
  have to reflow your mail manually when responding. ]
  
On Wed, Jun 20, 2018 at 09:45:05AM +0000, Karoly Pados wrote:
> OK, though if you allow me a few comments and explanations:
> 
> > You're gonna need to unify a lot of this with the current
> > implementation for cp2105 however.
> >
> This also relates to your later points about unifying the cp2105 an
> cp2102n: The implementation for the cp2102n ended up pretty different.
> Both in initializaiton as well as normal operation, partially due to
> the better config/input/alt.function support for the cp2102n. At this
> point I though it is much more readable if I just create separate code
> hierarchies than having to pollute everything with ifs and
> switch-cases.
> 
> And maybe most importantly, I cannot test on the cp2105, so I cannot
> check if I've broken anything by mistake, and since it is the odd bird
> anyway among most devices, I though it is pretty logical not to touch
> its code but instead create a new skeleton for others.
>
> Of course you're the boss and whatever you say I will do, but I wanted
> to explain my reasons (or at least let you know my arguments).

If it really was all that different it may make sense, but judging from
vendor driver there are a lot of similarities (e.g. 2 byte mask + value
for set and 1 byte value for get, open-source or push-pull, alternate
function, ...).

As I already mentioned, parsing the configuration will need to be
different, but it seems like a lot of the implementation can be shared
(without much clutter).

> > I was going to comment on the odd coding style above, when I noticed
> > that you've copied this implementation from a silabs forum post. Not
> > good at all (as there was no indication of any license).
> > 
> Not quite. It is not from a forum post, but from a SiLabs Knowledge
> Base article
> (https://www.silabs.com/community/interface/knowledge-base.entry.html/2017/06/12/fletcher_checksumfo-TeDF)

Yeah, that's the one I was referring to.

> That article states explicitly that the code was taken from Wikipedia,
> so it is CC-SA, which is to the best of my knowledge 1) compatible
> with GPL, and 2) does not require attribution if the original material
> is missing it, and it does. So AFAICT we are clear on the licensing
> front.

First of all I can't seem to find that code snippet on the wiki page it
does refer to, so I'm still not convinced.

Second, this should have been high-lighted in your submission somehow.

> Do you still want me to remove the checksum check?

Yes.

> > So for cp2105 we decided against implementing an input mode. We at least
> > need to be consistent here, so I suggest starting with dropping those
> >
> Again, you're the boss, but I do find this odd. These are different
> devices and thankfully now there'd be better support for the cp2102n,
> and you're asking me to remove input support for consistency reasons.
> To remove a feature for one device just because it wasn't correctly
> implemented in another and wanting to stay consistent with the missing
> support is very odd for me tbh.
> I know I'm in no position, but please let me ask you once to please
> reconsider this.

We're not removing anything from the kernel since nothing has yet been
merged. I'm asking you to separate it into a follow up patch, which if
we find it useful and correct would allow the same functionality for
cp2105 as well.

The gpio pins on cp2102n and cp2105 share the same electrical
characteristics and there's no good reason why we should treat them
differently.

> The way it was done for the cp2105 where we make everything and
> everyone on the system think that a pin is "out" but in reality is an
> input is quirky to say the least, while at the same time it also does
> not make sure that an input pin (which is of course not marked as
> such) is really an input.  Why amputate the cp2102n like this if it
> has been already implemented correctly?  If we wanted to stay
> consistent with half-developed and incomplete drivers then there'd be
> no improvements to Linux.

We do not want to have two competing and incompatible implementations of
essentially the same thing.

> > Please be more specific here; what do you mean by not corresponding to
> > reality.
> >
> It means that I've found GPIO4-6 occupying bits which were documented
> doing completely other things, and those other things occupying
> reserved bits even though they were documented occupying the places
> where GPIOs 4-6 were.

Ok, but try to explain your findings regarding this in the commit
message and/or a comment instead of the current formulation. You can be
more specific in the comment, without getting into every detail too
("not corresponding to reality" is too vague).

But to clarify, this has to do with the configuration of the pins,
right? You'd still use the same mechanisms to set and retrieve the latch
register?

> > No need to check for this in every callback; move to
> > cp210x_gpio_request().
> >
> Wouldn't this prevent the disabled GPIOs from being created in the
> first place?  I very much want to create them in every case, because
> otherwise it becomes a PITA for both the driver and consumers:
>
> - For the driver a PITA, because the disabled GPIOs can be any and
>   non-continuous, so the module would need to dynamically and
>   arbitrarily remap logical GPIOs to hardware GPIO numbers.
>
> - For consumers a PITA, because it would mean GPIOs can change names
>   depending on the current configuration of the device. On one device
>   GPIO.3 would be called GPIO.2, on another GPIO.1 etc. My intention
>   here is that applications should be able to use the real ID of the
>   GPIO and expect that GPIO.3 (base+offset 3) is actually GPIO.3 and
>   not something else.

No, that shouldn't be problem (unless something has changed in gpiolib
recently). All pins would be registered, but we simply deny requests for
unavailable pins.

Thanks,
Johan
