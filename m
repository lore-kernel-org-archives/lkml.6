Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03034C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C4B21834
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C4B21834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbeHIMcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:32:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:63560 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbeHIMcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:32:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 03:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,214,1531810800"; 
   d="scan'208";a="247433372"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 09 Aug 2018 03:08:05 -0700
Message-ID: <1c6de96932f6b7d2d94efb7d4a6db46948b32ac1.camel@linux.intel.com>
Subject: Re: [PATCH v5 2/4] ACPI / scan: Create platform device for fwnodes
 with multiple i2c devices
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c@vger.kernel.org
Date:   Thu, 09 Aug 2018 13:08:05 +0300
In-Reply-To: <20180809091558.4317-3-hdegoede@redhat.com>
References: <20180809091558.4317-1-hdegoede@redhat.com>
         <20180809091558.4317-3-hdegoede@redhat.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 11:15 +0200, Hans de Goede wrote:
> Some devices have multiple I2cSerialBus resources and for things to
> work
> an i2c-client must be instantiated for each, each with its own
> i2c_device_id.
> 
> Normally we only instantiate an i2c-client for the first resource,
> using
> the ACPI HID as id.
> 
> This commit adds a list of HIDs of devices, which need multiple i2c-
> clients
> instantiated from a single fwnode, to
> acpi_device_enumeration_by_parent and
> makes acpi_device_enumeration_by_parent return false for these devices
> so
> that a platform device will be instantiated.
> 
> This allows the drivers/platform/x86/i2c-multi-instantiate.c driver,
> which
> knows which i2c_device_id to use for each resource, to bind to the
> fwnode
> and initiate an i2c-client for each resource.
> 

I like this approach

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> -New patch in v3 of this patch-set
> 
> Changes in v4:
> -Some small code-style fixes
> ---
>  drivers/acpi/scan.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 6799d00dd790..b51913372e21 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1540,6 +1540,18 @@ static bool
> acpi_device_enumeration_by_parent(struct acpi_device *device)
>  {
>  	struct list_head resource_list;
>  	bool is_serial_bus_slave = false;
> +	/*
> +	 * These devices have multiple I2cSerialBus resources and an
> i2c-client
> +	 * must be instantiated for each, each with its own
> i2c_device_id.
> +	 * Normally we only instantiate an i2c-client for the first
> resource,
> +	 * using the ACPI HID as id. These special cases are handled by
> the
> +	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which
> knows
> +	 * which i2c_device_id to use for each resource.
> +	 */
> +	static const struct acpi_device_id i2c_multi_instantiate_ids[] =
> {
> +		{"BSG1160", },
> +		{}
> +	};
>  
>  	if (acpi_is_indirect_io_slave(device))
>  		return true;
> @@ -1551,6 +1563,10 @@ static bool
> acpi_device_enumeration_by_parent(struct acpi_device *device)
>  	     fwnode_property_present(&device->fwnode, "baud")))
>  		return true;
>  
> +	/* Instantiate a pdev for the i2c-multi-instantiate drv to bind
> to */
> +	if (!acpi_match_device_ids(device, i2c_multi_instantiate_ids))
> +		return false;
> +
>  	INIT_LIST_HEAD(&resource_list);
>  	acpi_dev_get_resources(device, &resource_list,
>  			       acpi_check_serial_bus_slave,

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

