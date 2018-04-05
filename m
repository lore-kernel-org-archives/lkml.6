Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeDETVM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:21:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46754 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeDETVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:21:11 -0400
X-Google-Smtp-Source: AIpwx49fGuC++BoTQDqO3Vx0NB5Bnp8GsZd8MO4XSmJbh/AR2kKeAkibYIStuyJYf5joiXtrePy3og==
Date: Thu, 5 Apr 2018 12:21:09 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Greg Hackmann <ghackmann@google.com>, marc.zyngier@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>, Dave.Martin@arm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Manoj Gupta <manojgupta@google.com>
Subject: Re: [PATCH] arm/arm64: smccc: Use xN for arm64 register constraints
 with clang
Message-ID: <20180405192109.GA130399@google.com>
References: <20180322212705.141175-1-mka@chromium.org>
 <CAKwvOdk4Tos1Q8dyQvic4PUX3cjy3q1hn3FkK=xiVSChht+gEg@mail.gmail.com>
 <20180322224456.GB78232@google.com>
 <fc921bfb-1f49-08f9-515c-07bd442a1e11@google.com>
 <20180322235811.GC78232@google.com>
 <CAKwvOdkcpxcP5Eb5f1-bJgU0gi4zkbof5WJWz2QbVCNsGBUO3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkcpxcP5Eb5f1-bJgU0gi4zkbof5WJWz2QbVCNsGBUO3w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 06:43:05PM +0000, Nick Desaulniers wrote:
> On Thu, Mar 22, 2018 at 4:58 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > El Thu, Mar 22, 2018 at 04:19:42PM -0700 Greg Hackmann ha dit:
> > > NAK.  There's a reason I didn't send my change upstream.
> > >
> > > As Marc pointed out (https://lkml.org/lkml/2018/3/16/987), the "r"
> > > prefix tells gcc to pick the appropriate register width.  "x" makes it
> > > unconditionally use the entire 64-bit register width.  Just swapping out
> > > one for the other changes the macro's semantics.
> > >
> > > Unfortunately since this was breaking builds in android-4.14 and we
> > > didn't have an immediate-term fix, I bit the bullet and added the above
> > > commit -- but *only* as a short-term workaround.  For the one caller we
> > > currently have in 4.14.y, gcc was using the entire 64-bit width for all
> > > its inputs anyway, so "r" vs. "x" didn't make a difference.  But that
> > > might not be true if/when someone introduces other SMCCC 1.1 callers.
> > >
> > > Unfortunately I don't see a better way to deal with this than waiting
> > > for clang to support "r"-style constraints on ARM64.
> 
> > Thanks for the clarification! From the other thread
> > (https://lkml.org/lkml/2018/3/1/268) I had the impression that ARM
> > folks saw the option of a mergeable fix.
> 
> > Given the fact that clang support for kernel builds is still
> > recent/WIP I guess it's not the end of the world if we have to raise
> > the minimum clang version to 7.x for newer kernels.
> 
> 
> Manoj fixed this in:
> https://reviews.llvm.org/rL328829
> https://bugs.llvm.org/show_bug.cgi?id=36862
> 
> Looks set to ride the Clang 6.0 train.  mka@ if you're planning another
> state of the union email, it would be good to note the clang 6.0
> requirement for arm64.
> 
> Is there anything left to do here?

We should be good, unless somebody wants to look into a patch that
fixes clang pre-6.0.1 builds and doesn't look too ugly.
