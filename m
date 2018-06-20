Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7940C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE53205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE53205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeFTCRd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:17:33 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:56942 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753758AbeFTCRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:17:32 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w5K2FjIr016628
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jun 2018 11:15:45 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w5K2FjkZ008492;
        Wed, 20 Jun 2018 11:15:45 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w5K2CsV7017583;
        Wed, 20 Jun 2018 11:15:45 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-1335395; Wed, 20 Jun 2018 11:14:54 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0319.002; Wed,
 20 Jun 2018 11:14:53 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
CC:     "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>
Subject: Re: [PATCH] mm: skip invalid pages block at a time in
 zero_resv_unresv
Thread-Topic: [PATCH] mm: skip invalid pages block at a time in
 zero_resv_unresv
Thread-Index: AQHUBMGZzpEnEUsumkebRnt6zmuZMaRn2I4A
Date:   Wed, 20 Jun 2018 02:14:53 +0000
Message-ID: <20180620021452.GA7241@hori1.linux.bs1.fc.nec.co.jp>
References: <20180615155733.1175-1-pasha.tatashin@oracle.com>
In-Reply-To: <20180615155733.1175-1-pasha.tatashin@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <5C4BEA7B6AF786479FE83EE4EF287E8D@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:57:33AM -0400, Pavel Tatashin wrote:
> The role of zero_resv_unavail() is to make sure that every struct page that
> is allocated but is not backed by memory that is accessible by kernel is
> zeroed and not in some uninitialized state.
> 
> Since struct pages are allocated in blocks (2M pages in x86 case), we can
> skip pageblock_nr_pages at a time, when the first one is found to be
> invalid.
> 
> This optimization may help since now on x86 every hole in e820 maps
> is marked as reserved in memblock, and thus will go through this function.
> 
> This function is called before sched_clock() is initialized, so I used my
> x86 early boot clock patches to measure the performance improvement.
> 
> With 1T hole on i7-8700 currently we would take 0.606918s of boot time, but
> with this optimization 0.001103s.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Looks good to me, thanks!

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> ---
>  mm/page_alloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1521100f1e63..94f1b3201735 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6404,8 +6404,11 @@ void __paginginit zero_resv_unavail(void)
>  	pgcnt = 0;
>  	for_each_resv_unavail_range(i, &start, &end) {
>  		for (pfn = PFN_DOWN(start); pfn < PFN_UP(end); pfn++) {
> -			if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
> +			if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
> +				pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
> +					+ pageblock_nr_pages - 1;
>  				continue;
> +			}
>  			mm_zero_struct_page(pfn_to_page(pfn));
>  			pgcnt++;
>  		}
> -- 
> 2.17.1
> 
> 
