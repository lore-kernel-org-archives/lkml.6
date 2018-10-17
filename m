Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FEEECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF6D21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF6D21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJQQm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:42:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:47482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbeJQQm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:42:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60AB3AF60;
        Wed, 17 Oct 2018 08:47:45 +0000 (UTC)
Date:   Wed, 17 Oct 2018 10:47:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        davem@davemloft.net, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [mm PATCH v3 1/6] mm: Use mm_zero_struct_page from SPARC on all
 64b architectures
Message-ID: <20181017084744.GH18839@dhcp22.suse.cz>
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202656.2171.92963.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015202656.2171.92963.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-10-18 13:26:56, Alexander Duyck wrote:
> This change makes it so that we use the same approach that was already in
> use on Sparc on all the archtectures that support a 64b long.
> 
> This is mostly motivated by the fact that 8 to 10 store/move instructions
> are likely always going to be faster than having to call into a function
> that is not specialized for handling page init.
> 
> An added advantage to doing it this way is that the compiler can get away
> with combining writes in the __init_single_page call. As a result the
> memset call will be reduced to only about 4 write operations, or at least
> that is what I am seeing with GCC 6.2 as the flags, LRU poitners, and
> count/mapcount seem to be cancelling out at least 4 of the 8 assignments on
> my system.
> 
> One change I had to make to the function was to reduce the minimum page
> size to 56 to support some powerpc64 configurations.

This really begs for numbers. I do not mind the change itself with some
minor comments below.

[...]
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bb0de406f8e7..ec6e57a0c14e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -102,8 +102,42 @@ static inline void set_max_mapnr(unsigned long limit) { }
>   * zeroing by defining this macro in <asm/pgtable.h>.
>   */
>  #ifndef mm_zero_struct_page

Do we still need this ifdef? I guess we can wait for an arch which
doesn't like this change and then add the override. I would rather go
simple if possible.

> +#if BITS_PER_LONG == 64
> +/* This function must be updated when the size of struct page grows above 80
> + * or reduces below 64. The idea that compiler optimizes out switch()
> + * statement, and only leaves move/store instructions
> + */
> +#define	mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
> +static inline void __mm_zero_struct_page(struct page *page)
> +{
> +	unsigned long *_pp = (void *)page;
> +
> +	 /* Check that struct page is either 56, 64, 72, or 80 bytes */
> +	BUILD_BUG_ON(sizeof(struct page) & 7);
> +	BUILD_BUG_ON(sizeof(struct page) < 56);
> +	BUILD_BUG_ON(sizeof(struct page) > 80);
> +
> +	switch (sizeof(struct page)) {
> +	case 80:
> +		_pp[9] = 0;	/* fallthrough */
> +	case 72:
> +		_pp[8] = 0;	/* fallthrough */
> +	default:
> +		_pp[7] = 0;	/* fallthrough */
> +	case 56:
> +		_pp[6] = 0;
> +		_pp[5] = 0;
> +		_pp[4] = 0;
> +		_pp[3] = 0;
> +		_pp[2] = 0;
> +		_pp[1] = 0;
> +		_pp[0] = 0;
> +	}

This just hit my eyes. I have to confess I have never seen default: to
be not the last one in the switch. Can we have case 64 instead or does gcc
complain? I would be surprised with the set of BUILD_BUG_ONs.

> +}
> +#else
>  #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
>  #endif
> +#endif
>  
>  /*
>   * Default maximum number of active map areas, this limits the number of vmas
> 

-- 
Michal Hocko
SUSE Labs
