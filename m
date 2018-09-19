Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2DFECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68292150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCfwhCrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68292150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeISVE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731744AbeISVE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:04:56 -0400
Received: from [192.168.0.101] (unknown [117.62.222.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BB220877;
        Wed, 19 Sep 2018 15:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537370790;
        bh=w2tLEmVKvppCMec4o4fDAVUkkD1tIHANzf4rv4gxz8w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KCfwhCrQtjVoqdVAics5FOU5Yx6A+MKJZMIZPKkkQA6XF9UGjMK+O0O9J4jBbzSkP
         f5u66cq6ZC4gpz02qp2vkr6731lwfXSRC1V9/b8dKHJVitcDCnszlbaAAB72+OzFlP
         5ks0bwsK0+DCJ9r8Tk3E9vUszc5l/9NAoc7rY+g0=
Subject: Re: [PATCH 4/6] staging: erofs: cleanup
 `z_erofs_vle_normalaccess_readpages'
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, devel@driverdev.osuosl.org
Cc:     Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>
References: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
 <1537336150-90604-4-git-send-email-gaoxiang25@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1b38cbfe-70e0-1e6d-fa50-89b1fddeeb43@kernel.org>
Date:   Wed, 19 Sep 2018 23:26:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537336150-90604-4-git-send-email-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2018/9/19 13:49, Gao Xiang wrote:
> This patch introduces `__should_decompress_synchronously' to
> cleanup `z_erofs_vle_normalaccess_readpages'.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/internal.h  | 11 +++++++++++
>  drivers/staging/erofs/super.c     |  5 +++++
>  drivers/staging/erofs/unzip_vle.c | 20 ++++++--------------
>  3 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index cfcc6db..c84eb97 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -95,6 +95,9 @@ struct erofs_sb_info {
>  	/* the dedicated workstation for compression */
>  	struct radix_tree_root workstn_tree;
>  
> +	/* threshold for decompression synchronously */
> +	unsigned int max_sync_decompress_pages;
> +
>  #ifdef EROFS_FS_HAS_MANAGED_CACHE
>  	struct inode *managed_cache;
>  #endif
> @@ -273,6 +276,14 @@ extern int erofs_try_to_free_cached_page(struct address_space *mapping,
>  	struct page *page);
>  #endif
>  
> +#define DEFAULT_MAX_SYNC_DECOMPRESS_PAGES	4
> +
> +static inline bool __should_decompress_synchronously(struct erofs_sb_info *sbi,
> +						     unsigned int nr)
> +{
> +	return nr <= sbi->max_sync_decompress_pages;

-		nr_pages < 4 /* sync */);

There is a little bit changed except cleanup, IIUC, would it be any difference
of performance around boundary of four pages?

Thanks,

> +}
> +
>  #endif
>  
>  /* we strictly follow PAGE_SIZE and no buffer head yet */
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index 802202c..5b87f59 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -162,6 +162,11 @@ static void erofs_build_fault_attr(struct erofs_sb_info *sbi,
>  
>  static void default_options(struct erofs_sb_info *sbi)
>  {
> +	/* set up some FS parameters */
> +#ifdef CONFIG_EROFS_FS_ZIP
> +	sbi->max_sync_decompress_pages = DEFAULT_MAX_SYNC_DECOMPRESS_PAGES;
> +#endif
> +
>  #ifdef CONFIG_EROFS_FS_XATTR
>  	set_opt(sbi, XATTR_USER);
>  #endif
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index 9fe18cd3..337a82d 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -1308,12 +1308,14 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
>  	return 0;
>  }
>  
> -static inline int __z_erofs_vle_normalaccess_readpages(
> -	struct file *filp,
> -	struct address_space *mapping,
> -	struct list_head *pages, unsigned int nr_pages, bool sync)
> +static int z_erofs_vle_normalaccess_readpages(struct file *filp,
> +					      struct address_space *mapping,
> +					      struct list_head *pages,
> +					      unsigned int nr_pages)
>  {
>  	struct inode *const inode = mapping->host;
> +	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> +	const bool sync = __should_decompress_synchronously(sbi, nr_pages);
>  
>  	struct z_erofs_vle_frontend f = VLE_FRONTEND_INIT(inode);
>  	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
> @@ -1372,16 +1374,6 @@ static inline int __z_erofs_vle_normalaccess_readpages(
>  	return 0;
>  }
>  
> -static int z_erofs_vle_normalaccess_readpages(
> -	struct file *filp,
> -	struct address_space *mapping,
> -	struct list_head *pages, unsigned int nr_pages)
> -{
> -	return __z_erofs_vle_normalaccess_readpages(filp,
> -		mapping, pages, nr_pages,
> -		nr_pages < 4 /* sync */);
> -}
> -
>  const struct address_space_operations z_erofs_vle_normalaccess_aops = {
>  	.readpage = z_erofs_vle_normalaccess_readpage,
>  	.readpages = z_erofs_vle_normalaccess_readpages,
> 
