Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9057BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523612081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523612081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbeLBW2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 17:28:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50837 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 17:28:13 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E675280A37; Sun,  2 Dec 2018 23:28:06 +0100 (CET)
Date:   Sun, 2 Dec 2018 23:28:09 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Numan =?utf-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
Cc:     jason.low2@hpe.com, Waiman.Long@hpe.com,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        dmitry.torokhov@gmail.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [regression, bisected] Keyboard not responding after resuming
 from suspend/hibernate
Message-ID: <20181202222809.GA29467@amd>
References: <20180831215121.1b1f66bf@korsan.localdomain>
 <20181019102031.77015d44@korsan.localdomain>
 <20181025074903.GA9323@amd>
 <20181028220654.7e77e5d7@ubuntu>
 <20181130154455.21578c4d@korsan.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20181130154455.21578c4d@korsan.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-30 15:44:55, Numan Demird=C3=B6=C4=9Fen wrote:
> Sun, 28 Oct 2018 22:06:54 +0300 tarihinde
> Numan Demird=C3=B6=C4=9Fen <if.gnu.linux@gmail.com> yazd=C4=B1:
>=20
> >Thu, 25 Oct 2018 09:49:03 +0200 tarihinde
> >Pavel Machek <pavel@ucw.cz> yazd=C4=B1:
> >
> >> Hi!
> >>=20
> >> Here's problem bisected down to:
> >>=20
> >> commit 9d659ae14b545c4296e812c70493bfdc999b5c1c
> >> Author: Peter Zijlstra <peterz@infradead.org>
> >> Date:   Tue Aug 23 14:40:16 2016 +0200
> >>=20
> >>     locking/mutex: Add lock handoff to avoid starvation
> >>=20
> >>     Implement lock handoff to avoid lock starvation.
> >>=20
> >> Numan, I assume revert of that patch on the 4.18 kernel still makes
> >> it work?
> >>  =20
> >
> >Unfortunately, I could not revert
> >9d659ae14b545c4296e812c70493bfdc999b5c1c on kernels from 4.18.16 to
> >4.10-rc1 because there were too much conflicts, which I could not solve
> >as an "average Joe". I tried a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3
> >which is parent of 9d659ae14b545c4296e812c70493bfdc999b5c1c and
> >succeeded to compile kernel.
> >
> >git checkout a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3
> >
> >Then, I compiled kernel and rebooted with it. I tried a couples of
> >times suspending and resuming, all of the time keyboard worked as
> >expected.
> >
>=20
> With this one line patch from Takashi Iwai, keyboard is working as
> expected after resuming from suspend/hibernate.
>=20
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -59,7 +59,7 @@ EXPORT_SYMBOL(__mutex_init);
>   * Bit2 indicates handoff has been done and we're waiting for pickup.
>   */
>  #define MUTEX_FLAG_WAITERS	0x01
> -#define MUTEX_FLAG_HANDOFF	0x02
> +#define MUTEX_FLAG_HANDOFF	0x00
>  #define MUTEX_FLAG_PICKUP	0x04
> =20
>  #define MUTEX_FLAGS		0x07
>=20
>=20
> Thanks in advance and regards,

Ok. So it is a regression, and you can ask Linus to apply this
=2E. but... that's kind of heavy solution. Peter, do you have any other
ideas?

									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwEXHkACgkQMOfwapXb+vKglQCaA7lxCzLnOVLGE4OKpnuR4mBr
tkcAnA2BnEslbP+BkCLCtbbImMzF0oSG
=MvNv
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
