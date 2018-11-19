Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61517C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335382146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335382146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404325AbeKTD4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:56:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35050 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390555AbeKTD4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:56:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CB841596;
        Mon, 19 Nov 2018 09:32:11 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8A03F5B7;
        Mon, 19 Nov 2018 09:32:05 -0800 (PST)
Date:   Mon, 19 Nov 2018 17:32:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        kasan-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v11 00/24] kasan: add software tag-based mode for arm64
Message-ID: <20181119173202.7pcxp5osupdw4t5t@lakrids.cambridge.arm.com>
References: <cover.1542648335.git.andreyknvl@google.com>
 <CAAeHK+xr04YNUY21osduxrVzxNEpiXZamSsFCGquvBD6JV6Lbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xr04YNUY21osduxrVzxNEpiXZamSsFCGquvBD6JV6Lbw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 06:28:57PM +0100, Andrey Konovalov wrote:
> On Mon, Nov 19, 2018 at 6:26 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > Changes in v11:
> > - Rebased onto 9ff01193 (4.20-rc3).
> > - Moved KASAN_SHADOW_SCALE_SHIFT definition to arch/arm64/Makefile.
> > - Added and used CC_HAS_KASAN_GENERIC and CC_HAS_KASAN_SW_TAGS configs to
> >   detect compiler support.
> > - New patch: "kasan: rename kasan_zero_page to kasan_early_shadow_page".
> > - New patch: "arm64: move untagged_addr macro from uaccess.h to memory.h".
> > - Renamed KASAN_SET_TAG/... macros in arch/arm64/include/asm/memory.h to
> >   __tag_set/... and reused them later in KASAN core code instead of
> >   redefining.
> > - Removed tag reset from the __kimg_to_phys() macro.
> > - Fixed tagged pointer handling in arm64 fault handling logic.
> 
> Hi Mark and Catalin,

Hi Andrey,

> I've addressed your comments, please take a look.

Catalin and I have just returned from Linux Plumbers and are ctaching up
with things. I do intend to look at this, but it may take me a short
while before I can.

Thanks,
Mark.
