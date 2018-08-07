Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE08FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9823B2159F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9823B2159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeHHAld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:41:33 -0400
Received: from orthanc.universe-factory.net ([104.238.176.138]:54450 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726521AbeHHAld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:41:33 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Aug 2018 20:41:30 EDT
Received: from [IPv6:2001:19f0:6c01:100::2] (unknown [IPv6:2001:19f0:6c01:100::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by orthanc.universe-factory.net (Postfix) with ESMTPSA id A0DFF1F627;
        Wed,  8 Aug 2018 00:17:20 +0200 (CEST)
Subject: Re: [PATCH 4.14 222/246] ext4: fix check to prevent initializing
 reserved inodes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
        Theodore Tso <tytso@mit.edu>
References: <20180801165011.700991984@linuxfoundation.org>
 <20180801165022.329322870@linuxfoundation.org>
From:   Matthias Schiffer <mschiffer@universe-factory.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mschiffer@universe-factory.net; prefer-encrypt=mutual;
 keydata=
 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
 mNagDQm6idBibmeHejD0zFE=
Message-ID: <0360c726-c139-345b-a478-82b33a7aa804@universe-factory.net>
Date:   Wed, 8 Aug 2018 00:17:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801165022.329322870@linuxfoundation.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0p6Rx2lXy1GO57c4J9dGs6YQzfSXg3D5e"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0p6Rx2lXy1GO57c4J9dGs6YQzfSXg3D5e
Content-Type: multipart/mixed; boundary="P1nSmdVm3pEvIydrOOrBtjiIk4qjFrfC0";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
 Theodore Tso <tytso@mit.edu>
Message-ID: <0360c726-c139-345b-a478-82b33a7aa804@universe-factory.net>
Subject: Re: [PATCH 4.14 222/246] ext4: fix check to prevent initializing
 reserved inodes
References: <20180801165011.700991984@linuxfoundation.org>
 <20180801165022.329322870@linuxfoundation.org>
In-Reply-To: <20180801165022.329322870@linuxfoundation.org>

--P1nSmdVm3pEvIydrOOrBtjiIk4qjFrfC0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable

On 08/01/2018 06:52 PM, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me =
know.

It seems this patch is still missing from the 4.4.y and 4.9.y branches.

Matthias


>=20
> ------------------
>=20
> From: Theodore Ts'o <tytso@mit.edu>
>=20
> commit 5012284700775a4e6e3fbe7eac4c543c4874b559 upstream.
>=20
> Commit 8844618d8aa7: "ext4: only look at the bg_flags field if it is
> valid" will complain if block group zero does not have the
> EXT4_BG_INODE_ZEROED flag set.  Unfortunately, this is not correct,
> since a freshly created file system has this flag cleared.  It gets
> almost immediately after the file system is mounted read-write --- but
> the following somewhat unlikely sequence will end up triggering a
> false positive report of a corrupted file system:
>=20
>    mkfs.ext4 /dev/vdc
>    mount -o ro /dev/vdc /vdc
>    mount -o remount,rw /dev/vdc
>=20
> Instead, when initializing the inode table for block group zero, test
> to make sure that itable_unused count is not too large, since that is
> the case that will result in some or all of the reserved inodes
> getting cleared.
>=20
> This fixes the failures reported by Eric Whiteney when running
> generic/230 and generic/231 in the the nojournal test case.
>=20
> Fixes: 8844618d8aa7 ("ext4: only look at the bg_flags field if it is va=
lid")
> Reported-by: Eric Whitney <enwlinux@gmail.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> ---
>  fs/ext4/ialloc.c |    5 ++++-
>  fs/ext4/super.c  |    8 +-------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>=20
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1397,7 +1397,10 @@ int ext4_init_inode_table(struct super_b
>  			    ext4_itable_unused_count(sb, gdp)),
>  			    sbi->s_inodes_per_block);
> =20
> -	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group)) {
> +	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group) ||
> +	    ((group =3D=3D 0) && ((EXT4_INODES_PER_GROUP(sb) -
> +			       ext4_itable_unused_count(sb, gdp)) <
> +			      EXT4_FIRST_INO(sb)))) {
>  		ext4_error(sb, "Something is wrong with group %u: "
>  			   "used itable blocks: %d; "
>  			   "itable unused count: %u",
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3103,14 +3103,8 @@ static ext4_group_t ext4_has_uninit_itab
>  		if (!gdp)
>  			continue;
> =20
> -		if (gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_ZEROED))
> -			continue;
> -		if (group !=3D 0)
> +		if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_ZEROED)))
>  			break;
> -		ext4_error(sb, "Inode table for bg 0 marked as "
> -			   "needing zeroing");
> -		if (sb_rdonly(sb))
> -			return ngroups;
>  	}
> =20
>  	return group;
>=20
>=20



--P1nSmdVm3pEvIydrOOrBtjiIk4qjFrfC0--

--0p6Rx2lXy1GO57c4J9dGs6YQzfSXg3D5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAltqGnoACgkQFu8/ZMsg
HZxLfBAA28d0lfOeipTqOn2rqS9QUJ0oAtXKsHl+wO4mptLQob3+x25nYtsvnksO
t1AUMpHJThRXn6asDhZyTsP43D42eezQxZyfIjbzCz4Btx200wHiFmuTE0rAc9gL
qi22jjWXjQA0/KUTDA6o+Qs9nikrQSHMEk0EaE2Oq1OJPBZcBpim/KERCdbpMl1N
1S19lylk1eydM6GLi7UmQb2V4C+mr5MEZrtc9V6mo/GymsKZrG3SABjERME+ciEQ
HOSfUDrjtMGUxgea+Sy/z+3b1AvEjIfPagkre2kvyz951CkSOuCi//wvA4X1akQY
kQ5qg9bu43Mhe4d3DXGbAKPZUjrv1QSRYKu2nYVSuguMZ793KEKdQ5hRLE26zAoD
j6PPnh4ieiyllnxdTOQH36IAvP1OQgDt+C0U38jfysC7F9tzxjqjpLrOAiVd1icZ
nq1r7fI4HiltMn0FBE0/UsRf+LDM6azRlCjDoBoxUHkkSblQLo3tuYCP4HsO7sm5
KOs/o19Oot0MQKEgrDDzOZ11sUkYhDd7/xaKdlAPQpHsjUlIk/3bcE6/HGWC82O2
BFQIjSbcCb+5pcSLqcFUxClWTKTfjB/OBfgKi6h4TevQVLdg5ygszOtn/TGYflEL
SqB5HTP+PoWZQD20sMdZxxEVLdd1ZXQglPHgEu9mJMJb6bfViG0=
=JbDc
-----END PGP SIGNATURE-----

--0p6Rx2lXy1GO57c4J9dGs6YQzfSXg3D5e--
