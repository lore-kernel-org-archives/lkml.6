Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7D6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDA12238D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SOkAVRVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDA12238D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeHIWEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:04:14 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40093 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeHIWEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:04:13 -0400
Received: by mail-yw1-f67.google.com with SMTP id z143-v6so6166167ywa.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q/G66rTI3ibq9RNzQInnB3gQg9nv61I5r+XmWb/2OPY=;
        b=SOkAVRVKKq53roeye3WQFiSZud2rzT/Yi+OZ4MYmCN1D7fYLaX7uzjek819ZeKWNe9
         B9MOMaPn4R+iVwGpMo8CeFtPdOl2fWREihwptlmGm9/9gWM76Zdopmg7VCfD7vRQOgM7
         w0eexRmQzx744HJLrXGrgYDsWn7jwkYIac/8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q/G66rTI3ibq9RNzQInnB3gQg9nv61I5r+XmWb/2OPY=;
        b=fk5ZSGzCbePN6ZjLH2C2ze9MXuh4bS/96fnnVi25vDcHr35AwFcBaTS2U2DsssEFoy
         RfxM9kZlEY5T6p3b3G+iO7Ka6nXdTyl7FG9L1AZbprHmPQeFrVBugFvpyI2iIkfJ+kLy
         S95xOKDSjPsIgFSdlJoydhDdOxqTAuiaFURJZM9BoDv11gp+1IfR7p8bwObwVnPQm1UR
         aNzOWyvhWO7c49wCmHd6+GN6xy+CkgiDQdGA6IgL1s9xL8WWPYoBADS+dpV/iKfUJwfk
         n0tMSdq2apOIRmlg2D4Lm1mitktoue6coXVGI2WyKQ2isDbwV4fNpConcPHKKFjxkyB7
         BYUg==
X-Gm-Message-State: AOUpUlH/v1PcILzUKW/SbGPQlhGdiOdohp6sp5tUDtBJEwV8O07yokNw
        qW3mOIjH1bAYQ71x+BLJjb/k2zYPAHc=
X-Google-Smtp-Source: AA+uWPy8eAXbAelHLjZnsCjuueNi+Yvem4xxa/Lv7KDSh49drZGWAob/ySR4rlGkOPpsEdYhzEdj5g==
X-Received: by 2002:a9f:2266:: with SMTP id 93-v6mr2376336uad.40.1533843475469;
        Thu, 09 Aug 2018 12:37:55 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id u25-v6sm1071825uan.26.2018.08.09.12.37.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:37:54 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id h1-v6so34553uao.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:37:54 -0700 (PDT)
X-Received: by 2002:ab0:11dd:: with SMTP id q29-v6mr2351191uac.191.1533843473898;
 Thu, 09 Aug 2018 12:37:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 12:37:52 -0700 (PDT)
In-Reply-To: <1533839042.2283.305.camel@impinj.com>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org> <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org> <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <1533839042.2283.305.camel@impinj.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Aug 2018 12:37:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4miw3i+8EPZPpgWGaVJhHbb2OBVTz6_iP-pMVhZoBOQ@mail.gmail.com>
Message-ID: <CAD=FV=V4miw3i+8EPZPpgWGaVJhHbb2OBVTz6_iP-pMVhZoBOQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "dkota@codeaurora.org" <dkota@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "kramasub@codeaurora.org" <kramasub@codeaurora.org>,
        "girishm@codeaurora.org" <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 9, 2018 at 11:24 AM, Trent Piepho <tpiepho@impinj.com> wrote:
> On Thu, 2018-08-09 at 11:03 -0700, Doug Anderson wrote:
>> On Fri, Aug 3, 2018 at 5:18 AM,  <dkota@codeaurora.org> wrote:
>> > > > +       if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
>> > > > +                               &spi->max_speed_hz)) {
>> >
>> >
>> > > Why does this need to come from DT?
>> >
>> >
>> > This is required to set the SPI controller max frequency.
>> > As it is specific to the controller, so looks meaningful to specify it in
>> > dtsi.
>> > Also, spi core framework will set the transfer speed to controller max
>> > frequency
>> > if transfer frequency is greater than controller max frequency.
>> > Please mention if you have a other opinion.
>>
>> Here are my thoughts:
>>
>> 1. It sure seems like the clock framework could be enforcing the max
>> speed here.  SPI can just ask for the speed and the clock framework
>> will pick the highest speed it can if you ask for one too high.  Isn't
>> that the whole point of the "struct freq_tbl" in the clock driver?
>>
>>
>> 2. The device tree writer already provides a max clock speed for each
>> SPI slave in the device tree.  ...shouldn't the device tree writer
>> already be taking into account the max of the SPI port when setting
>> this value?
>
> No, the way it works is the actual speed is the lesser of the master's
> max and the slave device's max.
>
> But usually the master's max is determined by:
>
> 1. The input clock the SPI master device, as provided by the clock
> framework.  Usually the max SPI clock will be this clock /2 or
> something like that.
>
> 2. The master has some maximum clock as part of its specifications, in
> which case the driver basically hard codes it.  Maybe it is different
> based on model and the driver has a table.
>
> The device tree isn't really meant to be a way to remove all data from
> the device driver just because it can be, or shift work from the driver
> author to the device tree author.
>
> So, one shouldn't specify the master max in the DT if the driver could
> figure it out.
>
> Sometimes you see a field in the DT and I think the thought process
> that put it there was, "I don't understand how to set this register,
> I'll just stick in the device tree and then it's Someone Else's Problem
> to find the correct value."
>
> The max speed that some board can talk to a SPI slave might be from the
> specs of the slave device or maybe it's due to the traces on the board
> itself that is the limiting factor.  In the latter case the convention
> is to consider this part of the slave's max speed and put into the DT
> in the slave's DT node max speed property.
>
> So the same spi eeprom chip might have have a max in the DT of 20 MHz
> on one board, copied out of the eeprom's datasheet.  But on another
> board it has a max of 10 MHz because on that board's layout it only
> works up to 10.

I think we're in agreement but perhaps there's a miscommunication here?

I'm saying that we _shouldn't_ put the max-speed of the master in the
device tree.  The max speed for the IP block ought to be in code
either in the clock driver or in the SPI driver based on the
compatible string.

...as one argument _against_ putting a max-speed for the master in the
device tree I'm saying that we can already specify a max-speed of each
slave in the device tree.  The max speed of the slave should take into
account whatever factors are specific to this board including trace
lengths, noise, etc.  If we somehow did need to get a max speed in the
device tree it seems like we could just adjust the max speed for the
slave to be something lower.  In other words if you know a board has
an sdm845 on it and you know that the SPI clock on sdm845 can't go
over 50 MHz then it would make no sense to suggest that we should run
the SPI clock for a device at 100 MHz.


-Doug
