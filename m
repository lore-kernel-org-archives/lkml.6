Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965976AbeBURtF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933603AbeBURs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:48:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B6321796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shli@kernel.org
Date: Wed, 21 Feb 2018 09:48:55 -0800
From: Shaohua Li <shli@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: NeilBrown <neilb@suse.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Song Liu <songliubraving@fb.com>,
        Guoqing Jiang <gqjiang@suse.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] md: raid5: avoid string overflow warning
Message-ID: <20180221174855.jq2wqrxntwvaocmv@kernel.org>
References: <20180220130924.3698067-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220130924.3698067-1-arnd@arndb.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 02:09:11PM +0100, Arnd Bergmann wrote:
> gcc warns about a possible overflow of the kmem_cache string, when adding
> four characters to a string of the same length:
> 
> drivers/md/raid5.c: In function 'setup_conf':
> drivers/md/raid5.c:2207:34: error: '-alt' directive writing 4 bytes into a region of size between 1 and 32 [-Werror=format-overflow=]
>   sprintf(conf->cache_name[1], "%s-alt", conf->cache_name[0]);
>                                   ^~~~
> drivers/md/raid5.c:2207:2: note: 'sprintf' output between 5 and 36 bytes into a destination of size 32
>   sprintf(conf->cache_name[1], "%s-alt", conf->cache_name[0]);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> If I'm counting correctly, we need 11 characters for the fixed part
> of the string and 18 characters for a 64-bit pointer (when no gendisk
> is used), so that leaves three characters for conf->level, which should
> always be sufficient.
> 
> This makes the code use snprintf() with the correct length, to
> make the code more robust against changes, and to get the compiler
> to shut up.
> 
> In commit f4be6b43f1ac ("md/raid5: ensure we create a unique name for
> kmem_cache when mddev has no gendisk") from 2010, Neil said that
> the pointer could be removed "shortly" once devices without gendisk
> are disallowed. I have no idea if that happened, but if it did, that
> should probably be changed as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
> ---
>  drivers/md/raid5.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 50d01144b805..7ef368061424 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -2196,15 +2196,16 @@ static int grow_one_stripe(struct r5conf *conf, gfp_t gfp)
>  static int grow_stripes(struct r5conf *conf, int num)
>  {
>  	struct kmem_cache *sc;
> +	size_t namelen = sizeof(conf->cache_name[0]);
>  	int devs = max(conf->raid_disks, conf->previous_raid_disks);
>  
>  	if (conf->mddev->gendisk)
> -		sprintf(conf->cache_name[0],
> +		snprintf(conf->cache_name[0], namelen,
>  			"raid%d-%s", conf->level, mdname(conf->mddev));
>  	else
> -		sprintf(conf->cache_name[0],
> +		snprintf(conf->cache_name[0], namelen,
>  			"raid%d-%p", conf->level, conf->mddev);
> -	sprintf(conf->cache_name[1], "%s-alt", conf->cache_name[0]);
> +	snprintf(conf->cache_name[1], namelen, "%.27s-alt", conf->cache_name[0]);
>  
>  	conf->active_name = 0;
>  	sc = kmem_cache_create(conf->cache_name[conf->active_name],
> -- 
> 2.9.0
> 
