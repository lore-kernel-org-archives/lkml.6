Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E54EC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB3E21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548676086;
	bh=RJ4iS+/RD5lcAZnjscbeJwQx/qZwY6ENY+ianG5wXNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c66ZKISMjczl+Gmjds1WOei/HeEWvsbbhzYfUgA2SYZvHOgrBgXs6g9i8q5vv5iEd
	 p6YheAygCstrWwTEb1XCZ9xTXs22bzpM7jNopp6aKdscLL+3MfQ4TI8w+2gwHXbv9W
	 BdHw/QXwWXAhMPpvi7tnO13UZy8qEkjncVBlSskA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfA1LsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:48:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46806 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1LsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XrHAbjQnJG++tg7jANcRVkmvnvK4hCi8ctkr9ui294U=; b=P+ic8FIDYqQ5k11ZCV0tpDS+K
        qmpAz3hoA4pQDIcMcXn5l/1nw3snHwlsOsdMdG/h6SC+oTQpaSc2uXwkjRASTlkO45eoEY9XGtBEx
        Sl2tItQMWeoWYD9y3g231zgUyOo7GPWtG5zrmgwVmnE66fMVCr0Qj5JLe+bYUeyvzBcxU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go5OQ-0002OT-5V; Mon, 28 Jan 2019 11:47:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8529D1127D29; Mon, 28 Jan 2019 11:47:57 +0000 (GMT)
Date:   Mon, 28 Jan 2019 11:47:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
Message-ID: <20190128114757.GA11699@sirena.org.uk>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
 <20190125174713.GA6939@sirena.org.uk>
 <20190125175031.GA25898@sirena.org.uk>
 <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
 <CAMuHMdUyt=DDMwDZA-TB0Yac13NJQCo2LxzvqnRzvn6LZ5F98w@mail.gmail.com>
 <ed62564f-d36b-1492-8e65-60166c0aa4a6@norrbonn.se>
 <CAMuHMdXQONq1UFuFHwny_xfAtxY7sOv2K3yi2i9T22OovMqFhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXQONq1UFuFHwny_xfAtxY7sOv2K3yi2i9T22OovMqFhw@mail.gmail.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 28, 2019 at 08:41:05AM +0100, Geert Uytterhoeven wrote:
> On Sat, Jan 26, 2019 at 4:40 PM Jonas Bonn <jonas@norrbonn.se> wrote:

> > spi-3wire: again, only set by MAXIM DS-1302 which always needs this
> > setting; driver could set this

> For DS1302, this is probable true.
> Some devices may support both 4-wire or 3-wire mode?

IIRC yes.

> > Yeah, that one make sense.  But if the DT is only overriding the maximum
> > device frequency that the driver should otherwise be setting, why is
> > spi-max-frequency a _required_ property?

> That's a good question. Legacy?

It's a documentation error.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxO6+wACgkQJNaLcl1U
h9AOgwf+IkdFBShqKG2xdlfJ5VF8oSqgYM0JOZyBmGJJrw4Uv4l/Ov5QffmAICt3
J8VIcm0Z9wr9iTi7bWCra8BPMGiqLM7Tx/aPErD2CtnuAVialMEwLVNejnFu9NnV
Dwd3HPacCIx/QXZdfZwiMTJvRZdRyn/0WFT7TUWuUklm6g6fq4aye60aq9w/wQRd
nbU1b/nwRl3m6+y0Y6i/grTCw5ZtVvrlgczav6EP1/yc1utZQ0tBXj95DXs6MJoQ
K8VBky1Kza8/lLaoOECEf+98MNbVFxKyJttu6nC0uwxqbvBCV1RMFfCDtnHMQxqY
OiLKZ8HXn9XlrCQrmsugXESuWcGxKQ==
=KFrc
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
