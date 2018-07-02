Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EEBC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB7023EA5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB7023EA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeGBTVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:21:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55220 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeGBTVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:21:16 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E64A6CB7;
        Mon,  2 Jul 2018 19:21:13 +0000 (UTC)
Date:   Mon, 2 Jul 2018 12:21:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Evgenii Stepanov <eugenis@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Message-Id: <20180702122112.267261b1e1609cf522753cf3@linux-foundation.org>
In-Reply-To: <CAFKCwrjxGEa6CLJnjmNy+92d2GSUkoymQ6Sm91CDpMZcJCcWCA@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com>
        <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
        <CAAeHK+xz552VNpZxgWwU-hbTqF5_F6YVDw3fSv=4OT8mNrqPzg@mail.gmail.com>
        <20180628124039.8a42ab5e2994fb2876ff4f75@linux-foundation.org>
        <CAAeHK+xsBOKghUp9XhpfXGqU=gjSYuy3G2GH14zWNEmaLPy8_w@mail.gmail.com>
        <20180629194117.01b2d31e805808eee5c97b4d@linux-foundation.org>
        <CAFKCwrjxGEa6CLJnjmNy+92d2GSUkoymQ6Sm91CDpMZcJCcWCA@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 12:16:42 -0700 Evgenii Stepanov <eugenis@google.com> wrote:

> On Fri, Jun 29, 2018 at 7:41 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Fri, 29 Jun 2018 14:45:08 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> >> >> What kind of memory consumption testing would you like to see?
> >> >
> >> > Well, 100kb or so is a teeny amount on virtually any machine.  I'm
> >> > assuming the savings are (much) more significant once the machine gets
> >> > loaded up and doing work?
> >>
> >> So with clean kernel after boot we get 40 kb memory usage. With KASAN
> >> it is ~120 kb, which is 200% overhead. With KHWASAN it's 50 kb, which
> >> is 25% overhead. This should approximately scale to any amounts of
> >> used slab memory. For example with 100 mb memory usage we would get
> >> +200 mb for KASAN and +25 mb with KHWASAN. (And KASAN also requires
> >> quarantine for better use-after-free detection). I can explicitly
> >> mention the overhead in %s in the changelog.
> >>
> >> If you think it makes sense, I can also make separate measurements
> >> with some workload. What kind of workload should I use?
> >
> > Whatever workload people were running when they encountered problems
> > with KASAN memory consumption ;)
> >
> > I dunno, something simple.  `find / > /dev/null'?
> >
>
> Looking at a live Android device under load, slab (according to
> /proc/meminfo) + kernel stack take 8-10% available RAM (~350MB).
> Kasan's overhead of 2x - 3x on top of it is not insignificant.
> 

(top-posting repaired.  Please don't)

For a debugging, not-for-production-use feature, that overhead sounds
quite acceptable to me.  What problems is it known to cause?

