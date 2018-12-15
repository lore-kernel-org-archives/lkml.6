Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C252D2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeLOTKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:10:19 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:42914 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbeLOTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:10:19 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 66407161688;
        Sun, 16 Dec 2018 04:10:18 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBFJAHqT011612
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 16 Dec 2018 04:10:18 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBFJAGuF024016
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 16 Dec 2018 04:10:16 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id wBFJAEft024015;
        Sun, 16 Dec 2018 04:10:14 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v2 2/3] fat: Moved MAX_FAT to fat.h and changed it to inline function
References: <1544879072-4251-1-git-send-email-carmeli.tamir@gmail.com>
        <1544879072-4251-3-git-send-email-carmeli.tamir@gmail.com>
Date:   Sun, 16 Dec 2018 04:10:14 +0900
In-Reply-To: <1544879072-4251-3-git-send-email-carmeli.tamir@gmail.com>
        (Carmeli Tamir's message of "Sat, 15 Dec 2018 08:04:31 -0500")
Message-ID: <8736qyd2sp.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carmeli Tamir <carmeli.tamir@gmail.com> writes:

> MAX_FAT is useless in msdos_fs.h, since it uses the MSDOS_SB function
> that is defined in fat.h. So really, this macro can be only called
> from code that already includes fat.h.
>
> Hence, this patch moves it to fat.h, right after MSDOS_SB is defined.
> I also changed it to an inline function in order to save the double call
> to MSDOS_SB. This was suggested by joe@perches.com in the previous
> version.
>
> This patch is required for the next in the series, in which the variant
> (whether this is FAT12, FAT16 or FAT32) checks are replaced with new 
> macros.

Could you use lower case chars for inline functions? Yeah, MSDOS_SB() is
upper case though, it is historical reason.

Thanks.

> Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
> ---
>  fs/fat/fat.h                  | 9 +++++++++
>  include/uapi/linux/msdos_fs.h | 2 --
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 4e1b2f6..11bc4a2 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -142,6 +142,15 @@ static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
>  	return sb->s_fs_info;
>  }
>  
> +/* Maximum number of clusters */
> +static inline u32 MAX_FAT(struct super_block *sb)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +
> +	return sbi->fat_bits == 32 ? MAX_FAT32 :
> +		sbi->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12;
> +}
> +
>  static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
>  {
>  	return container_of(inode, struct msdos_inode_info, vfs_inode);
> diff --git a/include/uapi/linux/msdos_fs.h b/include/uapi/linux/msdos_fs.h
> index 833c707..a577389 100644
> --- a/include/uapi/linux/msdos_fs.h
> +++ b/include/uapi/linux/msdos_fs.h
> @@ -65,8 +65,6 @@
>  #define MAX_FAT12	0xFF4
>  #define MAX_FAT16	0xFFF4
>  #define MAX_FAT32	0x0FFFFFF6
> -#define MAX_FAT(s)	(MSDOS_SB(s)->fat_bits == 32 ? MAX_FAT32 : \
> -	MSDOS_SB(s)->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12)
>  
>  /* bad cluster mark */
>  #define BAD_FAT12	0xFF7

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
