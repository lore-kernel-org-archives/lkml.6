Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A49DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72A32081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OORJ82Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72A32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeLEAsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:48:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeLEAsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kHWMcm6bYx+zbbxP/9lf3TWz5iQf7vnxsfFcUEW51SA=; b=OORJ82Fdj/NgbukGEbyHVGJ5C
        KM2zdVXpPdayvOAicSJST/GcMkqzPrXSzpswaCDGHquYWg9HCB5LfKHfcdXQJO7z6XoqBxyAVvBIk
        yZqcfYfuv9jR86XQRsCrHvYqQHFMcehaUsCMlIxqqMlmeaVzgrJlp9UAwmQKzC2h3ytE/xLgmD6oi
        0dg34GkQzk2W2CzNwf9zN9RU8tgCuvr4o20xJnFQ9+UCS5Y4JQvF0uh90iYTGgLSN+2OLoIXjHlw+
        Q6QuwtSjUYJN6z3cFLnuds9N8xBwzS+aRnc5A6YqX5ELYlxnPGEANVHXxWirNyjqKnmfabfZ6+wTI
        5JJ3b8p3Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gULMj-0005wg-4P; Wed, 05 Dec 2018 00:48:37 +0000
Date:   Tue, 4 Dec 2018 16:48:36 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        adobriyan@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        sfr@canb.auug.org.au, kirill.shutemov@linux.intel.com,
        rppt@linux.vnet.ibm.com, mhocko@suse.com,
        alexander.h.duyck@linux.intel.com, hannes@cmpxchg.org,
        miles.chen@mediatek.com, n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH] /proc/kpagecount: return 0 for special pages that are
 never mapped
Message-ID: <20181205004836.GU10377@bombadil.infradead.org>
References: <1543963526-27917-1-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543963526-27917-1-git-send-email-anthony.yznaga@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:45:26PM -0800, Anthony Yznaga wrote:
> Certain pages that are never mapped to userspace have a type
> indicated in the page_type field of their struct pages (e.g. PG_buddy).
> page_type overlaps with _mapcount so set the count to 0 and avoid
> calling page_mapcount() for these pages.
> 
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  fs/proc/page.c             | 2 +-
>  include/linux/page-flags.h | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
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
> index 50ce1bddaf56..f9a1c50ccefc 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -673,10 +673,17 @@ static inline int TestClearPageDoubleMap(struct page *page)
>  #define PG_balloon	0x00000100
>  #define PG_kmemcg	0x00000200
>  #define PG_table	0x00000400
> +#define PAGE_TYPE_ALL	(PG_buddy | PG_balloon | PG_kmemcg | PG_table)
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
>  
> +static inline int page_has_type(struct page *page)
> +{
> +	return (PageType(page, 0) &&
> +	       ((page->page_type & PAGE_TYPE_ALL) != PAGE_TYPE_ALL));
> +}
> +
>  #define PAGE_TYPE_OPS(uname, lname)					\

I think this is a bit complex, and a bit of a pain to update as we add
new page types.  How about this?

	return (int)page_type < -128;

(I'm open to appropriate #defines to make this more obvious that it's ~0x7F)
