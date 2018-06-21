Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B4C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616DE2192C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="DrcPcFcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616DE2192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeFURtN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:49:13 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41982 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFURtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:49:11 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so2062898ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=qt7y8o+tW15nYr8N2t0apr6wWTao4jAFvDBARX8SjFw=;
        b=DrcPcFcBXIW9HoA4DAeULGIP6LIy5XaupjnJCbcWeJvb48Lsrw9oBmMxhh2Mi54D6n
         Y2N23ogkZU23QAawdzs6osHe97NJRXM0DBPKhdBD1mEzLjoAEptH+NxgMHUoXdXth4+s
         XSTigGWgrtpb4XIfwo9GzXDdGBgr/ZTcR1c2LYA8+KLLOu/KavqzV10B+FmEwi9ZPJ4f
         untY2MnLwnl1Hsb4rfUyfoUeuX9DoK7AP58NKHTSDTa8miuy0OE+s7JBp1jZrRnhEQp6
         Md2dY52roB9NXXUYgUK3uExl/tbxbkCyd4gxJTdtVMtkeJu3VXxN9kP/aoa6XoxEz9eX
         Fpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=qt7y8o+tW15nYr8N2t0apr6wWTao4jAFvDBARX8SjFw=;
        b=bX2IchBn0rOodufdyl/MVlio+wG007eNy1fuSdPPZ4uwAqE96yXhRosdCu5F/ls7+j
         w/es1rkbyMU5QApW5pDVy28VHqRHBSx9RD9BfwaIt/A5scBJ5+AYwUlgpu6yPmBXrFrx
         vW0IlTrIv2jiOvTETgEzOmr9S8319QYYcfuW2ABDIjyGxcGxLJyjlpiQHEtqY/ZYDHd5
         zv/d0Yphc7VXr9+KZQMJh4lmdnwwCrhu7vMUDRGq0nET8nzadB964NoOT+igGK9GEU0D
         udgSpmFGTLGvr5b5rSRPh2NFJPiqiM8bo9OVTt/caiaVnwqy+d0jpGTs7GyUQwW681c2
         zOOQ==
X-Gm-Message-State: APt69E2aiwKrhO659IFv41ifYiukbHpYkNOK0wKyekToTUnSOvxiAg1t
        EIey/SZaIdcssaLL5nqIrhmVjw==
X-Google-Smtp-Source: ADUXVKL/QMFV4Tmwp20WPlUhb5oyOQz1fC+hJ3XuioqPfoUp1PonAYfAtsgRV/80LaxTTQgniM2dfQ==
X-Received: by 2002:a17:902:5602:: with SMTP id h2-v6mr29826280pli.314.1529603350539;
        Thu, 21 Jun 2018 10:49:10 -0700 (PDT)
Received: from cabot-100.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id r27-v6sm12484866pfg.94.2018.06.21.10.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:49:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4D58091B-6028-4E24-9EDD-0B4D53314FB8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C93D473D-5749-4058-B51D-09805EDD47E7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/6] ext4: sysfs: print ext4_super_block fields as
 little-endian
Date:   Thu, 21 Jun 2018 11:49:08 -0600
In-Reply-To: <20180620153322.54221-1-arnd@arndb.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        y2038@lists.linaro.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        stable@vger.kernel.org, Tyson Nottingham <tgnottingham@gmail.com>,
        Riccardo Schirone <sirmy15@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
