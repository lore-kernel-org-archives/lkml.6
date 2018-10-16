Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E252FC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68382145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="J7d/dPVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68382145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeJQDAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:00:36 -0400
Received: from imap.thunk.org ([74.207.234.97]:50666 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbeJQDAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=e7+qk/GiyfuvxznreBUL2d5BN+UD4r/dcBfmaiFbVoM=; b=J7d/dPVQu9rzTN5SowWBLB1Z6n
        DBWpA9y7/PRnPFHCwPyWIYEBjCtkNd6Bso31hwl3p5QMMEFQecgRJpeKbsJaLGjQOIPfYcLa69h/l
        m02vbyEkDE+ohjeYkb22HyCtUsXp1fwE9fZgnY3Rs1Gfzkjb2XtxQfyzu9s/4UcEp8Lo=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gCUht-00088Z-F8; Tue, 16 Oct 2018 19:08:41 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B707B7A4986; Tue, 16 Oct 2018 15:08:40 -0400 (EDT)
Date:   Tue, 16 Oct 2018 15:08:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     fishland <fishland@aliyun.com>
Cc:     adilger.kernel@dilger.ca, wang.yi59@zte.com.cn,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Song <liu.song11@zte.com.cn>
Subject: Re: [PATCH] ext4: direct return when jinode allocate failed
Message-ID: <20181016190840.GF24131@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        fishland <fishland@aliyun.com>, adilger.kernel@dilger.ca,
        wang.yi59@zte.com.cn, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liu Song <liu.song11@zte.com.cn>
References: <20181016145526.3288-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016145526.3288-1-fishland@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:55:26PM +0800, fishland wrote:
> The jinode does not need protected by *i_lock*, we can return
> directly if memory allocation fails.
> 

I don't see anything wrong with this patch, but at the same time, I'm
not sure I see the benefit, either.  Checking for the allocation
failure is cheap, and moving it out spinlock doesn't buy much; not to
mention that the allocation failure is going to be highly uncommon.

What inspired this commit?

						- Ted



> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> Reviewed-by: Wang Yi <wang.yi59@zte.com.cn>
> ---
>  fs/ext4/inode.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d767e993591d..67ba6f062de5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4384,12 +4384,11 @@ int ext4_inode_attach_jinode(struct inode *inode)
>  		return 0;
>  
>  	jinode = jbd2_alloc_inode(GFP_KERNEL);
> +	if (!jinode)
> +		return -ENOMEM;
> +
>  	spin_lock(&inode->i_lock);
>  	if (!ei->jinode) {
> -		if (!jinode) {
> -			spin_unlock(&inode->i_lock);
> -			return -ENOMEM;
> -		}
>  		ei->jinode = jinode;
>  		jbd2_journal_init_jbd_inode(ei->jinode, inode);
>  		jinode = NULL;
> -- 
> 2.17.1
> 
