Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE931C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A9E21924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZ1XQvMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403964AbeLUOqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:46:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40452 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:46:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so5949383wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rpqnL0JcJJoj7eRp5gFAviS8n3esW/zh8yneDX/x76o=;
        b=bZ1XQvMI7y6u+7xi8ZEsU4ytEli4h3k7rGpP4xqJKNxZAHCGbLvpCkpAGlBAgk5G+B
         WDDbGohOyakxIRgupVrC/pyggJshwVf8+hy4DdwOShkWccoNY4jWjWpuc3/QGlmVkIKT
         OHtLiV+wIEv/z70VU9X8WiQGJt/HaR+yC0R1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rpqnL0JcJJoj7eRp5gFAviS8n3esW/zh8yneDX/x76o=;
        b=Z44SAQ7PMX31PZmuKO4KOHqdoty5uoFtxVa+uNRQlPLTsP/XTNd8pmRaK6Uv3SzhQ3
         Te3EGppzjWPCz92JpwdU7kgoByhru33NEPvMZke1Uv92yO76LbSGGNIHeODQHZBiyIbP
         smft78QBOBPTnjLpdEj7YBxo1OrOHzgei3MEn+i5DKvA/P6iOjWm4/D1p52qoCgBEXRN
         1Zid0mNrPMmIaA+Mox4HrVy2Pshfl+2gLQ7Upogh/mEvQtxL7+YMvJf09JlW0BwfiPgJ
         PBbtvYWG7X8jt7QpLfIt6VQL8q9v25rRz5cmg/N6vLHL6sVEDRMxysJM8d+2XyTIW7JE
         w9Yw==
X-Gm-Message-State: AA+aEWb6A8zztVgxpio8jC+N7pt3GvYGP/VnZCCMsd19faCElRwcbyOf
        X+wPPSrdVO5rP3kErRLEMAj34w==
X-Google-Smtp-Source: AFSGD/W4sVIkoJ4SIotJ67vGaM2yCkDddZ7mZK2fOz43C8WtKny63M3BRAR47dJmjV5Og0pH5pj9oQ==
X-Received: by 2002:a1c:9d57:: with SMTP id g84mr3198722wme.16.1545403567010;
        Fri, 21 Dec 2018 06:46:07 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id v1sm12740441wrw.90.2018.12.21.06.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 06:46:06 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:46:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH v9 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
Message-ID: <20181221144603.GR13248@dell>
References: <20181218210417.30140-1-jae.hyun.yoo@linux.intel.com>
 <20181218210417.30140-9-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218210417.30140-9-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Jae Hyun Yoo wrote:

> This commit adds PECI client MFD driver.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: James Feist <james.feist@linux.intel.com>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/mfd/Kconfig                   |  14 +++
>  drivers/mfd/Makefile                  |   1 +
>  drivers/mfd/intel-peci-client.c       | 150 ++++++++++++++++++++++++++
>  include/linux/mfd/intel-peci-client.h | 110 +++++++++++++++++++
>  4 files changed, 275 insertions(+)
>  create mode 100644 drivers/mfd/intel-peci-client.c
>  create mode 100644 include/linux/mfd/intel-peci-client.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8c5dfdce4326..d021aa8dfa99 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -604,6 +604,20 @@ config MFD_INTEL_MSIC
>  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
>  	  devices used in Intel Medfield platforms.
>  
> +config MFD_INTEL_PECI_CLIENT
> +	bool "Intel PECI client"
> +	depends on (PECI || COMPILE_TEST)
> +	select MFD_CORE
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Intel PECI (Platform Environment Control Interface) client. PECI is a
> +	  one-wire bus interface that provides a communication channel from PECI
> +	  clients in Intel processors and chipset components to external
> +	  monitoring or control devices.

This driver doesn't appear to actually do anything that can't be done
in a header file i.e. match some static data with a CPU ID.  The child
devices can be registered by whatever registers this device.

It seems superfluous.  Why do you need it?

> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  config MFD_IPAQ_MICRO
>  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>  	depends on SA1100_H3100 || SA1100_H3600
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 12980a4ad460..b8c1da8e748b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -204,6 +204,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
>  obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
> +obj-$(CONFIG_MFD_INTEL_PECI_CLIENT)	+= intel-peci-client.o
>  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> diff --git a/drivers/mfd/intel-peci-client.c b/drivers/mfd/intel-peci-client.c
> new file mode 100644
> index 000000000000..d53e4f1078ac
> --- /dev/null
> +++ b/drivers/mfd/intel-peci-client.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Intel Corporation
> +
> +#include <linux/bitfield.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/intel-peci-client.h>
> +#include <linux/module.h>
> +#include <linux/peci.h>
> +#include <linux/of_device.h>

Alphabetical.

