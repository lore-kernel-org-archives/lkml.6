Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DFFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA9D248BC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA9D248BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934585AbeGCSlZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:41:25 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:38253 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934399AbeGCSlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:41:24 -0400
X-Originating-IP: 54.36.30.212
Received: from w540 (unknown [54.36.30.212])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 17AE520007;
        Tue,  3 Jul 2018 18:41:27 +0000 (UTC)
Date:   Tue, 3 Jul 2018 20:41:17 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Philipp Zabel <pza@pengutronix.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Discussion of the development of and with GStreamer 
        <gstreamer-devel@lists.freedesktop.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
Message-ID: <20180703184117.GC5611@w540>
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180531190659.xdp4q2cjro33aihq@pengutronix.de>
 <CAMty3ZCeR3uEx8oy18-Ur7ma7pciKUf_myDk6_SpWvxc6DvygQ@mail.gmail.com>
 <CAOMZO5AOpOSAx=L4tOU1Na6hm8Tex3PHNxCYDB81C0+NPHzTZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AOpOSAx=L4tOU1Na6hm8Tex3PHNxCYDB81C0+NPHzTZQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Fabio,
  thanks for pointing Jagan to my series, but..

On Fri, Jun 29, 2018 at 06:46:39PM -0300, Fabio Estevam wrote:
> Hi Jagan,
>
> On Fri, Jun 1, 2018 at 2:19 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> > I actually tried even on video0 which I forgot to post the log [4].
> > Now I understand I'm trying for wrong device to capture look like
> > video0 which is ipu1 prepenc firing kernel oops. I'm trying to debug
> > this and let me know if have any suggestion to look into.
> >
> > [   56.800074] imx6-mipi-csi2: LP-11 timeout, phy_state = 0x000002b0
> > [   57.369660] ipu1_ic_prpenc: EOF timeout
> > [   57.849692] ipu1_ic_prpenc: wait last EOF timeout
> > [   57.855703] ipu1_ic_prpenc: pipeline start failed with -110
>
> Could you please test this series from Jacopo?
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg133191.html
>
> It seems that it would fix this problem.

... unfortunately it does not :(

I've been able to test on the same platform where Jagan has reported
this issue, and the CSI-2 bus still fails to startup properly...

I do not have CSI-2 receiver driver documentation for the other platform
I am testing on and where my patches improved stability, but the i.MX6 error
reported by Jagan could be useful to help debugging what's wrong with the
serial bus initialization on that platform.

The error comes from register MIPI_CSI_PHY_STATE of the i.MX6 MIPI_CSI-2
interface and reads as:

0x2b0 : BIT(9) -> clock in ULPS state
	BIT(7) -> lane3 in stop state
	BIT(5) -> lane1 in stop state
	BIT(4) -> lane0 in stop state

The i.MX6 driver wants instead that register to be:

0x430 : BIT(10) -> clock in stop state
	BIT(5) -> lane1 in stop state
	BIT(4) -> lane0 in stop state

So indeed it represents a useful debugging tool to have an idea of what's going
on there.

I'm a bit puzzled by the BIT(7) as lane3 is not connected, as ov5640 is a 2
lanes sensor, and I would have a question for Jagan here: has the sensor been
validated with BSP/vendor kernels on that platform? There's a flat cable
connecting the camera module to the main board, and for high speed
differential signals that's maybe not the best possible solution...

Also, anyone interested in my mumbling on the ov5640 MIPI bus
initialization, I've collected some thoughts here:
https://paste.debian.net/1031942/

Any comment is of course welcome, and if I have a confirmation that
the Engicam platform works with that flat cable, I'll keep working on
it..

Thanks
   j


> Thanks

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbO8NNAAoJEHI0Bo8WoVY8x3oP/2taIopgpZrgje+iXYy4EMcY
5Qv3ITPlrEH0nVQs7xGNtkJ2t33IbfpQ3BZr0bKKzvUO4owGss9999mnjXufJtS9
A86jFb1Y4J9fls7918NUqxM4RFl1R9qEB6ogDDdF85B/9DH0PV6YKQp8BwQ57XZL
EdwL8z8kBx1X92dN/7Q9Rxgc20z1OHiHOPocwMMUV6FCt875TF6bQXKk3u6gLclG
9lnBmTW5uQUBARuJDBaP+0IkwFNF+S00ycsENFsKZwAcxR7CTPcatDht4tlzBPug
8FmCIu4Zb105lwxD+6HizFnOx308vZ/F1hhQfteOulDfyHmA3gQzp9ppX4NkMJbi
9AjZNdWllexNynh4TT5xOQK1DFuW67kbbtTTCxffcoJzvXFVUUprVvf54QJx4qmr
OFQJD5lR4FWPELw6wPCZnEJD2Qa6kC0/4lBDo1y80nMHdavX1GS3qHIA0xtbMavr
QyZ63OaeMcyfiSHyXxEhA2x3x0NJBbgHGkWHPHG7U77uqXae+n/AYl1wpMAKUdDh
/Oa7UaNtGmRRookLMiclNOYjSUl8GMJc3vZzXWuVTE06nsM4k25rn5AQu/8a8PnB
jk4MY2s669+7rZMBApw4k+gpd3bODo2VAL1XgiCiN0XCXOtpwbmVZZahTZ4pL239
2BuAjyOS5HmmCM7xY5Zm
=jUOJ
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
