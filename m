Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6234C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F13C214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13C214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbeLKACt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:02:49 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:55842 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbeLKACS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:02:18 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wBB0156d022034
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 09:01:05 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wBB014cP004785;
        Tue, 11 Dec 2018 09:01:04 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wBANxvKn032365;
        Tue, 11 Dec 2018 09:01:04 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-516596; Tue, 11 Dec 2018 08:39:29 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Tue,
 11 Dec 2018 08:39:28 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "willy@infradead.org" <willy@infradead.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "miles.chen@mediatek.com" <miles.chen@mediatek.com>
Subject: Re: [PATCH v2] /proc/kpagecount: return 0 for special pages that
 are never mapped
Thread-Topic: [PATCH v2] /proc/kpagecount: return 0 for special pages that
 are never mapped
Thread-Index: AQHUkNhMbO3i1VQD5U+oGvybj641bqV4Cp4A
Date:   Mon, 10 Dec 2018 23:39:28 +0000
Message-ID: <20181210233928.GA11726@hori1.linux.bs1.fc.nec.co.jp>
References: <1544481313-27318-1-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1544481313-27318-1-git-send-email-anthony.yznaga@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.88]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <9D831D435920344B9B6CB061EE52C9D2@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 02:35:13PM -0800, Anthony Yznaga wrote:
> Certain pages that are never mapped to userspace have a type
> indicated in the page_type field of their struct pages (e.g. PG_buddy).
> page_type overlaps with _mapcount so set the count to 0 and avoid
> calling page_mapcount() for these pages.
> 
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> Acked-by: Matthew Wilcox <willy@infradead.org>

Looks good to me.

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> ---
> 	v2 - incorporated feedback from Matthew Wilcox
> 
>  fs/proc/page.c             | 2 +-
>  include/linux/page-flags.h | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 6c517b11acf8..40b05e0d4274 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -46,7 +46,7 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>  			ppage = pfn_to_page(pfn);
>  		else
>  			ppage = NULL;
> -		if (!ppage || PageSlab(ppage))
> +		if (!ppage || PageSlab(ppage) || page_has_type(ppage))
>  			pcount = 0;
>  		else
>  			pcount = page_mapcount(ppage);
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 50ce1bddaf56..39b4494e29f1 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -669,6 +669,7 @@ static inline int TestClearPageDoubleMap(struct page *page)
>  
>  #define PAGE_TYPE_BASE	0xf0000000
>  /* Reserve		0x0000007f to catch underflows of page_mapcount */
> +#define PAGE_MAPCOUNT_RESERVE	-128
>  #define PG_buddy	0x00000080
>  #define PG_balloon	0x00000100
>  #define PG_kmemcg	0x00000200
> @@ -677,6 +678,11 @@ static inline int TestClearPageDoubleMap(struct page *page)
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
>  
> +static inline int page_has_type(struct page *page)
> +{
> +	return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
> +}
> +
>  #define PAGE_TYPE_OPS(uname, lname)					\
>  static __always_inline int Page##uname(struct page *page)		\
>  {									\
> -- 
> 1.8.3.1
> 
> 