> +#define CPU_ID_MODEL_MASK      GENMASK(7, 4)
> +#define CPU_ID_FAMILY_MASK     GENMASK(11, 8)
> +#define CPU_ID_EXT_MODEL_MASK  GENMASK(19, 16)
> +#define CPU_ID_EXT_FAMILY_MASK GENMASK(27, 20)
> +
> +#define LOWER_NIBBLE_MASK      GENMASK(3, 0)
> +#define UPPER_NIBBLE_MASK      GENMASK(7, 4)
> +#define LOWER_BYTE_MASK        GENMASK(7, 0)
> +#define UPPER_BYTE_MASK        GENMASK(16, 8)
> +
> +enum cpu_gens {
> +	CPU_GEN_HSX = 0, /* Haswell Xeon */
> +	CPU_GEN_BRX,     /* Broadwell Xeon */
> +	CPU_GEN_SKX,     /* Skylake Xeon */
> +};

This is unused.

> +static struct mfd_cell peci_functions[] = {
> +	{ .name = "peci-cputemp", },
> +	{ .name = "peci-dimmtemp", },
> +	/* TODO: Add additional PECI sideband functions into here */
> +};
> +
> +static const struct cpu_gen_info cpu_gen_info_table[] = {
> +	[CPU_GEN_HSX] = {
> +		.family        = 6, /* Family code */
> +		.model         = INTEL_FAM6_HASWELL_X,
> +		.core_max      = CORE_MAX_ON_HSX,
> +		.chan_rank_max = CHAN_RANK_MAX_ON_HSX,
> +		.dimm_idx_max  = DIMM_IDX_MAX_ON_HSX },
> +	[CPU_GEN_BRX] = {
> +		.family        = 6, /* Family code */
> +		.model         = INTEL_FAM6_BROADWELL_X,
> +		.core_max      = CORE_MAX_ON_BDX,
> +		.chan_rank_max = CHAN_RANK_MAX_ON_BDX,
> +		.dimm_idx_max  = DIMM_IDX_MAX_ON_BDX },
> +	[CPU_GEN_SKX] = {
> +		.family        = 6, /* Family code */
> +		.model         = INTEL_FAM6_SKYLAKE_X,
> +		.core_max      = CORE_MAX_ON_SKX,
> +		.chan_rank_max = CHAN_RANK_MAX_ON_SKX,
> +		.dimm_idx_max  = DIMM_IDX_MAX_ON_SKX },
> +};
> +
> +static int peci_client_get_cpu_gen_info(struct peci_client_manager *priv)
> +{
> +	u32 cpu_id;
> +	u16 family;
> +	u8 model;
> +	int rc;

ret is almost ubiquitous in the kernel.  Please use it instead.

> +	int i;
> +
> +	rc = peci_get_cpu_id(priv->client->adapter, priv->client->addr,
> +			     &cpu_id);
> +	if (rc)
> +		return rc;
> +
> +	family = FIELD_PREP(LOWER_BYTE_MASK,
> +			    FIELD_GET(CPU_ID_FAMILY_MASK, cpu_id)) |
> +		 FIELD_PREP(UPPER_BYTE_MASK,
> +			    FIELD_GET(CPU_ID_EXT_FAMILY_MASK, cpu_id));
> +	model = FIELD_PREP(LOWER_NIBBLE_MASK,
> +			   FIELD_GET(CPU_ID_MODEL_MASK, cpu_id)) |
> +		FIELD_PREP(UPPER_NIBBLE_MASK,
> +			   FIELD_GET(CPU_ID_EXT_MODEL_MASK, cpu_id));
> +
> +	for (i = 0; i < ARRAY_SIZE(cpu_gen_info_table); i++) {
> +		const struct cpu_gen_info *cpu_info = &cpu_gen_info_table[i];
> +
> +		if (family == cpu_info->family && model == cpu_info->model) {
> +			priv->gen_info = cpu_info;
> +			break;
> +		}
> +	}
> +
> +	if (!priv->gen_info) {
> +		dev_err(priv->dev, "Can't support this CPU: 0x%x\n", cpu_id);
> +		rc = -ENODEV;
> +	}
> +
> +	return rc;
> +}
> +
> +static int peci_client_probe(struct peci_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct peci_client_manager *priv;
> +	uint cpu_no;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, priv);
> +	priv->client = client;
> +	priv->dev = dev;

