Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C12C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E685B2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FNKQ6In/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E685B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeKZMyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 07:54:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKZMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 07:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jVXu2rkN7izqGpeeBbFryL6jaoCRC7xAik2JpopgPk8=; b=FNKQ6In/3dxfmKfHi4/fd+f1E
        DpyjypuQp6Sq792nk4N3v16ZjtCCKvTzRA7Fy8mg0OyUAgA3ew6MpwA1G9Szly3li0NpSseqbYwil
        XFm6RKYKhhu8fcHQgr6xdvRAGq+g6VdpNmUnxovp8MFJE00TPq0jvC088CP3SgmekKfjG8A7MN6f3
        4YuNq40VBed4B/XsYqs6dy6LHQW5wtIw6yKuPmn7EHiQZEo1biRtgnZokHUgKlNmgTJ2UQ3K6pERG
        8GS3GdAjiocTs9dl5KBarGBd0r+MDcWqiYQ9lG6DdmCE32DuusdEHqKHSvkNScHQaM8TYGoxmwSei
        O3yA5RGqQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gR6D5-0005hj-KK; Mon, 26 Nov 2018 02:01:15 +0000
Date:   Sun, 25 Nov 2018 18:01:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Yang <yang.yang29@zte.com.cn>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        pavel.tatashin@microsoft.com, vbabka@suse.cz, osalvador@suse.de,
        rppt@linux.vnet.ibm.com, iamjoonsoo.kim@lge.com,
        alexander.h.duyck@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn
Subject: Re: [PATCH] mm: do not consider SWAP to calculate available when not
 necessary
Message-ID: <20181126020115.GF3065@bombadil.infradead.org>
References: <1543190303-8121-1-git-send-email-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543190303-8121-1-git-send-email-yang.yang29@zte.com.cn>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:58:23AM +0800, Yang Yang wrote:
> When si_mem_available() calculates 'available', it takes SWAP
> into account. But if CONFIG_SWAP is N or SWAP is off(some embedded system
> would like to do that), there is no need to consider it.

I don't understand this patch.  The pagecache can be written back to
storage if it is dirty, regardless of whether there is swap space.

> @@ -4724,9 +4726,13 @@ long si_mem_available(void)
>  	 * Not all the page cache can be freed, otherwise the system will
>  	 * start swapping. Assume at least half of the page cache, or the
>  	 * low watermark worth of cache, needs to stay.
> +	 * But if CONFIG_SWAP is N or SWAP is off, do not consider it.
>  	 */
>  	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
> -	pagecache -= min(pagecache / 2, wmark_low);
> +#ifdef CONFIG_SWAP
> +	if (i.totalswap > 0)
> +		pagecache -= min(pagecache / 2, wmark_low);
> +#endif
>  	available += pagecache;
>  
>  	/*
> -- 
> 2.15.2
> 
