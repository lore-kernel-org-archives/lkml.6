Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32837C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D842088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzBq5DqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D842088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966057AbeFOTJV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:09:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41563 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965052AbeFOTJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:09:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so10864890wrq.8;
        Fri, 15 Jun 2018 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=70gOuKoiHgxaifenbwEfrp4GaSForhGZoPmlVkJandU=;
        b=IzBq5DqBK4mPaWXBweSPtbG1cRxIO1cT3Al0CySe2J5ihRAmYXWbRVeX1cuJAgYckq
         vRM/sRwl+BhWY3Ke85xverH8nIQFrtn9En8o65GIl3cGDq+w/Y1k0gxick8hfDsYtkfT
         jY+DVENWVtRJ/p9Fu31WWBUuVYnV9KVXQ9WYhXss9LEw//OxI12c8S3v/PdFBHw3zkek
         +K+hDILcZyZrElKFPgLlfHAk04MBJMnM4Ad/vyxITy6M27RDSKm8gL70mk6mLkl9XlzT
         BuynTd25yuuz8kzxWESXwdbCra+D/oHBkSk023IKwOq9jzKL4EtN0tH81CZk0T/n22p7
         B+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=70gOuKoiHgxaifenbwEfrp4GaSForhGZoPmlVkJandU=;
        b=eVvKF4bsiBIYcvG0TScdf+Rx2Jc4KktAshsNMEWKpN2pmTfxFhq5JOBRFsrhYR7WSS
         PSowzh8yHNbtNr9vi+qElUHd3phHG5RrAO5Zj+OaFNN4rHmUX3+DxhiFnD6D9nmcjKZN
         16ALr1rPEv1Sg4F0+vKNrYsCAxOjrsb+ewMMCGofnq4vlmZM017i7PN6or6kPYdrHQhE
         6Gzn+nrZNQ4dsTiOpa2MC7XfCIBSqApFeBSZzeP812kzjF/e5T4QG8C0yyBRQ4EyUPE+
         KXwRaMF7NzNF+9sA+MT1qBLAtOzsfssxwg4Hc57IwzR/9tBtk/SNCj/nn8Z8iYnhSF3G
         kgXw==
X-Gm-Message-State: APt69E2K0X/VpWmwvaerdblTbnfWviQeK+gOt+dB8at9AEwGtHes6Uz6
        sJqmo6PQucJk9ubhUhup9Co=
X-Google-Smtp-Source: ADUXVKIKEM9Sfh5cQUYrkDf0gjaN/jU1zK36Zi38yrLxvupWr8tmvFyjxgOoIGo62xeWOCYm1l7CMA==
X-Received: by 2002:a5d:4049:: with SMTP id w9-v6mr2738168wrp.96.1529089758034;
        Fri, 15 Jun 2018 12:09:18 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l41-v6sm14199469wre.87.2018.06.15.12.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 12:09:16 -0700 (PDT)
Date:   Fri, 15 Jun 2018 21:09:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180615190915.cdntdeesc52ei35u@pali>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <20180615112606.GA3986@amd>
 <20180615113728.h7snxhe2juaqvjyx@pali>
 <20180615123007.nxsymdvr3nj3it5i@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nxzveii33etgxj24"
Content-Disposition: inline
In-Reply-To: <20180615123007.nxsymdvr3nj3it5i@khazad-dum.debian.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nxzveii33etgxj24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 15 June 2018 09:30:07 Henrique de Moraes Holschuh wrote:
> On Fri, 15 Jun 2018, Pali Roh=C3=A1r wrote:
> > Henrique, any idea why there are no exported led classes for mute and
> > micmute? And how are suppose to be controlled?
>=20
> I have to look into the code, it was contributed by someone who had
> access to the proper hardware to test it.
>=20
> But the way *I* would like it to work is this:
>=20
> 1. When implemented in *hardware* or *EC*, let the hardware and EC take
>    full control, and never allow the operating system to mess with it.
>    So, it becomes much harder for that LED to "lie".

This means that kernel should not export any led class device. Or when
exported, then "set" operation should always fail.

> 2. Otherwise implement it in-kernel, so that userspace cannot unmute
>    when the human has activated the "mute" switch, and the LED cannot be
>    controlled by userspace to lie (report mute when it is not mute).

