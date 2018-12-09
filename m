Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF11C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3017C2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3017C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLIRYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 12:24:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35583 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeLIRYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 12:24:07 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3BC8D8076A; Sun,  9 Dec 2018 18:24:01 +0100 (CET)
Date:   Sun, 9 Dec 2018 18:24:04 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Droid 4: poweroff does not work? calls
Message-ID: <20181209172404.GA4593@amd>
References: <20181209121318.GA24478@amd>
 <20181209164650.GX6707@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20181209164650.GX6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-09 08:46:50, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181209 12:13]:
> > Hi!
> >=20
> > Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
> > seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
> > affected. It is bad, because when your battery is low, you get into
> > reboot loop and discharge it furher, which batteries do not like.
> >=20
> > Any ideas, or at least idea how to debug this?
>=20
> Hmm can you check if this is happening with usb unloaded or
> unbind? I suspect ohci or musb..

Ok, let me try: musb unbound, v4.20:

root@devuan:/sys/devices/platform/44000000.ocp/4a0ab000.usb_otg_hs#
echo 4a0ab000.usb_otg_hs > driver/unbind

(I hope I did not pull the USB too late). It rebooted instead of
poweroff. Now on 4.18:

root@devuan:/sys/devices/platform/44000000.ocp/4a062000.usbhstll# echo
4a062000.usbhstll > driver/unbind
root@devuan:/sys/devices/platform/44000000.ocp/4a062000.usbhstll#
uname -a
Linux devuan 4.18.0-rc4-88970-gf075a2c-dirty #764 SMP Mon Jul 9
12:51:47 CEST 2018 armv7l GNU/Linux

I get nice oops doing that:

[  170.705383] ------------[ cut here ]------------
[  170.710235] WARNING: CPU: 0 PID: 2371 at drivers/clk/clk.c:697
clk_core_unpre
pare+0xcc/0xec
[  170.718749] Unpreparing enabled l3_init_cm:clk:0048:8
[  170.723968] Modules linked in:

root@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.=
ohci#
echo 4a064800.ohci > driver/unbind

=2E.Hmm. I'm not sure how to unbind ehci. Let me try sudo
poweroff... no, it reboots, too.

Can you check if it works for you?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwNT7QACgkQMOfwapXb+vKzBACffSEF6vwWVha2uJMPdeAzqeP5
J9IAoJgKqEA/LXbRGiTz5NFIuF3I6xAG
=1Tt9
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
