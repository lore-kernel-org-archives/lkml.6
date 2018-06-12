Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C30F5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E998208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E998208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754367AbeFLOtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:49:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44811 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754257AbeFLOtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:49:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE9A2AC8A;
        Tue, 12 Jun 2018 14:49:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BCEF01E0D63; Tue, 12 Jun 2018 16:49:16 +0200 (CEST)
Date:   Tue, 12 Jun 2018 16:49:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: add error handling for kmem_cache_create
Message-ID: <20180612144916.5vuqy3v6nrtcxksh@quack2.suse.cz>
References: <1528776964-39826-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528776964-39826-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-06-18 12:16:04, Zhouyang Jia wrote:
> When kmem_cache_create fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling kmem_cache_create.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  fs/notify/dnotify/dnotify.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 63a1ca4..216b411 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -387,6 +387,9 @@ static int __init dnotify_init(void)
>  	dnotify_struct_cache = KMEM_CACHE(dnotify_struct, SLAB_PANIC);
>  	dnotify_mark_cache = KMEM_CACHE(dnotify_mark, SLAB_PANIC);
>  
> +	if (!dnotify_struct_cache || !dnotify_mark_cache)
> +		return -ENOMEM;
> +

Caches are allocated with SLAB_PANIC - i.e., we panic the system if caches
cannot be created. And that's intended since something is really wrong with
the system in that case. So this check is pointless.

								Honza

>  	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops);
>  	if (IS_ERR(dnotify_group))
>  		panic("unable to allocate fsnotify group for dnotify\n");
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
