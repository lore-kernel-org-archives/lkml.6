Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4F7C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A23D2054F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dGVOPsCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A23D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeJ2FIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:08:00 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38563 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeJ2FH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:07:59 -0400
Received: by mail-lf1-f49.google.com with SMTP id p86so2280613lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIheKlWRNlITSZ4UhIshoTLdblTc7otvxDweRLUerok=;
        b=dGVOPsCItAntfgKaScfINfIrF8CMcXsbINqXjlb7hE9gfd9rL4sJbXZjxS9jH5Pdja
         4Gqt/Dl1K9+yiusJKQPE7XAqbx9dBA+6yjS5D5vkcR9R4wE/E3x9j8aT/XvsRRm2kC1T
         rXzIITN0WZNU8IrOMNq9u4H9VZ19PfBPPLWTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIheKlWRNlITSZ4UhIshoTLdblTc7otvxDweRLUerok=;
        b=iXR3OPzbuFnfxV//Gnaso93RH/Fh0sSObESpjNEXAgR2vPRXbOhXbsELW5/6nkw7cd
         fEW4PGlK8v15Ats/eQgm22oLlWItmHIZBUK2CRO6uf1dQiTHbZ14R8cJtQL9Q33OA0sP
         nfJzWyUrkYiiZrw8n1M3Im0uzTMIfwM8PobRV7dAdTD9QkXnQ/i14kliGAK3+bNrov2U
         WecrNnrcS/g+LH/WvUYfC4k5Wlkof5wm2xAIi+fxzPPqpcMfmvLpPB+jxaTrJAoH8I+t
         vhfVPVqjvEvdj4//8ux6LX3BvOWmlMZmI2GhB3pGWMGa2Ic8krpUkCVm0C+QLjhbu3+5
         7M7w==
X-Gm-Message-State: AGRZ1gKGXL1DiwWPhsI6TdMRVjkEr8bf05uRVqBejEsTfi4IyRBUHaFz
        H/DDNvcbzWihz4+oqwv2oybjiiRf8Iw=
X-Google-Smtp-Source: AJdET5cCuiaNmTCc/oPNkzV+M/vXR45+94DoAof0n0hSyNOAnCPlspFj3/5a929YavSO+GeNMgATMQ==
X-Received: by 2002:a19:2c92:: with SMTP id s140mr1479071lfs.42.1540758134557;
        Sun, 28 Oct 2018 13:22:14 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id o88sm79792lfk.38.2018.10.28.13.22.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 13:22:13 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id g8-v6so2894156ljk.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:22:13 -0700 (PDT)
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr7294052ljd.148.1540758133192;
 Sun, 28 Oct 2018 13:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
 <20181028111625.mr2hxbcqh5k4rskz@angband.pl>
In-Reply-To: <20181028111625.mr2hxbcqh5k4rskz@angband.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 13:21:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whh44s8DyL04n2X_z2t_YJ7Cu2biYah-tDNKRorKJ_srg@mail.gmail.com>
Message-ID: <CAHk-=whh44s8DyL04n2X_z2t_YJ7Cu2biYah-tDNKRorKJ_srg@mail.gmail.com>
Subject: Re: drivers by default (was Re: Another HID problem this merge window..)
To:     kilobyte@angband.pl
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 4:16 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> Amen to that.  But, perhaps you could encourage people to do enable drivers
> once they become very popular?  For example, I just (72a9c673636) got hit by
> USB 3.0 being off in defconfigs, and not having keyboard is not that cool.

Yes, that seems reasonable.

I don't think we need much of an explicit "policy" for these things,
though. Things that get _so_ ubiquitous that they should be marked
default globally (as opposed to just being in a defconfig file for
some board) are pretty rare, and them being "new" things are rarer
still.

Yeah, usb3 sounds like it would count, but I think that's such a rare
exception that I don't think we need to make a policy for it, just a
"hey, once or twice in a decade we have a new bus that became so
common that we should update the 'default' to y".

               Linus
