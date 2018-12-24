Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B9DC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5C021736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="jDV1Efyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbeLXSnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:43:14 -0500
Received: from narfation.org ([79.140.41.39]:35380 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbeLXSnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:43:13 -0500
Received: from sven-edge.localnet (unknown [IPv6:2a02:2454:8871:1700:6a17:29ff:fee0:e6ec])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id B2416110115;
        Mon, 24 Dec 2018 19:43:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=narfation.org;
        s=20121; t=1545676991;
        bh=zjF5yaZQYfE0iijVwtm8gX0Tqm2HDahy3USIIxAcMgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDV1Efygk+Ddz+l3FFuP4A0jOkxbN2aotc94KlHIOWVDdKbefnF6C8xn3WYuBqd/U
         rxIDe+35hnad9MJrPNTCFQfXDn2uDzcf1D6TNG1oW6Hpd9cH5ElMEP+idhCm/TQEjv
         nHkdYbM8TbELoLfQ576G7orOmrGcjymWYaSpUHi8=
From:   Sven Eckelmann <sven@narfation.org>
To:     b.a.t.m.a.n@lists.open-mesh.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Marek Lindner <mareklindner@neomailbox.ch>, kjlu@umn.edu,
        Antonio Quartulli <a@unstable.cc>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv/main: Fix check on return value of rtnl_link_register
Date:   Mon, 24 Dec 2018 19:43:07 +0100
Message-ID: <4059540.uxCivL65nk@sven-edge>
In-Reply-To: <20181224174926.20321-1-pakki001@umn.edu>
References: <20181224174926.20321-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7191841.mqxAbxXKxD"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7191841.mqxAbxXKxD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 24 December 2018 18.49.26 CET Aditya Pakki wrote:
[...]
> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> index 69c0d85bceb3..e0007f242823 100644
> --- a/net/batman-adv/main.c
> +++ b/net/batman-adv/main.c
> @@ -109,7 +109,10 @@ static int __init batadv_init(void)
>  	batadv_debugfs_init();
>  
>  	register_netdevice_notifier(&batadv_hard_if_notifier);
> -	rtnl_link_register(&batadv_link_ops);
> +	ret = rtnl_link_register(&batadv_link_ops);
> +	if (ret < 0)
> +		return ret;
> +
>  	batadv_netlink_register();

Uhm, but shouldn't the already initialized parts be unregistered/uninitialized 
in this case?

Rejecting this patch because this could cause a new bug.

Also "Fixes: " line is missing

Kind regards,
	Sven
--nextPart7191841.mqxAbxXKxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwhKLsACgkQXYcKB8Em
e0aocw/+OngTRNriOUuAUhqvFiEsEOd9cTfKSauh01enwW3ER+X/MT+kzuaLxOBa
NRj7UEOvqtZw+UumsTQgO1B6hs3SPHgTPQ5SceUCDcQ8kDOc+mni52x//9xGpEd2
mABnL/kAmDxpUcDTr3T/83qUAdxw/dwrhRhnmMGiA6UOXJK27ocsOsUr3fMNMt2a
KoUaWg2Stiovz0/pBDmbe9wJiQ4TLmtwLyCjSHo4sdGWGJJ733QDIhq3Ou+4kG4r
gj5RJbE3MtXkqAzj0bf/OEBM2QT21cgMVzgjynHv6o+rREZUgY7cyx3rpVEBzlX4
muODmEqYdyJ4IiNf7iygsfRc2Nh/JXUGaFZ1r2NwJhPnGgQ2J/q+NyqFlw1Obzwl
ZYKmaL+Ap2EGG30+ZiCQJ3Ccq0x27eEe2mIcW2JSk/guQBiZ/gv8ufeKyLdZwj44
eVqAeO3SBYY+1qVnWb96hmDtBANvc9MOiuFQ55l7PYMrUpAoHpfrK4u4RZsfxycw
l2qfIUtmIOOMM0o5gTwYwK8pEsV7OeNqr31R08xKUCntOVFcKYlZYGh/GkSgWATc
pRlMnmIkjbLHHpjCP7YaAa1GvsL5paOd6S+AUwpj9SXyDmR4jpTKeVRAhdkocJEe
im9TSDSKVJaSLdhaBXTmH30HFGMeOC7Mw5CZ01lNVJvuBQIWXPE=
=dQvc
-----END PGP SIGNATURE-----

--nextPart7191841.mqxAbxXKxD--