If you have client (Which contains dev, you don't need dev).

> +	cpu_no = client->addr - PECI_BASE_ADDR;
> +
> +	ret = peci_client_get_cpu_gen_info(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_mfd_add_devices(priv->dev, cpu_no, peci_functions,
> +				   ARRAY_SIZE(peci_functions), NULL, 0, NULL);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "Failed to register child devices: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id peci_client_of_table[] = {
> +	{ .compatible = "intel,peci-client" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, peci_client_of_table);
> +#endif
> +
> +static const struct peci_device_id peci_client_ids[] = {
> +	{ .name = "peci-client" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(peci, peci_client_ids);
> +
> +static struct peci_driver peci_client_driver = {
> +	.probe    = peci_client_probe,
> +	.id_table = peci_client_ids,
> +	.driver   = {
> +		.name           = "peci-client",
> +		.of_match_table = of_match_ptr(peci_client_of_table),
> +	},
> +};
> +module_peci_driver(peci_client_driver);
> +
> +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
> +MODULE_DESCRIPTION("PECI client driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/intel-peci-client.h b/include/linux/mfd/intel-peci-client.h
> new file mode 100644
> index 000000000000..8f6d823a59cd
> --- /dev/null
> +++ b/include/linux/mfd/intel-peci-client.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2018 Intel Corporation */
> +
> +#ifndef __LINUX_MFD_INTEL_PECI_CLIENT_H
> +#define __LINUX_MFD_INTEL_PECI_CLIENT_H
> +
> +#include <linux/peci.h>
> +
> +#if IS_ENABLED(CONFIG_X86)
> +#include <asm/intel-family.h>
> +#else
> +/**
> + * Architectures other than x86 cannot include the header file so define these
> + * at here. These are needed for detecting type of client x86 CPUs behind a PECI
> + * connection.
> + */
> +#define INTEL_FAM6_HASWELL_X   0x3F
> +#define INTEL_FAM6_BROADWELL_X 0x4F
> +#define INTEL_FAM6_SKYLAKE_X   0x55
> +#endif
> +
> +#define CORE_MAX_ON_HSX        18 /* Max number of cores on Haswell */
> +#define CHAN_RANK_MAX_ON_HSX   8  /* Max number of channel ranks on Haswell */
> +#define DIMM_IDX_MAX_ON_HSX    3  /* Max DIMM index per channel on Haswell */
> +
> +#define CORE_MAX_ON_BDX        24 /* Max number of cores on Broadwell */
> +#define CHAN_RANK_MAX_ON_BDX   4  /* Max number of channel ranks on Broadwell */
> +#define DIMM_IDX_MAX_ON_BDX    3  /* Max DIMM index per channel on Broadwell */
> +
> +#define CORE_MAX_ON_SKX        28 /* Max number of cores on Skylake */
> +#define CHAN_RANK_MAX_ON_SKX   6  /* Max number of channel ranks on Skylake */
> +#define DIMM_IDX_MAX_ON_SKX    2  /* Max DIMM index per channel on Skylake */
> +
> +#define CORE_NUMS_MAX          CORE_MAX_ON_SKX
> +#define CHAN_RANK_MAX          CHAN_RANK_MAX_ON_HSX
> +#define DIMM_IDX_MAX           DIMM_IDX_MAX_ON_HSX
> +#define DIMM_NUMS_MAX          (CHAN_RANK_MAX * DIMM_IDX_MAX)
> +
> +/**
> + * struct cpu_gen_info - CPU generation specific information
> + * @family: CPU family ID
> + * @model: CPU model
> + * @core_max: max number of cores
> + * @chan_rank_max: max number of channel ranks
> + * @dimm_idx_max: max number of DIMM indices
> + *
> + * CPU generation specific information to identify maximum number of cores and
> + * DIMM slots.
> + */
> +struct cpu_gen_info {
> +	u16  family;
> +	u8   model;
> +	uint core_max;
> +	uint chan_rank_max;
> +	uint dimm_idx_max;
> +};
> +
> +/**
> + * struct peci_client_manager - PECI client manager information
> + * @client; pointer to the PECI client
> + * @dev: pointer to the struct device
> + * @name: PECI client manager name
> + * @gen_info: CPU generation info of the detected CPU
> + *
> + * PECI client manager information for managing PECI sideband functions on a CPU
> + * client.
> + */
> +struct peci_client_manager {
> +	struct peci_client *client;
> +	struct device *dev;
> +	char name[PECI_NAME_SIZE];
> +	const struct cpu_gen_info *gen_info;
> +};
> +
> +/**
> + * peci_client_read_package_config - read from the Package Configuration Space
> + * @priv: driver private data structure
> + * @index: encoding index for the requested service
> + * @param: parameter to specify the exact data being requested
> + * @data: data buffer to store the result
> + * Context: can sleep
> + *
> + * A generic PECI command that provides read access to the
> + * "Package Configuration Space" that is maintained by the PCU, including
> + * various power and thermal management functions. Typical PCS read services
> + * supported by the processor may include access to temperature data, energy
> + * status, run time information, DIMM temperatures and so on.
> + *
> + * Return: zero on success, else a negative error code.
> + */
> +static inline int
> +peci_client_read_package_config(struct peci_client_manager *priv,
> +				u8 index, u16 param, u8 *data)
> +{
> +	struct peci_rd_pkg_cfg_msg msg;
> +	int rc;
> +
> +	msg.addr = priv->client->addr;
> +	msg.index = index;
> +	msg.param = param;
> +	msg.rx_len = 4;
> +
> +	rc = peci_command(priv->client->adapter, PECI_CMD_RD_PKG_CFG, &msg);
> +	if (!rc)
> +		memcpy(data, msg.pkg_config, 4);
> +
> +	return rc;
> +}
> +
> +#endif /* __LINUX_MFD_INTEL_PECI_CLIENT_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
