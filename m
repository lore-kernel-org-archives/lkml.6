Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8935DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E98720883
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E98720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbeGIK24 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:28:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52074 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932435AbeGIK2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:28:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 039A880354; Mon,  9 Jul 2018 12:28:52 +0200 (CEST)
Date:   Mon, 9 Jul 2018 12:28:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        andriy.shevchenko@linux.intel.com
Subject: Re: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
Message-ID: <20180709102852.GA20580@amd>
References: <20180708174939.GA10002@amd>
 <20180708193720.GA13262@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20180708193720.GA13262@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > grep in /sys produces a nasty oops:
> >=20
> > I guess next step is trying to find out which file that is..
>=20
> Let me see...
>=20
> openat(6, "suspend",
> O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW) =3D 4
> fstat64(4, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
> read(4, 0x4d2000, 32768)                =3D -1 EINVAL (Invalid argument)
> write(2, "grep: ", 6grep: )                   =3D 6
> write(2, "/sys/kernel/debug/pm_debug/cefus"...,
> 47/sys/kernel/debug/pm_debug/cefuse_pwrdm/suspend) =3D 47
> write(2, ": Invalid argument", 18: Invalid argument)      =3D 18
> write(2, "\n", 1
> )                       =3D 1
> close(4)                                =3D 0
> close(6)                                =3D 0
> openat(5, "time", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW)
> =3D 4
> fstat64(4, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
> read(4, "cefuse_pwrdm (OFF),OFF:641441757"..., 32768) =3D 849
> read(4, "", 28672)                      =3D 0
> close(4)                                =3D 0
> openat(5, "count",
> O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW) =3D 4
> Connection to usb closed by remote host.
> Connection to usb closed.
> pavel@half:~$
>=20
> Ok, so it seems to be:
>=20
> user@devuan:~$ cat /sys/kernel/debug/pm_debug/count
> (oops).
>=20
> The file seems to be world-readable.
>=20
> user@devuan:~$ ls -al /sys/kernel/debug/pm_debug/count
> -r--r--r-- 1 root root 0 Jan  1  1970 /sys/kernel/debug/pm_debug/count
>=20
> But on PC, that file does not exist.

Ok, it is easier to reproduce like this:

sudo mount /dev/zero -t debugfs /sys/kernel/debug/
sudo cat /sys/kernel/debug/pm_debug/count

I tried adding debugging like this:

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index cba72de..ed98da8 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -78,14 +78,17 @@ static int clkdm_dbg_show_counter(struct clockdomain *c=
lkdm, void *user)
 {
 	struct seq_file *s =3D (struct seq_file *)user;
=20
+	printk("cmp...\n");
 	if (strcmp(clkdm->name, "emu_clkdm") =3D=3D 0 ||
 		strcmp(clkdm->name, "wkup_clkdm") =3D=3D 0 ||
 		strncmp(clkdm->name, "dpll", 4) =3D=3D 0)
 		return 0;
=20
+	printk("printf...\n");=09
 	seq_printf(s, "%s->%s (%d)\n", clkdm->name, clkdm->pwrdm.ptr->name,
 		   clkdm->usecount);
=20
+	printk("done...\n");=09
 	return 0;
 }
=20
But it seems to crash outside show_counter function:

[  100.345062] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[  102.049743] cmp...
[  102.051910] printf...
[  102.054351] done...
[  102.056579] cmp...
[  102.058685] printf...
=2E..
[  102.319427] printf...
[  102.323211] done...
[  102.326843] ------------[ cut here ]------------
[  102.333190] WARNING: CPU: 0 PID: 2360 at
drivers/bus/omap_l3_noc.c:147 l3_int
errupt_handler+0x23c/0x380
[  102.344696] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2
(Read): Da
ta Access in User mode during Functional access

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltDOOQACgkQMOfwapXb+vIxnACcCO51qnvkCTacqdhOUgNSNsNc
mI8AoKVarTkhTDuRfXsZgztgrKgS8GjS
=sc4Z
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
