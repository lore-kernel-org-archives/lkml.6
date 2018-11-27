Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8EEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EED208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EED208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeK0URA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:17:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:44890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730087AbeK0URA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:17:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03D2FAF5A;
        Tue, 27 Nov 2018 09:19:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B0D8E1E07ED; Tue, 27 Nov 2018 10:19:43 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:19:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: fix potential use after free
Message-ID: <20181127091943.GB16301@quack2.suse.cz>
References: <1543107482-97334-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543107482-97334-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 25-11-18 08:58:02, Pan Bian wrote:
> The function ext2_xattr_set calls brelse(bh) to drop the reference count
> of bh. After that, bh may be freed. However, following brelse(bh),
> it reads bh->b_data via macro HDR(bh). This may result in a
> use-after-free bug. This patch moves brelse(bh) after reading field.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Thanks for the fix! I've added the patch to my tree.

								Honza

> ---
>  fs/ext2/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 62d9a659a..dd8f10d 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -612,9 +612,9 @@ bad_block:		ext2_error(sb, "ext2_xattr_set",
>  	}
>  
>  cleanup:
> -	brelse(bh);
>  	if (!(bh && header == HDR(bh)))
>  		kfree(header);
> +	brelse(bh);
>  	up_write(&EXT2_I(inode)->xattr_sem);
>  
>  	return error;
> -- 
> 2.7.4
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
