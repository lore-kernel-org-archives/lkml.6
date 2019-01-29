Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDACC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E98B2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOB9iMGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfA2KPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:15:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38953 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA2KPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:15:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so17031957wmi.4;
        Tue, 29 Jan 2019 02:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EBCYi6r22cn+0LrGfkpIA5np/DMvwqkE0M2+eH0iYEI=;
        b=pOB9iMGk0DN+xvvl/yVSCaAloAmQO7jnj6kkOzeu8y/YrWDXyKxZMA0rsPMB62DpgX
         heYi85aFlshQzdxkmQdZbDCZ3IIqd57gCJtfdi5T+otQNeUDeZOT71ma4StnEXk3tgm9
         gXHBSgHq0uGESBfwhcfsNuvWnMZFIBaaiv+L20zqup2OVg1/poomghlWB8jeOj/mEHj1
         ghIBBlYrxojHFtFr7tiVgWIXErtYdvIEnFlJlIt++Tn41eqC1RWLIKi9GANbvUDXoK3M
         ByvPNL4ReCyNaj00Q7yHMT4FfhVGFaEpOUc3EpAZ8lSecEqDcXkyoiYdrePPh7zOXjac
         7GxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EBCYi6r22cn+0LrGfkpIA5np/DMvwqkE0M2+eH0iYEI=;
        b=s9Dkd2MeQidio+D0G+Dq3firqLjydjQ+v6EAigW3OD2kayp6vRtpIj8r/wga5iNvoc
         3tUXnvWOizuNXwnUOFMf4gsOiJciiVXCwCZOxev+82aaabKTeGmSi5o7mR1U0+FwzP3y
         AOd8EmXkjSa7IpoZv0RjbKAdZdua7RpuqlDa6T063W0mZJbmElpt8x118N1EDnisjqPh
         6/87J/qM0bHhqhxfgttFH1JGq01p7cvsZdx01x4pir1mIonG/TmcIHbslw0g5ExbVpS4
         ywiaKJUYE9aQUOaGFNd3kW/MHMag2G6W/9yifFcVsPHOwMfpDecIFY1qiijecNhpwHbK
         Ptcw==
X-Gm-Message-State: AJcUukeS3sXB5dzKbvMTwHY5Ba3oSew8n4FEMqUnZRmBQFjoX7ZDFCYF
        kQ3sq2i1CxE59TBvRGWW9A8=
X-Google-Smtp-Source: ALg8bN7FfeYRHfuwEeOEeqUig6XHx251oxYjky/CtCxXS+EJOleZk3TB3wOeSwJ8nzUGEet3/V3WPg==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr21939799wmk.74.1548756907337;
        Tue, 29 Jan 2019 02:15:07 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b129sm1235602wmd.24.2019.01.29.02.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 02:15:06 -0800 (PST)
Date:   Tue, 29 Jan 2019 11:15:05 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V3 2/3] i2c: tegra: Update transfer timeout
Message-ID: <20190129101505.GA28850@ulmo>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-2-git-send-email-skomatineni@nvidia.com>
 <0cf91475-f77d-7453-deb6-3dd91b63aeb6@gmail.com>
 <BYAPR12MB3398E9D32B57B0E2FC2A6466C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
 <c0b36535-6767-7327-5dc5-612e6957a769@gmail.com>
 <BYAPR12MB339837E896774531B0D11A98C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
 <2f3cab66-7424-1b33-976f-826877623726@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <2f3cab66-7424-1b33-976f-826877623726@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 01:27:09AM +0300, Dmitry Osipenko wrote:
> 29.01.2019 1:15, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >=20
> >=20
> >>>>> Update I2C transfer timeout based on transfer bytes and I2C bus rat=
e=20
> >>>>> to allow enough time during max transfer size based on the speed.
> >>>>
> >>>> Could it be that I2C device is busy and just slowly handling the tra=
nsfer requests? Maybe better to leave the timeout as-is and assume the wors=
t case scenario?
> >>>>
> >>> This change includes min transfer time out of 100ms in addition to co=
mputed timeout based on transfer bytes and speed which can account in cases=
 of slave devices running at slower speed.
