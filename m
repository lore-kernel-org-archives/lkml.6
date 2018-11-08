Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8FAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B5B20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PE8qDiMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B5B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeKHMt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:49:57 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55504 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbeKHMt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:49:57 -0500
Received: by mail-it1-f195.google.com with SMTP id b7-v6so26110010itd.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 19:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7ourNKjiPhot7vvZ5TpvyXSDOz0AmT1FHnFzSuLtp0=;
        b=PE8qDiMYMIN6rFLWJULMzCtXQt+B0GdP0bf3nfHck/PMXc27j6imfYbk70aZGyCR08
         JAemy8PhFCT1/qhxkVvA9usqdda1tLJMAzLPuuGBGKX/3pDijyeX9cMJg3luPNvIFEFI
         cwvZPsEQnfcuvdcdL7ue7ygBBchd+d+5A60Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7ourNKjiPhot7vvZ5TpvyXSDOz0AmT1FHnFzSuLtp0=;
        b=UoS+qe3/49IU32sjdzjQFwXWs6DsKvtK8ju/2K8dTC4kGspQ5INETu3+JqKxL/gooq
         nUboWSQBzT54JyXdG6X5f5HnUoYqTGCsEvWXDQgGemAON+gO0mjenZ2J+yVz5b639ppD
         d7KOuGrFY/HPyFLLhcG1mFFH6SiIMhgDPMts9YnAQ76D6H5F1RLr/+vzKX3HiNcTjp/N
         fatoi9uHqUYyPI8jhkB8OTZC1bljR62WNOI/3PrGgqDMzHl8KLUt3n8eBPWGb9MDckmj
         svTuX5yb4R6Ey8nyNSKMrVNPM+CqjN/MMLRjWfBn1fOQAQaOaqRJd7/VOTEY32n0JMLG
         1wig==
X-Gm-Message-State: AGRZ1gIgeRhl+Gj3Qcc14lbeWCIDUkmNfHyaNs1CkXctA3FyJwZ1T8V3
        k1z900uBwAhpN+hfKFmG/cErOvOyI0M=
X-Google-Smtp-Source: AJdET5cNczgpaQa4YMcEfHy6l8rjSPseoOMsmhXE7NfiqcGQZxRTXSb0xTBDaqQo1Np7VgEyH8oCjQ==
X-Received: by 2002:a24:d8c3:: with SMTP id b186-v6mr2547577itg.161.1541646995480;
        Wed, 07 Nov 2018 19:16:35 -0800 (PST)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id x26-v6sm1016189ioa.75.2018.11.07.19.16.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 19:16:34 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id a23-v6so13609079iod.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 19:16:33 -0800 (PST)
X-Received: by 2002:a6b:d541:: with SMTP id x1-v6mr2446642ioc.113.1541646993538;
 Wed, 07 Nov 2018 19:16:33 -0800 (PST)
MIME-Version: 1.0
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
 <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com>
 <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org> <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
 <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
 <20181107205514.GB12273@roeck-us.net> <20181107.210731.330601031@genki.is> <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
In-Reply-To: <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 7 Nov 2018 19:16:21 -0800
X-Gmail-Original-Message-ID: <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
Message-ID: <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     Doug Anderson <dianders@chromium.org>
Cc:     sky@genki.is, Guenter Roeck <linux@roeck-us.net>,
        lists@nerdbynature.de, yamada.masahiro@socionext.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:18 PM Doug Anderson <dianders@chromium.org> wrote:
> On Wed, Nov 7, 2018 at 1:07 PM Genki Sky <sky@genki.is> wrote:
> > On Wed, 7 Nov 2018 12:55:14 -0800, Guenter Roeck <linux@roeck-us.net> wrote:
> > > Ubuntu 16.04 ships with git version 2.7.4.
> >
> > Okay. I guess --no-optional-locks is a no-go then.
>
> In theory you could wrap it.  If passing git with
> "--no-optional-locks" doesn't work you could fall back to the old
> code?  That would mean only people with newer git would get your new
> feature and everyone else would stick with the pre-existing behavior.

+1, that's what I was going to suggest. Presumably older git would
give non-zero exit status for unknown flags, and we take that as
signal to try to the old way?
