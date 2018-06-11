Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aXFgBZxMHlv5KgAAmS7hNA
	; Mon, 11 Jun 2018 10:19:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 042E3607A4; Mon, 11 Jun 2018 10:19:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7611260541;
	Mon, 11 Jun 2018 10:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7611260541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeFKKTF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:19:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:56816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932517AbeFKKTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:19:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10EA5ACF0;
        Mon, 11 Jun 2018 10:19:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 56BE01E04CC; Mon, 11 Jun 2018 12:19:02 +0200 (CEST)
Date: Mon, 11 Jun 2018 12:19:02 +0200
From: Jan Kara <jack@suse.cz>
To: Shakeel Butt <shakeelb@google.com>
Cc: Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: reclaim least recently used dquots
Message-ID: <20180611101902.scimaa5dsvcoxfyy@quack2.suse.cz>
References: <20180608013759.46315-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608013759.46315-1-shakeelb@google.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-06-18 18:37:59, Shakeel Butt wrote:
> From: Greg Thelen <gthelen@google.com>
> 
> The dquots in the free_dquots list are not reclaimed in LRU way.
> put_dquot_last() puts entries to the tail and dqcache_shrink_scan()
> frees from the tail. Free unreferenced dquots in LRU order because it
> seems more reasonable than freeing most recently used.
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index d88231e3b2be..241b00f835b9 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -716,7 +716,7 @@ dqcache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	unsigned long freed = 0;
>  
>  	spin_lock(&dq_list_lock);
> -	head = free_dquots.prev;
> +	head = free_dquots.next;
>  	while (head != &free_dquots && sc->nr_to_scan) {
>  		dquot = list_entry(head, struct dquot, dq_free);
>  		remove_dquot_hash(dquot);
> @@ -725,7 +725,7 @@ dqcache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		do_destroy_dquot(dquot);
>  		sc->nr_to_scan--;
>  		freed++;
> -		head = free_dquots.prev;
> +		head = free_dquots.next;
>  	}
>  	spin_unlock(&dq_list_lock);
>  	return freed;
> -- 
> 2.18.0.rc1.242.g61856ae69a-goog
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
