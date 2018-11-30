Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F299DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCDD2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I84HEa/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCDD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeLADXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:23:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbeLADXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:23:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E259620867;
        Fri, 30 Nov 2018 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543594406;
        bh=0TMm+YuxAQj6SLqp9O4eKuFfuk3UdTULTJYQIdgusLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I84HEa/6tija6bCML0DDRSlZI93lpZGFp67UWpz7zmBHaTfqOMVSo4maG8lAbQui7
         UqVcC3lEJfIYMD+5+6XWefSk8A/tQeV9uN6psIxwlfjA4RBGMcu/qWmzxpPdAuJgoY
         p5TUolxrmOvOmuHBLdO5/wikt/e+lmhF6pvYwuSE=
Date:   Fri, 30 Nov 2018 17:13:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
Subject: Re: [RFC PATCH 2/6] char: fastrpc: Add Qualcomm fastrpc basic driver
 model
Message-ID: <20181130161324.GA8031@kroah.com>
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
 <20181130104657.14875-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130104657.14875-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 10:46:53AM +0000, Srinivas Kandagatla wrote:
> This patch adds basic driver model for qualcomm fastrpc.
> Each DSP rpmsg channel is represented as fastrpc channel context and
> is exposed as a character driver for userspace interface.
> Each compute context bank is represented as fastrpc-session-context,
> which are dynamically managed by the channel context char device.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/char/Kconfig   |  10 ++
>  drivers/char/Makefile  |   1 +
>  drivers/char/fastrpc.c | 337 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 348 insertions(+)
>  create mode 100644 drivers/char/fastrpc.c
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 9d03b2ff5df6..75fd274c67df 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -552,6 +552,16 @@ config ADI
>  	  and SSM (Silicon Secured Memory).  Intended consumers of this
>  	  driver include crash and makedumpfile.
>  
> +config QCOM_FASTRPC
> +	tristate "Qualcomm FastRPC"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on RPMSG
> +	help
> +	  Provides a communication mechanism that allows for clients to
> +	  make remote method invocations across processor boundary to
> +	  applications DSP processor. Say M if you want to enable this
> +	  module.
> +
>  endmenu
>  
>  config RANDOM_TRUST_CPU
> diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> index b8d42b4e979b..30ec9187350e 100644
> --- a/drivers/char/Makefile
> +++ b/drivers/char/Makefile
> @@ -58,3 +58,4 @@ js-rtc-y = rtc.o
>  obj-$(CONFIG_XILLYBUS)		+= xillybus/
>  obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
>  obj-$(CONFIG_ADI)		+= adi.o
> +obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
> diff --git a/drivers/char/fastrpc.c b/drivers/char/fastrpc.c
> new file mode 100644
> index 000000000000..97d8062eb3e1
> --- /dev/null
> +++ b/drivers/char/fastrpc.c
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2011-2018, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/idr.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/rpmsg.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +
> +#define ADSP_DOMAIN_ID (0)
> +#define MDSP_DOMAIN_ID (1)
> +#define SDSP_DOMAIN_ID (2)
> +#define CDSP_DOMAIN_ID (3)
> +#define FASTRPC_DEV_MAX		4 /* adsp, mdsp, slpi, cdsp*/
> +#define FASTRPC_MAX_SESSIONS	9 /*8 compute, 1 cpz*/
> +#define FASTRPC_CTX_MAX (256)
> +#define FASTRPC_CTXID_MASK (0xFF0)
> +#define FASTRPC_DEVICE_NAME	"fastrpc"
> +
> +#define cdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, cdev)
> +
> +static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
> +						"sdsp", "cdsp"};
> +static dev_t fastrpc_major;

Why do you need a whole major number for this?  Why not just use the
misc interface instead?

