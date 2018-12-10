Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D50BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C232084D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fBjjGifZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C232084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLJFPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:15:00 -0500
Received: from ozlabs.org ([203.11.71.1]:53391 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeLJFO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:14:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CrqM5GsMz9s4s;
        Mon, 10 Dec 2018 16:14:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544418897;
        bh=AxzeHxg/RqE+kYQLcllnfO6vlswPcINpAcSx74MdbLM=;
        h=Date:From:To:Cc:Subject:From;
        b=fBjjGifZixFjQc2lT7IjAGRNjpyafsnrZFlJzftJ0HmQYUMqeJZGN3+n7XeaXNbGA
         m1Jo9lpoz2Tzk9dB+NAqiNeqnIIymzVA7JgW8R+hr71xe1gGjbkgJcQIbfd+9IHWVC
         5bdcUz/lFGZvnNqvio1BVZZTLf16ZHfT8BOAwVgL/T5l8woYuobJqFWgQg/uevjjD+
         jACuMWd8y0kd9RoIhw2AXKwfhk6hXlnx9Mt/HDXwo+hy/F95WHCi7ynZlw+UfXPKmx
         sV3WPMdTvegasSu1/mvTmXymvwiTrsmGKE1sLIQGRbxdZx6JcTrhoFED0l8heXqPVV
         VF9BzFEnY5N3Q==
Date:   Mon, 10 Dec 2018 16:14:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: linux-next: manual merge of the driver-core tree with the pm tree
Message-ID: <20181210161454.1c8ca97f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GFox2QnFl7jy/bYo5QoCNtH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GFox2QnFl7jy/bYo5QoCNtH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  drivers/base/platform.c
u
between commit:

  2d51ac9086fd ("driver core: platform: Remove duplicated device_remove_pro=
perties() call")

from the pm tree and commit:

  99fef587ff98 ("driver core: platform: Respect return code of platform_dev=
ice_register_full()")

from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/base/platform.c
index 0fb5f140f1b0,e1ba610482c0..000000000000
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@@ -447,7 -447,8 +447,7 @@@ void platform_device_del(struct platfor
  {
  	int i;
 =20
- 	if (pdev) {
+ 	if (!IS_ERR_OR_NULL(pdev)) {
 -		device_remove_properties(&pdev->dev);
  		device_del(&pdev->dev);
 =20
  		if (pdev->id_auto) {

--Sig_/GFox2QnFl7jy/bYo5QoCNtH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwN9k4ACgkQAVBC80lX
0GzwiQf9F94ki0jSuhlmKg36TIsKQWGgSgfPcxiJCNldyURKVy06OvL22wOB+9Bv
dGxV3LK3s5JbwzAP1lw0i52RhY8nHt4Nz0j0xwZkoVM6B6igQLkeJOfXApzed4W0
NWCYcxMn1qaDLL3nK4H+a2PlwmU+6X6LV0XcwWJ4QOKy5Qo8Dyy8FwLfvA2QSO/D
Qb13eAZhwH2PDNX1YDMy+3RAdD14yNJVZDHhElsM4tGJyOWVez49ATLoTztFkbM+
w1Y9PvguyUGrbgzNL03nkyl10NqFoAiHyCOB9n2eNXWM6EzrJAjwrVcPVi/jDGY9
i/9PH4V0OfnAbhvzK47WN8sJezTSdQ==
=INHs
-----END PGP SIGNATURE-----

--Sig_/GFox2QnFl7jy/bYo5QoCNtH--
