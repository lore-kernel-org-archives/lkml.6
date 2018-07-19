Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EC7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26A320693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26A320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbeGSJkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:40:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeGSJkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:40:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD1A3ADA5;
        Thu, 19 Jul 2018 08:58:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 322AF1E3C28; Thu, 19 Jul 2018 10:58:12 +0200 (CEST)
Date:   Thu, 19 Jul 2018 10:58:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     akpm@linux-foundation.org, jack@suse.cz,
        mgorman@techsingularity.net, jlayton@redhat.com,
        ak@linux.intel.com, mawilcox@microsoft.com,
        tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] mm: adjust max read count in generic_file_buffered_read()
Message-ID: <20180719085812.sjup2odrjyuigt3l@quack2.suse.cz>
References: <20180719081726.3341-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719081726.3341-1-cgxu519@gmx.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 16:17:26, Chengguang Xu wrote:
> When we try to truncate read count in generic_file_buffered_read(),
> should deliver (sb->s_maxbytes - offset) as maximum count not
> sb->s_maxbytes itself.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, I can see you didn't include two (I'd say the most important ;)
addresses to CC: Al Viro as a VFS maintainer and linux-fsdevel mailing
list. Although this code resides in mm/ it is in fact a filesystem code.
Added now.

								Honza

> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 52517f28e6f4..5c2d481d21cf 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2064,7 +2064,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  
>  	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
>  		return 0;
> -	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
> +	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - *ppos);
>  
>  	index = *ppos >> PAGE_SHIFT;
>  	prev_index = ra->prev_pos >> PAGE_SHIFT;
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
