Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B73C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE7F20874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbeL1Qiv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:38:51 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:22315 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbeL1Qiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:38:51 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43RC8739THz9v118;
        Fri, 28 Dec 2018 17:38:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tJgowDavkt9D; Fri, 28 Dec 2018 17:38:47 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43RC872bZsz9v117;
        Fri, 28 Dec 2018 17:38:47 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id B14EB614; Fri, 28 Dec 2018 17:38:46 +0100 (CET)
Received: from 37.165.157.78 ([37.165.157.78]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Fri, 28 Dec 2018 17:38:46 +0100
Date:   Fri, 28 Dec 2018 17:38:46 +0100
Message-ID: <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finn Thain <fthain@telegraphics.com.au> a écrit :

> On powerpc, setting CONFIG_NVRAM=n builds a kernel with no NVRAM support.
> Setting CONFIG_NVRAM=m enables the /dev/nvram misc device module without
> enabling NVRAM support in drivers. Setting CONFIG_NVRAM=y enables the
> misc device (built-in) and also enables NVRAM support in drivers.
>
> m68k shares the valkyriefb driver with powerpc, and since that driver uses
> NVRAM, it is affected by CONFIG_ATARI_SCSI, because of the use of
> "select NVRAM".
>
> Adopt the powerpc convention on m68k to avoid surprises.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Christian T. Steigies <cts@debian.org>
> ---
> This patch temporarily disables CONFIG_NVRAM on Atari, to prevent build
> failures when bisecting the rest of this patch series. It gets enabled
> again with the introduction of CONFIG_HAVE_ARCH_NVRAM_OPS, once the
> nvram_* global functions have been moved to an ops struct.
> ---
>  drivers/char/Kconfig      | 5 +----
>  drivers/scsi/Kconfig      | 6 +++---
>  drivers/scsi/atari_scsi.c | 7 ++++---
>  3 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 9d03b2ff5df6..5b54595dfe30 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -236,7 +236,7 @@ source "drivers/char/hw_random/Kconfig"
>
>  config NVRAM
>  	tristate "/dev/nvram support"
> -	depends on ATARI || X86 || GENERIC_NVRAM
> +	depends on X86 || GENERIC_NVRAM
>  	---help---
>  	  If you say Y here and create a character special file /dev/nvram
>  	  with major number 10 and minor number 144 using mknod ("man mknod"),
> @@ -254,9 +254,6 @@ config NVRAM
>  	  should NEVER idly tamper with it. See Ralf Brown's interrupt list
>  	  for a guide to the use of CMOS bytes by your BIOS.
>
> -	  On Atari machines, /dev/nvram is always configured and does not need
> -	  to be selected.
> -
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nvram.
>
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 640cd1b31a18..924eb69e7fc4 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -1381,14 +1381,14 @@ config ATARI_SCSI
>  	tristate "Atari native SCSI support"
>  	depends on ATARI && SCSI
>  	select SCSI_SPI_ATTRS
> -	select NVRAM
>  	---help---
>  	  If you have an Atari with built-in NCR5380 SCSI controller (TT,
>  	  Falcon, ...) say Y to get it supported. Of course also, if you have
>  	  a compatible SCSI controller (e.g. for Medusa).
>
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called atari_scsi.
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called atari_scsi. If you also enable NVRAM support, the SCSI
> +	  host's ID is taken from the setting in TT RTC NVRAM.
>
>  	  This driver supports both styles of NCR integration into the
>  	  system: the TT style (separate DMA), and the Falcon style (via
> diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
> index 89f5154c40b6..99e5729d910d 100644
> --- a/drivers/scsi/atari_scsi.c
> +++ b/drivers/scsi/atari_scsi.c
> @@ -755,9 +755,10 @@ static int __init atari_scsi_probe(struct  
> platform_device *pdev)
>  	if (ATARIHW_PRESENT(TT_SCSI) && setup_sg_tablesize >= 0)
>  		atari_scsi_template.sg_tablesize = setup_sg_tablesize;
>
> -	if (setup_hostid >= 0) {
> +	if (setup_hostid >= 0)
>  		atari_scsi_template.this_id = setup_hostid & 7;
> -	} else {
> +#ifdef CONFIG_NVRAM
> +	else

Such ifdefs should be avoided in C files.
It would be better to use

} else if (IS_ENABLED(CONFIG_NVRAM)) {

>  		/* Test if a host id is set in the NVRam */
>  		if (ATARIHW_PRESENT(TT_CLK) && nvram_check_checksum()) {
>  			unsigned char b = nvram_read_byte(16);
> @@ -768,7 +769,7 @@ static int __init atari_scsi_probe(struct  
> platform_device *pdev)
>  			if (b & 0x80)
>  				atari_scsi_template.this_id = b & 7;
>  		}
> -	}
> +#endif
>
>  	/* If running on a Falcon and if there's TT-Ram (i.e., more than one
>  	 * memory block, since there's always ST-Ram in a Falcon), then
> --
> 2.19.2


