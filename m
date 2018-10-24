Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A040C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E162075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JoiNl1wX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E162075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJXT0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:26:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38144 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJXT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:26:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so5095951wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nEptbARROFpdOMnbAjoj4OF4zYn6X0zCLw0KXxbTtEk=;
        b=JoiNl1wXA97FJo4icfMpn5RfAlvxPBKnuHfJgMMovGBPt5tP19pwTfkNTeipMKCJoa
         l/q8lYD7BoeUyd7rac6F7o2GX2GNc1DPg6vg262UqIIW84q4Z4UgDl37pulGpdmvUJV2
         z5zVqd5xaAtMhWYVGJw60Ej424C23zO+cXXcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nEptbARROFpdOMnbAjoj4OF4zYn6X0zCLw0KXxbTtEk=;
        b=k+ehSAohmrjiXdg3/ZNt/R/IU47h5yYZ00WtgaQ3R4QeRbORsqzewbR9pYu1UU1bUf
         SZ1ExuDWU3a6fFDeVOJ/haz3tV8z3zIvR0UT2zSaboSkNw9g8nKjyIMP8ryi98WglInG
         C9x6cQnDZD9ST4Kxzbs/8W3GrQQ+Uu3LE/5X3B39fkq5SYUb/8zLidsSyZZvPGKAI+md
         gJoCPjtHuRVElbnl7HqPhRiVAhy/DsZfQSRiHpPIjBTohrQbs5pb9l31lt06n5zbfeWA
         XTYfYujtvhcMbE6wDF+VScKhh0UqMtJyQ2OYAKcQOy3TzCwzMV7HiFr/EgT1fgf3Mato
         TRgw==
X-Gm-Message-State: AGRZ1gK5V3+r5F7gF+Ft1u6qrNFuo44ga/iPBBmuBzW5WyM0FiMsQjRD
        5DirsX9DPqTR79pylYajU+/y9w==
X-Google-Smtp-Source: AJdET5cKzJZYfQmmkbKhpH99yEAwMEviAeJf+v07eqW5WBPkEkNZpuyQGmLA/Q7jl2BBmWaoDeTxww==
X-Received: by 2002:a5d:480b:: with SMTP id l11-v6mr2483051wrq.28.1540378747565;
        Wed, 24 Oct 2018 03:59:07 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id u132-v6sm4885878wmg.17.2018.10.24.03.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 03:59:06 -0700 (PDT)
Date:   Wed, 24 Oct 2018 11:59:03 +0100
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH v8 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
Message-ID: <20181024105903.GB4939@dell>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
 <20180918215124.14003-9-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180918215124.14003-9-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018, Jae Hyun Yoo wrote:

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
>  drivers/mfd/Kconfig                   |  14 ++
>  drivers/mfd/Makefile                  |   1 +
>  drivers/mfd/intel-peci-client.c       | 181 ++++++++++++++++++++++++++
>  include/linux/mfd/intel-peci-client.h |  81 ++++++++++++
>  4 files changed, 277 insertions(+)
>  create mode 100644 drivers/mfd/intel-peci-client.c
>  create mode 100644 include/linux/mfd/intel-peci-client.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 11841f4b7b2b..e68ae5d820ba 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -595,6 +595,20 @@ config MFD_INTEL_MSIC
>  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
>  	  devices used in Intel Medfield platforms.
>  
> +config MFD_INTEL_PECI_CLIENT
> +	bool "Intel PECI client"
> +	depends on (PECI || COMPILE_TEST)
> +	select MFD_CORE
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  multi-functional Intel PECI (Platform Environment Control Interface)

Remove 'multi-functional' from this sentence.

