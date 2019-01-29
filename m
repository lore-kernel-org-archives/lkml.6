Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD727C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929F121473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALrB247C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfA2KQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:16:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36069 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfA2KQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:16:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so21370237wrp.3;
        Tue, 29 Jan 2019 02:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJBZpYc5FJEmeTWcrWVs52mx7hbWaDLyRWT3qQ+yfrQ=;
        b=ALrB247Cx/cYb7fN+DNiJA3qQQbBfgmMILjpMoAgPJ9WpcIyxH8AnDjDpw1QGj8n6J
         BnjMniZfEgLFrlQa30/9IOe4gHOa6TghPHfj9ulfPqtFzyHiLY2HDB9GkVkuap7yyt7R
         1/NbT4Bej+M+Z445eegvr19K+t+n4/4gNuWH8FKDlxp4Q5WDjzRFeYsz6l2Jy/wRgtvv
         3IlGOlR0QmigQau2PT03PEjBJ1tbgmeNoAdsLWIE4BztUbxyp8D78Ql7F7puGAytneSu
         6Lt9mmlXE3/LumI38jtuNWdNT2oteCpYGP0VRUi1w7H4d7ORymBGQsWo2wvVGAo6iCav
         GmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJBZpYc5FJEmeTWcrWVs52mx7hbWaDLyRWT3qQ+yfrQ=;
        b=ZAhWI7JUmvBjbWZ+J45HezZ2ppiX0D8qMVQqOzFgeyVlqi3UQPyWxDC8UsXr1qZ7wc
         5e1BGVQbZK2kZdHHVbmW2HODXp/mSKPP1WsNuCDZMgaEoUMCDePfVGYNHUFjvvl6U3Cd
         iLR0u2G0BoxaNg7Be4F2SLQvGygjtH9XqIAq5FU1Pakcz5gb0hazg1COdhk+dDxzWyfT
         SomBcFNQl1p7yglUqBwC7OVbrbMV7O/uT6NQS8RQu19n2YueUYmaznF8pXuSleo1O2kX
         MlGO2MgfcRvD4xlQulzwJF4XlpV2jBnWDm+nMqE64xpiFcu3qHjTTSsmjP6xa7+VQMcf
         uQrQ==
X-Gm-Message-State: AJcUukf61283iaVB7hVl+JCjH433/ZcDCrNnmGFHbo9HsMknaSYy6D3B
        Yd8wUc7s1CfYGEDAjS4OzSE=
X-Google-Smtp-Source: ALg8bN5op9uCOXNn156JaQ1ulTIB7r1WpM92SDtKEZChybAUVYOasi5El2eUrCK2RMVNG7HeTpLcPw==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr26788854wrr.67.1548757014303;
        Tue, 29 Jan 2019 02:16:54 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id f3sm3020110wmd.22.2019.01.29.02.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 02:16:53 -0800 (PST)
Date:   Tue, 29 Jan 2019 11:16:52 +0100
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
Message-ID: <20190129101652.GB28850@ulmo>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-2-git-send-email-skomatineni@nvidia.com>
 <0cf91475-f77d-7453-deb6-3dd91b63aeb6@gmail.com>
 <BYAPR12MB3398E9D32B57B0E2FC2A6466C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
 <c0b36535-6767-7327-5dc5-612e6957a769@gmail.com>
 <BYAPR12MB339837E896774531B0D11A98C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
 <2f3cab66-7424-1b33-976f-826877623726@gmail.com>
 <20190129101505.GA28850@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <20190129101505.GA28850@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 11:15:05AM +0100, Thierry Reding wrote:
