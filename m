Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FF521A75
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FF521A75
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeFUTI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:08:29 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:47932 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754079AbeFUTI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:08:27 -0400
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 21 Jun 2018 19:07:22 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 21
 Jun 2018 12:07:21 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Thu, 21 Jun
 2018 12:07:21 -0700
Date:   Thu, 21 Jun 2018 12:07:21 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Daniel Vacek <neelx@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "mm: page_alloc: skip over regions of invalid
 pfns where possible"
Message-ID: <20180621190721.bdr42xmp6f2uba7x@pburton-laptop>
References: <20180316143855.29838-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180316143855.29838-1-neelx@redhat.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529608042-321459-32393-17165-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194295
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: neelx@redhat.com,linux-kernel@vger.kernel.org,linux-mm@kvack.org,ard.biesheuvel@linaro.org,akpm@linux-foundation.org,mhocko@suse.com,vbabka@suse.cz,mgorman@techsingularity.net,pasha.tatashin@oracle.com,stable@vger.kernel.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Hmm... I only just noticed this because you CC'd an email address that
is no longer functional. I presume you're not using .mailmap, which
would have given you my current email address.

On Fri, Mar 16, 2018 at 03:38:55PM +0100, Daniel Vacek wrote:
> This reverts commit b92df1de5d289c0b5d653e72414bf0850b8511e0. The commit
> is meant to be a boot init speed up skipping the loop in memmap_init_zone()
> for invalid pfns. But given some specific memory mapping on x86_64 (or more
> generally theoretically anywhere but on arm with CONFIG_HAVE_ARCH_PFN_VALID)

My patch definitely wasn't ARM-specific & I have never tested it on ARM.
It was motivated by a MIPS platform with an extremely sparse memory map.
Could you explain why you think it depends on ARM or
CONFIG_HAVE_ARCH_PFN_VALID?

> the implementation also skips valid pfns which is plain wrong and causes
> 'kernel BUG at mm/page_alloc.c:1389!'

Which VM_BUG_ON is that? I don't see one on line 1389 as of commit
b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns where
possible") or any mainline final release since.

> crash> log | grep -e BUG -e RIP -e Call.Trace -e move_freepages_block -e rmqueue -e freelist -A1
> kernel BUG at mm/page_alloc.c:1389!
> invalid opcode: 0000 [#1] SMP
> --
> RIP: 0010:[<ffffffff8118833e>]  [<ffffffff8118833e>] move_freepages+0x15e/0x160
> RSP: 0018:ffff88054d727688  EFLAGS: 00010087
> --
> Call Trace:
>  [<ffffffff811883b3>] move_freepages_block+0x73/0x80
>  [<ffffffff81189e63>] __rmqueue+0x263/0x460
>  [<ffffffff8118c781>] get_page_from_freelist+0x7e1/0x9e0
>  [<ffffffff8118caf6>] __alloc_pages_nodemask+0x176/0x420
> --
> RIP  [<ffffffff8118833e>] move_freepages+0x15e/0x160
>  RSP <ffff88054d727688>
> 
> crash> page_init_bug -v | grep RAM
> <struct resource 0xffff88067fffd2f8>          1000 -        9bfff       System RAM (620.00 KiB)
> <struct resource 0xffff88067fffd3a0>        100000 -     430bffff       System RAM (  1.05 GiB = 1071.75 MiB = 1097472.00 KiB)
> <struct resource 0xffff88067fffd410>      4b0c8000 -     4bf9cfff       System RAM ( 14.83 MiB = 15188.00 KiB)
> <struct resource 0xffff88067fffd480>      4bfac000 -     646b1fff       System RAM (391.02 MiB = 400408.00 KiB)
> <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff       System RAM (480.00 KiB)
> <struct resource 0xffff88067fffd640>     100000000 -    67fffffff       System RAM ( 22.00 GiB)
> 
> crash> page_init_bug | head -6
> <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff       System RAM (480.00 KiB)
> <struct page 0xffffea0001ede200>   1fffff00000000  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
> <struct page 0xffffea0001ede200> 505736 505344 <struct page 0xffffea0001ed8000> 505855 <struct page 0xffffea0001edffc0>
> <struct page 0xffffea0001ed8000>                0  0 <struct pglist_data 0xffff88047ffd9000> 0 <struct zone 0xffff88047ffd9000> DMA               1       4095
> <struct page 0xffffea0001edffc0>   1fffff00000400  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
> BUG, zones differ!
> 
> crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b787000 7b788000
>       PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
> ffffea0001e00000  78000000                0        0  0 0
> ffffea0001ed7fc0  7b5ff000                0        0  0 0
> ffffea0001ed8000  7b600000                0        0  0 0       <<<<
> ffffea0001ede1c0  7b787000                0        0  0 0
> ffffea0001ede200  7b788000                0        0  1 1fffff00000000

I'm not really sure what I'm looking at here. I presume you're saying
that memmap_init_zone() didn't initialize the struct page for
phys=0x7b788000?

Could you describe the memblock region list, and what ranges
memmap_init_zone() skipped over?

Thanks,
    Paul
