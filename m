Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F390C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BE72249A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pyEWhQ4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BE72249A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933871AbeF2KAS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:00:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50362 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932139AbeF2KAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:00:14 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5T9wAY7093901;
        Fri, 29 Jun 2018 04:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530266290;
        bh=F1rDf6T3YbLpbkJ1ghAujcAoaR3h5qsObZ6mDiMG+hA=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=pyEWhQ4KFquStvh8JbRbnah8zdCN5iwF4MwwAWT3H2J+GIcovyGuQbrY4qgxVSWm5
         m6vT0AzOE7xVLQMZrjxcmXMXkXxR9vMGJzQG/vONzsFUY05XbA/6mnbEuu74JYipo9
         p9VlcnJDBaC7UtJrjwUn1BQfFPQKUFr10BgMK4GE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5T9wAIB007700;
        Fri, 29 Jun 2018 04:58:10 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 29
 Jun 2018 04:58:09 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 29 Jun 2018 04:58:09 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5T9w5N4021434;
        Fri, 29 Jun 2018 04:58:06 -0500
From:   Roger Quadros <rogerq@ti.com>
Subject: New remoteproc driver for TI PRU
To:     David Lechner <david@lechnology.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        <linux-kernel@vger.kernel.org>, "Anna, Suman" <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>
References: <20180623210810.21232-1-david@lechnology.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <e0a883af-8228-5b06-3186-f57d8f898aaa@ti.com>
Date:   Fri, 29 Jun 2018 12:58:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Suman & Tero

Hi David,

On 24/06/18 00:08, David Lechner wrote:
> 
> Date: Sat, 23 Jun 2018 15:43:59 -0500
> Subject: [PATCH 0/8] New remoteproc driver for TI PRU
> 
> This series adds a new remoteproc driver for the TI Programmable Runtime Unit
> (PRU) that is present in some TI Sitara processors. This code has been tested
> working on AM1808 (LEGO MINDSTORMS EV3) and AM3358 (BeagleBone Green).

This is great. We have been working on something similar and I think it would
be great if we can collaborate to get all our needs addressed.

Our primary requirement is that it should be possible for a user (e.g. kernel driver) to
- request a specific PRU core load a specific firmware blob and boot/stop the PRU.
- configure INTC interrupt mapping based on either resource table or DT
- use request_irq to request and use an interrupt.
- request access to DRAM/SRAM
- configure gpimode/miirt/xfr (CFG space)

The work is published here

PRUSS platform bus driver (platform resets & quirks)
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pruss_soc_bus.c

PRUSS core driver (resource management e.g. SRAM/DRAM for clients)
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pruss.c

PRU Rproc driver (PRU remoteproc driver)
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pru_rproc.c

INTC driver (irqchip support for INTC)
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pruss_intc.c

Please have a look at it. I think it addresses most if not all of what your series addresses.
Maybe Suman and you can decide which driver to start with and get the missing pieces addressed.

An example of a client driver
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/net/ethernet/ti/prueth.c
and DT node for that
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/arch/arm/boot/dts/am335x-icev2-prueth.dts#line25

> 
> There are a couple of quirks that had to be worked around in order to get this
> working. The PRU units have multiple memory maps. Notably, both the instruction
> RAM and data RAM are at address 0x0. This caused the da_to_va callback to not
> work because the same address could refer to two different locations. To work
> around this, the first two patches add a "map" parameter to the da_to_va
> callbacks so that we have an extra bit of information to make this distinction.
> 
> Also, on AM38xx we have to use pdata for accessing a reset since there is not
> a reset controller. There are several other devices doing this, so the seems
> the best way for now.
> 
> For anyone else who would like to test, I used the rpmsg-client-sample driver.
> Just enable it in your kernel config. Then grab the appropriate firmware[1]
> and put in in /lib/firmware/. Use sysfs to start and stop the PRU:
> 
>         echo start > /sys/class/remoteproc<n>/state
>         echo stop > /sys/class/remoteproc<n>/state
> 
> [1]: firmware downloads:
> 
> AM18XX: https://github.com/ev3dev/ev3dev-pru-firmware/releases/download/mainline-kernel-testing/AM18xx-PRU-rpmsg-client-sample.zip
> AM335X: https://github.com/ev3dev/ev3dev-pru-firmware/releases/download/mainline-kernel-testing/AM335x-PRU-rpmsg-client-sample.zip
> 
> David Lechner (8):
>   remoteproc: add map parameter to da_to_va
>   remoteproc: add page lookup for TI PRU to ELF loader
>   ARM: OMAP2+: add pdata quirks for PRUSS reset
>   dt-bindings: add bindings for TI PRU as remoteproc
>   remoteproc: new driver for TI PRU
>   ARM: davinci_all_defconfig: enable PRU remoteproc module
>   ARM: dts: da850: add node for PRUSS
>   ARM: dts: am33xx: add node for PRU remoteproc
> 
>  .../bindings/remoteproc/ti_pru_rproc.txt      |  51 ++
>  MAINTAINERS                                   |   5 +
>  arch/arm/boot/dts/am33xx.dtsi                 |   9 +
>  arch/arm/boot/dts/da850.dtsi                  |   8 +
>  arch/arm/configs/davinci_all_defconfig        |   2 +
>  arch/arm/mach-omap2/pdata-quirks.c            |   9 +
>  drivers/remoteproc/Kconfig                    |   7 +
>  drivers/remoteproc/Makefile                   |   1 +
>  drivers/remoteproc/imx_rproc.c                |   2 +-
>  drivers/remoteproc/keystone_remoteproc.c      |   3 +-
>  drivers/remoteproc/qcom_adsp_pil.c            |   2 +-
>  drivers/remoteproc/qcom_q6v5_pil.c            |   2 +-
>  drivers/remoteproc/qcom_wcnss.c               |   2 +-
>  drivers/remoteproc/remoteproc_core.c          |  10 +-
>  drivers/remoteproc/remoteproc_elf_loader.c    | 117 +++-
>  drivers/remoteproc/remoteproc_internal.h      |   2 +-
>  drivers/remoteproc/st_slim_rproc.c            |   2 +-
>  drivers/remoteproc/ti_pru_rproc.c             | 660 ++++++++++++++++++
>  drivers/remoteproc/wkup_m3_rproc.c            |   3 +-
>  include/linux/platform_data/ti-pruss.h        |  18 +
>  include/linux/remoteproc.h                    |   2 +-
>  include/uapi/linux/elf-em.h                   |   1 +
>  22 files changed, 899 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
>  create mode 100644 drivers/remoteproc/ti_pru_rproc.c
>  create mode 100644 include/linux/platform_data/ti-pruss.h
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