> >>> Also Tegra I2C Master supports Clock stretching by the slave.
> >>
> >> Okay, I suppose in reality this shouldn't break anything.
> >>
> >> Please explain what benefits this change brings. Does it fix or improv=
e anything? The commit message only describes changes done in the patch and=
 has no word on justification of those changes. Transfer timeout is an extr=
eme case that doesn't happen often and > > when it happens, usually only th=
e fact of timeout matters. If there is no real value in shortening of the t=
imeout, why bother then?
> >=20
> > Original transfer timeout in existing driver is 1Sec and incases of tra=
nsfer size more than 10Kbytes at STD bus rate, timeout is not sufficient.
> > Also Tegra194 platform supports max of 64K bytes of transfer and to all=
ow full transfer size at lowest bus rate it takes almost ~5.8 Sec.
> > In cases if large transfer at low bus rates 1 Sec timeout is not enough=
 and in those cases transfers will timeout before it waits for complete tra=
nsfer to happen.
> >=20
> > So this patch uses transfer time based on transfer bytes and bus rate.
> >=20
>=20
> Please add that to the commit message.
>=20
> And then seems you also need to set I2C adapter timeout to a some
> larger value. Currently Tegra's I2C doesn't explicitly specify the
> "adapter.timeout" and I2C core sets it to 1 second if it is 0.

I don't think adapter.timeout is the same thing as the timeout that
we're dealing with here. adapter.timeout is only used as a way to retry
on arbitration lost conditions. So, as far as I understand, if we try to
send a message to an I2C slave and we loose arbitration, we'll keep
retrying for one second before finally failing. I wouldn't expect these
arbitration lost conditions to happen right in the middle of a transfer,
but rather at the beginning already, so I'm not sure arbitration could
even be lost after, say, 2 seconds into a very large transfer.

All of that said, it seems like i2c-tegra doesn't respect the protocol
for making this arbitration loss retry work in the first place. We
should be returning -EAGAIN if we detect arbitration loss, but I don't
see that we ever return that. We should probably fix that in another
patch.

Thierry

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxQJ6YACgkQ3SOs138+
s6G/IxAApCkLSlD9ft/tM34BpBPzUo1bHW85AEKvygq3sJeLEfLVj7y+lGpQZlb9
S4168g2cgkMVNNRZhtwhoTxZI3R4vgwz7mjciBp8hcxQ2H0AI99t4+4ogXPVNdXh
GfA8CZzLCSoGL9X4G8giKhJ7ciN1kJJXrHJwNVJwG45Ah9X30TH5sgxifUK9PWV9
MxdM5s4YPZ0OB2BFW8vgqdUy87Jpu1E/Js/tVOJIcDji7hGNom3b9lmJ7JjHbjsf
Kb2dGaUPmLprnYjxOBiFXW+f/IfXtz0BeBs18zxpN1pqQKHKBiFX196vKwdzlEUH
RbkadHCjdy77c1Qq7uivz5oAQuEbz1hBNcEeHPWyNWFnNRmSyGeLhAhaKoTgh8lI
xwsxEDwmZ0h55WFHXjeCyuIex68/c4X6a+r5navEjl8iCkAwoJDOJKm6vps5tVBE
VP2nPdMLLSP6yW/C2ggWAkbFuyVwc6fPrITdNO8D+kd4SaQlj+arRtQjez+2sF9L
HgqbVxVjmlLoz5dbs5aSxNzL5FMUv8/vDiG9DYVKBpk1Ew7zqq+8doj1UjUgJm5f
d/+oKlxrHeuU/upeqEZGCvkSaKl7IF2rR9HAuM/2ynfWVtEYQPLeCc7Uv/LD4aMr
hbcVLXbdJMQ/10xhCJqST5H1bP9vKaHAQAcBor+/TWo1H5OIYl0=
=1kRD
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