References: <20180620153322.54221-1-arnd@arndb.de>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_C93D473D-5749-4058-B51D-09805EDD47E7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 20, 2018, at 9:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> While working on extended rand for last_error/first_error timestamps,
> I noticed that the endianess is wrong, we access the little-endian
> fields in struct ext4_super_block as native-endian when we print them.
>=20
> This adds a special case in ext4_attr_show() and ext4_attr_store()
> to byteswap the superblock fields if needed.
>=20
> In older kernels, this code was part of super.c, it got moved to =
sysfs.c
> in linux-4.4.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 52c198c6820f ("ext4: add sysfs entry showing whether the fs =
contains errors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I was wondering why this didn't just use le32_to_cpu() all the time,
but I see that these functions are being used for both ext4_super_block
(on-disk) fields, as well as ext4_sb_info (in-memory) fields.  A bit
ugly, but I don't think there is a better solution.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/sysfs.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index f34da0bb8f17..b970a200f20c 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -274,8 +274,12 @@ static ssize_t ext4_attr_show(struct kobject =
*kobj,
> 	case attr_pointer_ui:
> 		if (!ptr)
> 			return 0;
> -		return snprintf(buf, PAGE_SIZE, "%u\n",
> -				*((unsigned int *) ptr));
> +		if (a->attr_ptr =3D=3D ptr_ext4_super_block_offset)
> +			return snprintf(buf, PAGE_SIZE, "%u\n",
> +					le32_to_cpup(ptr));
> +		else
> +			return snprintf(buf, PAGE_SIZE, "%u\n",
> +					*((unsigned int *) ptr));
> 	case attr_pointer_atomic:
> 		if (!ptr)
> 			return 0;
> @@ -308,7 +312,10 @@ static ssize_t ext4_attr_store(struct kobject =
*kobj,
> 		ret =3D kstrtoul(skip_spaces(buf), 0, &t);
> 		if (ret)
> 			return ret;
> -		*((unsigned int *) ptr) =3D t;
> +		if (a->attr_ptr =3D=3D ptr_ext4_super_block_offset)
> +			*((__le32 *) ptr) =3D cpu_to_le32(t);
> +		else
> +			*((unsigned int *) ptr) =3D t;
> 		return len;
> 	case attr_inode_readahead:
> 		return inode_readahead_blks_store(sbi, buf, len);
> --
> 2.9.0
>=20


Cheers, Andreas






--Apple-Mail=_C93D473D-5749-4058-B51D-09805EDD47E7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlsr5RQACgkQcqXauRfM
H+CP/BAAposFKM14Olv6fh+b6UclqOHR8MbfNo8ihie1dSxlWTvZQSzytRJiOueh
J76d2Hs1eXBT40Q7SFeeoP4CYwPW/mafKsHBaYxkY+D9bnMzCan0S12XWyHz4Tw0
RKiC706NbkAYg/BsL/r0UxOu66zEs/mIbO8CbXBMXzOb5D5W5/WA40Gc7jALLCf2
m+bAFqb16flJsp7mrC8tuLi8iVflqK4pGu5p1WJI8wsvwB1cmF0PwvixMkhYeDpf
cvjQP3aisJjHW3CAAxjPPKhCF0omEwQumXpu+SyqnldOqcrZ0pUyL1LC8b4fJJcM
k3SkbCWT+AgTpOYkAayzM5D93osDeYN+vpoIV9kC7X71UOGQrgtEw5VZGhSiWtQ+
F2WadBxG5ekJio364V7tJ/+Gs96cqCtsamAnSdIKDan2PcBi+/ZoQj5XRJjfKSCV
1oB2SSeyeHEWqQxGZ8snErnFpJr0fK903XAlnOV65T8ZGkCp8uZOkfD7Gr1n7ifp
zsx5tVm92iMbhTMXQshN5OeAsVucKCjeIKPzT+bbBwG+F+/ND8pQSksUoPzM/0QO
58Rb+jtngDXf2T+BhybD8kQrs3lbtEywxWl9o2b9MQKzl6dbcu6eXCzvrvcUd2j4
UgKEzp5tO+qxbCXcZGKMn3LXNQ2XjkjMauwq7295JjgwDh9gMbQ=
=fV5z
-----END PGP SIGNATURE-----

--Apple-Mail=_C93D473D-5749-4058-B51D-09805EDD47E7--
