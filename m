Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39B7C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFEB2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="W+iyERRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfAZSls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 13:41:48 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:57016 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfAZSlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 13:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4aqitaXZZxry87Mz1gDCXnlMlKGWW/rfnM/cXX+RYFI=; b=W+iyERRqvNlkXIOkN+N4jfjE7
        /2rjkuvNZxOyuLMZZ/jAxEi7An7WkH7+M8IVcsVQE2PXxHlEi4674sFOTXx/3uETJTj8Nx+il99fe
        dn98kDdQxNkZ7xsYj0T1KvZ9SFs6QvUKzXztrw98Ngg0Klr3pUBfogYfjSbsDmvgf9/Q8=;
Received: from p5dc58b75.dip0.t-ipconnect.de ([93.197.139.117] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gnStk-000070-PF; Sat, 26 Jan 2019 19:41:44 +0100
Date:   Sat, 26 Jan 2019 19:41:45 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] bus: ti-sysc: Fix timer handling with drop
 pm_runtime_irq_safe()
Message-ID: <20190126194145.2b3484da@aktux>
In-Reply-To: <20190122175717.13428-3-tony@atomide.com>
References: <20190122175717.13428-1-tony@atomide.com>
        <20190122175717.13428-3-tony@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2RvUWKBcFzdZgkVQ.ToJv5/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2RvUWKBcFzdZgkVQ.ToJv5/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jan 2019 09:57:16 -0800
Tony Lindgren <tony@atomide.com> wrote:

> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
> them with ti-sysc") started producing a warning for pwm-omap-dmtimer:
>=20
> WARNING: CPU: 0 PID: 77 at drivers/bus/omap_l3_noc.c:147
> l3_interrupt_handler+0x2f8/0x388
> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle):
> Data Access in Supervisor mode during Functional access
> ...
> __pm_runtime_idle
> omap_dm_timer_disable
> pwm_omap_dmtimer_start
> pwm_omap_dmtimer_enable
> pwm_apply_state
> pwm_vibrator_start
> pwm_vibrator_play_work
>=20
> This is because the timer that pwm-omap-dmtimer is using is now being
> probed with ti-sysc interconnect target module instead of omap_device
> and the ti-sysc quirk for SYSC_QUIRK_LEGACY_IDLE is not fully
> compatible with what omap_device has been doing.
>=20
> We could fix this by reverting the timer changes and have the timer
> probe again with omap_device. Or we could add more quirk handling to
> ti-sysc driver. But as these options don't work nicely as longer term
> solutions, let's just make timers probe with ti-sysc without any
> quirks.
>=20
> To do this, all we need to do is remove quirks for timers for ti-sysc,
> and drop the bogus pm_runtime_irq_safe() flag for timer-ti-dm.
>=20
> We should not use pm_runtime_irq_safe() anyways for drivers as it will
> take a permanent use count on the parent device blocking the parent
> devices from idling and has been forcing ti-sysc driver to use a
> quirk flag.
>=20
> Note that we will move the timer data to DEBUG section later on in
> clean-up patches.
>=20
together with 1/3 it fixes things on pyra.

Tested-By: Andreas Kemnade <andreas@kemnade.info>

--Sig_/2RvUWKBcFzdZgkVQ.ToJv5/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxMqekACgkQfb1qx03i
kySStxAAldk/NK4MDi3dXbEZDaUuskh8JlfN1iOQ1Bg2RzoBFN409hhj831VVcAy
6pVXmQl101j9tPEVWHEKg1yBfhWP/RpXe5ozMFTirZ6VYMqFn8xQhjqDcdQO1pix
ZvaR3uO0WGJ0iuRsD9ktllZKzSL6QSjv/19hJ06zxm7Ssvgw8dyyBI49Eb0i+eRW
EqKkHTmxwMkV/yP8IMLm9u2e0yd1gwZPSkCXzFmZisw0+F3T532lqbFQyoMpsBfd
pJCZN58bBmYbOlkuRM23+TZmCfFayhjJhMBjmTRsb76z32wTMGbd0tMhLKe2i/N8
9RwV8+zOidaRe6fZOSwVn9K/RCHkywr3ENuIBgqQhHSXkv/m6g18qlny7wU/wybj
HTCpfJlobco6YqhEAijk+HVCtcg5zmtn0f2BmP4NMU2j86mq5XFyGjyJl6J5qwNZ
/8kuN0/RmY04uRO3rFuQQuZXxho5mwx1ijohfWBczwGtdPGGuHgkls2XI24vwGdZ
tr/dQ/SSVP3toDMNyX8bbw+9PWkeMyu15Mwm4Ps4GV0XDks+5RLB59jfvvMVrmuR
uhYCsmR4roUF9VO5u3l0RghgnzX6GAu2pQbSKDE0VJUlE1dAaRZ2zs8jebRU26Ij
nyrrA2eOrTKGOXVYe9yjo9CyoMi+LDTei6ZHI9JulhhJsT6Imw4=
=c0sf
-----END PGP SIGNATURE-----

--Sig_/2RvUWKBcFzdZgkVQ.ToJv5/--
