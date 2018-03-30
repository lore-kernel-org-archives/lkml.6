Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeC3IIR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 04:08:17 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35658 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeC3IIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 04:08:14 -0400
X-Google-Smtp-Source: AIpwx49Q/kqp+14ma8KCAQyubX0nKZichTEV3bQL1/hACv63JY3pqzXOH/53yQAXdR7EqSD9JsH3HQ==
Date: Fri, 30 Mar 2018 11:07:35 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2 06/14] mm/page_alloc: Propagate encryption KeyID
 through page allocator
Message-ID: <20180330080735.cvajv6dbzbi2in7b@node.shutemov.name>
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
 <20180328165540.648-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328165540.648-7-kirill.shutemov@linux.intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 07:55:32PM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/tile/mm/homecache.c b/arch/tile/mm/homecache.c
> index 4432f31e8479..99580091830b 100644
> --- a/arch/tile/mm/homecache.c
> +++ b/arch/tile/mm/homecache.c
> @@ -398,7 +398,7 @@ struct page *homecache_alloc_pages_node(int nid, gfp_t gfp_mask,
>  {
>  	struct page *page;
>  	BUG_ON(gfp_mask & __GFP_HIGHMEM);   /* must be lowmem */
> -	page = alloc_pages_node(nid, gfp_mask, order);
> +	page = alloc_pages_node(rch/x86/events/intel/pt.cnid, gfp_mask, order, 0);
>  	if (page)
>  		homecache_change_page_home(page, order, home);
>  	return page;

Ouch. Fixup:

diff --git a/arch/tile/mm/homecache.c b/arch/tile/mm/homecache.c
index 99580091830b..9eb14da556a8 100644
--- a/arch/tile/mm/homecache.c
+++ b/arch/tile/mm/homecache.c
@@ -398,7 +398,7 @@ struct page *homecache_alloc_pages_node(int nid, gfp_t gfp_mask,
 {
 	struct page *page;
 	BUG_ON(gfp_mask & __GFP_HIGHMEM);   /* must be lowmem */
-	page = alloc_pages_node(rch/x86/events/intel/pt.cnid, gfp_mask, order, 0);
+	page = alloc_pages_node(nid, gfp_mask, order, 0);
 	if (page)
 		homecache_change_page_home(page, order, home);
 	return page;
-- 
 Kirill A. Shutemov
