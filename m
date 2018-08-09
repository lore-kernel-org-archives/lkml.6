Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7FFC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22F621547
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22F621547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbeHINd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:33:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:9664 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbeHINd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:33:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 04:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,214,1531810800"; 
   d="scan'208";a="79882884"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 09 Aug 2018 04:09:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 09 Aug 2018 14:09:29 +0300
Date:   Thu, 9 Aug 2018 14:09:29 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v5 4/4] platform/x86: Add ACPI i2c-multi-instantiate
 pseudo driver
Message-ID: <20180809110929.GD1634@kuha.fi.intel.com>
References: <20180809091558.4317-1-hdegoede@redhat.com>
 <20180809091558.4317-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809091558.4317-5-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 11:15:58AM +0200, Hans de Goede wrote:
> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
> i2c-device.
> 
> But in some rare cases the manufacturer has decided to describe multiple
> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
> 
> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
> code to support this corner-case.
> 
> This commit introduces a new i2c-multi-instantiate driver which fixes this
> in a different way. This new driver can be built as a module which will
> only loaded on affected systems.
> 
> This driver will instantiate a new i2c-client per I2cSerialBus resource,
> using the driver_data from the acpi_device_id it is binding to to tell it
> which chip-type (and optional irq-resource) to use when instantiating.
> 
> Note this driver depends on a platform device being instantiated for the
> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

<snip>

> +static int i2c_multi_inst_probe(struct platform_device *pdev)
> +{
> +	struct i2c_multi_inst_data *multi;
> +	const struct acpi_device_id *match;
> +	const struct i2c_inst_data *inst_data;
> +	struct i2c_board_info board_info = {};
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev;
> +	char name[32];
> +	int i, ret;
> +
> +	match = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!match) {
> +		dev_err(dev, "Error ACPI match data is missing\n");
> +		return -ENODEV;
> +	}
> +	inst_data = (const struct i2c_inst_data *)match->driver_data;
> +
> +	adev = ACPI_COMPANION(dev);
> +
> +	/* Count number of clients to instantiate */
> +	for (i = 0; inst_data[i].type; i++) {}
> +
> +	multi = devm_kmalloc(dev,
> +			offsetof(struct i2c_multi_inst_data, clients[i]),
> +			GFP_KERNEL);
> +	if (!multi)
> +		return -ENOMEM;
> +
> +	multi->num_clients = i;
> +
> +	for (i = 0; i < multi->num_clients; i++) {
> +		memset(&board_info, 0, sizeof(board_info));
> +		strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
> +		snprintf(name, sizeof(name), "%s-%s", match->id,
> +			 inst_data[i].type);
> +		board_info.dev_name = name;
> +		board_info.irq = 0;
> +		if (inst_data[i].irq_idx != -1) {
> +			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
> +			if (ret < 0) {
> +				dev_err(dev, "Error requesting irq at index %d: %d\n",
> +					inst_data[i].irq_idx, ret);
> +				goto error;

This seems to assume that we always have GpioInt with assigned for
these devices, but that's wrong. This needs to work with normal
Interrupt type resources as well.

The TI USB PD controller instances (HID 3515) for exmaple have normal
Interrupts assigned to them

Why not use the "irq_idx" with normal interrupts, and add a new member
for the GpioInts, something like gpio_irq_idx?

> +			}
> +			board_info.irq = ret;
> +		}
> +		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
> +		if (!multi->clients[i]) {
> +			dev_err(dev, "Error creating i2c-client, idx %d\n", i);
> +			ret = -ENODEV;
> +			goto error;
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, multi);
> +	return 0;
> +
> +error:
> +	while (--i >= 0)
> +		i2c_unregister_device(multi->clients[i]);
> +
> +	return ret;
> +}

Thanks,

-- 
heikki
