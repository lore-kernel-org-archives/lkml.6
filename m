Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeCPXFJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 19:05:09 -0400
Received: from anholt.net ([50.246.234.109]:49586 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeCPXFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 19:05:06 -0400
From: Eric Anholt <eric@anholt.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/vc4_validate: Remove VLA usage
In-Reply-To: <20180313143151.GA27486@embeddedgus>
References: <20180313143151.GA27486@embeddedgus>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Fri, 16 Mar 2018 16:05:03 -0700
Message-ID: <87y3irvcyo.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> In preparation to enabling -Wvla, remove VLA. In this particular
> case use macro ARRAY_SIZE so the length of array _bo_ can be
> computed at preprocessing time.
>
> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> or a security flaw. Also, in general, as code evolves it is easy to
> lose track of how big a VLA can get. Thus, we can end up having runtime
> failures that are hard to debug.
>
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/vc4/vc4_validate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4=
_validate.c
> index 2db485a..eec76af 100644
> --- a/drivers/gpu/drm/vc4/vc4_validate.c
> +++ b/drivers/gpu/drm/vc4/vc4_validate.c
> @@ -753,7 +753,7 @@ validate_gl_shader_rec(struct drm_device *dev,
>  		28, /* cs */
>  	};
>  	uint32_t shader_reloc_count =3D ARRAY_SIZE(shader_reloc_offsets);
> -	struct drm_gem_cma_object *bo[shader_reloc_count + 8];
> +	struct drm_gem_cma_object *bo[ARRAY_SIZE(shader_reloc_offsets) + 8];
>  	uint32_t nr_attributes, nr_relocs, packet_size;
>  	int i;
>=20=20
> --=20
> 2.7.4

It's a shame that the compiler is warning about this when it's obviously
a compile-time constant.  Regardless, reviewed and applied.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqsTZ8ACgkQtdYpNtH8
nug9bRAAjIn9pFHNaYECvcVFU6UJG/EKYMUvognThedYEk8I6Lak8CeFI8nZMXfx
QyAphxjxCSn9LFbxHQ28RjuWGztOP44EHjDvpesKFThHSjQnoAhfiC5/WYFUOMqK
4PK12fMtXMhGWLRIkIzUYUWer2q4Dkf6oeRTkwyu8WJfJ8xsAx1pcUCXw1m4kWdW
vh5pK0lDJ+eXAVn0SWHx4RXFmF7iEyh5JuqbkjlKjylW5V5Rquy4vZKxTHw3jwBG
JCLoi7c4iRPFwlTJTFgTYMA5dwJv1XKhXMVMxAQcrnCnCZFY0D8NA7PmgVPXSXyB
SWOMUAOr5OqLnd5OcAFlqglBGJZOAJOKJdl/Rb3tNkPGke5E5hICH67vdrimldLc
ZIrDRGTS4Fjq2gaQ6phorV3Ade1S8nqX0RonoOQnAedl3W923lURhj5RciEylEiS
yJvU7kunhzsdfPbOdVWZozoj+BqssCKgxiD+T96I3vy4XP2R+8gSjFFkiSaNzibL
EF1+NaCd7JESRld2jEolMYbLHtrrXOSqlfw2HAQV+lzqjXWby3NO7v2hzLti7Wmj
3nHIYEXko/sKS73Zk4MJ0LiMQI/DfsnAF6EQzGXVO7uohHDBIqZUZzmdC+UE/c68
wN6EyKbWp2mOchlae3HDUg7jLBMbwHFxwsU1RhtKTLCudjtrObM=
=NzNK
-----END PGP SIGNATURE-----
--=-=-=--
