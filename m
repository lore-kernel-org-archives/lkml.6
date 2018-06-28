Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80590C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C32C245F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C32C245F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030595AbeF1TDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:03:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:38590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968003AbeF1TDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:03:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31D8CAD61;
        Thu, 28 Jun 2018 19:03:35 +0000 (UTC)
Date:   Thu, 28 Jun 2018 13:21:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, gthelen@google.com
Subject: Re: [PATCH] mm: hugetlb: yield when prepping struct pages
Message-ID: <20180628112139.GC32348@dhcp22.suse.cz>
References: <20180627214447.260804-1-cannonmatthews@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627214447.260804-1-cannonmatthews@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-06-18 14:44:47, Cannon Matthews wrote:
> When booting with very large numbers of gigantic (i.e. 1G) pages, the
> operations in the loop of gather_bootmem_prealloc, and specifically
> prep_compound_gigantic_page, takes a very long time, and can cause a
> softlockup if enough pages are requested at boot.
> 
> For example booting with 3844 1G pages requires prepping
> (set_compound_head, init the count) over 1 billion 4K tail pages, which
> takes considerable time. This should also apply to reserving the same
> amount of memory as 2M pages, as the same number of struct pages
> are affected in either case.
> 
> Add a cond_resched() to the outer loop in gather_bootmem_prealloc() to
> prevent this lockup.
> 
> Tested: Booted with softlockup_panic=1 hugepagesz=1G hugepages=3844 and
> no softlockup is reported, and the hugepages are reported as
> successfully setup.
> 
> Signed-off-by: Cannon Matthews <cannonmatthews@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/hugetlb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a963f2034dfc..d38273c32d3b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2169,6 +2169,7 @@ static void __init gather_bootmem_prealloc(void)
>  		 */
>  		if (hstate_is_gigantic(h))
>  			adjust_managed_page_count(page, 1 << h->order);
> +		cond_resched();
>  	}
>  }
>  
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog

-- 
Michal Hocko
SUSE Labs
