Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44671C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1202720855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="RcyNKegv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfAQRj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:39:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43479 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbfAQRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:39:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so5148679pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=MxPmZz4R2yQgWVxIAO5ncLQeMMGtsBsodny+XPCZIAk=;
        b=RcyNKegvmV/gNysqpotTyGQtMdmOw+9yPP4T+VrvTAtdpAkJzqmD1l5pyzZyic/LI2
         e6g2dyK6/9ruxA2+WFs/iwocr2oGQslXZ9rhULXui8f8BRze2y3kN/M/yr1cmEGYV15a
         CUBkOOo8rjzDW6q4UTv56duSoqAoM7VYhO3lKMpCCWWWljtu+OwH72GDanS9rTcdcNK2
         RyXU85UCOrp+7xXjOPyP8jQeQYCktaD3Otlw3rLWZQECHgq36/s6Ywf2mlQ5ReO/LzUi
         ZrjkXTgsRNYfy1GBo2T8tFzKxqx3+E9VBBCQL7m/LWhuJCiZNvaE9vH9zSQnxjYyJIG7
         RwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=MxPmZz4R2yQgWVxIAO5ncLQeMMGtsBsodny+XPCZIAk=;
        b=V0eFZUYd4OQVpgRMyd8wnoLRlTTrmTU1Y9tZV4OCH+U9LVBQp7IVxvCmGp9ZJYCfmv
         /BnyTifynleLWRqjzcacGQcT3ALiH527H6+WD3Afon75wOWXqvzvued77GmJT1RARR7G
         cIakJxLoCNevwbbS823AVeealS4xSLwNKG3VhU6NR1kDMAHqEQlWlYKGzIRiVLyln1N/
         KN8X267VPHtwxoNEmzfYTh/UUlyKiKaV5vEnSoNNc1K+Qs3/8GtYQwR+U8RVZq9mDp0A
         Iy5BoA2LN86MKZ0ZibDbfAMcUGJyGoq8TE8jKdy1UxpfotPxsrYVJq410LCVk0m7t37l
         H1vw==
X-Gm-Message-State: AJcUukexysctlrxHqNTg0yNAQftNxuUnQCmLBiWKgNNYcnHW82d0+Evr
        CzX0rWjbjDQ6tfKzJP3bP4zjyw==
X-Google-Smtp-Source: ALg8bN4zXhVMawort23Rzpe3zhmUc6Ujlilgb5odRrGD1TkdOoLyz3+YfF5znf2riZhC51WICk9MIw==
X-Received: by 2002:a63:7418:: with SMTP id p24mr14398305pgc.196.1547746797199;
        Thu, 17 Jan 2019 09:39:57 -0800 (PST)
Received: from [172.20.10.10] ([24.114.37.93])
        by smtp.gmail.com with ESMTPSA id v184sm3327596pfb.182.2019.01.17.09.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 09:39:56 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <AA89ABC5-E584-4E1B-A446-FA358FAB16F5@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3CEE76E5-543F-4C96-AD6E-683E09880B53";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: annotate implicit fall throughs
