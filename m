Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72065C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F78921925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfBOQhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:37:01 -0500
Received: from sauhun.de ([88.99.104.3]:34976 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfBOQhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:37:00 -0500
Received: from localhost (unknown [195.52.228.164])
        by pokefinder.org (Postfix) with ESMTPSA id 2D6B22E3551;
        Fri, 15 Feb 2019 17:36:58 +0100 (CET)
Date:   Fri, 15 Feb 2019 17:36:57 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jun Gao <jun.gao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Message-ID: <20190215163657.fs6t7p3vqez53su3@ninjato>
References: <20190215090202.157100-1-hsinyi@chromium.org>
 <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fynakfv4m43e4662"
Content-Disposition: inline
In-Reply-To: <20190215092500.6q3hqnoufyowiqaz@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fynakfv4m43e4662
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>> > Ok, I can add a check in another patch. Should we return NULL pointer
>> > if msg->len is 0 or print out some warnings? Thanks.
>>=20
>> No warning, msg->len =3D=3D 0 is a valid setting. But interesting questi=
on:
>> I was about to say NULL, but your driver would assume ENOMEM there and
>> discard the message which is also not correct since msg->len =3D=3D 0 is=
 a
>> valid setting. So, should we just return msg->buf then? Will this work
>> with your driver? Can it handle zero-length transfers?
>=20
> dma_map_single(i2c->dev, msg->buf , msgs->len, DMA_TO_DEVICE); breaks
> kernel if msgs->len is 0, so I think it doesn't handle zero-length transf=
er.

Please don't drop the lists.

Then, the correct solution is to forbid those transfer with this
controller. Check I2C_AQ_NO_ZERO_LEN. Also, update the functionality
like this .. (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK).


--fynakfv4m43e4662
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxm6qUACgkQFA3kzBSg
KbbsQw//TKz2pCmEj99gaTnI4oak75P3IW10Xow7DY8Bhv4KTJ6irOVHclR2WoL/
/o3ASwvfasg2jvE7JBhdZyMXtAs0GhlISv/02ZG3oJ6/i6gmPGlgAlgftFH2YWVg
xRWLmRaPJCUfEsN1RddKYGBLsdYrELNJLHNqCvKDvnxiM2eUH1o4KVPn908AlzQf
6XHzsGew3EW/2G470f0qimDDRPcFN00r7FdUnvM8+fGazP39VPCGb7BFk/cm8iss
RWitHJTHQehSLLN+yKkLS697feeiV83Qi+tj7tkVOL4HJvs4hrLssAndK4eaaoVu
TIzXgASGfmO5EC/srp3KqZFNaVHe8sGE8B2uAlS1cmArLfUCG0PirLdAzp6mmG9t
ExfPZOw7pUsaNRdPyiGLu2xD8u//d2WA6WDvPYiD5/2azHKE3Klv+YDvQZlexkpm
TqhD56l1ohbQmmEpNzC/a5giCZbOujXMrUgz/2C+JtNEIgcq71VBOPtsUOwaTLxP
npBZxZ4+Lmu0VdvgLa30VmpaFf9s24rhADLuJs9DWQrECIo5c/8CV19x3jupM3e1
+UkRz2Vt/J7RqeXhOY2lv4pPz9RTx3MJNgUZErVsGsqYhIkzqjVv5Kh2vmoPt2GV
fnYlXaiiWYoUX2JZ14OBvaHPJA7GqP3T2yJqEOeoLdIVmKYYcng=
=lS99
-----END PGP SIGNATURE-----

--fynakfv4m43e4662--
