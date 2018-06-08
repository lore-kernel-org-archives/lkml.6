Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MxhTEsFgGlsgEQAAmS7hNA
	; Fri, 08 Jun 2018 11:00:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 46C25608BA; Fri,  8 Jun 2018 11:00:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BBF0E602FC;
	Fri,  8 Jun 2018 11:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBF0E602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeFHLAL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:00:11 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:10342 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeFHLAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:00:09 -0400
Received: from tock (unknown [88.130.57.229])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 77DF719F5CF;
        Fri,  8 Jun 2018 12:59:40 +0200 (CEST)
Date: Fri, 8 Jun 2018 12:59:38 +0200
From: Alban <albeu@free.fr>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Aban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode
 for the cells list
Message-ID: <20180608125938.4fd457a0@tock>
In-Reply-To: <0fb0e8e9-e7b8-10c3-fcdd-399c73a33878@linaro.org>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
        <1521933899-362-2-git-send-email-albeu@free.fr>
        <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
        <20180417165420.423a691b@avionic-0020>
        <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
        <20180417180040.04f53495@avionic-0020>
        <20180418134119.2e587621@avionic-0020>
        <9f7d2987-b33e-79b5-ae58-2985fd7334e4@linaro.org>
        <20180418143243.3c23493c@avionic-0020>
        <e34619a4-e9b6-9945-a1cc-a3680aac6819@linaro.org>
        <20180418153440.187ed16e@avionic-0020>
        <d30656d6-f17e-6ed0-251f-2b59d02cd202@linaro.org>
        <20180607184155.6da38a01@tock>
        <0fb0e8e9-e7b8-10c3-fcdd-399c73a33878@linaro.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4e/V8.qtwWgCC02QHOtNyeP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4e/V8.qtwWgCC02QHOtNyeP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Jun 2018 18:03:16 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 07/06/18 17:41, Alban wrote:
> > AFAIU the only thing that we disagree on now is if the nodes
> > representing the cells should be direct children of the provider
> > or in a dedicated subnode. For the MTD case both solution would solve
> > the binding clash. I would really appreciate if the DT people could =20
> Am reluctant in changing the nvmem generic bindings for a special case.

Where I think the generic binding is fundamentally flawed, as this
problem will most probably appear again. But do note that my proposal
doesn't require updating the dts using the original binding, both are
still supported. I proposed deprecating the current binding because I
think it is flawed, but we could also "officially" support both style.

> Can you try this with your original subnode proposal:
> just pass the subnode node pointer in np of nvmem_config:
>=20
> ------------------------->cut<------------------------------------ =20
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index b05aa8e81303..c9621632bbfb 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -472,7 +472,11 @@ struct nvmem_device *nvmem_register(const struct=20
> nvmem_config *config)
>          nvmem->priv =3D config->priv;
>          nvmem->reg_read =3D config->reg_read;
>          nvmem->reg_write =3D config->reg_write;
> -       nvmem->dev.of_node =3D config->dev->of_node;
> +
> +       if (config->np)
> +               nvmem->dev.of_node =3D config->np;
> +       else
> +               nvmem->dev.of_node =3D config->dev->of_node;
>=20
>          if (config->id =3D=3D -1 && config->name) {
>                  dev_set_name(&nvmem->dev, "%s", config->name);
> diff --git a/include/linux/nvmem-provider.h
> b/include/linux/nvmem-provider.h index f89598bc4e1c..743345ffe2c8
> 100644 --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -49,6 +49,7 @@ typedef int (*nvmem_reg_write_t)(void *priv,
> unsigned int offset,nvmem_device_get(
>    */
>   struct nvmem_config {
>          struct device           *dev;
> +       struct device_node      *np;
>          const char              *name;
>          int                     id;
>          struct module           *owner;
>=20
> ------------------------->cut<------------------------------------ =20

That should work just fine to allow next to any kind of binding.
I'll do a new patch using this approach for the code side and leaving
the generic binding as it is.

Alban

--Sig_/4e/V8.qtwWgCC02QHOtNyeP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbGmGaAAoJEHSUmkuduC28bpsQAOMfOXhboUrCBmyohY7223ev
QVvZKeMaCg4/9f5Ask/+nW7GE2bng9aL3CPPcp5C8zzfDJW9VPtZ6aqdQBxOS/GV
7WwnKaIc3qzBvmIyqFWEoZal4dv2C+AUW58CpukTPSo+upgLPD+L6stoXMWTK4ek
c1GVu4EDLCov7W2HGrdXI12sx9d/9yIEyNn8GnQtQYuYU2dZnSDuIvKIL/qeRKP1
T9k7IDyneRHx4XIQj58wZll9UUYfE5PfkRx2mYGkxO8BttTFRHjtQIfgw9mmb3/s
KCwVyHQGjV0r6ixja0hEdczVz4VnRxmCs/Q58dF3FZDzfmKrPuXEphWTtjlouieK
sKZWtQ5ZcU2IcQ9YSjVojHczbO5wyWpIuhj9ZTOOsRn/BbfMKtm08+VvUlaw0s4L
pu7LNW066bCr/PxcDdTL8OPGvImrCQJABUFAiclw/OOyF/ZL93/+vrX2uDoHUZfe
MRhSKApkFholQ63q5pj+1Xutr4hSdEVLip500sAUVjdEz53xDqJJuHADlGHBpbu5
NEW+ic33Tdkga+tR7mseq/JRcB9tVmkBreea7ytulSx86At1GWgfUVNx+ni/DzcT
DNCDc5/Ia9BTKd1tuaSMXIghsdW++oIHZPh1tDi9DbC4IxdsjhMWyacAROXzoBmw
QfvuT4yaKCg6aldCYddf
=E5vJ
-----END PGP SIGNATURE-----

--Sig_/4e/V8.qtwWgCC02QHOtNyeP--
