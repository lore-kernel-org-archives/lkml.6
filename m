Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A5DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC69A205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="JaNPM6hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfANV60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:58:26 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:49498 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iPRW8+q0btwHqPY6LWuJkYBZv6s3I/8CuVyqgWuRR/A=; b=JaNPM6hhy1twH3BtJ821Wi3Fp
        T/2pAijlY11AFjR8VsCiDgW81SVz/j8ePxgMZnhZWl+w41JXSuW6wEinY59/fKy6SNkTh6aos5tNg
        TUHV76+sg72xiCR0VCr6leTEzAORVIb6ihOrbm4MO6UqB6kxxHXyyyyozdKuccRG+wU9A=;
Received: from p5dcc3840.dip0.t-ipconnect.de ([93.204.56.64] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjAFS-0006aP-5W; Mon, 14 Jan 2019 22:58:22 +0100
Date:   Mon, 14 Jan 2019 22:58:02 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 2/5] gnss: sirf: power on logic for devices without
 wakeup signal
Message-ID: <20190114225802.4dcd8cd2@aktux>
In-Reply-To: <20190114105129.GE3691@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
        <20181209195150.5192-3-andreas@kemnade.info>
        <20190110121038.GA9725@localhost>
        <20190110230223.18ecbd87@kemnade.info>
        <20190114105129.GE3691@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0RBf60XTqK6jVJPjg_DdTCr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0RBf60XTqK6jVJPjg_DdTCr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Jan 2019 11:51:29 +0100
Johan Hovold <johan@kernel.org> wrote:

here is a second part of a reply.

[...]
> > > In pseudo code we have:
> > >=20
> > >   activate:
> > >    - toggle on-off
> > >    - wait(data-received, ACTIVATE_TIMEOUT + REPORT_CYCLE)
> > >      - reception: success  =20
> >=20
> > Note: we can also get the goodbye/shutdown message from the chip here
> > so there are chances of a false success, but since we initially power d=
own,
> > we will rule out wrong state here. =20
>=20
> Good point. Unless we know the current state, we'd need to sleep for
> HIBERNATE_TIMEOUT before waiting for data reception.
>=20

And probably this also magically (together with my
runtime_get/put()-pair) in _probe()) worked around the
problems fixed by the.
gnss: sirf: fix activation retry handling

I was not aware of this problem while writing that code. Just
discovered this fact after the submission.
The current state feels a bit wonky. So I would prefer to bring it
into a stable thing with clear limitations.

> > >      - timeout: failure
> > >=20
> > >   hibernate:
> > >    - toggle on-off
> > >    - sleep(HIBERNATE_TIMEOUT) =20
> > we could also additionally check here for=20
> >    if (last_bytes_received =3D=3D GOODBYE_MSG) =20
>=20
> Caching and parsing the stream for this could get messy. And is the
> expected message clearly defined somewhere, or would it be device (and
> firmware) dependent?
>=20
> > or alternatively check for
> >    if (!BOOTUP_MSG_RECEIVED)
> >      - return success =20
>=20
> This seems to suggest the only thing you worry about is the drivers idea
> of the current state being out of sync (which could be addressed
> differently and only once at probe) and not hibernation failing for some
> other reason. And you'd still need to wait for ACTIVATION_TIMEOUT (as
> well as allow the chip time to actually suspend).
>=20

States being out of sync is one problem. Hibernation/activation can also
fail. I would try to catch that also. The question was just how to get
the best for the long report cycle time problem and where we are now.

> > >    - wait(data-received, REPORT_CYCLE)
> > >      - reception: failure
> > >      - timeout: success
> > >=20
> > > A problem with your implementation, is that you assume a report cycle
> > > of one second, but this need to be the case. Judging from a quick look
> > > at the sirf protocols (sirf nmea and sirf binary) report cycles can be
> > > configured to be as long as 30s (sirf binary) or even 255s (sirf nmea=
).
> > > [ To make things worse these numbers can be even higher in some
> > > low-power modes it seems. ]
> > >  =20
> > As far as I see we will only might have a problem if=20
> >   - those settings are nonvolatile (or we come in with those
> >     settings on another way)
> >   - or a state change lateron fails which we cannot properly detect =20
>=20
> So again, you only worry about getting the initial state right?
>=20
The point is that we have at least some chances if we get the initial
state right.

> Otherwise, lowering the message rate would at runtime would affect all
> state changes (as currently implemented), regardless of whether these
> changes are stored in NVRAM or not.
>=20
Well, with the last patchset and short report cycle we can detect state
changes to off state reliably but state changes to on state
only unreliably (which was, as said, not the intention). If the GPS chip
behaves well enough, we will not see trouble.

Now with long report cycles: Off state detection will always return
success. On state detection (in its current wonky form) will see the
state change messages and will also always return success. If initial
state is correct, this works at least in a wonky way.

I do not like these wonky things too much. So I would rather see
well-defined behavior with well-known limitations.

State change failures are probably not only a theoretical thing,
so it is a good idea to track that.

Regards,
Andreas

--Sig_/0RBf60XTqK6jVJPjg_DdTCr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlw9BesACgkQfb1qx03i
kyR/KQ/+NAT6ejlldaUsrfiQAmlRw+o4uav6dYJVLBLPiiSEzPFhXfwBezPDVAZk
3t4Jk1Mfk1EbuDMEWRre75D9SnME2NJ1B37yfiaLcOCWXvHfVSxzpZFgae7uUajs
i5s/VU586wi/yuZ2BJmVShxxlxS5fap9v68BzZf8hylCNVKWTL572cVQBHXKRKTe
iNnL0mTjSnGH56EvNP/swkGkPdBW71A6XD6cHpsAwXhvc8CNTblE0Mhw3C89Yznc
OlOqc+Ir3oNt6q/mvwtTN9vfHKcWEtEkCSqeiT06ywa3EP5lveHEKsIczcyqCQeX
0AM7+KWXpRCWo2BOaGWjoJUWwgLKupHokUgkW9JnVlTI/3WAFhi9M9diJxd3XVUr
50ne37W4SttTwM4Qw5U+MUBImhADiR7GYlHbfqmLoSIpdXKTIAAz4vm6cZDfG1+w
EyfhJl8iwJmrNIexlbPiaWTdwjP5JEDmhuRDXXRqO5QLYNubD2uiI3eFDysLBLAH
4/dGN+mln4UiKIvyEJW84R8kfxg/BQjEsy+ni/UgpLl893v7Y2LyeSL9D90yrZVb
SCMoRP37A8wr0UilCDIhb/Jbftyvnl0LMw+zW69OrnU7LXoipzCSHIvzsQJHq92A
H6RITsP+H/1vcycz/2yG52eFI8Ms1RdTy+pVq3rV+rYfqV72dGs=
=vyXS
-----END PGP SIGNATURE-----

--Sig_/0RBf60XTqK6jVJPjg_DdTCr--
