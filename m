Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F5AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C158206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C158206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeIFPVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:21:45 -0400
Received: from foss.arm.com ([217.140.101.70]:43048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeIFPVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:21:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E7147A9;
        Thu,  6 Sep 2018 03:46:53 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F26C03F557;
        Thu,  6 Sep 2018 03:46:52 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B2DD21AE358D; Thu,  6 Sep 2018 11:47:07 +0100 (BST)
Date:   Thu, 6 Sep 2018 11:47:07 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jia He <hejianet@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
Message-ID: <20180906104707.GL3592@arm.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
 <20180905145755.cc89819d446f311e4b8e8f95@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905145755.cc89819d446f311e4b8e8f95@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:57:55PM -0700, Andrew Morton wrote:
> On Wed, 22 Aug 2018 11:07:14 +0800 Jia He <hejianet@gmail.com> wrote:
> 
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
> 
> Thanks.  I switched to v11.  It would be nice to see some confirmation
> from ARM people please?

I'll take a look...

Will