> +	  client. PECI is a one-wire bus interface that provides a communication
> +	  channel from PECI clients in Intel processors and chipset components
> +	  to external monitoring or control devices.
> +
> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  config MFD_IPAQ_MICRO
>  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>  	depends on SA1100_H3100 || SA1100_H3600
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5856a9489cbd..ed05583dc30e 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -203,6 +203,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
>  obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
> +obj-$(CONFIG_MFD_INTEL_PECI_CLIENT)	+= intel-peci-client.o
>  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> diff --git a/drivers/mfd/intel-peci-client.c b/drivers/mfd/intel-peci-client.c
> new file mode 100644
> index 000000000000..507e4ac66dfa
> --- /dev/null
> +++ b/drivers/mfd/intel-peci-client.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Intel Corporation
> +
> +#include <linux/bitfield.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/intel-peci-client.h>
> +#include <linux/module.h>
> +#include <linux/peci.h>
> +#include <linux/of_device.h>
> +
> +enum cpu_gens {
> +	CPU_GEN_HSX = 0, /* Haswell Xeon */
> +	CPU_GEN_BRX,     /* Broadwell Xeon */
> +	CPU_GEN_SKX,     /* Skylake Xeon */
> +};
> +
> +static struct mfd_cell peci_functions[] = {
> +	{
> +		.name = "peci-cputemp",
> +	},
> +	{
> +		.name = "peci-dimmtemp",
> +	},

	{ .name = "peci-cputemp", },
	{ .name = "peci-dimmtemp", },

Do these have 2 different drivers?  Where are you putting them?

> +	/* TODO: Add additional PECI sideband functions into here */

When will this be done?

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

The '},'s should go on the line below.

> +};
> +
> +static int peci_client_get_cpu_gen_info(struct peci_mfd *priv)

Remove all mention of 'mfd'.  It's not a thing.

> +{
> +	u32 cpu_id;
> +	int i, rc;
> +
> +	rc = peci_get_cpu_id(priv->adapter, priv->addr, &cpu_id);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < ARRAY_SIZE(cpu_gen_info_table); i++) {
> +		if (FIELD_GET(CPU_ID_FAMILY_MASK, cpu_id) +
> +			FIELD_GET(CPU_ID_EXT_FAMILY_MASK, cpu_id) ==
> +				cpu_gen_info_table[i].family &&
> +		    FIELD_GET(CPU_ID_MODEL_MASK, cpu_id) ==
> +			FIELD_GET(LOWER_NIBBLE_MASK,
> +				  cpu_gen_info_table[i].model) &&
> +		    FIELD_GET(CPU_ID_EXT_MODEL_MASK, cpu_id) ==
> +			FIELD_GET(UPPER_NIBBLE_MASK,
> +				  cpu_gen_info_table[i].model)) {
> +			break;
> +		}
> +	}

This is really read.  Please reformat it, even if you have to use
local variables to make it more legible.

> +	if (i >= ARRAY_SIZE(cpu_gen_info_table))
> +		return -ENODEV;

Do you really want to fail silently?

> +	priv->gen_info = &cpu_gen_info_table[i];

If you do this in the for(), you can then test priv->gen_info instead
of seeing if the iterator maxed out.  Much nicer I think.

