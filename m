Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70451C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AAB21712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rvxq8Xkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AAB21712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeJUGiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:38:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJUGiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CRP8Ayew7U9wynVOETjbzgG5SjudMur8IlCuHEKHUWk=; b=rvxq8Xkf5daSeB9BkYp/0wPOa
        nB1XYN+ujMiTdGgaMh36Kdq4KXTBcROo8RWhJ27WDsrE3sMtMjXx6uxB8vDVh4fWcGwqjRkly4SA+
        EhXOlYvgO7/naJTq2n5l0JpFABoyjynKZw877t6awcY3lumMRN7YagyBSDOPn1uAs+LYc1Jm6Eybj
        oRbI5k1TfTzJ2uLgkqYsOIaQX9LmAEmbedMoRI8gqhRnKDAZVgXjxpemf6Vxrwb1HlQ+bIaSPqyQZ
        C8MYODz7hRXbWpt8MllFzZmSuzmce15mSIzF9yp2jEvB6Iw+RZqRb10xIzmCxo9AWfqAF2Fo3hQOL
        m3NEnIooA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDzhd-0002H9-QM; Sat, 20 Oct 2018 22:26:37 +0000
Date:   Sat, 20 Oct 2018 15:26:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     dushistov@mail.ru, viro@zeniv.linux.org.uk,
        David.Laight@aculab.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181020222637.GA3477@bombadil.infradead.org>
References: <20181020220957.GA7267@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020220957.GA7267@pathfinder>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 11:09:57PM +0100, Phillip Potter wrote:
> Remove switch statement from ufs_set_de_type function in fs/ufs/util.h
> header and replace with simple assignment. For each case, S_IFx >> 12
> is equal to DT_x, so in valid cases (mode & S_IFMT) >> 12 should give
> us the correct file type. It is expected that for *nix compatibility
> reasons, the relation between S_IFx and DT_x will not change. For
> cases where the mode is invalid, upper layer validation catches this
> anyway, so this improves readability and arguably performance by
> assigning (mode & S_IFMT) >> 12 directly without any jump table
> or conditional logic.

Shouldn't we also do this for other filesystems?  A quick scan suggests
someone should at least look at xfs, ubifs, squashfs, romfs, ocfs2,
nilfs2, hfsplus, f2fs, ext4, ext2, exofs, coda, cifs & btrfs.

> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  fs/ufs/util.h | 30 ++----------------------------
>  1 file changed, 2 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/ufs/util.h b/fs/ufs/util.h
> index 1fd3011ea623..7e0c0878b9f9 100644
> --- a/fs/ufs/util.h
> +++ b/fs/ufs/util.h
> @@ -16,6 +16,7 @@
>   * some useful macros
>   */
>  #define in_range(b,first,len)	((b)>=(first)&&(b)<(first)+(len))
> +#define S_SHIFT			12
>  
>  /*
>   * functions used for retyping
> @@ -158,34 +159,7 @@ ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
>  	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
>  		return;
>  
> -	/*
> -	 * TODO turn this into a table lookup
> -	 */
> -	switch (mode & S_IFMT) {
> -	case S_IFSOCK:
> -		de->d_u.d_44.d_type = DT_SOCK;
> -		break;
> -	case S_IFLNK:
> -		de->d_u.d_44.d_type = DT_LNK;
> -		break;
> -	case S_IFREG:
> -		de->d_u.d_44.d_type = DT_REG;
> -		break;
> -	case S_IFBLK:
> -		de->d_u.d_44.d_type = DT_BLK;
> -		break;
> -	case S_IFDIR:
> -		de->d_u.d_44.d_type = DT_DIR;
> -		break;
> -	case S_IFCHR:
> -		de->d_u.d_44.d_type = DT_CHR;
> -		break;
> -	case S_IFIFO:
> -		de->d_u.d_44.d_type = DT_FIFO;
> -		break;
> -	default:
> -		de->d_u.d_44.d_type = DT_UNKNOWN;
> -	}
> +	de->d_u.d_44.d_type = (mode & S_IFMT) >> S_SHIFT;
>  }
>  
>  static inline u32
> -- 
> 2.17.2
> 
