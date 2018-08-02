Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24D9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5A0214AB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5A0214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeHBPn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:43:29 -0400
Received: from foss.arm.com ([217.140.101.70]:58442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732079AbeHBPn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:43:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F1237A9;
        Thu,  2 Aug 2018 06:52:10 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1BBD3F5B3;
        Thu,  2 Aug 2018 06:52:04 -0700 (PDT)
Date:   Thu, 2 Aug 2018 14:52:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Lawrence <paullawrence@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Christoph Lameter <cl@linux.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-sparse@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Message-ID: <20180802135201.qjweapbskllthvhu@armageddon.cambridge.arm.com>
References: <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com>
 <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com>
 <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
 <CAAeHK+xc1E64tXEEHoXqOuUNZ7E_kVyho3_mNZTCc+LTGHYFdA@mail.gmail.com>
 <20180801163538.GA10800@arm.com>
 <CACT4Y+aZtph5qDsLzTDEgpQRz4_Vtg1DD-cB18qooi6D0bexDg@mail.gmail.com>
 <20180802111031.yx3x6y5d5q6drq52@armageddon.cambridge.arm.com>
 <CACT4Y+b0gkSQHUG67MbYZUTA_aZWs7EmJ2eUzOEPWdt9==ysdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b0gkSQHUG67MbYZUTA_aZWs7EmJ2eUzOEPWdt9==ysdg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(trimming the quoted text a bit)

On Thu, Aug 02, 2018 at 01:36:25PM +0200, Dmitry Vyukov wrote:
> On Thu, Aug 2, 2018 at 1:10 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, Aug 01, 2018 at 06:52:09PM +0200, Dmitry Vyukov wrote:
> >> On Wed, Aug 1, 2018 at 6:35 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> > I'd really like to enable pointer tagging in the kernel, I'm just still
> >> > failing to see how we can do it in a controlled manner where we can reason
> >> > about the semantic changes using something other than a best-effort,
> >> > case-by-case basis which is likely to be fragile and error-prone.
> >> > Unfortunately, if that's all we have, then this gets relegated to a
> >> > debug feature, which sort of defeats the point in my opinion.
> >>
> >> Well, in some cases there is no other way as resorting to dynamic testing.
> >> How do we ensure that kernel does not dereference NULL pointers, does
> >> not access objects after free or out of bounds?
> >
> > We should not confuse software bugs (like NULL pointer dereference) with
> > unexpected software behaviour introduced by khwasan where pointers no
> > longer represent only an address range (e.g. calling find_vmap_area())
> > but rather an address and a tag.
[...]
> > However, not untagging a pointer when converting to long may have
> > side-effects in some cases and I consider these bugs introduced by the
> > khwasan support rather than bugs in the original kernel code. Ideally
> > we'd need some tooling on top of khwasan to detect such shortcomings but
> > I'm not sure we can do this statically, as Andrey already mentioned. For
> > __user pointers, things are slightly better as we can detect the
> > conversion either with sparse (modified) or some LLVM changes.
[...]
> For example, LOCKDEP has the same problem. Previously correct code can
> become incorrect and require finer-grained lock class annotations.
> KMEMLEAK has the same problem: previously correct code that hides a
> pointer may now need changes to unhide the pointer.

It's not actually the same. Take the kmemleak example as I'm familiar
with, previously correct code _continues_ to run correctly in the
presence of kmemleak. The annotation or unhiding is only necessary to
reduce the kmemleak false positives. With khwasan, OTOH, an explicit
untagging is necessary so that the code functions correctly again.

IOW, kmemleak only monitors the behaviour of the original code while
khwasan changes such behaviour by tagging the pointers.

> If somebody has a practical idea how to detect these statically, let's
> do it. Otherwise let's go with the traditional solution to this --
> dynamic testing. The patch series show that the problem is not a
> disaster and we won't need to change just every line of kernel code.

It's indeed not a disaster but we had to do this exercise to find out
whether there are better ways of detecting where untagging is necessary.

If you want to enable khwasan in "production" and since enabling it
could potentially change the behaviour of existing code paths, the
run-time validation space doubles as we'd need to get the same code
coverage with and without the feature being enabled. I wouldn't say it's
a blocker for khwasan, more like something to be aware of.

The awareness is a bit of a problem as the normal programmer would have
to pay more attention to conversions between pointer and long. Given
that this is an arm64-only feature, we have a risk of khwasan-triggered
bugs being introduced in generic code in the future (hence the
suggestion of some static checker, if possible).

-- 
Catalin