> +	return 0;
> +}
> +
> +bool peci_temp_need_update(struct temp_data *temp)
> +{
> +	if (temp->valid &&
> +	    time_before(jiffies, temp->last_updated + UPDATE_INTERVAL))
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(peci_temp_need_update);
> +
> +void peci_temp_mark_updated(struct temp_data *temp)
> +{
> +	temp->valid = 1;
> +	temp->last_updated = jiffies;
> +}
> +EXPORT_SYMBOL_GPL(peci_temp_mark_updated);

These are probably better suited as inline functions to be placed in
a header file.  No need to export them, since they only use their own
data.

> +int peci_client_command(struct peci_mfd *priv, enum peci_cmd cmd, void *vmsg)
> +{
> +	return peci_command(priv->adapter, cmd, vmsg);
> +}
> +EXPORT_SYMBOL_GPL(peci_client_command);

If you share the adaptor with the client, you can call peci_command()
directly.  There should also be some locking in here somewhere too.

> +int peci_client_rd_pkg_cfg_cmd(struct peci_mfd *priv, u8 mbx_idx,

This is gobbledegook.  What's rd?  Read?

> +			       u16 param, u8 *data)
> +{
> +	struct peci_rd_pkg_cfg_msg msg;
> +	int rc;
> +
> +	msg.addr = priv->addr;
> +	msg.index = mbx_idx;
> +	msg.param = param;
> +	msg.rx_len = 4;
> +
> +	rc = peci_command(priv->adapter, PECI_CMD_RD_PKG_CFG, &msg);
> +	if (!rc)
> +		memcpy(data, msg.pkg_config, 4);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(peci_client_rd_pkg_cfg_cmd);

This too should be set-up as an inline function, not an exported one.

> +static int peci_client_probe(struct peci_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct peci_mfd *priv;
> +	int rc;

'ret' is more common.

> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, priv);
> +	priv->client = client;
> +	priv->dev = dev;

> +	priv->adapter = client->adapter;
> +	priv->addr = client->addr;

You're already saving client.  No need to save its individual
attributes as well.

> +	priv->cpu_no = client->addr - PECI_BASE_ADDR;

This seems clunky.  Does the spec say that the addresses have to be in
numerical order with no gaps?  What if someone chooses to implement 4
CPUs at 0x30, 0x35, 0x45 and 0x60?

What do you then do with cpu_no?

> +	snprintf(priv->name, PECI_NAME_SIZE, "peci_client.cpu%d", priv->cpu_no);
> +
> +	rc = peci_client_get_cpu_gen_info(priv);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_mfd_add_devices(priv->dev, priv->cpu_no, peci_functions,
> +				  ARRAY_SIZE(peci_functions), NULL, 0, NULL);
> +	if (rc < 0) {
> +		dev_err(priv->dev, "devm_mfd_add_devices failed: %d\n", rc);

This to too specific.

  "Failed to register child devices"

> +		return rc;
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
> +	{ .name = "peci-client", .driver_data = 0 },

Remove .driver_data if you're not going to use it.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(peci, peci_client_ids);
> +
> +static struct peci_driver peci_client_driver = {
> +	.probe    = peci_client_probe,
> +	.id_table = peci_client_ids,
> +	.driver   = {
> +			.name           = "peci-client",
> +			.of_match_table =
> +				of_match_ptr(peci_client_of_table),
> +	},
> +};

Odd tabbing.

> +module_peci_driver(peci_client_driver);
> +
> +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
> +MODULE_DESCRIPTION("PECI client MFD driver");

Remove "MFD".

> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/intel-peci-client.h b/include/linux/mfd/intel-peci-client.h
> new file mode 100644
> index 000000000000..7ec272cddceb
> --- /dev/null
> +++ b/include/linux/mfd/intel-peci-client.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2018 Intel Corporation */
> +
> +#ifndef __LINUX_MFD_PECI_CLIENT_H
> +#define __LINUX_MFD_PECI_CLIENT_H
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
> +#define LOWER_NIBBLE_MASK      GENMASK(3, 0)
> +#define UPPER_NIBBLE_MASK      GENMASK(7, 4)
> +
> +#define CPU_ID_MODEL_MASK      GENMASK(7, 4)
> +#define CPU_ID_FAMILY_MASK     GENMASK(11, 8)
> +#define CPU_ID_EXT_MODEL_MASK  GENMASK(19, 16)
> +#define CPU_ID_EXT_FAMILY_MASK GENMASK(27, 20)
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
> +#define TEMP_TYPE_PECI         6 /* Sensor type 6: Intel PECI */
> +
> +#define UPDATE_INTERVAL        HZ
> +
> +struct temp_data {
> +	uint  valid;
> +	s32   value;
> +	ulong last_updated;
> +};

This should not live in here.

> +struct cpu_gen_info {
> +	u16  family;
> +	u8   model;
> +	uint core_max;
> +	uint chan_rank_max;
> +	uint dimm_idx_max;
> +};
> +
> +struct peci_mfd {

Remove "_mfd".

> +	struct peci_client *client;
> +	struct device *dev;
> +	struct peci_adapter *adapter;
> +	char name[PECI_NAME_SIZE];

What is this used for?

> +	u8 addr;
> +	uint cpu_no;
> +	const struct cpu_gen_info *gen_info;

Where is this used?

> +};

Both of these structs need kerneldoc headers.

> +bool peci_temp_need_update(struct temp_data *temp);
> +void peci_temp_mark_updated(struct temp_data *temp);

These should live in a temperature driver.

> +int  peci_client_command(struct peci_mfd *mfd, enum peci_cmd cmd, void *vmsg);
> +int  peci_client_rd_pkg_cfg_cmd(struct peci_mfd *mfd, u8 mbx_idx,
> +				u16 param, u8 *data);
> +
> +#endif /* __LINUX_MFD_PECI_CLIENT_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
