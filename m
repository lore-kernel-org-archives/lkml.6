Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F440ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19DB2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19DB2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeJYGst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:48:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeJYGst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:48:49 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E55711721;
        Wed, 24 Oct 2018 22:18:55 +0000 (UTC)
Date:   Wed, 24 Oct 2018 15:18:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Message-Id: <20181024151853.3edd9097400b0d52edff1f16@linux-foundation.org>
In-Reply-To: <20181023164302.20436-1-guro@fb.com>
References: <20181023164302.20436-1-guro@fb.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 16:43:29 +0000 Roman Gushchin <guro@fb.com> wrote:

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
> 
> ...
>
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
>  		inode->i_state &= ~I_REFERENCED;
>  		spin_unlock(&inode->i_lock);
>  		return LRU_ROTATE;

hm, why "1"?

I guess one could argue that this will encompass long symlinks, but I
just made that up to make "1" appear more justifiable ;) 
