Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1167CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DBF21019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DBF21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeK1XIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:08:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:29063 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbeK1XIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:08:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 04:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="116504574"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 28 Nov 2018 04:07:22 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 28 Nov 2018 14:07:21 +0200
Date:   Wed, 28 Nov 2018 14:07:21 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/15] ACPI / scan: Create platform device for INT3515
 ACPI nodes
Message-ID: <20181128120721.GB32679@kuha.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-15-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128114535.80223-15-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 01:45:34PM +0200, Andy Shevchenko wrote:
> The ACPI device with INT3515 _HID is representing a complex USB PD
> hardware infrastructure which includes several I2C slave ICs.
> 
> We add an ID to the I2C multi instantiate list to enumerate
> all I2C slaves correctly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/acpi/scan.c                          | 1 +
>  drivers/platform/x86/i2c-multi-instantiate.c | 9 +++++++++
>  drivers/usb/typec/tps6598x.c                 | 8 ++++----
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index bd1c59fb0e17..e9eda5558c1f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1541,6 +1541,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
>  		{"BSG1160", },
>  		{"INT33FE", },
> +		{"INT3515", },
>  		{}
>  	};
>  
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> index 2439d4c71118..3d893e0ac250 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -159,12 +159,21 @@ static const struct i2c_inst_data bsg1160_data[]  = {
>  	{}
>  };
>  
> +static const struct i2c_inst_data int3515_data[]  = {
> +	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
> +	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
> +	{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
> +	{ "tps6598x", IRQ_RESOURCE_APIC, 3 },
> +	{}
> +};
> +
>  /*
>   * Note new device-ids must also be added to i2c_multi_instantiate_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>   */
>  static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>  	{ "BSG1160", (unsigned long)bsg1160_data },
> +	{ "INT3515", (unsigned long)int3515_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index c84c8c189e90..1c0033ad8738 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -501,19 +501,19 @@ static int tps6598x_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static const struct acpi_device_id tps6598x_acpi_match[] = {
> -	{ "INT3515", 0 },
> +static const struct i2c_device_id tps6598x_id[] = {
> +	{ "tps6598x" },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(acpi, tps6598x_acpi_match);
> +MODULE_DEVICE_TABLE(i2c, tps6598x_id);
>  
>  static struct i2c_driver tps6598x_i2c_driver = {
>  	.driver = {
>  		.name = "tps6598x",
> -		.acpi_match_table = tps6598x_acpi_match,
>  	},
>  	.probe_new = tps6598x_probe,
>  	.remove = tps6598x_remove,
> +	.id_table = tps6598x_id,
>  };
>  module_i2c_driver(tps6598x_i2c_driver);
>  
> -- 
> 2.19.2

-- 
heikki
