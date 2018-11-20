Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEDEC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42377206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hANNkRZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42377206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeKUAyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:54:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45069 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKUAyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:54:33 -0500
Received: by mail-io1-f65.google.com with SMTP id w7so1459466iom.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GgP7NTEdA3hdcGhYH7s3Ow22+K154MYSIIOWWzZDGsc=;
        b=hANNkRZPCw9bA3VzMidiMrUMA4ubGu1qwtEctPNUXLCqNVSqNiTMJklGAOYwkErgOo
         jFyh82gXYsGwR9LXj7xZ1xJz3f1dye0aC6maHAwwNYNzhLSfVXFPoSRLksUhVV6Y7o7A
         fXqPuGPdK+qXOxDpWW7Y6AxsCdXIIhlZCcZpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GgP7NTEdA3hdcGhYH7s3Ow22+K154MYSIIOWWzZDGsc=;
        b=CsRb1qBeRLt43RP3lNG3tDZNotlbOHlEcwp3fKm/iKXOsIOGpbxGActvD3bRZZKKJZ
         9UTqKc1yhc3BB2jktU7d9Wo905L3HqxCpT9jma76SVuk3Yp7TqcV11eXLJmLS4O6J1vV
         Si2/B4YbmXMly1epLDTvgtpq9EiKXPK/yZrK2/nDM9Wepf1o4gQqtfAN3hSkdypz8qsj
         BqG1I+eHajXi1vj0siI58hdd8MpraLvJqTh4y2IVfabEKqzNLSWhnJUZCCDUMcuXJu1C
         qZ5XDVW75qpxnfBcDOb6K6zdRxmhqbcDexsU72Et7WDW76/DofH7whQTqlHS8mqJoO84
         N88Q==
X-Gm-Message-State: AA+aEWahkgGRE0p1TZ9vdXhAGFm58LHXD28+wAfjFRccwZf4qSeq1zui
        ZtCBM98P+n6MxmpriIAriKRc0lFtg9KAoZbj0KYsCg==
X-Google-Smtp-Source: AFSGD/VHaGqyPb9CcyBHrUWTgpAqwKpj+cI26moH6SDllpmHd/aVZ51Mn00fz/xs2b3/BpR8B8Wo99fbkWL8xZJdwoQ=
X-Received: by 2002:a6b:2c92:: with SMTP id s140mr1650571ios.218.1542723908428;
 Tue, 20 Nov 2018 06:25:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 06:24:27
 -0800 (PST)
In-Reply-To: <515b72f2bd526d144fdc662126aa6e1e8484a25c.camel@collabora.co.uk>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com> <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai> <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
 <20181120102300.GA1056@kunai> <aa26f5dc9e595feb3772495a6d0542c007948f48.camel@collabora.co.uk>
 <CAPDyKFrFz9bHa5EmiBmQvXnoRibbL4-Gq9E7E5vDBbd=uj_2kA@mail.gmail.com> <515b72f2bd526d144fdc662126aa6e1e8484a25c.camel@collabora.co.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Nov 2018 15:24:27 +0100
Message-ID: <CAPDyKFoCyXSQ9bVD9iYYcr4Y7e87Ltdt2+QNg0euvNijRGi83Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
To:     Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Faiz Abbas <faiz_abbas@ti.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Bastian Stender <bst@pengutronix.de>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Hal Emmerich <hal@halemmerich.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 November 2018 at 15:00, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> On Tue, 2018-11-20 at 14:08 +0100, Ulf Hansson wrote:
>> + Hal Emmerich
>>
>> On 20 November 2018 at 12:38, Sjoerd Simons
>> <sjoerd.simons@collabora.co.uk> wrote:
>> > On Tue, 2018-11-20 at 11:23 +0100, Wolfram Sang wrote:
>> > > > > >
>> > So if you know the pattern, or just happen to hit it often in e.g.
>> > automated testing, it does show up during development. Otherwise it
>> > can
>> > appear to "happen once in a while randomly".
>>
>> I don't quite follow. As far as I understand, the extended timeout is
>> needed when turning the cache on.
>>
>> The above seems more related to flushing the cache, no? Flushing have
>> no timeout (also reported to be an issue [1]), which happens either
>> at
>> _mmc_hw_reset() or at _mmc_suspend().
>>
>> What is the relation here?
>
> Yes it's the kinda of behaviour you would expect on a flush indeed! I
> don't know what the card actaully does when turning the cache on,
> whether it's actually flush of something persistent when turning the
> cache on after a hard poweroff or doing some other validation.
>
> All i can share is what our testing seems to indicate, which is that
> there is a wide spread in the time the card needs *and* there seems to
> be strong correlation to the I/O activity before the hard power off and
> the time taken by "cache on".

So the hard power off, means that you are cutting the power to the
platform and not doing a graceful power off? Just so I understand
correctly.

>
>> > Unfortunately for me, it was really a case of getting reports of
>> > some
>> > boards started failing at some point which took a while to track
>> > back.
>> > Especially since it's a battery powered device (thus hard poweroffs
>> > are
>> > rather rare) and we allow the board manufactorer to select from
>> > various
>> > different eMMCs depending on price/available at build time...
>> >
>> > > Yet, if we add a quirk for that, then we should probably mention
>> > > it
>> > > in
>> > > an error message when we hit -ETIMEDOUT for cache on ("does your
>> > > card
>> > > need this quirk?")? It can be pretty time consuming to track this
>> > > down
>> > > otherwise, I'd think.
>> >
>> > Yes please. It would be nice if someone happens to have the right
>> > contacts with Micron to see if it's a known issue for their cards
>> > in
>> > general or just this one.
>> >
>> > Also would be good to have a timeout higher then 1 seconds (or for
>> > these cards not have one?); On our testing thusfar we've seen
>> > timeouts
>> > up to 850ms, but it's impossible to ensure that that's the true
>> > upper
>> > bound.
>>
>> Using no limit of the timeout, would mean we may hang for ~10 minutes
>> (MMC_OPS_TIMEOUT_MS) instead, no thanks.
>
> Probably a silly question, but would this actually cause e.g. boot to
> hang while waiting for the card (assuming rootfs is somewhere else)?

Nope.

[...]

Kind regards
Uffe
