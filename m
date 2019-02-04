Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1746C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0C2214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTA2MgZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfBDHaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:30:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34940 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfBDHaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:30:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id r17so7283330wrp.2;
        Sun, 03 Feb 2019 23:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DoFn+xdgznSpaBxrAbm7pTEdZhwTGwlxKuzIl5XMK/s=;
        b=nTA2MgZM4Y0heigMtoeH/iatpsrc/wKJrlVhG4HMhbrk1+ObWe5N9jpKyeWqfy+HhH
         dBlaa7H+aUg+lyIHIPJXbphpwoZKON9LaBKwcgBf/sqeyc9A+n1tV48L5RBVOTIrNrFm
         MCppmWqU4DaTW0dqNs1eCXZFd4ExSiZOcRShOMZKutxM8sjKlt836eOFdwM9sQjZVfVw
         cjQvuosXC5qvyBU+3veZ7YnYzenRuRWYD20LQfreVSyPqNbZ5WpuYYSUstQ6Iw7yYYXG
         noN8Cw5VqHe6ANvqEFzDjk/zpRTCwX0d122BCdWx7WDTfp9NdIMnuWgBe2ZPTY8Ig+bD
         Al8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DoFn+xdgznSpaBxrAbm7pTEdZhwTGwlxKuzIl5XMK/s=;
        b=e6Rpxve5BPIfA0ibQwY4fcvN2qx+GZ9uVur5qpbeHL2TPY5gFpInx3HAQ4xVTJaHqY
         Df3zi/WurkPv7InN1nLopRzfRe/0j8M3kTRI8WFZfsIpVXEnmSUvcA/0Fu/ebBwgXu72
         QYWU115GCXJJyLxSBxKd/HYBhq4thDtFbnmPfjujznOH+LcqCEelxTGJeGfsoa8uHue4
         a1CTndyrhm0Isv/copf37BxNd7WWpaXXJ1yVZvmhbktq/xG/i5yt6OyLgEmG397yTSis
         E2SbLIOJCu69ha2KHNifaIAeqDDJuzwC+JloLS76hqMbLXxBheoNcFSZ1zvSPmHHeO7z
         m4IQ==
X-Gm-Message-State: AJcUukc86yJ4+78UIIkyGB7ia3FI+jymtAG86AJLX+JNs6R/HiI5hXqH
        d+D0G1N2Jqr1m/WZY/dwpIRuQV4VUv4=
X-Google-Smtp-Source: ALg8bN62TOnKpBbDXuu3xNd/NK99VaYAKSk1KvEEKBMbD+4IsbSkw+1/9MALlT3eSEcQ/aAHFkfNow==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr50217074wrf.164.1549265405253;
        Sun, 03 Feb 2019 23:30:05 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id o8sm17798169wrx.15.2019.02.03.23.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 23:30:04 -0800 (PST)
Date:   Mon, 4 Feb 2019 08:30:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: build failure after merge of the drm-tegra tree
Message-ID: <20190204073003.GB16448@ulmo>
References: <20190204111241.278b6215@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20190204111241.278b6215@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 11:12:41AM +1100, Stephen Rothwell wrote:
> Hi Thierry,
>=20
> After merging the drm-tegra tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>=20
> drivers/gpu/host1x/cdma.c: In function 'host1x_cdma_wait_pushbuffer_space=
':
> drivers/gpu/host1x/cdma.c:279:13: error: 'struct host1x_cdma' has no memb=
er named 'sem'
>    down(&cdma->sem);
>              ^~
>=20
> Caused by commit
>=20
>   abb289796799 ("gpu: host1x: Use completion instead of semaphore")
>=20
> interacting with commit
>=20
>   db5652be58a9 ("gpu: host1x: Introduce support for wide opcodes")
>=20
> I have used the drm-tegra tree from next-20190201 for today.

Oh my... so I go through all the build testing and then pull in the
seemlessly harmless fix and ruin everything...

I've fixed it up in my tree now, thanks.

Thierry

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX6fsACgkQ3SOs138+
s6HwkA/+NQ62abvdo/YP6rg2FdIQbFVodcXKOf0wvWAE//O6xdEFtHghQaHbzkn1
jp+Guv8Y6/mEnHHfbsTE+OUXh1AyRJ0BOq6t7saVA3hiV81IQAuGwSWaV9C/i5dQ
8aRGgkIeegxrECAL4i1+B+EkdZbMif1zZ3fypydI13kdQvl04gUHGl+iKYxwQWJg
rX2dRHbBVbODb6X9PwEslEWfm1ArAAy6z+I98J7sMQ5BLSGqzsD29KxyUR4x107R
g+I6JFz4Djy0SAM+b/h66jyn7fvy3kvpvknOj/9+0sWatGlNUVOKhWcwMww+rg69
cdVPKDrPYm7Eoq7Wf+OHKaXvvqa3yKJudwDW+q8IKU4Aup2/WbKyvog+onJoOdmA
sdUWJ6+XN+7ln5jsY/gwRE0m4Kk7BMLGcwS356Qxun0Ygiy+Dh4igauZV/4hJBKm
vk/wmUEnxzuk4Ffl+jYGynQT/rSVWpxaL1FdsBuh7QrkONPgcPQjma+LuiNV0y9y
DsRuCGY2kTCWlAKO+FH9YkMrkvI++Bcc61qzAzK7o6+pWeOavtjcwMCIMOte2meQ
2DZ50Mi6RA03TEqj4bIutXzY8k61/5z93AJWYJddgyJUMZs0sT4SInvs7X0N8lVZ
ALcvMp8YnrcpxrhlspKABowfVm9o6IG0cuj9O+K6wTAEp4EcR98=
=aLFD
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
