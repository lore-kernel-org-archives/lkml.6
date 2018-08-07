Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B89EC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD7B214ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD7B214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbeHGPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:00:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388534AbeHGPAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:00:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8B5E31E0D90CF;
        Tue,  7 Aug 2018 20:46:26 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Tue, 7 Aug 2018
 20:46:25 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3 4/4] i2c: Add multi-instantiate pseudo driver
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-5-hdegoede@redhat.com>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        <linux-i2c@vger.kernel.org>
Message-ID: <7e68276c-2211-85d3-3e1f-2bc4b2d9f7d5@huawei.com>
Date:   Tue, 7 Aug 2018 13:46:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180807080539.17811-5-hdegoede@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 09:05, Hans de Goede wrote:
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
>  MAINTAINERS                                  |   6 +
>  drivers/platform/x86/Kconfig                 |  11 ++
>  drivers/platform/x86/Makefile                |   1 +
>  drivers/platform/x86/i2c-multi-instantiate.c | 131 +++++++++++++++++++
>  4 files changed, 149 insertions(+)
>  create mode 100644 drivers/platform/x86/i2c-multi-instantiate.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b377508f24f..09e16d76cab7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6657,6 +6657,12 @@ F:	drivers/i2c/i2c-mux.c
>  F:	drivers/i2c/muxes/
>  F:	include/linux/i2c-mux.h
>
> +I2C MULTI INSTANTIATE DRIVER
> +M:	Hans de Goede <hdegoede@redhat.com>
> +L:	linux-i2c@vger.kernel.org
> +S:	Maintained
> +F:	drivers/drivers/platform/x86/i2c-multi-instantiate.c

This path looks incorrect

> +
>  I2C MV64XXX MARVELL AND ALLWINNER DRIVER
>  M:	Gregory CLEMENT <gregory.clement@bootlin.com>
>  L:	linux-i2c@vger.kernel.org
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 85a93453237c..8256629f58f7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1219,6 +1219,17 @@ config INTEL_CHTDC_TI_PWRBTN
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called intel_chtdc_ti_pwrbtn.
>
> +config I2C_MULTI_INSTANTIATE
> +	tristate "I2C multi instantiate pseudo device driver"
> +	depends on I2C && ACPI
> +	help
> +	  Some ACPI bases systems list multiple i2c-devices in a single ACPI

I guess that this should be "Some ACPI-based systems"

> +	  firmware-node. This driver will instantiate separate i2c-clients
> +	  for each device in the firmware-node.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called i2c-multi-instantiate.
> +

Thanks,
John

