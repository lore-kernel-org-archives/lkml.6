Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B74C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCAC20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCAC20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLDHY6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:24:58 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:45651 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLDHYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:24:49 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wB47OT5B032751
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Dec 2018 16:24:29 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wB47OTCu019757;
        Tue, 4 Dec 2018 16:24:29 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wB47OTZW009848;
        Tue, 4 Dec 2018 16:24:29 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-314200; Tue, 4 Dec 2018 16:21:18 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Tue, 4
 Dec 2018 16:21:17 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Oscar Salvador <OSalvador@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@gmail.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages to
 be offlined
Thread-Topic: [RFC PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages
 to be offlined
Thread-Index: AQHUiu9tY5+24nB+PkGyMm7atS1YiqVtlyQA
Date:   Tue, 4 Dec 2018 07:21:16 +0000
Message-ID: <20181204072116.GA24446@hori1.linux.bs1.fc.nec.co.jp>
References: <20181203100309.14784-1-mhocko@kernel.org>
In-Reply-To: <20181203100309.14784-1-mhocko@kernel.org>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.82]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <B37C8DEADD258948B64BA709B5D5B46E@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:03:09AM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> We have received a bug report that an injected MCE about faulty memory
> prevents memory offline to succeed. The underlying reason is that the
> HWPoison page has an elevated reference count and the migration keeps
> failing. There are two problems with that. First of all it is dubious
> to migrate the poisoned page because we know that accessing that memory
> is possible to fail. Secondly it doesn't make any sense to migrate a
> potentially broken content and preserve the memory corruption over to a
> new location.
> 
> Oscar has found out that it is the elevated reference count from
> memory_failure that is confusing the offlining path. HWPoisoned pages
> are isolated from the LRU list but __offline_pages might still try to
> migrate them if there is any preceding migrateable pages in the pfn
> range. Such a migration would fail due to the reference count but
> the migration code would put it back on the LRU list. This is quite
> wrong in itself but it would also make scan_movable_pages stumble over
> it again without any way out.
> 
> This means that the hotremove with hwpoisoned pages has never really
> worked (without a luck). HWPoisoning really needs a larger surgery
> but an immediate and backportable fix is to skip over these pages during
> offlining. Even if they are still mapped for some reason then
> try_to_unmap should turn those mappings into hwpoison ptes and cause
> SIGBUS on access. Nobody should be really touching the content of the
> page so it should be safe to ignore them even when there is a pending
> reference count.
> 
> Debugged-by: Oscar Salvador <osalvador@suse.com>
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
> Hi,
> I am sending this as an RFC now because I am not fully sure I see all
> the consequences myself yet. This has passed a testing by Oscar but I
> would highly appreciate a review from Naoya about my assumptions about
> hwpoisoning. E.g. it is not entirely clear to me whether there is a
> potential case where the page might be still mapped.

One potential case is ksm page, for which we give up unmapping and leave
it unmapped. Rather than that I don't have any idea, but any new type of
page would be potentially categorized to this class.

> I have put
> try_to_unmap just to be sure. It would be really great if I could drop
> that part because then it is not really great which of the TTU flags to
> use to cover all potential cases.
> 
> I have marked the patch for stable but I have no idea how far back it
> should go. Probably everything that already has hotremove and hwpoison
> code.

Yes, maybe this could be ported to all active stable trees.

> 
> Thanks in advance!
> 
>  mm/memory_hotplug.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c6c42a7425e5..08c576d5a633 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -34,6 +34,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/memblock.h>
>  #include <linux/compaction.h>
> +#include <linux/rmap.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -1366,6 +1367,17 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  			pfn = page_to_pfn(compound_head(page))
>  				+ hpage_nr_pages(page) - 1;
>  
> +		/*
> +		 * HWPoison pages have elevated reference counts so the migration would
> +		 * fail on them. It also doesn't make any sense to migrate them in the
> +		 * first place. Still try to unmap such a page in case it is still mapped.
> +		 */
> +		if (PageHWPoison(page)) {
> +			if (page_mapped(page))
> +				try_to_unmap(page, TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS);
> +			continue;
> +		}
> +

I think this looks OK (no better idea.)

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

I wondered why I didn't find this for long, and found that my testing only
covered the case where PageHWPoison is the first page of memory block.
scan_movable_pages() considers PageHWPoison as non-movable, so do_migrate_range()
started with pfn after the PageHWPoison and never tried to migrate it
(so effectively ignored every PageHWPoison as the above code does.)

Thanks,
Naoya Horiguchi

>  		if (!get_page_unless_zero(page))
>  			continue;
>  		/*
> -- 
> 2.19.1
> 
> 
