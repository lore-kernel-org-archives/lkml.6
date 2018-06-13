Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 78CE4C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376B720891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376B720891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935089AbeFMBPm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:15:42 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:49040 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933125AbeFMBPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:15:41 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 057F53A313B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 02:58:14 +0200 (CEST)
X-Originating-IP: 70.80.172.8
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EE8C9C0003;
        Wed, 13 Jun 2018 00:58:13 +0000 (UTC)
Date:   Tue, 12 Jun 2018 20:58:07 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <Valentin.Vidic@CARNet.hr>
Subject: Re: [PATCH v2] staging: pi433: add mutex fixing concurrency issues.
Message-ID: <20180613005807.GB2265@hle-laptop.local>
References: <20180602175649.GA2816@hle-laptop.local>
 <20180607124216.GA2329@hle-laptop.local>
 <20180609081244.GP14048@gavran.carpriv.carnet.hr>
 <20180609154842.GB1826@hle-laptop.local>
 <20180612121107.xgxdqda5bzhqeizr@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20180612121107.xgxdqda5bzhqeizr@mwanda>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > case PI433_IOC_WR_TX_CFG:
> >         if (copy_from_user(&instance->tx_cfg, argp,
> >                    sizeof(struct pi433_tx_cfg)))
> >             return -EFAULT;
> >         break;
>=20
> Btw, it looks so wrong to me that we copy partial data to
> &instance->tx_cfg...  I'd really prefer copying it to a tmp buffer and
> then verifying it's corrent then memcpy()ing it to &instance->tx_cfg.

AFAIK this piece of code is not supposed to check passed tx config.
These checks are realised later by rf69_set_tx_cfg (called by
pi433_tx_thread) after the config has been written to the fifo by
pi433_write.

What kind of checks do you want to perform exactly ?

But, right, I prefer the idea of the temporary buffer too, and seeing the
rest of kernel code it seems to be the usual way to go.

Regards,
 Hugo

--=20
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlsgbBkACgkQLVy48vb3
khm69Af+LdHLS+TMk1DD4IyFMv4UX1sRwEDnX9GRhSEMmg2xOg5SS48yGBQKPJ7y
O79AWowM1bEkP+BfnTPPe+5+UgJ9+KXp1+ULtLlLMexRvD2TtvchR1gh0dw9B1Jm
3Rr/2CqQmwZEuMtW4o9tFqRjeCAb9BxLwGpAGNpwZypOb+Furvi9ou51qd9axBWQ
jhelFp7Lx5C6AwHi0N8CYce5LbsaCd8j6Bt8uEfhmDoxEhYEsY9LX+aOjahu5AOK
iyQwMbw/5qfHGD1ggzB5W+SY7Iamao+XXOncwc+gdZGz3qR5r9ttao/Y+ZsNhii0
Y76P1WGw9Ppkml44On59acliGWC30A==
=1PGh
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
