Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C93BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68A123EF1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68A123EF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbeGBSPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:15:18 -0400
Received: from sauhun.de ([88.99.104.3]:43884 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753218AbeGBSPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:15:15 -0400
Received: from localhost (p54B33579.dip0.t-ipconnect.de [84.179.53.121])
        by pokefinder.org (Postfix) with ESMTPSA id 53D6A56A485;
        Mon,  2 Jul 2018 20:15:12 +0200 (CEST)
Date:   Mon, 2 Jul 2018 20:15:11 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
Subject: Re: [PATCH v10 4/7] i2c: fsi: Add abort and hardware reset procedures
Message-ID: <20180702181511.mv2fuiwjjdhyp43v@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-5-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023849.op4rimmsnlv4rgwg@ninjato>
 <3dc50e6b-6985-1920-4f8c-dc7698e2f692@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e56uxospgaof7b76"
Content-Disposition: inline
In-Reply-To: <3dc50e6b-6985-1920-4f8c-dc7698e2f692@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e56uxospgaof7b76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eddie,

> > I think this is a way too aggressive recovery. Your are doing the 9
> > pulse toggles basically on any error while this is only when the device
> > keeps SDA low and you want to recover from that. If SDA is not stuck
> > low, sending a STOP should do. Or do you have a known case where this is
> > not going to work?
>=20
> It is aggressive, but I don't see the harm in doing this on every error.

Well, as it happens, I just fixed such a case. Please check these patch
series and elinux wiki pages:

=3D=3D=3D

(new fault injector)
[PATCH v2 0/2] i2c: gpio: fault-injector: add new injector

(actual recovery fix)
[PATCH 0/2] i2c: recovery: make sure pulses are not misinterpreted

=3D=3D=3D

And here is the new elinux wiki page to describe my findings:

https://elinux.org/Tests:I2C-bus-recovery-write-byte-fix

Also, the previous pages have been updated to reflect the latest status:

https://elinux.org/Tests:I2C-fault-injection
https://elinux.org/Tests:I2C-bus-recovery

To sum it up: This is a proven case where uncontrolled bus recovery can
result into a bogus write!

> There are some other error conditions with this hardware which may require
> the clock toggling, such as "bus arbitration lost." I think this is the

Why is that? In my understanding, recovery is *only* needed when SDA is
stuck low. If SDA is high, sending STOP should do. If not, it needs to
be researched why.

> safest option for this hardware, and this routine has been tested for many
> years.

I remember having a similar argument with Joakim Tjernlund a while ago.
I recently re-read our argument, yet I still keep my position: I don't
want to do $random things to recover, just a tested and well understood
procedure. And in that thread, I was never given a test case.

> >=20
> > Also, you implement the pulse toggling manually. Can't you just populate
> > {get|set}_{scl|sda} and use the generic routine we have in the core?
>=20
> I see that the generic implementation breaks the loop if it sees the clock
> isn't high after setting it, or if SDA goes high. I think it's safer to
> finish the reset for our hardware. Plus, we actually have different

Why do you think it is safer? What is the test case for that? I think
one really should do check SDA! See above, you might trigger a write
otherwise. If this breaks something for you, I am looking forward to
discuss it.

> registers for setting 0 or 1 to the clock/data, so we save some cpu cycles
> by doing it directly instead of implementing set_scl/sda and having to ch=
eck
> val every time :)

Correctness comes above all here. And I am afraid your implementation is
not correct.

> If you feel very strongly that this recovery procedure needs to be reduce=
d,
> then I will work on that and have to do some extensive testing.

I am open for discussion, yet I also feel strong about it. The reason
why the recovery procedure is moved into the core is to have one working
and understood bit-banging algorithm which all drivers can rely on. If
all drivers implement their custom version, they might miss gory details
like the above write_byte fix.

I do understand this might cause testing effort for you, I am sorry for
the delay it causes. However, my goal as a maintainer is to have a
reliable recovery mechanism, for your driver as well as for all drivers.

I hope this is understandable. BTW if you want this driver upstream
soon, then it may be an idea to resend it without any bus recovery and
then we can work on it incrementally.

Kind regards and thanks,

   Wolfram

--e56uxospgaof7b76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls6a68ACgkQFA3kzBSg
KbYflg/+Mjc+BP3srgLvTVEJPYbXNx2EYablKQtd+hsI39GvV/J7YNDyB3PbNrbl
PXuC+zth2OIX5s3LCBZzzTE50X5+5wr1Jvy+2Kh+dDnnJJ5XbmvoembOSbzANced
MboBqHPfkI4dpUisZOyM40APiCn0B7PQBc/lk9NXRl3kJm77iv1pNO9z0cfmMPCu
aruMNRQLcigYXQvNiJfsE6DXMktZj9S2VCKEXhJRskRpWz9hUXF3kTQ6hiJ2P+/6
PsC4yVpa3dwwBh1NxZ0ylfiV1xZtHNAgec5jstcWlSGWbuqic7QLWwa7VK4vmyYA
T8+M4x+bFnJTt9E81Kcm5r7eONxOk6s6BTjcCxUFKPkdcxdbPgfGvE7bzSzKk+UC
Muh9SyyqAjRZ7/q/V3eHlAkFs9NcFH4CgKT79Zdody1NMRvQpeiLfDflflJMtUPS
/yEndwRao5t5N1jbKvAps9/5H3S4Tz6rRQwkQF8faC8dsKCjwNHU/rSxAG6GXCKE
9iOHPuHxN4GWBzDkKQuhHKuitFGd55nIDNjsG7GQa5eGPgmhUBHUkrIjwKCM4+7b
Jo9LwZ/g+RifBg+bBaak6AoF5W+JdklebiML97WSO3J0wSe+Qxn77F+pj/ryvFPC
JpuvLWqDIk+dxyTZw8KgQNQrGS/7EAYv5YlSIVPltah2eT5zPXg=
=FRs+
-----END PGP SIGNATURE-----

--e56uxospgaof7b76--
