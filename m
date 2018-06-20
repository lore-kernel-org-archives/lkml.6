Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3FEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3699208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3699208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeFTI2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:28:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:57103 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754106AbeFTI2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:28:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C229FAEF2;
        Wed, 20 Jun 2018 08:28:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7515F1E0A21; Wed, 20 Jun 2018 10:28:30 +0200 (CEST)
Date:   Wed, 20 Jun 2018 10:28:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        y2038@lists.linaro.org, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] reiserfs: use 64-bit values in print_time
Message-ID: <20180620082830.vwpcikmpnjluqud4@quack2.suse.cz>
References: <20180619154343.3640484-1-arnd@arndb.de>
 <20180619154343.3640484-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619154343.3640484-3-arnd@arndb.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-06-18 17:43:15, Arnd Bergmann wrote:
> Inode timestamps are now 64-bit wide even on 32-bit machines, and reiserfs
> interprets the 32-bit on-disk timestamps as unsigned when returning them
> to user space with statx(), so for consistency we should print them
> the same way in the emergency console logs.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
...
> diff --git a/fs/reiserfs/item_ops.c b/fs/reiserfs/item_ops.c
> index e3c558d1b78c..d0ab3a763962 100644
> --- a/fs/reiserfs/item_ops.c
> +++ b/fs/reiserfs/item_ops.c
> @@ -33,11 +33,11 @@ static int sd_is_left_mergeable(struct reiserfs_key *key, unsigned long bsize)
>  	return 0;
>  }
>  
> -static char *print_time(time_t t)
> +static char *print_time(time64_t t)
>  {
>  	static char timebuf[256];
>  
> -	sprintf(timebuf, "%ld", t);
> +	sprintf(timebuf, "%lld", t);
>  	return timebuf;
>  }

Well, seeing how print_time() is used, more appropriate prototype would be:

static char *print_time(u32 t)

and then print it as %u.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
