Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E1C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D7421785
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D7421785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFURPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:15:23 -0400
Received: from anholt.net ([50.246.234.109]:56306 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750980AbeFURPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:15:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7695E10A1642;
        Thu, 21 Jun 2018 10:15:21 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id e-9xvaScff9s; Thu, 21 Jun 2018 10:15:20 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 24D4210A0D3A;
        Thu, 21 Jun 2018 10:15:20 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 981F52FE2FF0; Thu, 21 Jun 2018 10:15:19 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Define the fourcc modifier for the Broadcom UIF format.
In-Reply-To: <20180621065359.GE19791@phenom.ffwll.local>
References: <20180621001703.13522-1-eric@anholt.net> <20180621065359.GE19791@phenom.ffwll.local>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jun 2018 10:15:19 -0700
Message-ID: <87vaaccb88.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Daniel Vetter <daniel@ffwll.ch> writes:

> On Wed, Jun 20, 2018 at 05:17:03PM -0700, Eric Anholt wrote:
>> This will be used by Mesa, and potentially other drivers in the
>> future, to describe tiled buffers.
>>=20
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  include/uapi/drm/drm_fourcc.h | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>=20
>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc=
.h
>> index 64bf67abff7e..d5e52350a3aa 100644
>> --- a/include/uapi/drm/drm_fourcc.h
>> +++ b/include/uapi/drm/drm_fourcc.h
>> @@ -464,6 +464,27 @@ extern "C" {
>>  #define DRM_FORMAT_MOD_BROADCOM_SAND256 \
>>  	DRM_FORMAT_MOD_BROADCOM_SAND256_COL_HEIGHT(0)
>>=20=20
>> +/* Broadcom UIF format
>> + *
>> + * This is the common format for the current Broadcom multimedia
>> + * blocks, including V3D 3.x and newer, newer video codecs, and
>> + * displays.
>> + *
>> + * The image consists of utiles (64b blocks), UIF blocks (2x2 utiles),
>> + * and macroblocks (4x4 UIF blocks).  Those 4x4 UIF block groups are
>> + * stored in columns, with padding between the columns to ensure that
>> + * moving from one column to the next doesn't hit the same SDRAM page
>> + * bank.
>> + *
>> + * To calculate the padding, it is assumed that each hardware block
>> + * and the software driving it knows the platform's SDRAM page size,
>> + * number of banks, and XOR address, and that it's identical between
>> + * all blocks using the format.  This tiling modifier will use XOR as
>> + * necessary to reduce the padding.  If a hardware block can't do XOR,
>> + * the assumption is that a no-XOR tiling modifier will be created.
>> + */
>
> I think for as long as a modifier is only for a specific SoC, and not e.g.
> also meant for pci devices, it's perfectly fine to heavily rely on
> platform specific "every block agrees" language like here. We do the same
> for intel's X/Y tiling on older chips (latest gens stopped doing funky
> swizzling because the memory controllers seem to be better).
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Yeah, this is very similar to the Intel swizzling.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlsr3ScACgkQtdYpNtH8
nuikLQ/8Dvwuc/DBTy5ZyZTbuYxZnR3pGqEzr0pJ631kLQSUL/JtpLpBEYThJqLA
ABPYquxO96soM4vYk9CgyUlsVpZ8JrcBtlBr1NOHm7yMtN9E5yy5shOTbKuS6XPG
63oWISiw+0QYsgsXqkif5rV21um/1qtNNnGFYfcDwVHSSogFgfMZwDwI8qxNT/CS
Op/uv3h4GQiFIA2LFH4bqLi+YpyvANJ4lLSpJUfUZzdPH0lXWl9eX571mbuuqCHQ
eeDkEAbFM6/e47vfuxcvyxAMYHX8itSBAVekPIQXxQ+sNh6ygpMUw845TJb15JSt
IPM+gNYcviJuGlPGg7N90uDY9FexjYoUJO+zkqR+kGhZ0GjObjFd514MfZHP0jvx
v5wv8OS2+n/wQD1JvQJUmaHNT5D3canisSUpKiin7JQLTtM6Mwj5STV9sTy5ED35
tg4zWhPugBBs8APbp9feYG4d/HfEfpwu3rJmoz5xvgyJPYMpBSrGaoEL+QH5Yyfp
92gmmYeLKdwlZesTAZNYixgeBoDa67+r6fMi9053SRAlN1UNcAH+x2zGq0GUjrRV
h23IY3yKMRY30g5LM6+ibrDPA2pqa31IDa3ccNJsqva0vo3wkM43g37lL1FNwPp8
6sdFy5nqd3BwwA6CIke0vODzVg7+qLCVtWnilF6Moxe8Cocz+GA=
=4UgL
-----END PGP SIGNATURE-----
--=-=-=--
