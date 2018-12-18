Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840ECC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE5620815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeLRUR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:17:29 -0500
Received: from sauhun.de ([88.99.104.3]:48914 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeLRUR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:17:29 -0500
Received: from localhost (p54B3362C.dip0.t-ipconnect.de [84.179.54.44])
        by pokefinder.org (Postfix) with ESMTPSA id EBF762E3542;
        Tue, 18 Dec 2018 21:17:25 +0100 (CET)
Date:   Tue, 18 Dec 2018 21:17:25 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
Message-ID: <20181218201725.2uqfmsethlkasdvc@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
 <20181211234102.GA6701@kunai>
 <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xjz6c4seersbpqak"
Content-Disposition: inline
In-Reply-To: <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xjz6c4seersbpqak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hans, all,

> > ... this. I don't know what these flags do (and reading SMART in there
> > gives me more a 'uh-oh' feeling)
>=20
> On x86 the lines between runtime suspend and system-suspend are blurring
> with technologies like "connected standby" and in general devices moving
> to suspend2idle as system-suspend state, I guess this also applies to
> modern smartphone platforms but I'm not following those closely.

I'd guess so, too. I am not aware of any existing mechanism for that at
the moment, though. If somebody does, please enlighten us.

> The "SMART" bit is really not all that smart, SMART_PREPARE means that
> the drivers pm prepare callback will return positive non 0 (e.g. 1) to
> indicate that the device may not be kept in its runtime suspended
> state when transitioning to system-suspend, otoh when the prepare
> callback returns 0 and the SMART_PREPARE flag is set then *all* suspend/
> resume handling can be skipped during a system suspend.

Thanks for the detailed explanation! Much appreciated.

> > Looking at the open coded version you did for the designware driver, I
> > wonder now if it is better to just leave it at driver level? Need to
> > sleep over it, though.
>=20
> I myself was thinking in the same direction (leave the entire suspended
> check at the driver level).

So, I was giving it some more thoughts, and my feeling is to still apply
this series with the review comments addressed. Plus, clearly mark the
new 'is_suspended' flag and the helper function as *optional* to allow
for driver specific solutions as well. The then-to-be-added
documentation would state that it is mostly useful for seperated system
suspend and runtime suspend. For more complex situations, custom
solutions are accepted, too. Which means your patch for designware
should be added to the series.

My take is there are enough drivers out there already which can benefit
=66rom this new helper. If it turns out to be useless somewhen in the
future, we can still remove it.

What do you (and all others, of course) think?

Thanks,

   Wolfram

--xjz6c4seersbpqak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZVdUACgkQFA3kzBSg
KbZgCg/+Mi5R4bOlSvy+L7fIs79nM05v0QMNCbEAXOZ3EmZKkt9sHHiEeGzFdzKY
Iiawm2BGLUW+sVrCoxsnav0k+hSl+5TNlKd1C72V3inzemIbkEQTOiVbDPmp7fTV
0UE5WO6CUfZHirCk3XnA8xNSn8YxfHMKUOq2GuMUZEQcXyIk0mwlO84WPkWXjLTu
pHNovX+74FM6iGL3IId6KQI6773u79o8d4OA5R3pCOzPD1O7OtWAJjcP2oyD/Ge7
+45+F1eIH5GupW0zn+ByR4tU2XiDFw7uUX/6WYvPPmqPbpz/6l5Ujs1pGC9nYyPx
S8TuIAiTU8CEDVBLF1IN2Kh6+TEo0iwXpKL821lCL4lwb0ahTq/NjcyqZR0yeyYK
3bCaupT4sScf/LACYeHLPCSD3gNzK5WnaddFWnGB8YqAmQeqG1bDB+5wYxV5+FjB
V8YiuuLm+kwF4jAMZITO+iDJIHeZ5HF62JeCE0lFCf21AqlWS2KoYfcJgjln3WHU
Lk2CFEQidCTk2Vjb2U1AHBjGiAyzhle/fop8L/gMmXoCv9J+b5Jz4bIgJD+76d/A
apkIbW9HRg90t+WdzecpdU+R9qJMqeyxeKCTRga7PPO+buBJszke+8ozXvtcN+Dw
l3nKZh+uXk+nhF1T1mUW9QJ88NuCSX0SOxthrlS85oWRoiko0qk=
=SIgX
-----END PGP SIGNATURE-----

--xjz6c4seersbpqak--
