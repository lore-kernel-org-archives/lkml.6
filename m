Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70358C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4388E20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4388E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeK0UEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:04:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:57537 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbeK0UEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:04:40 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 01:07:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="95523094"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 27 Nov 2018 01:07:20 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 27 Nov 2018 11:07:19 +0200
Date:   Tue, 27 Nov 2018 11:07:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/13] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Message-ID: <20181127090719.GM2296@lahna.fi.intel.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
 <20181126150858.16901-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126150858.16901-8-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:08:52PM +0200, Andy Shevchenko wrote:
> Besides current two users one more is coming. Definitely makes sense to
> introduce a helper.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/i2c/i2c-core-acpi.c | 31 +++++++++++++++++++------------
>  include/linux/acpi.h        | 11 +++++++++++
>  2 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 287a5e4b3d30..b43f535d264b 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -45,6 +45,23 @@ struct i2c_acpi_lookup {
>  	u32 min_speed;
>  };
>  

Since this is exported, you may want to add kernel-doc here.

> +bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
> +			       struct acpi_resource_i2c_serialbus **i2c)
> +{
> +	struct acpi_resource_i2c_serialbus *sb;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return false;
> +
> +	sb = &ares->data.i2c_serial_bus;
> +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
> +		return false;
> +
> +	*i2c = sb;
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(i2c_acpi_get_i2c_resource);
> +
>  static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
>  {
>  	struct i2c_acpi_lookup *lookup = data;
> @@ -52,11 +69,7 @@ static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
>  	struct acpi_resource_i2c_serialbus *sb;
>  	acpi_status status;
>  
> -	if (info->addr || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> -		return 1;
> -
> -	sb = &ares->data.i2c_serial_bus;
> -	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
> +	if (info->addr || !i2c_acpi_get_i2c_resource(ares, &sb))
>  		return 1;
>  
>  	if (lookup->index != -1 && lookup->n++ != lookup->index)
> @@ -528,13 +541,7 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
>  		goto err;
>  	}
>  
> -	if (!value64 || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> -		ret = AE_BAD_PARAMETER;
> -		goto err;
> -	}
> -
> -	sb = &ares->data.i2c_serial_bus;
> -	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> +	if (!value64 || !i2c_acpi_get_i2c_resource(ares, &sb)) {
>  		ret = AE_BAD_PARAMETER;
>  		goto err;
>  	}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ed80f147bd50..6afc6e3c4c5c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1054,6 +1054,17 @@ static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
>  }
>  #endif
>  
> +#if defined(CONFIG_ACPI) && IS_ENABLED(CONFIG_I2C)
> +bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
> +			       struct acpi_resource_i2c_serialbus **i2c);
> +#else
> +static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
> +					     struct acpi_resource_i2c_serialbus **i2c)
> +{
> +	return false;
> +}

I think this belongs to include/linux/i2c.h where we have
i2c_acpi_find_bus_speed() and friends.
