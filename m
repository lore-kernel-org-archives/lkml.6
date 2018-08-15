Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB18CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84602084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84602084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbeHPB3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:29:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbeHPB3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:29:08 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 670CB40B;
        Wed, 15 Aug 2018 22:34:57 +0000 (UTC)
Date:   Wed, 15 Aug 2018 15:34:56 -0700
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
        linux-mm@kvack.org
Subject: Re: [RESEND PATCH v10 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
Message-Id: <20180815153456.974798c62dd5a5e4628db8f5@linux-foundation.org>
In-Reply-To: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Jul 2018 17:01:09 +0800 Jia He <hejianet@gmail.com> wrote:

> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> where possible") optimized the loop in memmap_init_zone(). But it causes
> possible panic bug. So Daniel Vacek reverted it later.
> 
> But as suggested by Daniel Vacek, it is fine to using memblock to skip
> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
> 
> More from what Daniel said:
> "On arm and arm64, memblock is used by default. But generic version of
> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> not always return the next valid one but skips more resulting in some
> valid frames to be skipped (as if they were invalid). And that's why
> kernel was eventually crashing on some !arm machines."
> 
> About the performance consideration:
> As said by James in b92df1de5,
> "I have tested this patch on a virtual model of a Samurai CPU with a
> sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
> 
> Besides we can remain memblock_next_valid_pfn, there is still some room
> for improvement. After this set, I can see the time overhead of memmap_init
> is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
> memory, pagesize 64k). I believe arm server will benefit more if memory is
> larger than TBs

This patchset is basically unreviewed at this stage.  Could people
please find some time to check it carefully?

Thanks.
