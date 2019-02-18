Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051CB2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550514219;
	bh=SBO+3L6U1TOUIu9oCOlMX906YZHn3HpRNxDiDv20Qeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ThdR8d4aNY+ooVQI+P8sgLyZ3LyN+Lf6w6nBt1hYzlPYFYOcKSphWHHXI3YAO9SlX
	 l4MdvQobXY8iree4aVxNmNS7jJMSuZ6H5DtP2ChwO1SvOvg0u+iBinKVhvyFxEXkc5
	 aRKrr8xYavGZgAnT+YZ4WpA9cFckZ8glcyCJH1hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392415AbfBRSWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:22:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53290 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390821AbfBRSWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SBO+3L6U1TOUIu9oCOlMX906YZHn3HpRNxDiDv20Qeo=; b=Tx74LqNcx1UfEARApShGX3/0X
        qU8NrgsRJ/moKLdghISRZh6RJzG5rQ5bDKBwc7P29+sryTXlwiiLFy2+tQ4NVxQrj9ozlAfowXObO
        y044f+c3W3Zo1fBj+hB24YZfazGwJZgPsGaKD8eQxIelK6tm01wWfYS1ALXywd09U8zpg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnYv-0001VO-9Y; Mon, 18 Feb 2019 18:22:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CA4F91128008; Mon, 18 Feb 2019 18:22:40 +0000 (GMT)
Date:   Mon, 18 Feb 2019 18:22:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "vicencb@gmail.com" <vicencb@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: simple-card: Fix refcount underflow
Message-ID: <20190218182240.GG10794@sirena.org.uk>
References: <20190216100927.10017-1-daniel.baluta@nxp.com>
 <87pnrp52jl.wl-kuninori.morimoto.gx@renesas.com>
 <87lg2d51lv.wl-kuninori.morimoto.gx@renesas.com>
 <b4bee8ff1307004ec9d1122f70ab2cb0d636ea4a.camel@nxp.com>
 <s5hpnrp8ret.wl-tiwai@suse.de>
 <20190218175010.GB10794@sirena.org.uk>
 <CAEnQRZCLE7DHumOCDSXxaKEgpukDgP5EtH=j7xMwTBJcTWQTZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kadn00tgSopKmJ1H"
Content-Disposition: inline
In-Reply-To: <CAEnQRZCLE7DHumOCDSXxaKEgpukDgP5EtH=j7xMwTBJcTWQTZw@mail.gmail.com>
X-Cookie: Take an astronaut to launch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kadn00tgSopKmJ1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2019 at 08:00:48PM +0200, Daniel Baluta wrote:

> Would you want me to change the patch for 5.0 to have an identical commit
> message as the one for 5.1?

No, that's fine - since Morimoto-san's patch has been tested I'll just use
that.

--kadn00tgSopKmJ1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxq9/AACgkQJNaLcl1U
h9CKWAf/QhJOOS76j3FBAB7PkiShjc2QFHAP9oqiH9Lww2tp3YOOsGCFdJlb6cBI
w2zA6yFx1Y4tPYVlsVQIX5U2aGmHzIebVvsxQA4n6GMGj8kmf87AI+x32JXBqV7Z
T2dKCFkAx67vaFy6ReFW7Ck0SZfRLjEYMWTANBmnmq7wlgApQxuvlySMIPnrN7Md
5t5qn2xFsBonZACjE7PgQEB1KaLKsWCPj2G8HZexyr0wq68ll4snaHxHHbg7Gna7
Iv+wCry69RvEPOcq+aUH/PttGwL4BBhKniCsmvVYH25+vFt366BNUzkunMIQ3yk1
M8+REeKOGuXHuf0wr5zWsnLoaseIAQ==
=wHox
-----END PGP SIGNATURE-----

--kadn00tgSopKmJ1H--
