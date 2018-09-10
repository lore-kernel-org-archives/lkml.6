Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03EAC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5988520833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5988520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeIJTWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:22:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbeIJTWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:22:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D56EAE46;
        Mon, 10 Sep 2018 14:27:50 +0000 (UTC)
Date:   Mon, 10 Sep 2018 16:27:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Use BUG_ON directly instead of a if condition
 followed by BUG
Message-ID: <20180910142748.GK10951@dhcp22.suse.cz>
References: <1536588197-22115-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536588197-22115-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-09-18 22:03:17, zhong jiang wrote:
> The if condition can be removed if we use BUG_ON directly.
> The issule is detected with the help of Coccinelle.

typo here

Is this really worth changing? If anything I would really love to see
the BUG_ON going away rather than make a cosmetic changes to it.

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  mm/memory_hotplug.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 38d94b7..280b26c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1888,8 +1888,7 @@ void __ref remove_memory(int nid, u64 start, u64 size)
>  	 */
>  	ret = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1), NULL,
>  				check_memblock_offlined_cb);
> -	if (ret)
> -		BUG();
> +	BUG(ret);
>  
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");
> -- 
> 1.7.12.4
> 

-- 
Michal Hocko
SUSE Labs
