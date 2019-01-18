Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0309C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662F32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="YYs8P3Jg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfARTjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:39:01 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:60686 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfARTjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ywqisD/37Pgq7s/UlZuHwoL7VWtWj4NwcDSziimaMDo=; b=YYs8P3JgQrZNrbNy/ibGGHFhL
        guKf0aawsle3K2287wOg5CQgRj9b4AozFDfCQdr9WzN3Q6XRkFuDhS0aX6mPunmai2GGNsjdR7Bew
        usMo0FmQcUwljWJJJNx1I7YmjiHbcMwMToDYYy6xwztL1bxBY26cxSslJ8rSCFXRWI9rY=;
Received: from p5dcc388c.dip0.t-ipconnect.de ([93.204.56.140] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gkZye-0003Xe-6x; Fri, 18 Jan 2019 20:38:52 +0100
Date:   Fri, 18 Jan 2019 20:38:47 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Message-ID: <20190118203832.3be7975e@aktux>
In-Reply-To: <20190118183630.GX5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190116220429.9136-4-andreas@kemnade.info>
        <20190118154807.GV5544@atomide.com>
        <20190118181827.7163bee4@aktux>
        <20190118183630.GX5544@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zoeBvEPg.zuoTfvj4MUKxts"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zoeBvEPg.zuoTfvj4MUKxts
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 18 Jan 2019 10:36:30 -0800
Tony Lindgren <tony@atomide.com> wrote:

[...]
> til the next workaround.
>=20
> > That flags also causes the iclk being enabled/disabled
> > manually. =20
>=20
> Yes but SWSUP_IDLE for the interface clock to me currently
> just means:
>=20
> "manually enable and disable ocp interface clock"
>=20
well, if we want to manually disable it and not automatically,
we have to disable autoidle or it will be automatically disabled.

Disabling it manually when it is already auto-disabled (by autoidle) is
just practically a no-op towards the clock.

> and with your changes it becomes:
>=20
> "manually enable and disable ocp interface clock and block
>  autoidle while in use".
>=20
> So aren't we now changing the way things behave in general
> for SWSUP_IDLE?
>=20
Yes, we are, so proper testing is needed. But If I read those comments
it was always intended this way but not fully implemented because it
appeared to be more work like needing a usecounter (which my patchset
also adds) for that autoidle flag.

Regards,
Andreas

--Sig_/zoeBvEPg.zuoTfvj4MUKxts
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxCK0cACgkQfb1qx03i
kyRmeA//Q32OMXJrBz0h85xgjrdhARhbFnIPSR+K9/kxtLwakGqCC5/ufBdJsKJz
XMRpfQAhOURtCGkQlFNWNCKG/Mi38qw97TQ+iIXOKMpwpgGk6oMcC49qV98rjeKW
AX4EkQxeSD4mdV6keCxScvQbdvByiDRHEP4Yk85ZoFNdWQMUNga1FiHll2fqKuo3
FjzoNpJNi+MeQhTKUMVr6QwMJ7uk7SuLLFM/BsSxeKBDJl4qnrmCozlGVTG0Iz8Z
VXF12FLOic64yzqgqNNDVUiAxflM1mbBKC/uLbVEXyE9HgqannMgEgbtyGdfjMEZ
FGFdExXSTnpb8Q/XDAtJrVTR9b8XGGxdExZHYd6XQQgUPHDfd7VEXMgyVR1Vv4ao
+gU8sJIsZdwYc4dXkpCHFy0Kyk/XFVLMvMT5d/GQEX9ro5RVnxw7czNeWTPk81bJ
LRdAx7kMo4Ci1RPAmOL9AHYGJBSTScYOl5ACnxGYC4ThIjaobMqd8erdO8O4utpq
yEq0HApADR4SO7oaoMBCJn/8R0mIlb2aGYvOjdfmURoVEnPxTYilP6Njwh9qMAkO
89cN7il/HI5i6JQ02VJhiqed67qAPK3D9u/AsehM39LDjjiO8AXVLRaLOsgIDLe1
aGoxEaURw9FhEHgjm99YD/kw6Sxt6HA8OHBxsefX2fr0WJyM18Y=
=Du9n
-----END PGP SIGNATURE-----

--Sig_/zoeBvEPg.zuoTfvj4MUKxts--