Date:   Thu, 17 Jan 2019 10:40:16 -0700
In-Reply-To: <20190114203945.20233-2-malat@debian.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
References: <20190114203945.20233-1-malat@debian.org>
 <20190114203945.20233-2-malat@debian.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_3CEE76E5-543F-4C96-AD6E-683E09880B53
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jan 14, 2019, at 1:39 PM, Mathieu Malaterre <malat@debian.org> =
wrote:
>=20
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=3D1). Fix them up.
>=20
> This commit remove the following warnings:
>=20
>  fs/ext4/indirect.c:1182:6: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>  fs/ext4/indirect.c:1188:6: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>  fs/ext4/indirect.c:1432:6: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>  fs/ext4/indirect.c:1440:6: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>=20
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/indirect.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index bf7fa1507e81..c2225f0d31b5 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -1183,18 +1183,21 @@ void ext4_ind_truncate(handle_t *handle, =
struct inode *inode)
> 			ext4_free_branches(handle, inode, NULL, &nr, =
&nr+1, 1);
> 			i_data[EXT4_IND_BLOCK] =3D 0;
> 		}
> +		/* fall through */
> 	case EXT4_IND_BLOCK:
> 		nr =3D i_data[EXT4_DIND_BLOCK];
> 		if (nr) {
> 			ext4_free_branches(handle, inode, NULL, &nr, =
&nr+1, 2);
> 			i_data[EXT4_DIND_BLOCK] =3D 0;
> 		}
> +		/* fall through */
> 	case EXT4_DIND_BLOCK:
> 		nr =3D i_data[EXT4_TIND_BLOCK];
> 		if (nr) {
> 			ext4_free_branches(handle, inode, NULL, &nr, =
&nr+1, 3);
> 			i_data[EXT4_TIND_BLOCK] =3D 0;
> 		}
> +		/* fall through */
> 	case EXT4_TIND_BLOCK:
> 		;
> 	}
> @@ -1433,6 +1436,7 @@ int ext4_ind_remove_space(handle_t *handle, =
struct inode *inode,
> 			ext4_free_branches(handle, inode, NULL, &nr, =
&nr+1, 1);
> 			i_data[EXT4_IND_BLOCK] =3D 0;
> 		}
> +		/* fall through */
> 	case EXT4_IND_BLOCK:
> 		if (++n >=3D n2)
> 			return 0;
> @@ -1441,6 +1445,7 @@ int ext4_ind_remove_space(handle_t *handle, =
struct inode *inode,
> 			ext4_free_branches(handle, inode, NULL, &nr, =
&nr+1, 2);
> 			i_data[EXT4_DIND_BLOCK] =3D 0;
> 		}
> +		/* fall through */
> 	case EXT4_DIND_BLOCK:
> 		if (++n >=3D n2)
> 			return 0;
> @@ -1449,6 +1454,7 @@ int ext4_ind_remove_space(handle_t *handle, =
struct inode *inode,
> 			ext4_free_branches(handle, inode, NULL, &nr, =
&nr+1, 3);
> 			i_data[EXT4_TIND_BLOCK] =3D 0;
> 		}
> +		/* fall through */
> 	case EXT4_TIND_BLOCK:
> 		;
> 	}
> --
> 2.19.2
>=20


Cheers, Andreas






--Apple-Mail=_3CEE76E5-543F-4C96-AD6E-683E09880B53
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlxAvgEACgkQcqXauRfM
H+BP9A/8DbKt+WfBFRnHtNjx9+PBz8yHUWwBEUhYKNgsjK5cJwFFl94UTyQRvptJ
vbzf34zg/Sig0aOs3atB6abBHPHAeklnpcSGnTUNZFN2FqvKgu4yqdkTRHHm0l6t
Wb4o+RGm1kTiOh85Ap4ubhof2476lhgBH2wxsSZ4CzKr5BdJfaC60ODPHIW37yx0
Ey0YdQ+HhR2ciepCkfAamayd7H2YRdF0aGELD9wzhIwzD2rXNk7ye7wZ1U24EBnm
iXSq8UG/EZafaXey6bHbc8PR98watqp2SOOXPn0Uaz2co8wLEbwaTkUtgGzqweyz
b8eS3fmQEaeK+a3DdVIlZgWt0dllWjohRXiXVoMpYPehVPPxbnQ8bMNfH0u17tn+
KkEK7iJVaXcFpganNXk8wvyYs6ZIjeJDpWGH6UpLGlrcrKXP2w8xWMkzoElAPbog
kHVr2qQ+R1Nw0pCmoVd8Y2emeqv+WLhI9WQD2P9mWjxZqPcFamcgET/Z+rKS0e9l
u7KR4HLu+jjVc38Rzyqh5suYmYRjMWBK6xOOpF4ZNXIHFDzM2O4b7aWwOdCtnpz5
k/QPbZnf5eSTBlvuO6VkIhlSKOTP8gQYNyIEfcLQiM6xPVgGkkWGtWHQLFkxpRGj
R0eTfYxfshT/RPZY/K88X12EXPPfa19VC1yX3g8M1TRbkE+wdTQ=
=5WcX
-----END PGP SIGNATURE-----

--Apple-Mail=_3CEE76E5-543F-4C96-AD6E-683E09880B53--
