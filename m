Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5221AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F086520779
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bBpJq+NS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F086520779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754616AbeGIQMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:12:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35042 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754556AbeGIQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RgghVkLOGWz8u3dJ7tbQpgqSl2FKTJ+NNenwy//J2z0=; b=bBpJq+NSZK7Nz58QM1GNOGOva
        f1E8qP/6P90BzuQ9PV3USSdy0/Ahkh+rcMYobZvbZpY0ukTCINWbZdBDBD0LOYkV/jkyfsxyFy32t
        2LqOdW/YfaFlQwBnyFxXZ/a6WisRBYTghErr5meOOoZmRbcLIZ1/1ryuj1SDhdu+Szjb0=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcYlV-0003qF-SN; Mon, 09 Jul 2018 16:11:53 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcYlU-0004i6-O2; Mon, 09 Jul 2018 17:11:52 +0100
Date:   Mon, 9 Jul 2018 17:11:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     pascal paillet <p.paillet@st.com>, benjamin.gaignard@linaro.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Don't link consumers on the same device
Message-ID: <20180709161152.GH16082@sirena.org.uk>
References: <CGME20180709125425epcas1p2343265d3a6a826b2ace0ef584d062dac@epcas1p2.samsung.com>
 <20180709125402.32427-1-broonie@kernel.org>
 <20180709133215eucas1p138cd9714d802a446973ce90058ef0afb~-tpG-E94E1650416504eucas1p1I@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Content-Disposition: inline
In-Reply-To: <20180709133215eucas1p138cd9714d802a446973ce90058ef0afb~-tpG-E94E1650416504eucas1p1I@eucas1p1.samsung.com>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 03:32:14PM +0200, Marek Szyprowski wrote:

> This patch doesn't help, because wm8994 creates separate struct device for
> each registered regulator, so you need to check the regulator parents too,
> see my fixes below in the patch.

Ugh, right - I'd not looked at enough of the context to see what was
being checked.

> I don't like such fixes for this specific case. It's not that uncommon
> that a complex device provides various functionalities used by its
> components, so it is not a bad design to use regulator provided by
> its parent/grandparent/other ancestor device.

> Frankly, either the device_is_dependent() function should be exported and
> used in regulator core or device_link_add() should have another flag:
> DL_FLAG_SKIP_DEPENDANT.

Or it should just make the warning optional at the core level.

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDiUcACgkQJNaLcl1U
h9BSXgf/Q1suVsCj60nXkSRxw6s3MFEQECAaWcff6O45Rf4PPWtlYWE+3gO3B1Fu
LKCdklusjVMizEvnZr0dF+EMKEtnwmvoy3GNXZnaKspM7sCI8R8nLR6mKnk19dgE
wIqyBICxeu+tFgpnrBcN6mr9rVfFt7zytoNNLTJljSoYSahtcBUiT0cBbc9SQmAo
/6GvsuzWErBS4gbUFX/zM08qPRJjMb0IohO0ZX1B7rJEQzzfYOOdind6jXmPVQT1
FvzTHvAXP28KI5QexE+QhYxY9yCEFy3pXbDUeM52IVYv6QqJoL1xTicERB2tv/u1
XTo/nOu9FEmFGVLBGUpSCY+rX5G1sQ==
=SU2f
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
