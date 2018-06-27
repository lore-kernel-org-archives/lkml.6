Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F4EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4E72613D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4E72613D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964862AbeF0Lo7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:44:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37306 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753597AbeF0Lo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:44:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F041F2079D; Wed, 27 Jun 2018 13:44:55 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id AACA920714;
        Wed, 27 Jun 2018 13:44:55 +0200 (CEST)
Date:   Wed, 27 Jun 2018 13:44:56 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     dedekind1@gmail.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 1/2] ubi: provide a way to skip CRC checks
Message-ID: <20180627134456.522a1c96@bbrezillon>
In-Reply-To: <b94a9de06741a9a87807fa4d599504503798a835.1530099128.git-series.quentin.schulz@bootlin.com>
References: <cover.54081a233a7b9efc0fa933bdba97c73c85b20059.1530099128.git-series.quentin.schulz@bootlin.com>
        <b94a9de06741a9a87807fa4d599504503798a835.1530099128.git-series.quentin.schulz@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018 13:33:19 +0200
Quentin Schulz <quentin.schulz@bootlin.com> wrote:

> Some users of static UBI volumes implement their own integrity check,
> thus making the volume CRC check done at open time useless. For
> instance, this is the case when one use the ubiblock + dm-verity +
> squashfs combination, where dm-verity already checks integrity of the
> block device but this time at the block granularity instead of verifying
> the whole volume.
> 
> Skipping this test drastically improves the boot-time.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Just a few minor comments (see below).

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/ubi/kapi.c      |  2 +-
>  drivers/mtd/ubi/ubi-media.h |  6 ++++++
>  drivers/mtd/ubi/ubi.h       |  4 ++++
>  drivers/mtd/ubi/vmt.c       |  9 +++++++++
>  drivers/mtd/ubi/vtbl.c      |  3 +++
>  5 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
> index d4b2e87..e9e9ecb 100644
> --- a/drivers/mtd/ubi/kapi.c
> +++ b/drivers/mtd/ubi/kapi.c
> @@ -202,7 +202,7 @@ struct ubi_volume_desc *ubi_open_volume(int ubi_num, int vol_id, int mode)
>  	desc->mode = mode;
>  
>  	mutex_lock(&ubi->ckvol_mutex);
> -	if (!vol->checked) {
> +	if (!vol->checked && !vol->skip_check) {
>  		/* This is the first open - check the volume */
>  		err = ubi_check_volume(ubi, vol_id);
>  		if (err < 0) {
> diff --git a/drivers/mtd/ubi/ubi-media.h b/drivers/mtd/ubi/ubi-media.h
> index 195ff8c..f43a4ff 100644
> --- a/drivers/mtd/ubi/ubi-media.h
> +++ b/drivers/mtd/ubi/ubi-media.h
> @@ -45,6 +45,11 @@ enum {
>   * Volume flags used in the volume table record.
>   *
>   * @UBI_VTBL_AUTORESIZE_FLG: auto-resize this volume
> + * @UBI_VTBL_SKIP_CRC_CHECK_FLG: skip the CRC check done on static volume at

								      ^ volumes?

> + *				 open time. Should only be set on volumes that
> + *				 are used by upper layers doing this kind of
> + *				 check. Main use-case for this flag is
> + *				 boot-time reduction
>   *
>   * %UBI_VTBL_AUTORESIZE_FLG flag can be set only for one volume in the volume
>   * table. UBI automatically re-sizes the volume which has this flag and makes
> @@ -76,6 +81,7 @@ enum {
>   */
>  enum {
>  	UBI_VTBL_AUTORESIZE_FLG = 0x01,
> +	UBI_VTBL_SKIP_CRC_CHECK_FLG = 0x02,
>  };
>  
>  /*
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index f5ba97c..429102b 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -327,6 +327,9 @@ struct ubi_eba_leb_desc {
>   *           atomic LEB change
>   *
>   * @eba_tbl: EBA table of this volume (LEB->PEB mapping)
> + * @skip_check: %1 if CRC check of static volumes should be skipped. Directly
> + *		reflect the presence of the %UBI_VTBL_SKIP_CRC_CHECK_FLG in the

		^ reflects?		    ^ %UBI_VTBL_SKIP_CRC_CHECK_FLG *flag* in

> + *		vtbl entry
>   * @checked: %1 if this static volume was checked
>   * @corrupted: %1 if the volume is corrupted (static volumes only)
>   * @upd_marker: %1 if the update marker is set for this volume
> @@ -374,6 +377,7 @@ struct ubi_volume {
>  	void *upd_buf;
>  
>  	struct ubi_eba_table *eba_tbl;
> +	unsigned int skip_check:1;
>  	unsigned int checked:1;
>  	unsigned int corrupted:1;
>  	unsigned int upd_marker:1;
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 0be5167..e2606a4 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -299,6 +299,10 @@ int ubi_create_volume(struct ubi_device *ubi, struct ubi_mkvol_req *req)
>  		vtbl_rec.vol_type = UBI_VID_DYNAMIC;
>  	else
>  		vtbl_rec.vol_type = UBI_VID_STATIC;
> +
> +	if (vol->skip_check)
> +		vtbl_rec.flags |= UBI_VTBL_SKIP_CRC_CHECK_FLG;
> +
>  	memcpy(vtbl_rec.name, vol->name, vol->name_len);
>  
>  	err = ubi_change_vtbl_record(ubi, vol_id, &vtbl_rec);
> @@ -733,6 +737,11 @@ static int self_check_volume(struct ubi_device *ubi, int vol_id)
>  			ubi_err(ubi, "bad used_bytes");
>  			goto fail;
>  		}
> +
> +		if (vol->skip_check) {
> +			ubi_err(ubi, "bad skip_check");
> +			goto fail;
> +		}
>  	} else {
>  		if (vol->used_ebs < 0 || vol->used_ebs > vol->reserved_pebs) {
>  			ubi_err(ubi, "bad used_ebs");
> diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
> index 94d7a86..2c133cd 100644
> --- a/drivers/mtd/ubi/vtbl.c
> +++ b/drivers/mtd/ubi/vtbl.c
> @@ -560,6 +560,9 @@ static int init_volumes(struct ubi_device *ubi,
>  		vol->name[vol->name_len] = '\0';
>  		vol->vol_id = i;
>  
> +		if (vtbl[i].flags & UBI_VTBL_SKIP_CRC_CHECK_FLG)
> +			vol->skip_check = 1;
> +
>  		if (vtbl[i].flags & UBI_VTBL_AUTORESIZE_FLG) {
>  			/* Auto re-size flag may be set only for one volume */
>  			if (ubi->autoresize_vol_id != -1) {

