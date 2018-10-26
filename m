Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82434C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C23420834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C23420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeJZReD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:34:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbeJZReD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:34:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5201AD1D;
        Fri, 26 Oct 2018 08:57:49 +0000 (UTC)
Date:   Fri, 26 Oct 2018 10:57:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, dairinin@gmail.com
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Message-ID: <20181026085735.GZ18839@dhcp22.suse.cz>
References: <20181023164302.20436-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023164302.20436-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spock doesn't seem to be cced here - fixed now

On Tue 23-10-18 16:43:29, Roman Gushchin wrote:
> Spock reported that the commit 172b06c32b94 ("mm: slowly shrink slabs
> with a relatively small number of objects") leads to a regression on
> his setup: periodically the majority of the pagecache is evicted
> without an obvious reason, while before the change the amount of free
> memory was balancing around the watermark.
> 
> The reason behind is that the mentioned above change created some
> minimal background pressure on the inode cache. The problem is that
> if an inode is considered to be reclaimed, all belonging pagecache
> page are stripped, no matter how many of them are there. So, if a huge
> multi-gigabyte file is cached in the memory, and the goal is to
> reclaim only few slab objects (unused inodes), we still can eventually
> evict all gigabytes of the pagecache at once.
> 
> The workload described by Spock has few large non-mapped files in the
> pagecache, so it's especially noticeable.
> 
> To solve the problem let's postpone the reclaim of inodes, which have
> more than 1 attached page. Let's wait until the pagecache pages will
> be evicted naturally by scanning the corresponding LRU lists, and only
> then reclaim the inode structure.

Has this actually fixed/worked around the issue?

> Reported-by: Spock <dairinin@gmail.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  fs/inode.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 73432e64f874..0cd47fe0dbe5 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -730,8 +730,11 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  		return LRU_REMOVED;
>  	}
>  
> -	/* recently referenced inodes get one more pass */
> -	if (inode->i_state & I_REFERENCED) {
> +	/*
> +	 * Recently referenced inodes and inodes with many attached pages
> +	 * get one more pass.
> +	 */
> +	if (inode->i_state & I_REFERENCED || inode->i_data.nrpages > 1) {

The comment is just confusing. Did you mean to say s@many@any@ ?

>  		inode->i_state &= ~I_REFERENCED;
>  		spin_unlock(&inode->i_lock);
>  		return LRU_ROTATE;
> -- 
> 2.17.2

-- 
Michal Hocko
SUSE Labs
