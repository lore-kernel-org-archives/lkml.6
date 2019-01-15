Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89285C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D5A204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547584030;
	bh=IgjzawO284bPZ4FGBTufyzIwdUVDeZcDgdoRojkmztE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ain3MDPL98wgDdxkgM6JrxPdcUmuRZMCLEoMsiEaMoMZSlJuDa+hHggCBnmKxdg15
	 RxzSVbB7sUDyKwdC60gI6vNvmSBWsdgYnUKAHP806uSFi9er9BJcsfE0LCV6moqdre
	 tMq9/kbBI//STyKj0UsikzHHU42VUA+yhtM+tkPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389817AbfAOU1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbfAOU1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:27:08 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939C520873
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 20:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547584027;
        bh=IgjzawO284bPZ4FGBTufyzIwdUVDeZcDgdoRojkmztE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LsFdYYjlvSzhdJZSeYSOTlXGoPQ0sly/BHtRuRGELrmywPPJAleLuZH78r8WPsfqG
         n4EDu3tH7i7KlKEsCjBbB83RlPea8FNxSYF+DSGjcqipNIC2RMUQsrYbeUo8B/xXsm
         a3I1vPaFco2TRPq3U8wkULWiHcAkMTc/6JjA3bR0=
Received: by mail-wm1-f53.google.com with SMTP id a62so4687066wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 12:27:07 -0800 (PST)
X-Gm-Message-State: AJcUukd9gmzkNu0YSd00Oeurisj4to8v7xLQ6r0GnBd2hAvtAMFhAkDO
        aUnw+cTzAJV1o+Rvw5KKFWDdjEakrzNPYjOt8A79nA==
X-Google-Smtp-Source: ALg8bN6+Xl7p+xUDCzFuHsjjHSJyR8U0Oah7E08XlnNgSNK/UArJ11bJ2lsT6rY5zEHQBhHdjy9TNoe2uoPXbmbtdKQ=
X-Received: by 2002:a1c:864f:: with SMTP id i76mr4638117wmd.83.1547584025994;
 Tue, 15 Jan 2019 12:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20190109114744.10936-1-bigeasy@linutronix.de> <2e396dbcbb1c4cc191b4208626baed07@AcuMS.aculab.com>
 <dc9e3308-4e2a-2ce8-495e-6fdb868c60b2@intel.com>
In-Reply-To: <dc9e3308-4e2a-2ce8-495e-6fdb868c60b2@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 15 Jan 2019 12:26:55 -0800
X-Gmail-Original-Message-ID: <CALCETrX0RNgiVop+9uSkLyfxoy-cDyWk2G09svGD_UPsVyLAhA@mail.gmail.com>
Message-ID: <CALCETrX0RNgiVop+9uSkLyfxoy-cDyWk2G09svGD_UPsVyLAhA@mail.gmail.com>
Subject: Re: [PATCH v6] x86: load FPU registers on return to userland
To:     Dave Hansen <dave.hansen@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:46 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/15/19 4:44 AM, David Laight wrote:
> > Once this is done it might be worth while adding a parameter to
> > kernel_fpu_begin() to request the registers only when they don't
> > need saving.
> > This would benefit code paths where the gains are reasonable but not massive.
> >
> > The return value from kernel_fpu_begin() ought to indicate which
> > registers are available - none, SSE, SSE2, AVX, AVX512 etc.
> > So code can use an appropriate implementation.
> > (I've not looked to see if this is already the case!)
>
> Yeah, it would be sane to have both a mask passed, and returned, say:
>
>         got = kernel_fpu_begin(XFEATURE_MASK_AVX512, NO_XSAVE_ALLOWED);
>
>         if (got == XFEATURE_MASK_AVX512)
>                 do_avx_512_goo();
>         else
>                 do_integer_goo();
>
>         kernel_fpu_end(got)
>
> Then, kernel_fpu_begin() can actually work without even *doing* an XSAVE:
>
>         /* Do we have to save state for anything in 'ask_mask'? */
>         if (all_states_are_init(ask_mask))
>                 return ask_mask;
>
> Then kernel_fpu_end() just needs to zero out (re-init) the state, which
> it can do with XRSTORS and a careful combination of XSTATE_BV and the
> requested feature bitmap (RFBM).
>
> This is all just optimization, though.

I don't think we'd ever want kernel_fpu_end() to restore anything,
right?  I'm a bit confused as to when this optimization would actually
be useful.

Jason Donenfeld has a rather nice API for this in his Zinc series.
Jason, how is that coming?
