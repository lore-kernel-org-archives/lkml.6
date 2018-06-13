Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A2AE7C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A81208AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A81208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935018AbeFMAtw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:49:52 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:59176 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934873AbeFMAtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:49:51 -0400
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id F37A43A13AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 02:37:09 +0200 (CEST)
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 181B5100003;
        Wed, 13 Jun 2018 00:36:48 +0000 (UTC)
Date:   Tue, 12 Jun 2018 20:36:17 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] staging: pi433: add mutex fixing race condition when
 accessing tx_cfg
Message-ID: <20180613003617.GA2265@hle-laptop.local>
References: <20180612011200.GB1794@hle-laptop.local>
 <20180612110230.dvqmcyisdwaynixj@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20180612110230.dvqmcyisdwaynixj@mwanda>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> We read the data from the user here and then we write it to the fifo
> in pi433_write().  We should be using the device->tx_fifo_lock so that
> we don't copy over the data at the same time we're writing it to the
> fifo.

Oh right, that makes the bug even worse.

In this case we don't even need to introduce a new lock, using
device->tx_fifo_lock should be fine. I'll update the patch.

--=20
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlsgZvkACgkQLVy48vb3
khnTcgf/TQQQCNinka6VClKLUfIebQJ385tfDxD4ggUyB+gt+llBOVaPqHUHVzo7
xKey2McFoLEQaRaYwSdj5uuBI4getT0oYCf2jQn+sHSLJhxf7OdJdzezUlA9dgcd
LRydvUhYauqRaQGKYuqpkgBLIqPy9GULMzPGTasS60nt3P3jiJCoNJcG8CRbZTxR
3xctA1UJnCtCBpL03Fl8Spr7Avw6J/doy+ITqEhS6Bt0IvqHNAJS6ol85whWPqfP
p13RWo17LPsAyFAXWDWMkHCtsi7x0lhh1DxuNHGYWsFAeAkri5bvkxImpcp9VzJo
a/eqVhxKY3EX0fD+2U4PSKMjGwNyVg==
=xsIr
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
