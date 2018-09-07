Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02121C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC69C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC69C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbeIGTZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:25:48 -0400
Received: from foss.arm.com ([217.140.101.70]:32980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbeIGTZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:25:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 103D218A;
        Fri,  7 Sep 2018 07:44:33 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D455E3F575;
        Fri,  7 Sep 2018 07:44:32 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 078CE1AE3828; Fri,  7 Sep 2018 15:44:47 +0100 (BST)
Date:   Fri, 7 Sep 2018 15:44:47 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jia He <hejianet@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jia He <jia.he@hxt-semitech.com>
Subject: Re: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
Message-ID: <20180907144447.GD12788@arm.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
 <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:24:22PM +0200, Ard Biesheuvel wrote:
> On 22 August 2018 at 05:07, Jia He <hejianet@gmail.com> wrote:
> > Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> > where possible") optimized the loop in memmap_init_zone(). But it causes
> > possible panic bug. So Daniel Vacek reverted it later.
> >
> > But as suggested by Daniel Vacek, it is fine to using memblock to skip
> > gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
> >
> > More from what Daniel said:
> > "On arm and arm64, memblock is used by default. But generic version of
> > pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> > not always return the next valid one but skips more resulting in some
> > valid frames to be skipped (as if they were invalid). And that's why
> > kernel was eventually crashing on some !arm machines."
> >
> > About the performance consideration:
> > As said by James in b92df1de5,
> > "I have tested this patch on a virtual model of a Samurai CPU with a
> > sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
> > Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
> >
> > Besides we can remain memblock_next_valid_pfn, there is still some room
> > for improvement. After this set, I can see the time overhead of memmap_init
> > is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
> > memory, pagesize 64k). I believe arm server will benefit more if memory is
> > larger than TBs
> >
> 
> OK so we can summarize the benefits of this series as follows:
> - boot time on a virtual model of a Samurai CPU drops from 109 to 62 seconds
> - boot time on a QDF2400 arm64 server with 96 GB of RAM drops by ~15
> *milliseconds*
> 
> Google was not very helpful in figuring out what a Samurai CPU is and
> why we should care about the boot time of Linux running on a virtual
> model of it, and the 15 ms speedup is not that compelling either.
> 
> Apologies to Jia that it took 11 revisions to reach this conclusion,
> but in /my/ opinion, tweaking the fragile memblock/pfn handling code
> for this reason is totally unjustified, and we're better off
> disregarding these patches.

Oh, we're talking about a *simulator* for the significant boot time
improvement here? I didn't realise that, so I agree that the premise of
this patch set looks pretty questionable given how much "fun" we've had
with the memmap on arm and arm64.

Will
