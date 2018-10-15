Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52E0C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9995D2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9995D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeJOTjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:39:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36832 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbeJOTjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:39:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CC1ED2074F; Mon, 15 Oct 2018 13:54:07 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 69B1420379;
        Mon, 15 Oct 2018 13:54:07 +0200 (CEST)
Date:   Mon, 15 Oct 2018 13:54:08 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] spi: add support for octal mode
Message-ID: <20181015135408.49142c88@bbrezillon>
In-Reply-To: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Mon, 15 Oct 2018 11:47:55 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add support for octal mode IO data transfer.
> Micron flash, mt35xu512aba, supports octal mode data transfer and
> NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> 
> Patch series
> * Add support for octal mode flags and parsing of same in spi driver.
> * Add opcodes for octal I/O commands in spi-nor framework, Read and Write proto for (1-1-8/1-8-8) mode.
>   Opcodes are added as per octal data IO commands required for mt35xu512aba [1] flash.
> * Add parsing logic for spi-mem framework and m25p80.c device file.
> * Add mode bit required for octal mode in nxp-fspi driver [2].
> * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> 
> Cherry pick below 2 patches (from: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git):
>     c639f871febe6667d9afce28108c634e5636c735 spi: spi-mem: Fix inverted logic in op sanity check
>     db122eb8a749a1eff038f9a282c620ab16c4be1d spi: spi-mem: Add extra sanity checks on the op param
> 
> Tested on LX2160ARDB target with nxp-fspi driver, below are
> Read performance number of 1-1-1 and 1-1-8 read protocol.
> 
>  root@lxxx:~# cat /proc/mtd
>  dev:    size   erasesize  name
>  mtd0: 04000000 00001000 "spi0.0"
>  mtd1: 04000000 00001000 "spi0.1"
>  root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
> 
>  real    0m2.792s
>  user    0m0.000s
>  sys     0m2.790s
>  root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
> 
>  real    0m0.441s
>  user    0m0.000s
>  sys     0m0.440s
>  root@ls1012ardb:~#
> 
>  Flash device MTD0 configured in 1-1-1 protocol.
>  Flash device MTD1 configured in 1-1-8 protocol.
> 
> [1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70384
> [2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70210
> 
> Yogesh Gaur (7):
>   spi: add support for octal I/O data transfer
>   mtd: spi-nor: add opcodes for octal Read/Write commands
>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>   mtd: m25p80: add support of octal I/O transfer
>   spi: spi-mem: add support for octal I/O data transfer

Patch 5 should be moved before patch 4 (ideally in 2nd position) if
you want this series to be bisectable.

Regards,

Boris

>   spi: nxp-fspi: add mode flag bit for octal support
>   arm64: dts: lx2160a: update fspi node
> 
> Changes for v2:
>  Incorporated review comments of Boris and Vignesh.
> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
>  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
>  drivers/mtd/spi-nor/spi-nor.c                     | 15 ++++++++++++++-
>  drivers/spi/spi-mem.c                             |  9 ++++++++-
>  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
>  drivers/spi/spi.c                                 |  6 ++++++
>  include/linux/mtd/spi-nor.h                       |  8 ++++++++
>  include/linux/spi/spi.h                           |  2 ++
>  8 files changed, 52 insertions(+), 5 deletions(-)
> 

