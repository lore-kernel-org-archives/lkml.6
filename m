Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E338DC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773E62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773E62082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electrozaur.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeJXUYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:24:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54360 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXUYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:24:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so5103621wma.4;
        Wed, 24 Oct 2018 04:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=d01SOZy5TT66QMO4iZqWTeiU/L63HqZ4e588cmmTHqs=;
        b=Z9dzXmcRE1IZK+69yz+ZB4WcHbc7fECzMbp9ce4AWNno4kFwEAD+duZ5lXBef0uMhs
         PMTk459cJn9G3B9O4sK/cq/j7yoTnpu0o5FG/VldRCYGpCBk0qUCFaO1otDTrq/LBISl
         bYmG5kBVjOdg+KGLGCtDIld/HtH81NeojMLjBxItCwrJVAdrux3X2lkqSPRsKFDZM6/o
         WRuiOLmeiUxKxyjP037AaPzzihDFwGCqIczwlA3Zg+LBPEUKXV3S/Z7LXf4ljrqQmPTV
         iAacSO4oHMIKXJvH9NjorwPLtSuXtK5f5FP8DZlcsHde6PZHJ0Xpf7HcemTnYfGGMLF+
         5UKA==
X-Gm-Message-State: AGRZ1gK0ACnghXCoY3gjeXCvdJeGnjRin2vjE8OZwFB1fAvBTh58oi6V
        5mTQu/Av4nwsAl7JDYdns1v5ItC/
X-Google-Smtp-Source: AJdET5ed+6TQG+P+oZ/33E2wYVSynj3ncvpGpGD2qMRSodOwButpQSo++eRT3r5bOIQUZN/itHmd/w==
X-Received: by 2002:a1c:c142:: with SMTP id r63-v6mr2355043wmf.72.1540382222012;
        Wed, 24 Oct 2018 04:57:02 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id r131-v6sm5270809wmb.32.2018.10.24.04.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 04:57:00 -0700 (PDT)
Subject: Re: [RFC][PATCH v2 05/10] exofs: use common file type conversion
To:     Phillip Potter <phil@philpotter.co.uk>
References: <20181023201959.GA15715@pathfinder>
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <11231c2a-0bb8-5c87-a65c-4fc7ff47f866@electrozaur.com>
Date:   Wed, 24 Oct 2018 14:56:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181023201959.GA15715@pathfinder>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/18 23:19, Phillip Potter wrote:
> Deduplicate the exofs file type conversion implementation.
> 
> Original patch by Amir Goldstein.
> 
> v2:
> - This version does not remove EXOFS_FT_x enum from fs/exofs/common.h,
>   as these values are now used in compile-time checks added by
>   Phillip Potter to make sure they remain the same as FT_x values
> 
> v1:
> - Initial implementation
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Yes thank you, totally

ACK-by: Boaz Harrosh <ooo@electrozaur.com>

> ---
>  fs/exofs/dir.c | 49 ++++++++++++++++++-------------------------------
>  1 file changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/exofs/dir.c b/fs/exofs/dir.c
> index f0138674c1ed..2e3161ca9014 100644
> --- a/fs/exofs/dir.c
> +++ b/fs/exofs/dir.c
> @@ -204,33 +204,10 @@ exofs_validate_entry(char *base, unsigned offset, unsigned mask)
>  	return (char *)p - base;
>  }
>  
> -static unsigned char exofs_filetype_table[EXOFS_FT_MAX] = {
> -	[EXOFS_FT_UNKNOWN]	= DT_UNKNOWN,
> -	[EXOFS_FT_REG_FILE]	= DT_REG,
> -	[EXOFS_FT_DIR]		= DT_DIR,
> -	[EXOFS_FT_CHRDEV]	= DT_CHR,
> -	[EXOFS_FT_BLKDEV]	= DT_BLK,
> -	[EXOFS_FT_FIFO]		= DT_FIFO,
> -	[EXOFS_FT_SOCK]		= DT_SOCK,
> -	[EXOFS_FT_SYMLINK]	= DT_LNK,
> -};
> -
> -#define S_SHIFT 12
> -static unsigned char exofs_type_by_mode[S_IFMT >> S_SHIFT] = {
> -	[S_IFREG >> S_SHIFT]	= EXOFS_FT_REG_FILE,
> -	[S_IFDIR >> S_SHIFT]	= EXOFS_FT_DIR,
> -	[S_IFCHR >> S_SHIFT]	= EXOFS_FT_CHRDEV,
> -	[S_IFBLK >> S_SHIFT]	= EXOFS_FT_BLKDEV,
> -	[S_IFIFO >> S_SHIFT]	= EXOFS_FT_FIFO,
> -	[S_IFSOCK >> S_SHIFT]	= EXOFS_FT_SOCK,
> -	[S_IFLNK >> S_SHIFT]	= EXOFS_FT_SYMLINK,
> -};
> -
>  static inline
>  void exofs_set_de_type(struct exofs_dir_entry *de, struct inode *inode)
>  {
> -	umode_t mode = inode->i_mode;
> -	de->file_type = exofs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
> +	de->file_type = fs_umode_to_ftype(inode->i_mode);
>  }
>  
>  static int
> @@ -279,17 +256,27 @@ exofs_readdir(struct file *file, struct dir_context *ctx)
>  				exofs_put_page(page);
>  				return -EIO;
>  			}
> -			if (de->inode_no) {
> -				unsigned char t;
>  
> -				if (de->file_type < EXOFS_FT_MAX)
> -					t = exofs_filetype_table[de->file_type];
> -				else
> -					t = DT_UNKNOWN;
> +			/*
> +			 * compile-time asserts that generic FT_x types
> +			 * still match EXOFS_FT_x types - no need to list
> +			 * for other functions as well as build will
> +			 * fail either way
> +			 */
> +			BUILD_BUG_ON(EXOFS_FT_UNKNOWN != FT_UNKNOWN);
> +			BUILD_BUG_ON(EXOFS_FT_REG_FILE != FT_REG_FILE);
> +			BUILD_BUG_ON(EXOFS_FT_DIR != FT_DIR);
> +			BUILD_BUG_ON(EXOFS_FT_CHRDEV != FT_CHRDEV);
> +			BUILD_BUG_ON(EXOFS_FT_BLKDEV != FT_BLKDEV);
> +			BUILD_BUG_ON(EXOFS_FT_FIFO != FT_FIFO);
> +			BUILD_BUG_ON(EXOFS_FT_SOCK != FT_SOCK);
> +			BUILD_BUG_ON(EXOFS_FT_SYMLINK != FT_SYMLINK);
> +			BUILD_BUG_ON(EXOFS_FT_MAX != FT_MAX);
>  
> +			if (de->inode_no) {
>  				if (!dir_emit(ctx, de->name, de->name_len,
>  						le64_to_cpu(de->inode_no),
> -						t)) {
> +						fs_dtype(de->file_type))) {
>  					exofs_put_page(page);
>  					return 0;
>  				}
> 

