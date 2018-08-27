Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D6AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F4F208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F4F208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeH0NeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:34:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59447 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0NeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:34:11 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C3D4982F86; Mon, 27 Aug 2018 11:48:11 +0200 (CEST)
Date:   Mon, 27 Aug 2018 11:48:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Gu Zhimin <kookoo.gu@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Yu Chen <yu.c.chen@intel.com>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86, hibernate: Fix nosave_regions setup for
 hibernation
Message-ID: <20180827094811.GA31905@amd>
References: <cover.1535361949.git.kookoo.gu@intel.com>
 <73b18a8b87a465fc442366cccf5542307c4f1ae9.1535361949.git.kookoo.gu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <73b18a8b87a465fc442366cccf5542307c4f1ae9.1535361949.git.kookoo.gu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-08-27 17:42:05, Gu Zhimin wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
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
> On the problematic 32bit system, there are reserved memory above low memo=
ry,
> which triggered the MCE:
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
> This issue should also exist on 64bits systems, if there are reserved
> regions above 4GB.
>=20
> Acked-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluDyNsACgkQMOfwapXb+vIU0wCfXZND0ye9TaIHs0qACEiZw0q2
fMsAnRFaIfhY/BFAtMgL/AvBVYucJtFg
=nVgm
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
