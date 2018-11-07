Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2504C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9008A20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RX4sUZGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9008A20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeKHGuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:50:44 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43684 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeKHGuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:50:44 -0500
Received: by mail-vk1-f196.google.com with SMTP id o130so1578152vke.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 13:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ihhgHrKEE1pacViDFlSsQzwqvPqE2E1R1WjQ3EseAE=;
        b=RX4sUZGfUL61yuG7JSexiOiBeR1R305fZSarM2oMqdfoyJzcFa3hZXPdiywZxhDeoC
         qDKMD5lhaddRKPtE+o9uCrU+PwZIsch/256TpC0aE+cyWerJl7pkPDBNCBYHqrXNsyAP
         +Cr+ckNPcEHFlgTF6virgzEbMAO8NwID9Tqeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ihhgHrKEE1pacViDFlSsQzwqvPqE2E1R1WjQ3EseAE=;
        b=sM/fdCL/3IlyVWQbkwv2lyjDj08tfXpCs3SQV+j7zdNVakzrM79SntFGQUs7KXOw2Z
         5QBLc8TrfZivO0ph7GakWo9qguvMosDPRHd6XaWkZdSTAAvsLLV8mEdqJxdSPfyFjFKA
         LYGWW8qeYYdJ2Nu5dSRXce1AlklfQ6+6a2ST+FDVEGtiw3RW3a62PCe+Ba1pId8TpmwQ
         PwyUBQ6VS/QhIan27yEWg1RQxYhc1wyT+t/QeEuOQuVYn1F7hTRlF0B1bN1mys+R24Re
         BSDIkqMfq3/kHNRropIEzDx7UrGW7HgL+1li/ZCZj35I9DLLBLQiNarQa88cEl7gIdoL
         Ifrw==
X-Gm-Message-State: AGRZ1gLzyrNJ06aireXJwLiiQUAb40VuIQ1RLFDBObmA1b5/9TRyrrHB
        SpGIET7/AkCTnbAY+yzuJ/Rn9GivRgY=
X-Google-Smtp-Source: AJdET5cppQUpnLITafuAL8/IaKSxP2VZLdwAtrBMQ3KdoyM+QRmioKuQNr74UYD3ti+y7yN4uBDIhQ==
X-Received: by 2002:a1f:e3c7:: with SMTP id a190mr847244vkh.66.1541625512039;
        Wed, 07 Nov 2018 13:18:32 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id x132sm483693vsc.34.2018.11.07.13.18.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 13:18:31 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id d21so6409507uap.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 13:18:31 -0800 (PST)
X-Received: by 2002:ab0:650e:: with SMTP id w14mr915588uam.83.1541625510833;
 Wed, 07 Nov 2018 13:18:30 -0800 (PST)
MIME-Version: 1.0
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
 <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com>
 <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org> <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
 <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
 <20181107205514.GB12273@roeck-us.net> <20181107.210731.330601031@genki.is>
In-Reply-To: <20181107.210731.330601031@genki.is>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Nov 2018 13:18:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
Message-ID: <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     sky@genki.is
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>, lists@nerdbynature.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 7, 2018 at 1:07 PM Genki Sky <sky@genki.is> wrote:
>
> On Wed, 7 Nov 2018 12:55:14 -0800, Guenter Roeck <linux@roeck-us.net> wrote:
> > I do not think it is a good idea to create a random file in the .git directory
> > under any circumstance, and much less so if an output directory was specified,
> > no matter if the path is read-only or not. I also still think that it is a
> > bad idea to touch the source tree if an output directory was specified.
> > It defeats the purpose of specifying an output directory.
>
> I was thinking of touching a pre-existing file like .git/config or
> .git/description, which I was hoping would be harmless. But sounds
> like that's still not desired?
>
> Okay, I guess one approach is to only refresh the index if $objtree ==
> $srctree, by passing some flag to scripts/setlocalversion from
> scripts/package/Makefile. Is that what you're thinking? Feels a little
> strange, but it seems it'd satisfy everyone.

From reading the thread it sounds like Guenter was not even super
happy with that based on the principal that you wouldn't expect a
kernel build to be doing write operations in your .git directory even
if $objtree == $srctree


> > Ubuntu 16.04 ships with git version 2.7.4.
>
> Okay. I guess --no-optional-locks is a no-go then.

In theory you could wrap it.  If passing git with
"--no-optional-locks" doesn't work you could fall back to the old
code?  That would mean only people with newer git would get your new
feature and everyone else would stick with the pre-existing behavior.

It does seem like any things like this should be done atop Guenter's
revert.  AKA: revert first to get things working the way that they
were and then start talking about how to make it better.

-Doug
