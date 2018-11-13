Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA694C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5BD2250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdC94+D0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5BD2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbeKMKKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbeKMKKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:10:48 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73804224E0;
        Tue, 13 Nov 2018 00:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542068119;
        bh=mzbjpKU9Vg741DbBOW8tnJ+52nAuVvvIrY1PneRqDt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdC94+D0Frl08eKsQBi9rvG5wRJPWDmhbvd1ANtlICk7IhQTpRNUtsSccOsRj8eAT
         2rCZgsBjoUZxtjTIwxo7dtrwS8vi2O+tF4JzdwZppLOBSNiBCGIfOWZtfPVz9suvnA
         3ZOhiEEm3dY7ImcYEelT2jVZqyNObmft8chgsFVQ=
Date:   Mon, 12 Nov 2018 16:15:17 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yunlong Song <yunlong.song@huawei.com>
Cc:     chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com,
        miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: only flush the single temp bio cache which owns
 the target page
Message-ID: <20181112013003.GA83294@jaegeuk-macbookpro.roam.corp.google.com>
References: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
 <1540380945-18114-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540380945-18114-1-git-send-email-yunlong.song@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24, Yunlong Song wrote:
> Previously, when f2fs finds which temp bio cache owns the target page,
> it will flush all the three temp bio caches, but we only need to flush
> one single bio cache indeed, which can help to keep bio merged.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/data.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 106f116..882e217 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -396,13 +396,17 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
>  }
>  
>  static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
> -				enum page_type type, enum temp_type temp)
> +				struct inode *inode, struct page *page, nid_t ino,
> +				enum page_type type, enum temp_type temp, bool force)
>  {
>  	enum page_type btype = PAGE_TYPE_OF_BIO(type);
>  	struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
>  
>  	down_write(&io->io_rwsem);
>  
> +	if (!force && !__has_merged_page(io, inode, page, ino))
> +		goto out;

Could you clean up this to call once in __submit_merged_write_cond() only?

> +
>  	/* change META to META_FLUSH in the checkpoint procedure */
>  	if (type >= META_FLUSH) {
>  		io->fio.type = META_FLUSH;
> @@ -412,6 +416,7 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
>  			io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
>  	}
>  	__submit_merged_bio(io);
> +out:
>  	up_write(&io->io_rwsem);
>  }
>  
> @@ -426,7 +431,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>  
>  	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
>  
> -		__f2fs_submit_merged_write(sbi, type, temp);
> +		__f2fs_submit_merged_write(sbi, inode, page, ino, type, temp, force);
>  
>  		/* TODO: use HOT temp only for meta pages now. */
>  		if (type >= META)
> -- 
> 1.8.5.2
