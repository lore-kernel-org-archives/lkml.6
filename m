Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675BFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE17205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ixrZTdrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE17205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJPRIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:08:01 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:47339 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJPRIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:08:00 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9G9IRDi017958;
        Tue, 16 Oct 2018 18:18:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9G9IRDi017958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539681508;
        bh=0yCcOWXR8kVm9dNfnO+yZC4OZrxakjeWWIzJB4i/FJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ixrZTdrx9PDT6XVlxIXicG86gSkILkbXjTr23xKUpqjudeot5qn59GyMNADrBjkO0
         9vRkjEPpPnK4nJOd9ItlUdB3TOcAtdyPRVBfB7GV/jBwHkyLITchfNwwC9bnLK8lJc
         /NBgUeVXee03TwrBM0JnhNB7KOlKZFDOrqBEZDm6bzeHyG+bRZ7P8v5vBQv3FWNr4O
         /HU3CTRhoF4e3IZGbHRuTEqdL/NdV7ZYV0UoZW4B3MP8ckO+E44PB/t2g0SoowULSy
         sbA8Aqdr/LpOsCuF0OtB9xHPW4zsIyuWSaQSm30DTRgVJz+yKwwat97dwThly1hb9E
         G278nkghCSh8A==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id c1so3088368uaq.9;
        Tue, 16 Oct 2018 02:18:28 -0700 (PDT)
X-Gm-Message-State: ABuFfoi4ndGyLvfm5SsPWk2XB5WHCaOMpZWJ4lsd/6SAidqASsDKPPCd
        jh44l2v/ecLiuEuH1I1FDVIpQICA3vvar2Rwey8=
X-Google-Smtp-Source: ACcGV63Ij8v5ISZfVC3bdw70IpNiPI6RWvxEreqEjUdPd7ZOrmFrDH7j/bl2QDAPBZbrD9PpiPwLndfIqfvZGBHAfT8=
X-Received: by 2002:ab0:7093:: with SMTP id m19mr8970928ual.55.1539681507267;
 Tue, 16 Oct 2018 02:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181010222333.17794-1-bp@alien8.de> <CAK7LNAT2KpYkn=hj=h1XmbMJRdtgCQ__xP0X+Rpwm3e_Xs1brQ@mail.gmail.com>
 <20181011085234.GA25435@zn.tnic> <CAK7LNAS=Kr1W6SfwojEVdwpKy7Au9NRh-wd2Qfo5+aVQVDe9ZQ@mail.gmail.com>
 <20181011153245.GD25435@zn.tnic>
In-Reply-To: <20181011153245.GD25435@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 16 Oct 2018 18:17:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQv816_ViZVNrSS9rhLHQO_6Pbx9ZOMC1T1FNV3emqS=w@mail.gmail.com>
Message-ID: <CAK7LNAQv816_ViZVNrSS9rhLHQO_6Pbx9ZOMC1T1FNV3emqS=w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fail the build early when no lz4 present
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:33 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Oct 12, 2018 at 12:08:07AM +0900, Masahiro Yamada wrote:
> > Install lz4c, and run 'make' again.
> > Almost all objects have been built there,
> > so you will finish it soon.
>
> So when this LZ4 thing got added at the time, the lz4 package had to be
> downloaded and built and installed and it wasn't as easy as zypper in
> lz4 or apt-get install lz4.
>
> And I *might* install it if there were a human readable error message
> which would tell me so.
>
> And we should strive to be as user-friendly as possible. And no, this:
>
> /bin/sh: 1: lz4c: not found
> make[2]: *** [arch/x86/boot/compressed/Makefile:145: arch/x86/boot/compressed/vmlinux.bin.lz4] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
> make: *** [arch/x86/Makefile:290: bzImage] Error 2
> make: *** Waiting for unfinished jobs....
>
> is not user-friendly.
>
> > If you are building up a compile-test machine,
> > you will probably need to install various tools anyway.
>
> Yes, and look how perf tool solves this. Much much better.
>
> > I do not want to add ugly checks in random places.
>
> That's fair.
>
> What would be a fitting place to add such checks and be able to issue a
> human-readable error message to people?

Sorry for delay.

I have been thinking of this
because I have a motivation to
move libelf check in the top Makefile to somewhere else.

I just made a trial.


-- 
Best Regards
Masahiro Yamada
