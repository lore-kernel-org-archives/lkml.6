Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0558C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6906720874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPnhJb6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6906720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933568AbeFTWIO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933249AbeFTWIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:08:13 -0400
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55DCF20872;
        Wed, 20 Jun 2018 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529532492;
        bh=8c9Th0Bs/Kk9+gazLHbfR4eko57RihmLhcVBZuUcBO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPnhJb6Bb26dkrITxnxNkUvdIVPnYMxTJDWCN9CxrVJjwbvmSAc+TRaZ8U/rhYQkd
         qgy04TcI7SdDAJIEzH6gDPWRBd3wCMdYDX4mOvPtANUUMWk3lC+y6pEKxagGCd8rmN
         XWwCYoIkYY7h37N+k9FP8x1H3b9LFVCrMVp/IBqM=
Date:   Wed, 20 Jun 2018 23:08:08 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mips: generic: allow not building DTB in
Message-ID: <20180620220807.GD22606@jamesdev>
References: <20180425211607.2645-1-alexandre.belloni@bootlin.com>
 <20180425211607.2645-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <20180425211607.2645-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 11:16:07PM +0200, Alexandre Belloni wrote:
> Allow not building any DTB in the generic kernel so it gets smaller. This
> is necessary for ocelot because it can be built as a legacy platform that
> needs a built-in DTB and it can also handle a separate DTB once it is
> updated with a more modern bootloader. In the latter case, it is preferab=
le
> to not include any DTB in the kernel image so it is smaller.

Since bootloaders can modify DTs before passing them to the kernel (e.g.
to add cmdline args or memory nodes), that would seem to make it
impossible to have a kernel supporting both legacy bootloader, and a
u-boot which might do that DT tweaking.

Or perhaps its not important for this platform.

> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 5e9fce076ab6..3d3554c13710 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -404,7 +404,7 @@ endif
>  CLEAN_FILES +=3D vmlinux.32 vmlinux.64
> =20
>  # device-trees
> -core-$(CONFIG_BUILTIN_DTB) +=3D arch/mips/boot/dts/
> +core-y +=3D arch/mips/boot/dts/

Won't that result in DTBs being built unnecessarily on other platforms
which support BUILTIN_DTB but don't have it enabled?

I suppose the alternative is another Kconfig symbol for when building of
DTBs is needed, selected by BUILTIN_DTB and MIPS_GENERIC.

> =20
>  %.dtb %.dtb.S %.dtb.o: | scripts
>  	$(Q)$(MAKE) $(build)=3Darch/mips/boot/dts arch/mips/boot/dts/$@
> diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/M=
akefile
> index 8982b19504a3..437ec65ec14a 100644
> --- a/arch/mips/boot/dts/mscc/Makefile
> +++ b/arch/mips/boot/dts/mscc/Makefile
> @@ -1,3 +1,3 @@
>  dtb-$(CONFIG_MSCC_OCELOT)	+=3D ocelot_pcb123.dtb
> =20
> -obj-y				+=3D $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +obj-($CONFIG_BUILTIN_DTB)	+=3D $(patsubst %.dtb, %.dtb.o, $(dtb-y))

(This part is already merged in 4.18-rc1 in commit fca3aa166422 ("MIPS:
dts: Avoid unneeded built-in.a in DTS dirs"))

> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index 6564f18b2012..012f283f99c4 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -3,6 +3,7 @@ if MIPS_GENERIC
> =20
>  config LEGACY_BOARDS
>  	bool
> +	select BUILTIN_DTB
>  	help
>  	  Select this from your board if the board must use a legacy, non-UHI,
>  	  boot protocol. This will cause the kernel to scan through the list of
> diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.=
its.S
> index 1a08438fd893..9c954f2ae561 100644
> --- a/arch/mips/generic/vmlinux.its.S
> +++ b/arch/mips/generic/vmlinux.its.S
> @@ -21,6 +21,7 @@
>  		};
>  	};
> =20
> +#if IS_ENABLED(CONFIG_BUILTIN_DTB)

An #ifdef would do, but no matter if it works. Though shouldn't that be
if !IS_ENABLED (or #ifndef)?

A comment would be great here too to mention why its helpful.

Cheers
James

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWyrQRwAKCRA1zuSGKxAj
8u2XAPwOaQsDGCEy8PQdCR0hxJyLb/ZLthX1f4lTVcjnaf2KBwD9GDnCw0tJXsWM
mhevw/torZmNvC+Dap23ntXernSm5QM=
=MtcW
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
