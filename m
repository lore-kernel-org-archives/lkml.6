Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB41AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6943E26A25
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="mf25Ff75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6943E26A25
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=xff.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934943AbeFZMCv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:02:51 -0400
Received: from vps.xff.cz ([195.181.215.36]:57872 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933658AbeFZMCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:02:49 -0400
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2018 08:02:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1530014015; bh=3y0DfM7wwsUtOlGAkx6fintErTkXRfswHutxDVp4zhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mf25Ff75UYOs0XbicaUfNnfjHqKGap9di+rIPKWC0b7PthSnbkwucywXE4UPtmEA0
         rdbfJ2oiv2RctPP7e0ZL23XSvrHwx7fcCI24Uew2LZS4gfee3wweUGNOrge9fOKaTf
         EmGdVB+j+w1tXIBcSg+6c2OyqJ4Q9fm39H2d7eHM=
Date:   Tue, 26 Jun 2018 13:53:35 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <doudahwezomiechahtah@xff.cz>
To:     =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc:     linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com,
        devicetree@vger.kernel.org, opendmb@gmail.com,
        quentin.schulz@bootlin.com, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, f.fainelli@gmail.com,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 00/12] Sunxi: Add SMP support on A83T
Message-ID: <20180626115335.cou6o22lks2stign@core>
Mail-Followup-To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>,
        linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com,
        devicetree@vger.kernel.org, opendmb@gmail.com,
        quentin.schulz@bootlin.com, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, f.fainelli@gmail.com,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180504190545.5114-1-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mylène,

On Fri, May 04, 2018 at 09:05:33PM +0200, Mylène Josserand wrote:
> Hello everyone,
> 
> This is a V9 of my series that adds SMP support for Allwinner sun8i-a83t.
> Based on sunxi's tree, sunxi/for-next branch.
> Depends on a patch from Doug Berger that allows to include the "cpu-type"
> header on assembly files that I included in my series (patch 01).

I've tested your patches and the kernel always locks up when disabling the first
CPU in the second cluster. I can enable/disable other CPUs in the second cluster
though.

Other thing I observed was, that when disabling cores no power is saved (not
even a tiny bit), which is slightly surprising.

From the standpoint of the DT, A83T CPU config seems to lack some cpu
properties, which makes it not claim a cluster clock when I enable any other
CPU than the first CPU in the cluster.

The same goes for cpu-supply regulator. When I dump the state of regulators
after booting with maxcpus=1 and enabling cpu5, the regulator on the second
cluster is not claimed, but when I add cpu-supply property on all cpu# nodes,
I get (when enabling CPU5):

[  200.072895] CPU5: update cpu_capacity 1024
[  200.072914] CPU5: thread -1, cpu 1, socket 1, mpidr 80000101
[  200.151403] cpu cpu5: opp_list_debug_create_link: Failed to create link
[  200.151411] cpu cpu5: _add_opp_dev: Failed to register opp debugfs (-12)

I'm not having much luck with this. Do you have some suggestions, please?
I'll probably figure out the last issue with the regulators, but I'm at the
loss about the lockup on CPU4 disable.

thaks and regards,
  Ondrej Jirman

