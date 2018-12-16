Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A32C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E735B2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544986575;
	bh=MCiUR2NprOQeHfKvw6aflAs3MJrwmgnf25fiVDa0aRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BLFZ7CNiRkzDfp3H+uxh9RJpZennEX3YT+rqAQclm0WOi2Vc31/BIVTS9/tqzbzZu
	 Qr0Xy2akGV1emGR1vUAbMzwCyASFB2uGAdvO48bxTycOIViuWOA1nnDNmGSTHWLaaR
	 3f1qxoGPehIzUM2mJTbp2lYI+rvtWPUy0gmuigGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbeLPS4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 13:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbeLPS4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 13:56:13 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E082086C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 18:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544986572;
        bh=MCiUR2NprOQeHfKvw6aflAs3MJrwmgnf25fiVDa0aRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rtP3SvRpe2SHQ0k60c1F0mev9/rr4Blk1PwutDPFBbxn83HVVt12NbEQAumejkc/Z
         g3uxCwdBjtWMBO9hh0q3+4sXnnTWj85O2fI2dviIQb71bXErJZjobpNkHw/zBP7VGZ
         Xlh7/Trs7iimCXlmeGWUf0vLahUA6hivkSqfRBgE=
Received: by mail-wr1-f44.google.com with SMTP id t27so10119195wra.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 10:56:12 -0800 (PST)
X-Gm-Message-State: AA+aEWZxIP5aLxJn46aMrhVjwvYtShl+re2c3pl3EYLSiZetZfhVpQKE
        n1wKySkDqRH6D0B1NyI7gvXgubTo+oX4fXOwiSpM3g==
X-Google-Smtp-Source: AFSGD/Xw467mRKoqES+eJaK3104rTPAggMsMuQeOVl+0vvhenT14gb6V8KbUIbFP93ApTB0u9EZ+qnGGmLW61ttsX2o=
X-Received: by 2002:adf:8323:: with SMTP id 32mr8013201wrd.176.1544986570861;
 Sun, 16 Dec 2018 10:56:10 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
 <20181215212643.sfk2zwzatdfysbk3@pburton-laptop>
In-Reply-To: <20181215212643.sfk2zwzatdfysbk3@pburton-laptop>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 16 Dec 2018 10:55:48 -0800
X-Gmail-Original-Message-ID: <CALCETrW49AdvgFrKkFaMtfaFcUDGGDykLDZoCH93utxe5pmPDQ@mail.gmail.com>
Message-ID: <CALCETrW49AdvgFrKkFaMtfaFcUDGGDykLDZoCH93utxe5pmPDQ@mail.gmail.com>
Subject: Re: Fixing MIPS delay slot emulation weakness?
To:     Paul Burton <paul.burton@mips.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 1:22 AM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Andy,
>
> On Sat, Dec 15, 2018 at 11:19:37AM -0800, Andy Lutomirski wrote:
> > Some security researchers pointed out that writing to the delay slot
> > emulation page is a great exploit technique on MIPS.  It was
> > introduced in:
> >
> > commit 432c6bacbd0c16ec210c43da411ccc3855c4c010
> > Author: Paul Burton <paul.burton@imgtec.com>
> > Date:   Fri Jul 8 11:06:19 2016 +0100
> >
> >     MIPS: Use per-mm page to execute branch delay slot instructions
>
> Are there any further details you can share? You'd still need to
> persuade a program to both write to & jump to the page, right? We're
> talking purely about this providing writable+executable memory?

Yes, exactly.  You need a bug in order to take advantage of it.  The
RWX page at a known location just makes exploitation considerably
easier.

I should also note that, on x86 at least, emulating loads and stores
is not so bad.  The x86 vsyscall emulation code does it and has almost
fully correct fault semantics.  (I say "almost" because I didn't
bother getting the semantics exactly right for non-canonical addresses
and kernel addresses.)
