Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7042EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AFC20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AFC20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeKIRwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:52:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43741 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeKIRwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:52:53 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ED88A80642; Fri,  9 Nov 2018 09:13:20 +0100 (CET)
Date:   Fri, 9 Nov 2018 09:13:22 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4.18 30/34] x86, hibernate: Fix nosave_regions setup for
 hibernation
Message-ID: <20181109081322.GA12450@amd>
References: <20181108215138.892971755@linuxfoundation.org>
 <20181108215140.736117265@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20181108215140.736117265@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-11-08 13:52:59, Greg Kroah-Hartman wrote:
> 4.18-stable review patch.  If anyone has any objections, please let me kn=
ow.
>

For the record, this and

[PATCH 4.14 27/31] x86, hibernate: Fix nosave_regions setup

makes sense to me.

Best regards,
								Pavel



> ------------------
>=20
> From: Zhimin Gu <kookoo.gu@intel.com>
>=20
> commit cc55f7537db6af371e9c1c6a71161ee40f918824 upstream.
>=20
> On 32bit systems, nosave_regions(non RAM areas) located between
> max_low_pfn and max_pfn are not excluded from hibernation snapshot
> currently, which may result in a machine check exception when
> trying to access these unsafe regions during hibernation:
>=20
> [  612.800453] Disabling lock debugging due to kernel taint
> [  612.805786] mce: [Hardware Error]: CPU 0: Machine Check Exception: 5 B=
ank 6: fe00000000801136
> [  612.814344] mce: [Hardware Error]: RIP !INEXACT! 60:<00000000d90be566>=
 {swsusp_save+0x436/0x560}
> [  612.823167] mce: [Hardware Error]: TSC 1f5939fe276 ADDR dd000000 MISC =
30e0000086
> [  612.830677] mce: [Hardware Error]: PROCESSOR 0:306c3 TIME 1529487426 S=
OCKET 0 APIC 0 microcode 24
> [  612.839581] mce: [Hardware Error]: Run the above through 'mcelog --asc=
ii'
> [  612.846394] mce: [Hardware Error]: Machine check: Processor context co=
rrupt
> [  612.853380] Kernel panic - not syncing: Fatal machine check
> [  612.858978] Kernel Offset: 0x18000000 from 0xc1000000 (relocation rang=
e: 0xc0000000-0xf7ffdfff)
>=20
> This is because on 32bit systems, pages above max_low_pfn are regarded
> as high memeory, and accessing unsafe pages might cause expected MCE.
> On the problematic 32bit system, there are reserved memory above low
> memory, which triggered the MCE:
>=20
> e820 memory mapping:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000d160cfff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x00000000d160d000-0x00000000d1613fff] ACP=
I NVS
> [    0.000000] BIOS-e820: [mem 0x00000000d1614000-0x00000000d1a44fff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x00000000d1a45000-0x00000000d1ecffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000d1ed0000-0x00000000d7eeafff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x00000000d7eeb000-0x00000000d7ffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000d8000000-0x00000000d875ffff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x00000000d8760000-0x00000000d87fffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000d8800000-0x00000000d8fadfff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x00000000d8fae000-0x00000000d8ffffff] ACP=
I data
> [    0.000000] BIOS-e820: [mem 0x00000000d9000000-0x00000000da71bfff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x00000000da71c000-0x00000000da7fffff] ACP=
I NVS
> [    0.000000] BIOS-e820: [mem 0x00000000da800000-0x00000000dbb8bfff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x00000000dbb8c000-0x00000000dbffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000dd000000-0x00000000df1fffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041edfffff] usa=
ble
>=20
> Fix this problem by changing pfn limit from max_low_pfn to max_pfn.
> This fix does not impact 64bit system because on 64bit max_low_pfn
> is the same as max_pfn.
>=20
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> ---
>  arch/x86/kernel/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1258,7 +1258,7 @@ void __init setup_arch(char **cmdline_p)
>  	x86_init.hyper.guest_late_init();
> =20
>  	e820__reserve_resources();
> -	e820__register_nosave_regions(max_low_pfn);
> +	e820__register_nosave_regions(max_pfn);
> =20
>  	x86_init.resources.reserve_resources();
> =20
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvlQaIACgkQMOfwapXb+vK6wQCeIgJEeHG/NdKt938YZOz5fYCh
FS8AoLV+XGFlXZ0l2YcjEW38a6a+zfP0
=Oykp
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
