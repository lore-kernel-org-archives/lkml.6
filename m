Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2597EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72E32086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="CK69W+RY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72E32086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeKHCEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:04:55 -0500
Received: from imap.thunk.org ([74.207.234.97]:49530 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbeKHCEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UaXXjSeX5KEIi27cXQdt86WNOwPjgRtNmZk+P+yUNeQ=; b=CK69W+RYUSutJJSptevpZ+yG5m
        2BB20a4P9ms2MzGhO2aJWCz/v2w7juLILU+L8/6IMXcvxUJnSZ4O+2Wyc9w8H7q/KpP4Kz115YAgg
        Xlw8CdT9WDpuodDGhzvEnrZgaTkimh14o8z8bsMByYC8bqkCJBFh+zKYzjgiH8V8Y2wE=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKQm3-0000dj-Of; Wed, 07 Nov 2018 16:33:47 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F023D7A7D18; Wed,  7 Nov 2018 11:33:46 -0500 (EST)
Date:   Wed, 7 Nov 2018 11:33:46 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: missing !bh check in ext4_xattr_inode_write()
Message-ID: <20181107163346.GH9919@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <710ddac8-eb88-e631-3b27-74410039d15f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710ddac8-eb88-e631-3b27-74410039d15f@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 08:29:39PM +0300, Vasily Averin wrote:
> ext4_getblk() called with map_flags=0 can return NULL,
> it can lead to oops on bh dereferemce
> 
> Fixes e50e5129f384 ("ext4: xattr-in-inode support")
> Cc: stable@kernel.org # 4.13
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/ext4/xattr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 0b9688683526..6dc6c70828f0 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1384,6 +1384,8 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
>  		bh = ext4_getblk(handle, ea_inode, block, 0);
>  		if (IS_ERR(bh))
>  			return PTR_ERR(bh);
> +		if (!bh)
> +			return -ENOMEM;

ext4_getblk() should never return NULL here; and if it does, it won't
be because of ENOMEM.  If we did have a memory allocation problem, we
would have returned ERR_PTR(-ENOMEM). 

In the while loop above this point, the blocks in ea_inode would have
been allocated, and so when ext4_getblk() is called with map_flags ==
0, it will return NULL if there is a hole in the inode --- but we had
*just* allocated the blocks in question.

The only time that bh could be NULL, then, would be in the case of
something really going wrong; a programming error elsewhere (perhaps a
wild pointer dereference) or I/O error causing on-disk file system
corruption (although that would be highly unlikely given that we had
*just* allocated the blocks and so the metadata blocks in question
probably would still be in the cache).

If we do want to handle this case, what we should do is something like
call WARN_ON_ONCE(1), call ext4_error() since the file system may have
gotten corrupted, and then return -EFSCORRUPTED.

(Linus has said that there should be no new BUG_ON's, so the
WARN_ON_ONE is to help debugging, and flaging the file system as
corrupted is probably the best we could do here, and is marginally
better than what we do now, which is just let the Oops take place.)

						- Ted
