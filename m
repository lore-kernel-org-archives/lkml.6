Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B74EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B65422B1C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B65422B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeGFWhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:37:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbeGFWhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:37:11 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 971ABDA5;
        Fri,  6 Jul 2018 22:37:10 +0000 (UTC)
Date:   Fri, 6 Jul 2018 15:37:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jia He <hejianet@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <jia.he@hxt-semitech.com>
Subject: Re: [RESEND PATCH v10 2/6] mm: page_alloc: remain
 memblock_next_valid_pfn() on arm/arm64
Message-Id: <20180706153709.6bcc76b0245f239f1d1dcc8a@linux-foundation.org>
In-Reply-To: <1530867675-9018-3-git-send-email-hejianet@gmail.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
        <1530867675-9018-3-git-send-email-hejianet@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Jul 2018 17:01:11 +0800 Jia He <hejianet@gmail.com> wrote:

> From: Jia He <jia.he@hxt-semitech.com>
> 
> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> where possible") optimized the loop in memmap_init_zone(). But it causes
> possible panic bug. So Daniel Vacek reverted it later.
> 
> But as suggested by Daniel Vacek, it is fine to using memblock to skip
> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
> Daniel said:
> "On arm and arm64, memblock is used by default. But generic version of
> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> not always return the next valid one but skips more resulting in some
> valid frames to be skipped (as if they were invalid). And that's why
> kernel was eventually crashing on some !arm machines."
> 
> About the performance consideration:
> As said by James in b92df1de5,
> "I have tested this patch on a virtual model of a Samurai CPU
> with a sparse memory map.  The kernel boot time drops from 109 to
> 62 seconds."
> 
> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
> 

We're making a bit of a mess here.  mmzone.h:

...
#ifndef CONFIG_HAVE_ARCH_PFN_VALID
...
#define next_valid_pfn(pfn)	(pfn + 1)
#endif
...
#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
#define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
...
#else
...
#ifndef next_valid_pfn
#define next_valid_pfn(pfn)	(pfn + 1)
#endif

I guess it works OK, since CONFIG_HAVE_MEMBLOCK_PFN_VALID depends on
CONFIG_HAVE_ARCH_PFN_VALID.  But it could all do with some cleanup and
modernization.

- Perhaps memblock_next_valid_pfn() should just be called
  pfn_valid().  So the header file's responsibility is to provide
  pfn_valid() and next_valid_pfn().

- CONFIG_HAVE_ARCH_PFN_VALID should go away.  The current way of
  doing such thnigs is for the arch (or some Kconfig combination) to
  define pfn_valid() and next_valid_pfn() in some fashion and to then
  ensure that one of them is #defined to something, to indicate that
  both of these have been set up.  Or something like that.


Secondly, in memmap_init_zone()

> -		if (!early_pfn_valid(pfn))
> +		if (!early_pfn_valid(pfn)) {
> +			pfn = next_valid_pfn(pfn) - 1;
> 			continue;
> +		}
> +

This is weird-looking.  next_valid_pfn(pfn) is usually (pfn+1) so it's
a no-op.  Sometimes we're calling memblock_next_valid_pfn() and then
backing up one, presumably because the `for' loop ends in `pfn++'.  Or
something.  Can this please be fully commented or cleaned up?