> On Tue, Jan 29, 2019 at 01:27:09AM +0300, Dmitry Osipenko wrote:
> > 29.01.2019 1:15, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > >=20
> > >=20
> > >>>>> Update I2C transfer timeout based on transfer bytes and I2C bus r=
ate=20
> > >>>>> to allow enough time during max transfer size based on the speed.
> > >>>>
> > >>>> Could it be that I2C device is busy and just slowly handling the t=
ransfer requests? Maybe better to leave the timeout as-is and assume the wo=
rst case scenario?
> > >>>>
> > >>> This change includes min transfer time out of 100ms in addition to =
computed timeout based on transfer bytes and speed which can account in cas=
es of slave devices running at slower speed.
> > >>> Also Tegra I2C Master supports Clock stretching by the slave.
> > >>
> > >> Okay, I suppose in reality this shouldn't break anything.
> > >>
> > >> Please explain what benefits this change brings. Does it fix or impr=
ove anything? The commit message only describes changes done in the patch a=
nd has no word on justification of those changes. Transfer timeout is an ex=
treme case that doesn't happen often and > > when it happens, usually only =
the fact of timeout matters. If there is no real value in shortening of the=
 timeout, why bother then?
> > >=20
> > > Original transfer timeout in existing driver is 1Sec and incases of t=
ransfer size more than 10Kbytes at STD bus rate, timeout is not sufficient.
> > > Also Tegra194 platform supports max of 64K bytes of transfer and to a=
llow full transfer size at lowest bus rate it takes almost ~5.8 Sec.
> > > In cases if large transfer at low bus rates 1 Sec timeout is not enou=
gh and in those cases transfers will timeout before it waits for complete t=
ransfer to happen.
> > >=20
> > > So this patch uses transfer time based on transfer bytes and bus rate.
> > >=20
> >=20
> > Please add that to the commit message.
> >=20
> > And then seems you also need to set I2C adapter timeout to a some
> > larger value. Currently Tegra's I2C doesn't explicitly specify the
> > "adapter.timeout" and I2C core sets it to 1 second if it is 0.
>=20
> I don't think adapter.timeout is the same thing as the timeout that
> we're dealing with here. adapter.timeout is only used as a way to retry
> on arbitration lost conditions. So, as far as I understand, if we try to
> send a message to an I2C slave and we loose arbitration, we'll keep
> retrying for one second before finally failing. I wouldn't expect these
> arbitration lost conditions to happen right in the middle of a transfer,
> but rather at the beginning already, so I'm not sure arbitration could
> even be lost after, say, 2 seconds into a very large transfer.
>=20
> All of that said, it seems like i2c-tegra doesn't respect the protocol
> for making this arbitration loss retry work in the first place. We
> should be returning -EAGAIN if we detect arbitration loss, but I don't
> see that we ever return that. We should probably fix that in another
> patch.

Scratch that. Sowjanya's "bus clear" patch already takes care of that.

Thierry

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxQKBQACgkQ3SOs138+
s6G1ExAAoUu0MGAShYZQunkWDdEHOp6YC2wdKI6ZFdXYYFCDO03YYWz4vYdFWg3P
F5h6VZ/0iugVMWnaRZLl2IvDPJMgajBXNQikh3OMfmX63J3lTrY7OoRIT6xR80iH
aERxXV3jBod7F1fCfQyazXnqOQaX0SvsSTxIOOGwt/s7jgdqrpmj/M9LJc/l0QBa
rlrypR7Jx6CBnE9tyVhKMC8Hs3zKZai6DevIteswFKqp1aa0vBFeAMTHi+wSPgbY
QbuAKL/BeaR6alELOxoFCMzGFSn+JFhkFyJ0VLUFr3F6yT8OWtRr/RkM6hgWHc+v
E4VKqwW9pjBqg5Hvd68ykvNTBW/wCxLtcVHGKjuEVm1UaoeYO1gUE7elxJTGhq6P
MQN5/Uk6je2rSaIylq1rp8epG3HEmkgvqOtHPtNQ4Srd8yuiV5jvzZueQgGy2jk8
T4v70PZ25UiS8lviOY+PEyRuXlTGTCfChktM4onJsIimAqZfROFRqE2Y8gcZ8V71
5UlOT4fJ9N9pKaZwq26Qd665yeGBm393h+fppDsgxdu4/VWSlvIk3MdeM61jmHVO
LqcyPZtpFHQZ5zNp7eaySxNEdMYDyMfqp8QQvCloPZu8Ahs82tIZkl6eJVIoTMXG
fPSlVMfgyH5EX0mw1PuRnW69Jns6kupQJV+2RMA8hhazMGxqWXk=
=OcTh
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