This looks like a good candidate to use led "trigger" interface. Create
a mute trigger and attach it to that led device.

I hope that this is what Pavel means.

> It might, or might not be possible to achieve the above.
>=20
> > > With thinkpad_acpi.ko unloaded, hardware drives the LEDs, so nothing
> > > for us to do...
> >=20
> > So somehow tell thinkpad_acpi.ko to let hardware control those LEDs when
> > thinkpad_acpi.ko is loaded?
>=20
> I.e. look into the DSDT and XSDT, to find out what it is doing.  It will
> be there: it is very rare for the thinkpad EC itself to implement these
> behavior changes.

DSDT helped. Thanks!

Function with "EC.LED" name is self explaining and also "EC.HKEY". I
used acpi_call.ko for debugging and here are results how to control
these two leds on ThinkPad T480s:

        Scope (\_SB.PCI0.LPCB.EC.HKEY)
        {
            Method (MMTG, 0, NotSerialized)
            {
                Local0 =3D 0x0101
                If (HDMC)
                {
                    Local0 |=3D 0x00010000
                }

                Return (Local0)
            }

            Method (MMTS, 1, NotSerialized)
            {
                If (HDMC)
                {
                    Noop
                }
                ElseIf (Arg0 =3D=3D 0x02)
                {
                    \_SB.PCI0.LPCB.EC.LED (0x0E, 0x80)
                }
                ElseIf (Arg0 =3D=3D 0x03)
                {
                    \_SB.PCI0.LPCB.EC.LED (0x0E, 0xC0)
                }
                Else
                {
                    \_SB.PCI0.LPCB.EC.LED (0x0E, 0x00)
                }
            }
        }

        Scope (\_SB.PCI0.LPCB.EC.HKEY)
        {
            Method (GSMS, 1, NotSerialized)
            {
                Return (\AUDC (0x00, 0x00))
            }

            Method (SSMS, 1, NotSerialized)
            {
                Return (\AUDC (0x01, (Arg0 & 0x01)))
            }

            Method (SHDA, 1, NotSerialized)
            {
                Local0 =3D Arg0
                If ((OSYS >=3D 0x07DF) && (Local0 =3D=3D 0x01))
                {
                    Local0 =3D 0x02
                }

                Return (\AUDC (0x02, (Local0 & 0x03)))
            }
        }

    Method (AUDC, 2, NotSerialized)
    {
        Return (SMI (0x14, 0x07, Arg0, Arg1, 0x00))
    }

MMTS controls mic mute led. When Arg0 is 0x02 then mic mute led is
turned on. When it is 0x03 then it starts blinking. And otherwise is
turned off. MM in name probably means MicMute and S as set. I guess that
MMTG (G as get) would return capabilities as it returns constant.

blink: echo "\_SB.PCI0.LPCB.EC.HKEY.MMTS 3" > /proc/acpi/call
on:    echo "\_SB.PCI0.LPCB.EC.HKEY.MMTS 2" > /proc/acpi/call
off:   echo "\_SB.PCI0.LPCB.EC.HKEY.MMTS 0" > /proc/acpi/call

SSMS controls mute led. It calls some SMI method via AUDC. When Arg0 has
first bit set to one then mute led is turned on. When set to zero then
is turned off. GSMS takes one parameter, but ignores it. When mute led
is turned off then it returns 0x100. When mute led is turned on then it
return 0x101. So looks like that "G" in GSMS means "get" and "S" in SSMS
means set. What is SHDA doing, I have not figured out. It does not
change GSMS result nor led status. When called with argument 1..10 then
it returns always returned 0x0 except for 3 and 7 it returned
0x80000000. There is no blinking support (or at least I have not figured
out).

on:    echo "\_SB.PCI0.LPCB.EC.HKEY.SSMS 1" > /proc/acpi/call
off:   echo "\_SB.PCI0.LPCB.EC.HKEY.SSMS 0" > /proc/acpi/call

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nxzveii33etgxj24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWyQO2AAKCRCL8Mk9A+RD
UsbLAJ9Z/rS7vsdYqcH3z2t3XJ/NaSbjDwCfXG/D1KRqD6yO8rv0s/CCEfKLJcM=
=lPFY
-----END PGP SIGNATURE-----

--nxzveii33etgxj24--
