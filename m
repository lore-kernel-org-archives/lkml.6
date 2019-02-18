Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FD1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9242218FF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550482936;
	bh=0aECagmqyWP2fLRL+qcEEdNtqsET9KyhE8A9iecbvPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZV7FtVZmzoAwnxKHCBq15uCS+65VZVaZMl2WNUCvPJ7O1Rg/q1zPoVELbXZlekDoR
	 KO3nHOLtDDPcxcF9aOO3NXLtM/sGJWo5hQV3cCxmACXNhT+M+TF7GxnFFEL1ix3aUA
	 sxhpjk3f3m1zkroJi2Qnu8UfMMe7/o8Q/Zdkv1Qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfBRJmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:42:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:59916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727228AbfBRJmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:42:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0BBCADF0;
        Mon, 18 Feb 2019 09:42:12 +0000 (UTC)
Date:   Mon, 18 Feb 2019 10:42:11 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix buddy list helpers
Message-ID: <20190218094211.GI4525@dhcp22.suse.cz>
References: <155033679702.1773410.13041474192173212653.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155033679702.1773410.13041474192173212653.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 16-02-19 09:07:02, Dan Williams wrote:
> Tetsuo reports that free page statistics are not reporting correctly,
> and Vlastimil noticed that "mm: Move buddy list manipulations into
> helpers" botched one of its conversions of add_to_free_area(). Fix the
> double-increment of ->nr_free.
> 
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@suse.com>
> Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Thanks for catching that. I have really missed it during review.
Sorry about that.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> Hi Andrew,
> 
> Please fold this into
> mm-move-buddy-list-manipulations-into-helpers.patch.
> 
>  mm/page_alloc.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2a0969e3b0eb..da537fc39c54 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1851,7 +1851,6 @@ static inline void expand(struct zone *zone, struct page *page,
>  			continue;
>  
>  		add_to_free_area(&page[size], area, migratetype);
> -		area->nr_free++;
>  		set_page_order(&page[size], high);
>  	}
>  }
> 

-- 
Michal Hocko
SUSE Labs