> The difference with the v8 is just that the machine is renamed in sun8i-a83t
> (see patch 07), according to Maxime's review.
> 
> Thank you in advance,
> Best regards,
> Mylène
> 
> Changes from v8:
>     - Rename machine into "sun8i-a83t"
> 
> Changes from v7:
>     - Add the patch of Doug Berger in my series.
>     - Rename the machine name to start secure_cntvoff into "sun8i-a83t",
>     according to Maxime's review.
>     - Change the type of is_a83t field from integer into boolean.
> 
> Changes from v6:
>     - Correct the commit log on patch 07 according to Sergei Shtylyov's
>     review.
>     - Rename the field "is_sun8i" into "is_a83t".
>     - Add all Tested-by and Reviewed-by from previous version.
> 
> Changes from v5:
>     - Remove my patch 01 and use the patch of Doug Berger to be able to
>     include the cpu-type header on assembly files.
>     - Rename smp_init_cntvoff function into secure_cntvoff_init according
>     to Marc Zyngier's review.
>     - According to Chen-Yu and Maxime's reviews, remove the patch that was
>     moving structures. Instead of using an index to retrieve which
>     architecture we are having, use a global variable.
>     - Merge the 2 patches that move assembly code from C to assembly file.
>     - Use a sun8i field instead of sun9i to know on which architecture we
>     are using because many modifications/additions of the code are for
>     sun8i-a83t.
>     - Rework the patch "add is_sun8i field" to add only this field in this
>     patch. The part of the patch that was starting to handle the differences
>     between sun8i-a83t and sun9i-a80 is merged in the patch that adds the
>     support of sun8i-a83t.
>     - Add a new patch that refactor the shmobile code to use the new function
>     secure_cntvoff_init introduced in this series.
> 
> Changes from v4:
>     - Rebased my series according to new Chen-Yu series:
>        "ARM: sunxi: Clean and improvements for multi-cluster SMP"
>        https://lkml.org/lkml/2018/3/8/886
>     - Updated my series according to Marc Zyngier's reviews to add CNTVOFF
>     initialization's function into ARM's common part. Thanks to that, other
>     platforms such as Renesa can use this function.
>     - For boot CPU, create a new machine to handle the CNTVOFF initialization
>     using "init_early" callback.
> 
> Changes from v3:
>     - Take into account Maxime's reviews:
> 	- split the first patch into 4 new patches: add sun9i device tree
> 	parsing, rename some variables, add a83t support and finally,
> 	add hotplug support.
> 	- Move the code of previous patch 07 (to disable CPU0 disabling)
> 	into hotplug support patch (see patch 04)
> 	- Remove the patch that added PRCM register because it is already
> 	available. Because of that, update the device tree parsing to use
> 	"sun8i-a83t-r-ccu".
> 	- Use a variable to know which SoC we currently have
>     - Take into account Chen-Yu's reviews: create two iounmap functions
>     to release the resources of the device tree parsing.
>     - Take into account Marc's review: Update the code to initialize CNTVOFF
>     register. As there is already assembly code in the driver, I decided
>     to create an assembly file not to mix assembly and C code.
>     For that, I create 3 new patches: move the current assembly code that
>     handles the cluster cache enabling into a file, move the cpu_resume entry
>     in this file and finally, add a new assembly entry to initialize the timer
>     offset for boot CPU and secondary CPUs.
> 
> Changes from v2:
>     - Rebased my modifications according to new Chen Yu's patch series
>     that adds SMP support for sun9i-a80 (without MCPM).
>     - Split the device-tree patches into 3 patches for CPUCFG, R_CPUCFG
>     and PRCM registers for more visibility.
>     - The hotplug of CPU0 is currently not working (even after trying what
>     Allwinner's code is doing) so remove the possibility of disabling
>     this CPU. Created a new patch for it.
> 
> Changes from v1:
>     - Add Chen Yu's patch in my series (see path 01)
>     - Add new compatibles for prcm and cpucfg registers for sun8i-a83t.
>     Create two functions to separate the DT parsing of sun9i-a80 and
>     sun8i-a83t.
>     - Thanks to Maxime's review: order device tree's nodes according
>     to physical addresses, remove unused label and fix registers' sizes.
>     Update the commit log and commit title of my last patch (see
>     patch 05).
> 
> Doug Berger (1):
>   ARM: Allow this header to be included by assembly files
> 
> Mylène Josserand (11):
>   ARM: sunxi: smp: Move assembly code into a file
>   ARM: dts: sun8i: Add CPUCFG device node for A83T dtsi
>   ARM: dts: sun8i: Add R_CPUCFG device node for the A83T dtsi
>   ARM: dts: sun8i: a83t: Add CCI-400 node
>   ARM: smp: Add initialization of CNTVOFF
>   ARM: sunxi: Add initialization of CNTVOFF
>   ARM: sun9i: smp: Rename clusters's power-off
>   ARM: sun9i: smp: Add is_a83t field
>   ARM: sun8i: smp: Add support for A83T
>   ARM: dts: sun8i: Add enable-method for SMP support for the A83T SoC
>   ARM: shmobile: Convert file to use cntvoff
> 
>  arch/arm/boot/dts/sun8i-a83t.dtsi        |  59 ++++++++
>  arch/arm/common/Makefile                 |   1 +
>  arch/arm/common/secure_cntvoff.S         |  31 ++++
>  arch/arm/include/asm/cputype.h           |  10 +-
>  arch/arm/include/asm/secure_cntvoff.h    |   8 ++
>  arch/arm/mach-shmobile/common.h          |   1 -
>  arch/arm/mach-shmobile/headsmp-apmu.S    |  22 +--
>  arch/arm/mach-shmobile/setup-rcar-gen2.c |   3 +-
>  arch/arm/mach-sunxi/Kconfig              |   2 +-
>  arch/arm/mach-sunxi/Makefile             |   2 +-
>  arch/arm/mach-sunxi/headsmp.S            |  81 +++++++++++
>  arch/arm/mach-sunxi/mc_smp.c             | 239 +++++++++++++++++++------------
>  arch/arm/mach-sunxi/sunxi.c              |  20 ++-
>  13 files changed, 356 insertions(+), 123 deletions(-)
>  create mode 100644 arch/arm/common/secure_cntvoff.S
>  create mode 100644 arch/arm/include/asm/secure_cntvoff.h
>  create mode 100644 arch/arm/mach-sunxi/headsmp.S
> 
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
