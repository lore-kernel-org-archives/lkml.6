Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204C7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC1D2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC1D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbeLJUJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:09:36 -0500
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:38926 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727156AbeLJUJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:09:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id F06281E253E;
        Mon, 10 Dec 2018 20:09:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: list12_536ccd5624b2a
X-Filterd-Recvd-Size: 3131
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Dec 2018 20:09:33 +0000 (UTC)
Message-ID: <906167f7ca975d437ff9868333d8bf1e86b934a7.camel@perches.com>
Subject: Re: [PATCH 2/2] fat: New macros to determine the FAT variant (32,
 16 or 12)
From:   Joe Perches <joe@perches.com>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>,
        hirofumi@mail.parknet.co.jp, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        axboe@kernel.dk, martin.petersen@oracle.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Dec 2018 12:09:31 -0800
In-Reply-To: <1544470917-6443-3-git-send-email-carmeli.tamir@gmail.com>
References: <1544470917-6443-1-git-send-email-carmeli.tamir@gmail.com>
         <1544470917-6443-3-git-send-email-carmeli.tamir@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 14:41 -0500, Carmeli Tamir wrote:
> This patch introduces 3 new macros - IS_FAT12, IS_FAT16 and IS_FAT32,
> and replaces every occurrence in the code in which the FS variant (whether
> this is FAT12, FAT16 or FAT32) was previously checked using
> msdos_sb_info->fat_bits.

Overall a nice cleanup and a couple style suggestions:

> diff --git a/fs/fat/cache.c b/fs/fat/cache.c
> index 78d501c..99962b3 100644
> --- a/fs/fat/cache.c
> +++ b/fs/fat/cache.c
> @@ -363,7 +363,7 @@ int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
>  
>  	*phys = 0;
>  	*mapped_blocks = 0;
> -	if ((sbi->fat_bits != 32) && (inode->i_ino == MSDOS_ROOT_INO)) {
> +	if ((!IS_FAT32(sbi)) && (inode->i_ino == MSDOS_ROOT_INO)) {

Perhaps nicer without the parens around !IS_FAT32(sbi)

[]

> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
[]
> @@ -116,12 +116,16 @@ static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
>   * this is FAT12, FAT16 or FAT32.
>   */
>  
> -#define FAT_FIRST_ENT(s, x)     ((MSDOS_SB(s)->fat_bits == 32 ? 0x0FFFFF00 : \
> -	MSDOS_SB(s)->fat_bits == 16 ? 0xFF00 : 0xF00) | (x))
> +#define IS_FAT12(sbi) (sbi->fat_bits == 12)
> +#define IS_FAT16(sbi) (sbi->fat_bits == 16)
> +#define IS_FAT32(sbi) (sbi->fat_bits == 32)

sbi should be parenthesized or perhaps better these should be
static inline bool functions

> +
> +#define FAT_FIRST_ENT(s, x)     ((IS_FAT32(MSDOS_SB(s)) ? 0x0FFFFF00 : \
> +	IS_FAT16(MSDOS_SB(s)) ? 0xFF00 : 0xF00) | (x))

This is probably nicer to use a statement expression macro
so MSDOS_SB(s) is only evaluated once or convert this to a
static inline, but it may even better to remove it altogether
instead as it seems unused anywhere.

>  
>  /* maximum number of clusters */
> -#define MAX_FAT(s)      (MSDOS_SB(s)->fat_bits == 32 ? MAX_FAT32 : \
> -	MSDOS_SB(s)->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12)
> +#define MAX_FAT(s)      (IS_FAT32(MSDOS_SB(s)) ? MAX_FAT32 : \
> +	IS_FAT16(MSDOS_SB(s)) ? MAX_FAT16 : MAX_FAT12)

Used once, so perhaps better inlined there.


