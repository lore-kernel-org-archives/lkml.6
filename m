Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E57C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FD02174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7RQuLMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FD02174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeHCMqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:46:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeHCMqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:46:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so4998570wre.6;
        Fri, 03 Aug 2018 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MSH5Ya+8RNQGD6qr+JAId280U00PG15EitZmMysyMyg=;
        b=p7RQuLMH8qGyP7tWIwq9skUT7y5PYbMhH5wkc5KWs33q4pbLNhCXV4jKdkraO8fu30
         //zhGd+m9L+GEUfwPMFMG1wlLv4WcdQ564oxx69TOnI3q8HgmoXWyTa16EhbBTsRxvbS
         1j77oEswXl3W30m1w48lirV4DakFxf894WeLMisyjYXAs0/QBAcYYk8/rCwqIoMS/f7X
         Odsp+4aV6dTjqvHn72JvCG67XUjhXn+9aH9kTsju6bszP7whSFMb1kbS77btvHz7y2+J
         qETacvQYk1NISUSsahK0SK1MUb65R4U/v8VO1WV7JlGJ6/elwSyW/ah6gXLS06m6NLHO
         mgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MSH5Ya+8RNQGD6qr+JAId280U00PG15EitZmMysyMyg=;
        b=DQwb8panv9e92WhU1TmWrPYBA2fSLdN6U0gj8Vylt1gJxSIjsSn14/JCzqvUunCAF6
         loZ8ZO2pm+thSiSAdrVvf2XxwL6hUQhafF3DR58pdJhT1jCwJN7mUzvMFY5yE1KptAM1
         mN5LC94tqfPoRLLCrweGoxn+vPmORPruu/4P5yikYp7V5jNvZEke+o9Oh8EA8YzTaGjA
         RoFKw61zD4bpd9mTBYMUwDPNRZ8hNGOq0AAQFABqLjzSeF4PXGeS6XBK22CrW2q18ie7
         QqRPvGrXKC8QNWMc4DOumEons83nPgAEJFrUrcFfcxACZcwCO3hp0y+jdjZmrWvP+RP2
         ESRA==
X-Gm-Message-State: AOUpUlGfAEexCZOOW3SiB1K2Sh5Lt7kbsIbSODKgP0oeGbdlouVXCcJS
        fdRvTGuzGCmyCN8jxL+xl44=
X-Google-Smtp-Source: AAOMgpesTtR6zG1tIjJznVwyGjXuZaZ7/sPfShR2JO1VP2yF+O2iE5eKKkljyWKm1Xs5yCvpwOiCTw==
X-Received: by 2002:a5d:4785:: with SMTP id w5-v6mr2069774wrq.188.1533293457606;
        Fri, 03 Aug 2018 03:50:57 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id b13-v6sm6149199wrn.17.2018.08.03.03.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 03:50:56 -0700 (PDT)
Date:   Fri, 3 Aug 2018 12:50:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, Kyle Evans <kvans32@gmail.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpu: host1x: Ignore clients initialization failure
Message-ID: <20180803105055.GC28546@ulmo>
References: <20180801150807.15926-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <20180801150807.15926-1-digetx@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 06:08:07PM +0300, Dmitry Osipenko wrote:
> From time to time new bugs are popping up, causing some host1x client to
> fail its initialization. Currently a single clients initialization failure
> causes whole host1x device registration to fail, as a result a single DRM
> sub-device initialization failure makes whole DRM initialization to fail.
> Let's ignore clients initialization failure, as a result display panel
> lights up even if some DRM clients (say GR2D or VIC) fail to initialize.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/host1x/bus.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

This is actually done on purpose. I can't think of a case where we would
actively like to keep a half-broken DRM device operational. The errors
that you're talking about should only happen during development, and the
device not showing up is a pretty good indicator that something is wrong
as opposed to everything booting normally and then getting some cryptic
error at runtime because one of the clients didn't initialize.

=46rom my perspective, all clients should always be operational in
whatever baseline version you use. If it isn't that's a bug that should
be fixed. Ideally those bugs should get fixed before making it into a
baseline version (mainline, linux-next, ...), so that this never impacts
even developers, unless they break it themselves, in which case refusing
to register the DRM device is a pretty good incentive to fix it.

Thierry

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltkM48ACgkQ3SOs138+
s6Hm1BAAoGsbJGzgHXS7YAf1X9ZYxz85nfkxuOjGHeVKZ0lIOhBDpuWrI3yLURAE
e4rwNMQVJiF+EPQ1n6TIl/WC3qgDaV7YZkaI5giyXkshdrLOE/YOEvRTBItDUIQY
+0/JExd0xNOUbYBId/YWfxVQOhGY+CCEqyg2ElZPYftSS82m88rxWQfmGKsXzh+7
iK0HxrAQIxLyBkbWqOLb3efku+CXFlG0Po8Km/JZ3gb+kpeb8j4JS5ldgy7nTOyu
hjx4vco54+bUoGUpLCGLlVIbVgz7maKrgiZ2LQaw4D+MPZ7pQ4eXUrJhXfXU7esM
FF2nObIzxo2ZR2tV8Ux5RozCKqD5Q6x3iY2YyYzwf2FW+lcADxHMcdxRaKE/HIWW
5f75xsVTJpsEnR7PyvWeJHEgf5zecTO9PQwiQMgqgAppDISrZGnOOXTe7JPyz28B
euJF3ARA/Gme8fQoL7KrNc5nC8cSDyVQIVq/1hIOu0CFjNiWJU1M8B1ZgdKb7umH
6nW06KYXaDBI7NXgx3QAnEuohTTDPsfYTVNw2KtCmNf+HnYrMun4SCACUt/RHJkJ
dO/xO8IV+XVp5knGHxN9tir0Xn7o9qgpU093jX2Uaq5xlsSXW4f9upQ3Qjt6ddjL
ooqeanlSWN/lsbSSOkOwF7e5AIphoq6vrDU1uyl83cTW4pd7oC0=
=em8O
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
