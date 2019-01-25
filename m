Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375AC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EE0218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548426754;
	bh=hEG1JgvRgEoHRlaufO4PKPnY1RPyKem8nD/y+Xb3snM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=spYrKGdKDNUehQ3YjMx6MlP2/Ri3IeoCP4Ak88y+5fzV6jUDRD3Zw9+m9MaoQIpMA
	 mvwCkzZtUaMUAlXHxBxWKjxvDjk3jLXTL1VJzfVQEMX3jbftfkWfL2onyLFJLZVn9f
	 yR2zyqKOUw6ljK/C19ChWH07TlwdG4QLFviY/BqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfAYOcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:32:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:37300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726256AbfAYOcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:32:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9239EAF4C;
        Fri, 25 Jan 2019 14:32:31 +0000 (UTC)
Date:   Fri, 25 Jan 2019 15:32:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        keith.busch@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@suse.de
Subject: Re: [PATCH v7 3/3] mm: Maintain randomization of page free lists
Message-ID: <20190125143230.GP3560@dhcp22.suse.cz>
References: <154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154690328135.676627.5979130839159447106.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154690328135.676627.5979130839159447106.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-01-19 15:21:21, Dan Williams wrote:
> When freeing a page with an order >= shuffle_page_order randomly select
> the front or back of the list for insertion.
> 
> While the mm tries to defragment physical pages into huge pages this can
> tend to make the page allocator more predictable over time. Inject the
> front-back randomness to preserve the initial randomness established by
> shuffle_free_memory() when the kernel was booted.
> 
> The overhead of this manipulation is constrained by only being applied
> for MAX_ORDER sized pages by default.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mmzone.h  |   10 ++++++++++
>  include/linux/shuffle.h |   12 ++++++++++++
>  mm/page_alloc.c         |   11 +++++++++--
>  mm/shuffle.c            |   16 ++++++++++++++++
>  4 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b78a45e0b11c..c15f7f703be0 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -98,6 +98,8 @@ extern int page_group_by_mobility_disabled;
>  struct free_area {
>  	struct list_head	free_list[MIGRATE_TYPES];
>  	unsigned long		nr_free;
> +	u64			rand;
> +	u8			rand_bits;
>  };

Do we really need per order randomness? Why a global one is not
sufficient?
-- 
Michal Hocko
SUSE Labs
