Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FC3C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6B920879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ/1vb5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6B920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeLMQSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:18:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40142 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:18:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id d3so2498992edx.7;
        Thu, 13 Dec 2018 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+FdXPipH9AIz3yWNmpA4/ClAfz2jT9tmmIjwYuktQ+E=;
        b=bQ/1vb5cCIdHP7A762nSa7Ce2w2un5zz0IfsSzrx+QthoqKuIJaFdrLZs6vwOLfeMf
         uix/5McKQTkmpX0Y6iYY4hXgAJ7x8Arf8xqZg/A/4nMpRC45QjFGxayE74keC1ewiW4c
         kPxo3NAoi35hAU5lhsHkMrzgd7+DuNOwjiEHeWEYLyc5SJbEv1jfpn4C53U6lSWglti6
         FTYRQi2YYgnQCwBHznmL9Ljeg3RADkRqX2nvOhFcOnKEU8Yhq3cRgj3ooVnyJv5Kab7U
         Wd+iZnaNjQ9l7rtTozZnkYthc0kBw7k3xdrgsynro2mzEXofgfEoo0I2f4fo8TF7sZde
         b8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+FdXPipH9AIz3yWNmpA4/ClAfz2jT9tmmIjwYuktQ+E=;
        b=UWoKX6PUlVhx61L+rpWL3NVMVX/JQ/9ISoxqSgkpg+aZVcQu39+33FUvT0WM1Bwo/Q
         6BYo8sT386SPIg+tlrLxWftxNaiF7oGH4fTlcymOm3alMGx+Ut/P3KY/PZ+5SgSlCwB6
         8Ta54vgv6PajAUcIxW1LzQmRyi83v0RrklcctCDcs6j4A3GRDjbiK+cdaSbyugeKlufp
         ixAABZxroQg2PYl+fvS5JTAo8PTwQPZ3aQ6lBEpF6RQcc975MzMsHJWWZAd+lDthAM4S
         0YOOWlIibv+AIOi6iceynW7wJlZ0PmbdUPjCxsDda7vSyg37cQfLHb96d+z9QzeyL0Yz
         q3OA==
X-Gm-Message-State: AA+aEWaPCY1Dqj0ekw0RxUhchMWAwkC4UtaBgA2aA1m8buJPqD2bkCjT
        tQacAhu1H9qeSpPwBui0Cxo=
X-Google-Smtp-Source: AFSGD/XHM3NswUvX+kvSB6GgwBHruq+9RY4kmKXvtZ1x9yOZWjFcjY50qAH4sw7m6tfwvHzf+XrZcg==
X-Received: by 2002:a17:906:e287:: with SMTP id gg7-v6mr19062147ejb.128.1544717913525;
        Thu, 13 Dec 2018 08:18:33 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id h11-v6sm403394ejc.3.2018.12.13.08.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 08:18:32 -0800 (PST)
Date:   Thu, 13 Dec 2018 17:18:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
Message-ID: <20181213161831.GC13531@ulmo>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
 <1544709795.18952.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <1544709795.18952.1@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 03:03:15PM +0100, Paul Cercueil wrote:
> Hi,
>=20
> Le jeu. 13 d=C3=A9c. 2018 =C3=A0 10:24, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > Hello,
> >=20
> > On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
> > >  The PWM in the JZ4725B works the same as in the JZ4740, except that
> > > it
> > >  only has 6 channels available instead of 8.
> >=20
> > this driver is probed only from device tree? If yes, it might be
> > sensible to specify the number of PWMs there and get it from there.
> > There doesn't seem to be a generic binding for that, but there are
> > several drivers that could benefit from it. (This is a bigger project
> > though and shouldn't stop your patch. Still more as it already got
> > Thierry's ack.)
>=20
> I think there needs to be a proper guideline, as there doesn't seem to be
> a consensus about this. I learned from emails with Rob and Linus (Walleij)
> that I should not have in devicetree what I can deduce from the compatible
> string.

Correct. If the compatible string already defines the number of PWMs
that the hardware exposes, there's no need to explicitly say so again in
DT.

Thierry

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwShlcACgkQ3SOs138+
s6FpGBAAnSdBj1VfdT/8QgKaKbqU4xM6IIM84lPPIcpnwOx61r4Q9wKVlcWX7I9h
uYpGNc+ObutBYqeqCt73aJZ6AW9EQyvD47/D2dMHt6SexpCAse2Rg7OfwPxV3qN7
NlfVdBSqtBGcrVZZLtZ3+JPkLzIUhl4UooMQo6j73FCRiww7k1B5YfdrGeN38kDA
o8nMXKNuSRSXSF3KUNeDHx2mIB1BjRJJjW5pOwfIbQbO4EdhxHzkgS54UlZU/bUr
z0gqwFMOGsRPrhSmvDv5CR5GKbbxC/YR3uPcAFOSgEuXr+1LEaEtzhTea5h1yokw
POmWLezWZ6Y8RlhawFhnBWGg44E/HO1x5H3UVUQjmM16I++lovIyZh8PwwAhyO5q
6mEWlcLjBnPoOXh7t8RRmZUJ5s6za2l2oBm6Ot/mjDjrPmabwNCMVDTz5GyHDtK3
uflj6xxSlSt8eQV66yFA62wdoXPz5MFSGumz+kOQQOs2rqzSGh3C7rp3nU5xmE/K
DfsNs92AvWte+ad0nbvZ3IrPYkZH/FdJErx6QMEBUvbwcmwxPh0m4VfKaa8DUZ7Z
s9dKdJYLkT6RtGpBK9qK3Anrh7Cp6+zImtyf7pyh89KN2P4oIQroq51Ape6gpFnt
RZVc3NqUTOk2/RXelfCPC23ShWn1dxzOSOhXrtQ6FQOAKwQ7bkY=
=qfF6
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
