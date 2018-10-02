Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E738C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF212089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UtDN0XPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF212089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJCFCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:02:39 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46191 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeJCFCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:02:39 -0400
Received: by mail-vs1-f68.google.com with SMTP id i10so2044749vsm.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5G7tjN40CDlRozQ9gYIZOP0q/emfF0IIDP/O9EbimgE=;
        b=UtDN0XPrpgTEkSefdUBRMfwqQdCIZrfOAWcbBQzhvR3Kn22ebI6erUzPheBHCIPhYI
         4fM7y0BAuhaDwNFXpInLFre6TWRTe3J21N5xfASoGDtzzLxzRP9Rajs2A/KHwNjKBBZa
         7KxVbdxfhmuMWAC2JzFVa9n48pFXH1LjXFuDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5G7tjN40CDlRozQ9gYIZOP0q/emfF0IIDP/O9EbimgE=;
        b=O1RtuVFG1lB8dVxS+isiAwExENrnjJ4XSbHUq4D3O2yqJWgciCMVfd4NlMTpmZFnjk
         Y33Z8cDm23jWyPwAf/wB3l+UIlyqbxbMHq5D4cQy0bNwMWbVNX0jOn4V/k0CHpbtRQrG
         B8jEBfwbE4clARolMQ5tEjtVYETRb3SnDgLd1rGBg/P+e4hf/lF/0ZyVZps3JIkZS1y3
         fcsC4kY3gomOuatOEq54HkhEa6bkjqS019khlVoSo4sLPtsYEY0R4xcKthU8mGKFaFjN
         qw2tOyU+IZPXPFXm/oGhWK2e+otXj8c7mj6OeMoQQ3VUsRZn8upbHCSxTJsuAijiQ7/q
         CLVQ==
X-Gm-Message-State: ABuFfojTjo2Myu6EzMYimkKbQVsbae5QlpV9zNxhU7PCFbksTdZMhXUc
        kX7QlEwZed6IB4+mbQgpYcmsEyNwEaE=
X-Google-Smtp-Source: ACcGV63AtuXLum+/W5MBcyoApr5W0L2qa6Py9qkxf3TapKPi09k5u9TO6URRdnPtpUsOFJG0ns4DuQ==
X-Received: by 2002:a67:4e90:: with SMTP id j16mr1390353vsg.216.1538518624871;
        Tue, 02 Oct 2018 15:17:04 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id q11-v6sm1803576vsk.13.2018.10.02.15.17.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 15:17:04 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id s197-v6so822461vkf.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:17:03 -0700 (PDT)
X-Received: by 2002:a1f:101f:: with SMTP id g31-v6mr6681052vki.90.1538518623509;
 Tue, 02 Oct 2018 15:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180927203523.60856-1-dianders@chromium.org> <20181002080554.GC19677@amd>
 <CAJZ5v0g13wJrUpshFoQx-FXHMs=MkQ1dStNSESiqXC3zduqJcA@mail.gmail.com>
 <CAD=FV=Xi=BmWtzHAmXe0nNU4rBaQzHZDQhqOgbdKi4+dDCrJ8g@mail.gmail.com> <CAJZ5v0hSohUZvJcVcQzy_DdSyPVppOABk0HELsa3dpvf12LMPQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hSohUZvJcVcQzy_DdSyPVppOABk0HELsa3dpvf12LMPQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Oct 2018 15:16:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XU45z=kvO48Cwhi2NxuOBermbnEdxov5kZtt-VdMB4GA@mail.gmail.com>
Message-ID: <CAD=FV=XU45z=kvO48Cwhi2NxuOBermbnEdxov5kZtt-VdMB4GA@mail.gmail.com>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns
 an error
To:     rafael@kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dilip Kota <dkota@codeaurora.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 2, 2018 at 2:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 2, 2018 at 11:01 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Oct 2, 2018 at 1:29 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> [cut]
>
> > > I guess so.
> > >
> > > Doing that in all cases is kind of risky IMO, because we haven't taken
> > > the return values of the ->resume* callbacks into account so far
> > > (except for printing the information that is), so there may be
> > > non-lethal cases when that happens and the $subject patch would make
> > > them not work any more.
> >
> > I think you're arguing that the best option is to leave the code / API
> > exactly as-is because someone could be relying on the existing
> > behavior?  That is certainly the least likely to introduce any new
> > bugs.  ;-P
> >
> > ...would you accept a patch adding a comment codifying the existing
> > behavior (AKA suspend will be called again even if resume failed) as
> > the officially documented behavior?
>
> It is documented already IIRC, but yes.

Ah ha!  I'm guessing this is the documentation you're talking about in pm.h?

 * All of the above callbacks, except for @complete(), return error codes.
 * However, the error codes returned by @resume(), @thaw(), @restore(),
 * @resume_noirq(), @thaw_noirq(), and @restore_noirq(), do not cause the PM
 * core to abort the resume transition during which they are returned.  The
 * error codes returned in those cases are only printed to the system logs for
 * debugging purposes.  Still, it is recommended that drivers only return error
 * codes from their resume methods in case of an unrecoverable failure (i.e.
 * when the device being handled refuses to resume and becomes unusable) to
 * allow the PM core to be modified in the future, so that it can avoid
 * attempting to handle devices that failed to resume and their children.

To me the above reads as "the behavior of the kernel right now isn't
quite right, but we'll fix it in the future".  It also don't
explicitly state that the next "suspend" will still be called.  That's
implicit in the "all we do is print a message" but the "we'll fix it
in the future" makes me feel like that might change.

...if there's some other documentation you're thinking of then I'm
happy to keep looking.


> > ...or if the official word is that if your resume fails you're totally
> > unrecoverable then I can start simplifying the error handling in
> > resume.  AKA instead of:
> >
> >   hypothetical_resume(...) {
> >     ret = clk_enable(...);
> >     if (ret)
> >       return ret;
> >     ret = regulator_enable(...);
> >     if (ret)
> >       clk_disable(...);
> >     return ret;
> >
> > ...I can just change it to:
> >
> >   hypothetical_resume(...) {
> >     ret = clk_enable(...);
> >     if (ret)
> >       return ret;
> >     return regulator_enable(...);
> >
> > ...the above would leave no way to recover the system because if
> > hypothetical_resume() returned an error we'd have no idea if the clock
> > was left enabled or not.  ...but if we're unrecoverable anyway why not
> > save the code?
>
> This really depends on the particular case.
>
> If you deal with clocks directly, then you pretty much know whether or
> not things are recoverable after a failing device resume, but if AML
> tells you that it failed (say), you don't really know what happened.
> In many cases the device that failed to resume will not work correctly
> in the working state, but attempting to suspend it again may be fine.
> It may recover after the next suspend-resume cycle even sometimes.  So
> IMO drivers can do "smart" things if they really want to and know
> enough, but there really is too much variation to handle it in the
> core in a uniform way.

Got it.  Right that every driver will be different and we can't
possibly magically "fix the world" and universally recover from all
errors.  ...and putting too much smarts in the drivers doesn't make a
lot of sense since really we're in a mostly unrecoverable place
anyway.

In any case, if I don't hear anything else I'll assume that the
officially documented suggestion is to assume that suspend() will
still be called after a failed resume() (AKA today's behavior) and I
should code drivers to that standard until I hear otherwise.

Thanks for your time.

-Doug
