Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524C2C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0427E24EE2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0427E24EE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeFXMuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:50:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52477 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbeFXMuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:50:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 20D5E20834; Sun, 24 Jun 2018 14:50:01 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id E1556206D8;
        Sun, 24 Jun 2018 14:49:50 +0200 (CEST)
Date:   Sun, 24 Jun 2018 14:49:49 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] ubi: fastmap: Add support for flags
Message-ID: <20180624144949.13411483@bbrezillon>
In-Reply-To: <20180613212344.11608-4-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
        <20180613212344.11608-4-richard@nod.at>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 23:23:33 +0200
Richard Weinberger <richard@nod.at> wrote:

> With version 2 of fastmap, flags are supported.
> We fall back to scanning mode if unsupported flags are found.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/mtd/ubi/fastmap.c   | 24 ++++++++++++++++++++----
>  drivers/mtd/ubi/ubi-media.h | 11 +++++++++--
>  drivers/mtd/ubi/ubi.h       |  2 ++
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
> index 768fa8a76867..1ebb5d15ab1a 100644
> --- a/drivers/mtd/ubi/fastmap.c
> +++ b/drivers/mtd/ubi/fastmap.c
> @@ -949,9 +949,24 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
>  		goto free_fm_sb;
>  	}
>  
> -	if (fmsb->version != UBI_FM_FMT_VERSION) {
> -		ubi_err(ubi, "bad fastmap version: %i, expected: %i",
> -			fmsb->version, UBI_FM_FMT_VERSION);
> +	fm->flags = be32_to_cpu(fmsb->flags);
> +
> +	if (fmsb->version == 1) {
> +		if (fm->flags != 0) {
> +			ubi_err(ubi, "fastmap flags are non-zero: %#x",
> +				fm->flags);
> +			ret = UBI_BAD_FASTMAP;
> +			goto free_fm_sb;
> +		}
> +	} else if (fmsb->version == 2) {
> +		if ((fm->flags & UBI_FM_SB_FLG_MASK) != UBI_FM_SB_FLG_MASK) {

Do you mean

		if (fm->flags & ~UBI_FM_SB_FLG_MASK) {

?

Because you test will return an error if at least one of all the
possible flags are not set, which I guess is a valid case.

> +			ubi_err(ubi, "unsupported fastmap flags present: %#x",
> +				fm->flags);
> +			ret = UBI_BAD_FASTMAP;
> +			goto free_fm_sb;
> +		}

Is there really a point in supporting FM v2 so early in the patch
series? I mean, the new thing in v2 is flag support, and here you fail
when ->flags != 0. Better add support for at least one flag before
saying you support v2 IMO.

> +	} else {
> +		ubi_err(ubi, "bad fastmap version: %i", fmsb->version);
>  		ret = UBI_BAD_FASTMAP;
>  		goto free_fm_sb;
>  	}
> @@ -1229,10 +1244,11 @@ static int ubi_write_fastmap(struct ubi_device *ubi,
>  	ubi_assert(fm_pos <= ubi->fm_size);
>  
>  	fmsb->magic = cpu_to_be32(UBI_FM_SB_MAGIC);
> -	fmsb->version = UBI_FM_FMT_VERSION;
> +	fmsb->version = UBI_FM_FMT_WRITE_VERSION;
>  	fmsb->used_blocks = cpu_to_be32(new_fm->used_blocks);
>  	/* the max sqnum will be filled in while *reading* the fastmap */
>  	fmsb->sqnum = 0;
> +	fmsb->flags = 0;
>  
>  	fmh->magic = cpu_to_be32(UBI_FM_HDR_MAGIC);
>  	free_peb_count = 0;
> diff --git a/drivers/mtd/ubi/ubi-media.h b/drivers/mtd/ubi/ubi-media.h
> index 195ff8ca8211..6136a97f4844 100644
> --- a/drivers/mtd/ubi/ubi-media.h
> +++ b/drivers/mtd/ubi/ubi-media.h
> @@ -365,7 +365,10 @@ struct ubi_vtbl_record {
>  #define UBI_FM_DATA_VOLUME_ID	(UBI_LAYOUT_VOLUME_ID + 2)
>  
>  /* fastmap on-flash data structure format version */
> -#define UBI_FM_FMT_VERSION	1
> +#define UBI_FM_FMT_VERSION		2

How about renaming that one UBI_FM_MAX_SUPPORTED_VERSION or something
like that.

> +
> +/* this implementation writes always version 1 */
> +#define UBI_FM_FMT_WRITE_VERSION	1

It really feels weird to hardcode that. What if you're reading a
fastmap volume that has version 2 set, and need to update it? Does that
mean you'll downgrade the FM to version 1 or will you prevent updating
the it?

>  
>  #define UBI_FM_SB_MAGIC		0x7B11D69F
>  #define UBI_FM_HDR_MAGIC	0xD4B82EF7
> @@ -387,6 +390,8 @@ struct ubi_vtbl_record {
>  #define UBI_FM_MIN_POOL_SIZE	8
>  #define UBI_FM_MAX_POOL_SIZE	256
>  
> +#define UBI_FM_SB_FLG_MASK	0

How about naming that one UBI_FM_SB_SUPPORTED_FLG_MASK since you seem
to add new flags afterwards without changing the version number.

> +
>  /**
>   * struct ubi_fm_sb - UBI fastmap super block
>   * @magic: fastmap super block magic number (%UBI_FM_SB_MAGIC)
> @@ -396,6 +401,7 @@ struct ubi_vtbl_record {
>   * @block_loc: an array containing the location of all PEBs of the fastmap
>   * @block_ec: the erase counter of each used PEB
>   * @sqnum: highest sequence number value at the time while taking the fastmap
> + * @flags: fastmap specific flags, only used with @version > 1, zero otherwise
>   *
>   */
>  struct ubi_fm_sb {
> @@ -407,7 +413,8 @@ struct ubi_fm_sb {
>  	__be32 block_loc[UBI_FM_MAX_BLOCKS];
>  	__be32 block_ec[UBI_FM_MAX_BLOCKS];
>  	__be64 sqnum;
> -	__u8 padding2[32];
> +	__be32 flags;
> +	__u8 padding2[28];
>  } __packed;
>  
>  /**
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index f5ba97c46160..4fab3790733b 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -249,6 +249,7 @@ struct ubi_volume_desc;
>   * @used_blocks: number of used PEBs
>   * @max_pool_size: maximal size of the user pool
>   * @max_wl_pool_size: maximal size of the pool used by the WL sub-system
> + * @flags: fastmap flags
>   */
>  struct ubi_fastmap_layout {
>  	struct ubi_wl_entry *e[UBI_FM_MAX_BLOCKS];
> @@ -256,6 +257,7 @@ struct ubi_fastmap_layout {
>  	int used_blocks;
>  	int max_pool_size;
>  	int max_wl_pool_size;
> +	int flags;
>  };
>  
>  /**

