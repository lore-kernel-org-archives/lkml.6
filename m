Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE2AC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16903217B4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16903217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbeHMVWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:22:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:60636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729988AbeHMVWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:22:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F745AE0B;
        Mon, 13 Aug 2018 18:39:18 +0000 (UTC)
Subject: Re: [PATCH] reiserfs: fix broken xattr handling (heap corruption, bad
 retval)
To:     Jann Horn <jannh@google.com>, reiserfs-devel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20180802151539.5373-1-jannh@google.com>
From:   Jeff Mahoney <jeffm@suse.com>
Message-ID: <29083095-5e67-1b1e-f891-143ccd8a2bf2@suse.com>
Date:   Mon, 13 Aug 2018 14:39:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:63.0)
 Gecko/20100101 Thunderbird/63.0a1
MIME-Version: 1.0
In-Reply-To: <20180802151539.5373-1-jannh@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SroCWJhD4VSE7A9OkimW7U2HS75fGAzXM"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SroCWJhD4VSE7A9OkimW7U2HS75fGAzXM
Content-Type: multipart/mixed; boundary="w1F5p7mxh9Z0KEEIw5KfqLi6jRY4SGWHm";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: Jann Horn <jannh@google.com>, reiserfs-devel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <29083095-5e67-1b1e-f891-143ccd8a2bf2@suse.com>
Subject: Re: [PATCH] reiserfs: fix broken xattr handling (heap corruption, bad
 retval)
References: <20180802151539.5373-1-jannh@google.com>
In-Reply-To: <20180802151539.5373-1-jannh@google.com>

--w1F5p7mxh9Z0KEEIw5KfqLi6jRY4SGWHm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/2/18 11:15 AM, Jann Horn wrote:
> This fixes the following issues:
>=20
>  - When a buffer size is supplied to reiserfs_listxattr() such that eac=
h
>    individual name fits, but the concatenation of all names doesn't
>    fit, reiserfs_listxattr() overflows the supplied buffer. This leads =
to
>    a kernel heap overflow (verified using KASAN) followed by an
>    out-of-bounds usercopy and is therefore a security bug.
>  - When a buffer size is supplied to reiserfs_listxattr() such that a n=
ame
>    doesn't fit, -ERANGE should be returned. But reiserfs instead just
>    truncates the list of names; I have verified that if the only xattr =
on
>    a file has a longer name than the supplied buffer length, listxattr(=
)
>    incorrectly returns zero.
>=20
> With my patch applied, -ERANGE is returned in both cases and the memory=

> corruption doesn't happen anymore.
>=20
> Credit for making me clean this code up a bit goes to Al Viro, who poin=
ted
> out that the ->actor calling convention is suboptimal and should be
> changed.
>=20
> Fixes: 48b32a3553a5 ("reiserfs: use generic xattr handlers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Jeff Mahoney <jeffm@suse.com>

Thanks,

-Jeff

> ---
> Triggering the bug:
>=20
> root@debian:/home/user# mount -o user_xattr reiserimg reisermount/
> root@debian:/home/user# cd reisermount/
> root@debian:/home/user/reisermount# touch test_file
> root@debian:/home/user/reisermount# setfattr -n user.foo1 -v A test_fil=
e
> root@debian:/home/user/reisermount# setfattr -n user.foo2 -v A test_fil=
e
> root@debian:/home/user/reisermount# setfattr -n user.foo3 -v A test_fil=
e
> root@debian:/home/user/reisermount# setfattr -n user.foo4 -v A test_fil=
e
> root@debian:/home/user/reisermount# setfattr -n user.foo5 -v A test_fil=
e
> root@debian:/home/user/reisermount# setfattr -n user.foo6 -v A test_fil=
e
> root@debian:/home/user/reisermount# cat xattr_test.c
> #include <sys/types.h>
> #include <attr/xattr.h>
> #include <err.h>
> #include <stdio.h>
> #include <string.h>
> int main(int argc, char **argv) {
>   if (argc !=3D 2) errx(1, "bad invocation");
>   char list[10];
>   int res =3D listxattr(argv[1], list, sizeof(list));
>   if (res =3D=3D -1)
>     err(1, "listxattr failed");
>   printf("listxattr returned %d\n", res);
>   for (char *p =3D list; p < list+res-1; p =3D p + strlen(p) + 1) {
>     printf("list entry: %s\n", p);
>   }
> }
> root@debian:/home/user/reisermount# gcc -o xattr_test xattr_test.c
> root@debian:/home/user/reisermount# ./xattr_test test_file
> Segmentation fault
> root@debian:/home/user/reisermount#
>=20
> Result:
>=20
> [  122.071318] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  122.072334] BUG: KASAN: slab-out-of-bounds in listxattr_filler+0x170=
/0x1b0
> [  122.073173] Write of size 9 at addr ffff8801c43b474a by task xattr_t=
est/923
> [  122.074030]
> [  122.074223] CPU: 1 PID: 923 Comm: xattr_test Not tainted 4.18.0-rc7+=
 #67
