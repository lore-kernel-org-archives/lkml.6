Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464412075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464412075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIELaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:30:11 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41836 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbeIELaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:30:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id t39-v6so6917382qtc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NEovcPTWttorgGlT8gLCpICBwUsroL+wL0GnDFE9eU=;
        b=tFogPCntOFYJlKX35vM+UgeL1wSGtv3mZWYLrSc0z9+VzUPrEHBt29q9Fd1cJsoPgZ
         xHaJegfL4g5bfta8qM0e7sstgKy0+hW5BuFAu2WI608GMWFtUYtBxIbgLh+i6KvSevpo
         5C8WmFPSgTAf75zuDPvO3LQ9bhumZihD/6HtPTcX8HUTatW1gV/+jIzF6hf2p5Rf4WZs
         /7qU3jiPtVlZ7snhQJEOZARxngJTgd6EKKZaFQzBu333xcKvK3YKkgovQpk5n43El2dt
         fBh5pZHqy11GpGmh4ocx/E1btqpIO01fFPJwvGsOkM59P+T8apXgQBv2aobija2vrAEl
         gd/g==
X-Gm-Message-State: APzg51BdnQ1NnRkZ89AcePjok4RDDEDna4pSYcaE15mu7jPHBc0ZuZl4
        +VmVXi8H21zbcHd+Ppoi3HGcQUkXEu3i3HBVI4S+bg==
X-Google-Smtp-Source: ANB0VdYKkLBEQ6fhf97Q/YCn6dtPk/tRLgPFf91YZ0z5EqAntksYR7FwQwPu0Fvu5pHQ9OWlv6H8qd/g1ZUIg521xbE=
X-Received: by 2002:ac8:3423:: with SMTP id u32-v6mr33170656qtb.237.1536130886670;
 Wed, 05 Sep 2018 00:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
 <20180904133115.5111-2-benjamin.tissoires@redhat.com> <nycvar.YFH.7.76.1809042130260.15880@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1809042130260.15880@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 5 Sep 2018 09:01:15 +0200
Message-ID: <CAO-hwJ+MN=BR_ZS4_GpZitqu2WR+kYSJ3MikQrt8qHFheAbqrQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] HID: multitouch: fix Elan panels with 2 input modes declaration
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 9:31 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 4 Sep 2018, Benjamin Tissoires wrote:
>
> > When implementing commit 7f81c8db5489 ("HID: multitouch: simplify
> > the settings of the various features"), I wrongly removed a test
> > that made sure we never try to set the second InputMode feature
> > to something else than 0.
> >
> > This broke badly some recent Elan panels that now forget to send the
> > click button in some area of the touchpad.
> >
> > Fixes 7f81c8db5489
>
> Please make sure that the 'Fixes:' tag is always in proper format. There
> are tools depending on that :)

Oops, thanks for fixing it. Lazy me :)

Cheers,
Benjamin

>
> I'll fix that up manually.
>
> Thanks!
>
> --
> Jiri Kosina
> SUSE Labs
>
