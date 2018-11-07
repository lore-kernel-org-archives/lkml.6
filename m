Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10481C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1302081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="i6eBBq8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1302081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeKHA4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:56:40 -0500
Received: from imap.thunk.org ([74.207.234.97]:49172 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeKHA4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZeYb+xBNhiWS7emnLY4af3tCaj+iG0cuinpBw5wTrZA=; b=i6eBBq8l2ZF4GFj02hVkcKkPZO
        HkOsh6PsPObsys46JBgw3rXRzv3E6TQcWSFoKaQmvvvu7I8XJJRAhhKeVK+q+ndPijL7R4CFGMspy
        Xs8tewATGichb7PJ68zzoBBYR23swEFm69eCr8jklsyyZ+sEErAHS22T+gNpGE7sjTMI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKPiH-0008Vg-VF; Wed, 07 Nov 2018 15:25:50 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 336657A7D10; Wed,  7 Nov 2018 10:25:49 -0500 (EST)
Date:   Wed, 7 Nov 2018 10:25:49 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] ext4: lost brelse in __ext4_read_dirblock()
Message-ID: <20181107152549.GB9919@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1541011937.git.vvs@virtuozzo.com>
 <60f19df8-1e65-99a0-cb6b-696d1b530fd4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f19df8-1e65-99a0-cb6b-696d1b530fd4@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:12:18PM +0300, Vasily Averin wrote:
> Fixes dc6982ff4db1 ("ext4: refactor code to read directory blocks ...") # 3.9
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/ext4/namei.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index d388cce72db2..1a21e59ede72 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -111,6 +111,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
>  	if (!bh) {
>  		ext4_error_inode(inode, func, line, block,
>  				 "Directory hole found");
> +		brelse(bh);
>  		return ERR_PTR(-EFSCORRUPTED);
>  	}
>  	dirent = (struct ext4_dir_entry *) bh->b_data;

Inside the conditional, bh == NULL, so the brelse isn't needed.

Cheers,

						- Ted
