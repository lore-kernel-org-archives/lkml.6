Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFEFC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 03:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E13920877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 03:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E13920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeJMLax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 07:30:53 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:12504 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbeJMLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 07:30:52 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 13 Oct 2018 14:25:17 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gBB1I-0006ci-Tz; Sat, 13 Oct 2018 14:55:16 +1100
Date:   Sat, 13 Oct 2018 14:55:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 4/6] mm: introduce page->dma_pinned_flags, _count
Message-ID: <20181013035516.GA18822@dastard>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012060014.10242-5-jhubbard@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:00:12PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Add two struct page fields that, combined, are unioned with
> struct page->lru. There is no change in the size of
> struct page. These new fields are for type safety and clarity.
> 
> Also add page flag accessors to test, set and clear the new
> page->dma_pinned_flags field.
> 
> The page->dma_pinned_count field will be used in upcoming
> patches
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm_types.h   | 22 +++++++++++++-----
>  include/linux/page-flags.h | 47 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5ed8f6292a53..017ab82e36ca 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -78,12 +78,22 @@ struct page {
>  	 */
>  	union {
>  		struct {	/* Page cache and anonymous pages */
> -			/**
> -			 * @lru: Pageout list, eg. active_list protected by
> -			 * zone_lru_lock.  Sometimes used as a generic list
> -			 * by the page owner.
> -			 */
> -			struct list_head lru;
> +			union {
> +				/**
> +				 * @lru: Pageout list, eg. active_list protected
> +				 * by zone_lru_lock.  Sometimes used as a
> +				 * generic list by the page owner.
> +				 */
> +				struct list_head lru;
> +				/* Used by get_user_pages*(). Pages may not be
> +				 * on an LRU while these dma_pinned_* fields
> +				 * are in use.
> +				 */
> +				struct {
> +					unsigned long dma_pinned_flags;
> +					atomic_t      dma_pinned_count;
> +				};
> +			};

Isn't this broken for mapped file-backed pages? i.e. they may be
passed as the user buffer to read/write direct IO and so the pages
passed to gup will be on the active/inactive LRUs. hence I can't see
how you can have dual use of the LRU list head like this....

What am I missing here?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
