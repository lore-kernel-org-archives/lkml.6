Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B464C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3EE20869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="G3P4+o8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfA2RM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:12:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43258 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbfA2RM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:12:29 -0500
Received: from zn.tnic (p200300EC2BCC5400E03D356D4AA330A5.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5400:e03d:356d:4aa3:30a5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E08731EC0245;
        Tue, 29 Jan 2019 18:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548781948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AM2K0+tCHs+fdS0c9BLSunpnMRxeNJtQlIFF5mclbRY=;
        b=G3P4+o8HIxzJQxPMhm+06yB5C77qlhv74+wzAxUV3hygnZ1FU7Zd54/09W6tHkimKOrbju
        uue2YFC65Ko6YaZhs9UmvW/t7piPoWkTUP2tXl691UDsNaauAeqgRbGi/kNt3YQ9PufCqb
        BIal2lI4Ke4FH2xUVz6LZ5BdJsqqV1w=
Date:   Tue, 29 Jan 2019 18:12:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] EDAC, skx_edac: Delete the duplicated codes
Message-ID: <20190129171224.GE27037@zn.tnic>
References: <20190125195902.17109-1-tony.luck@intel.com>
 <20190125195902.17109-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190125195902.17109-3-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:59:00AM -0800, Tony Luck wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> Part of the skx_edac driver codes are carved to the skx_comm_edac.c
> file, which are used by both skx_edac driver and i10nm_edac driver.
> Delete the duplicated codes from the skx_edac.c file and rename
> skx_edac.c to skx_base.c. Update the Makefile to build the skx_edac
> driver from skx_base.c plux skx_comm_edac.c
> 
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/Makefile   |    4 +-
>  drivers/edac/skx_base.c |  673 +++++++++++++++++++
>  drivers/edac/skx_edac.c | 1358 ---------------------------------------
>  3 files changed, 676 insertions(+), 1359 deletions(-)
>  create mode 100644 drivers/edac/skx_base.c
>  delete mode 100644 drivers/edac/skx_edac.c

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

Sensible warnings:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#65: FILE: drivers/edac/skx_base.c:1:
+/*

WARNING: Use #include <linux/processor.h> instead of <asm/processor.h>
#97: FILE: drivers/edac/skx_base.c:33:
+#include <asm/processor.h>

> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 716096d08ea0..1764b7ed05db 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -30,7 +30,6 @@ obj-$(CONFIG_EDAC_I5400)		+= i5400_edac.o
>  obj-$(CONFIG_EDAC_I7300)		+= i7300_edac.o
>  obj-$(CONFIG_EDAC_I7CORE)		+= i7core_edac.o
>  obj-$(CONFIG_EDAC_SBRIDGE)		+= sb_edac.o
> -obj-$(CONFIG_EDAC_SKX)			+= skx_edac.o
>  obj-$(CONFIG_EDAC_PND2)			+= pnd2_edac.o
>  obj-$(CONFIG_EDAC_E7XXX)		+= e7xxx_edac.o
>  obj-$(CONFIG_EDAC_E752X)		+= e752x_edac.o
> @@ -58,6 +57,9 @@ obj-$(CONFIG_EDAC_MPC85XX)		+= mpc85xx_edac_mod.o
>  layerscape_edac_mod-y			:= fsl_ddr_edac.o layerscape_edac.o
>  obj-$(CONFIG_EDAC_LAYERSCAPE)		+= layerscape_edac_mod.o
>  
> +skx_edac-y				:= skx_comm_edac.o skx_base.o
> +obj-$(CONFIG_EDAC_SKX)			+= skx_edac.o
> +
>  obj-$(CONFIG_EDAC_MV64X60)		+= mv64x60_edac.o
>  obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
>  obj-$(CONFIG_EDAC_PPC4XX)		+= ppc4xx_edac.o
> diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
> new file mode 100644
> index 000000000000..4aa53c15b89b
> --- /dev/null
> +++ b/drivers/edac/skx_base.c
> @@ -0,0 +1,673 @@
> +/*
> + * EDAC driver for Intel(R) Xeon(R) Skylake processors
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */

First patch adds SPDX headers - this one has the old licensing thing. Pls fix.


> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/pci.h>
> +#include <linux/pci_ids.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/edac.h>
> +#include <linux/mmzone.h>
> +#include <linux/smp.h>
> +#include <linux/bitmap.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/adxl.h>
> +#include <acpi/nfit.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +#include <asm/processor.h>
> +#include <asm/mce.h>

*all* those includes are needed?!

> +
> +#include "edac_module.h"
> +#include "skx_comm_edac.h"

This one has some of the above includes too.

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
