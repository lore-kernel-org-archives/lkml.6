Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E87AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163EF20578
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IwHR6ITw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405920AbfAPRSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:18:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38785 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfAPRSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:18:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so3309063plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZTiHF3dL+2srsmvssgd9ObZTL3s29JwNyOk6wAQF10Y=;
        b=IwHR6ITwxyt3b2CWTgmNjHANS4gmQledAxOXiMHswCHz/xLfPVxbU8BBevwVaAfpdx
         2iAOsl6omCigjzyzO9eKUtexe7lhU/Q7jZd0LWapEgsaGEQryfV2u7VmwBcgKlsYoWcp
         bMOVuF6rlAZNKp5vzPcafNDiILF7H6ehsrhv5cdS98NzLslHpclX4oeCZHZJdQgL0hpp
         DSOvvQHdShbMwk+X9meaONPOoRsDq7NjV7DIdgdybuPdpq6yeXEWmHYZbF9X2vDtBuo3
         2P3AROnEeI2gkl014SZgWzeeIPt0Dfdc4DhWqK5XxntQnHU4+uJ443WK43MXOA8RGCtm
         dE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZTiHF3dL+2srsmvssgd9ObZTL3s29JwNyOk6wAQF10Y=;
        b=tT8Au85wd348tYfklZfKHa+KD3HMaQ0ycQ9N0zBb+7FLYYm29VF4jezSgv2qhs6gnV
         m/LWrKDauVmjEnm/m56PmHRUfNeqV2s5QIiBcPmt2do/N4nXrg+2VdeAROteXMGzB+4g
         QQTN/nTQORvEIZMHKBPMFs68LaLLVp2Z25b673jeCguRI/8cy/Y6Pu6pA8LkMS03L9Gm
         xjyjH+93EzF3AUDllgQ2kspSrfIXX0Jq4MxYDRR//xRR05c4eScA3rQsJSFDURgMyoDE
         Hg0/t603sp2X0AgdxCU+xKktbMnO6InRrjnASl3joMkWX76ui8OYZa79ljNlNNG2YHwl
         XZPw==
X-Gm-Message-State: AJcUukeSlhX04YqJtrJwNofLo2v9JzAEuZFVZvC5Ci1f15czJfeskjtp
        p90q9Kp7nECugVDuR8iSD8G38g==
X-Google-Smtp-Source: ALg8bN75ZlXgeuf3XWu6SSZjOj9NOU9HLQ37HC38cXDiHArS8zTJukwiUl2PXmBP/rZaDiLrUFlACg==
X-Received: by 2002:a17:902:925:: with SMTP id 34mr10638623plm.14.1547659127552;
        Wed, 16 Jan 2019 09:18:47 -0800 (PST)
Received: from localhost ([2607:f598:b382:d300::14ef])
        by smtp.gmail.com with ESMTPSA id q199sm12601950pfc.97.2019.01.16.09.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 09:18:46 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Wed, 16 Jan 2019 09:18:45 -0800 (PST)
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Yash Shah <yash.shah@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
In-Reply-To: <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
Message-ID: <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com> <1547194964-16718-3-git-send-email-yash.shah@sifive.com> <20190115220046.etgbno6ymsux75dk@pengutronix.de> <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-800223328-1547659125=:19681"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-800223328-1547659125=:19681
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Jan 2019, Uwe Kleine-K=F6nig wrote:

> On Wed, Jan 16, 2019 at 04:40:42PM +0530, Yash Shah wrote:
> > On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > index a8f47df..3bcaf6a 100644
> > > > --- a/drivers/pwm/Kconfig
> > > > +++ b/drivers/pwm/Kconfig
> > > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > > >         To compile this driver as a module, choose M here: the modu=
le
> > > >         will be called pwm-samsung.
> > > >
> > > > +config PWM_SIFIVE
> > > > +     tristate "SiFive PWM support"
> > > > +     depends on OF
> > > > +     depends on COMMON_CLK
> > >
> > > I'd say add:
> > >
> > >         depends on MACH_SIFIVE || COMPILE_TEST
> > >
> > > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
> >=20
> > As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
> > @Paul, Do you have any comments on this?
>=20
> If this is not going to be available at least protect it by
>=20
> =09depends RISCV || COMPILE_TEST

There's nothing RISC-V or SiFive SoC-specific about this driver or IP=20
block.  The HDL for this IP block is open-source and posted on Github. =20
The IP block and driver would work unchanged on an ARM or MIPS SoC, and in=
=20
fact, SiFive does design ARM-based SoCs as well.  Likewise, any other SoC=
=20
vendor could take the HDL for this IP block from the git tree and=20
implement it on their own SoC.

More generally: it's a basic principle of Linux device drivers that they=20
should be buildable for any architecture.  The idea here is to prevent=20
developers from burying architecture or SoC-specific hacks into the=20
driver.  So there shouldn't be any architecture or SoC-specific code in=20
any device driver, unless it's abstracted in some way - ideally through a=
=20
common framework.

So from this point of view, neither "depends MACH_SIFIVE" nor "depends=20
RISCV" would be appropriate.  Similarly, the equivalents for other=20
architectures (e.g. "ARCH_ARM") or SoC manufacturers (e.g.,=20
"MACH_SAMSUNG") wouldn't be appropriate for any generic IP block device=20
driver like this one.


- Paul
--8323329-800223328-1547659125=:19681--
