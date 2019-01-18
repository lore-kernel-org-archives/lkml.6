Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE83C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0532120823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Oa4Tr/Fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfARRWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:22:07 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:60414 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfARRSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FR37dNV2StMDy/4G45SmkCsaP1PX3ShhSHv6pOERd/E=; b=Oa4Tr/FqvE/gsvqxOeFJPRMN3
        XmSJUTg+hDiMCF1Mcz0gh4ziRj3KJcBeDh3q2pvId4UCjogW38Fsy0LEWf1a6rNWcE/YgyEEqQMxc
        6IPFBHWPbRC/7ZauhYQqvW+xLMS8yDi+mdXw/ZiaC3ek5+CIuAjkj4HpRw85YIvaxH0Bg=;
Received: from p5dcc388c.dip0.t-ipconnect.de ([93.204.56.140] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gkXmq-00023U-K2; Fri, 18 Jan 2019 18:18:32 +0100
Date:   Fri, 18 Jan 2019 18:18:27 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Message-ID: <20190118181827.7163bee4@aktux>
In-Reply-To: <20190118154807.GV5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190116220429.9136-4-andreas@kemnade.info>
        <20190118154807.GV5544@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3lHBf4TAeKUNdaSQ9oYE/gh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3lHBf4TAeKUNdaSQ9oYE/gh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 18 Jan 2019 07:48:07 -0800
Tony Lindgren <tony@atomide.com> wrote:

> Hi,
>=20
> * Andreas Kemnade <andreas@kemnade.info> [190116 22:04]:
> > Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
> > that makes hwmods working properly which cannot handle
> > autoidle properly in lower power states. =20
>=20
> Sorry if I'm still missing something :)
>=20
> But doesn't this now block autoidle for all modules
> with OCPIF_SWSUP_IDLE even if they work just fine with
> autoidle?

According to the code comments, it was just meant for that.
             if (os->flags & OCPIF_SWSUP_IDLE) {
-                       /* XXX omap_iclk_deny_idle(c); */
+                       /*


I guess there are workarounds for the other modules in place,
or critical situations were not found yet.=20
The other affected module is e.g. DSS. And we had some trouble
in initialisation order for omap3 in the past and did some
quirks. Probably we also fixed issues in reality caused by
having the autoidle bit set.
That flags also causes the iclk being enabled/disabled
manually.

Did you see any regressions? The patch is now 3 month old
and nobody complained. I checked module idlest bits and did
not see any changes.

>=20
> I think what you want to do is keep clocks enabled
> while in use?
>=20
> If so, how about using HWMOD_CLKDM_NOAUTO:
>=20
> "HWMOD_CLKDM_NOAUTO: Allows the hwmod's clockdomain to
>  be prevented from entering HW_AUTO while hwmod is
>  active."

That is about iclk. I think we should have clear wording here
between all the idle things.
>=20
> > Affected is e. g. the omap_hdq. =20
>=20
> Have you already tried what happens if you just tag
> omap_hdq with HWMOD_CLKDM_NOAUTO?
>=20
Well, I am just happy with having that single bit cleared.
But having two flags for the same things makes no sense to me.

Regards,
Andreas

--Sig_/3lHBf4TAeKUNdaSQ9oYE/gh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxCCmMACgkQfb1qx03i
kyQ6TBAAjpFQDokqCcThBIXanpTuL7QL0hVYuxWtIW+lzA1SFg5R5aZnIaR6thuz
RlzC8bpQ8q79S57pF2jYueCA4B2xpP8cY3DgiHJ3Of+v3Wj+7WvnpndFaICDcEJx
qxgoMwbC8nSlskvMrxaI3ywqGeQkeEeBRQNGQjwo2kYVtHBv8BvgfjvYZmP1HeK5
MtUIgI+7L1RwBr1wplMFW0aG4E937+A0t22w4oP2NHPjBNf7207WzNi9AIoNH5Co
r3D6gJ8OqhsB8QTD4Ty9owvm8YmAMa5A1hUKVrR190OpUEz7I6psalwyas0QQgYk
mB+2RHIdIWFbrK4PhokCaRonqN6fuiStxotgWO6gx4aX3a1YyGHO4bdvYlXJd65f
sh/Dnz5g8PydmfdCNaC/DH3MSM2SYE1iVbfnNWz4NnitjC/oEpGSfYR3aiU9Bf/M
KT8j3dDByw2soiBG+GyO9FzycYKpyT8yqQz+z9Cdy0v4Y7U8DGJczhbC/n32J1/Y
6QTSmljwgJmNHFH13pNfJOaVpkMt/jFOK0uAGIqAMfdcF7Cy0kbwGz58meiJwsGZ
f1HMOOanOdnln8J0gIzu9QSsjhbWbBETxtcpON4eemvgEq52YYjISd1H7oNK628R
yOj7jWFAZiQoXNivNiH+SRCGdbAKdhWVd89gwG5ZUsQ5iK4WKDo=
=dLt3
-----END PGP SIGNATURE-----

--Sig_/3lHBf4TAeKUNdaSQ9oYE/gh--