> [  122.075050] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.10.2-1 04/01/2014
> [  122.076107] Call Trace:
> [  122.076453]  dump_stack+0x71/0xab
> [  122.076900]  print_address_description+0x6a/0x250
> [  122.077514]  kasan_report+0x258/0x380
> [  122.077961]  ? listxattr_filler+0x170/0x1b0
> [  122.078469]  memcpy+0x34/0x50
> [  122.078894]  listxattr_filler+0x170/0x1b0
> [...]
>=20
>  fs/reiserfs/xattr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
> index ff94fad477e4..48cdfc81fe10 100644
> --- a/fs/reiserfs/xattr.c
> +++ b/fs/reiserfs/xattr.c
> @@ -792,8 +792,10 @@ static int listxattr_filler(struct dir_context *ct=
x, const char *name,
>  			return 0;
>  		size =3D namelen + 1;
>  		if (b->buf) {
> -			if (size > b->size)
> +			if (b->pos + size > b->size) {
> +				b->pos =3D -ERANGE;
>  				return -ERANGE;
> +			}
>  			memcpy(b->buf + b->pos, name, namelen);
>  			b->buf[b->pos + namelen] =3D 0;
>  		}
>=20

--=20
Jeff Mahoney
SUSE Labs



--w1F5p7mxh9Z0KEEIw5KfqLi6jRY4SGWHm--

--SroCWJhD4VSE7A9OkimW7U2HS75fGAzXM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAltx0FAACgkQHntLYyF5
5bKA5g//VSQFckvKvMJtpPENxz3fbpTgjVnYbB84IZqnm+FIVOFzb1KAJ0quzsny
r+JpXuGNKph8vfZBu8H7fAuexdD1x3BL9bUwiCyyW8GgC4ozCXCsvdaNnrQ/M/by
v5cbz9/PXA3Hug0KIMchBruykOOI3JwZc0MDZZkSbBqDE3Ci6Dzfra1G7KPYlNlB
9W+exsLWoevNdoZOJx0z9sNQM1SvI+c21fNpgJUEzzddc1hB7J2CFk4P060/6Aio
VLp5i/Q5oA+yAWBLgivSrwfAKfrBst/ZLc0JqYEL4ylnFcgdSZbmZdx20dZ8JwTb
c8t2qM243CjYk7jyOHvJHtuNj0AAc06xQxFC+0AhdMsnPMuKhR4jVnVEamKJNi2e
BRTIvsDOl2ntqdUBi29yZ/AVkIL03iokj1OqBKUxCoPtjXjXFw7Ua0MmGKwFcYPm
lFh8HaPaUsmB03+rtDs2u9XSMxDJSF5J6V5AhnTW4J0Gl49ij5VkukcTTKmQEhS/
W4pQoMKhqK44PR+QyQKidgJnh25H82163saG2Pfnbm4MeoQCgjgoN0ZvyvPQ7wli
oAhTC+rKrRRrrxbrQMEyZCqvmxx25BNZkhS2y2ThITDSE5KsPy62haHB5lEo33JX
cJcNGlfrCEHer0hMIp2+oo8DevLqRoKH4P0cVKB4NiWr94uLKgE=
=j8Qr
-----END PGP SIGNATURE-----

--SroCWJhD4VSE7A9OkimW7U2HS75fGAzXM--
