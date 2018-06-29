Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC971C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5856725163
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5856725163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936882AbeF2QPF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:15:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:53767 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934834AbeF2QPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:15:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 09:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="53270482"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 29 Jun 2018 09:14:58 -0700
Message-ID: <33642a4af01344cda16fd09c58d79ceee0b81f25.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/2] eeprom: at24: Add support for address-width
 property
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     alanx.chiang@intel.com, linux-i2c@vger.kernel.org
Cc:     andy.yeh@intel.com, sakari.ailus@linux.intel.com,
        rajmohan.mani@intel.com, andy.shevchenko@gmail.com,
        tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Fri, 29 Jun 2018 19:14:57 +0300
In-Reply-To: <1530256915-25034-3-git-send-email-alanx.chiang@intel.com>
References: <1530256915-25034-1-git-send-email-alanx.chiang@intel.com>
         <1530256915-25034-3-git-send-email-alanx.chiang@intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 15:21 +0800, alanx.chiang@intel.com wrote:
> From: Alan Chiang <alanx.chiang@intel.com>
> 
> Provide a flexible way to determine the addressing bits of eeprom.
> Pass the addressing bits to driver through address-width property.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> 
> ---
> since v1
> -- Add a warn message for 8-bit addressing.
> since v2
> -- Modify the warning message for clear.
> -- Move the clearing bit operation outside of a statement.
> since v3
> -- Merge the warning message into one line.
> 
> ---
>  drivers/misc/eeprom/at24.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 0c125f2..7ea640b 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -478,6 +478,23 @@ static void at24_properties_to_pdata(struct
> device *dev,
>  	if (device_property_present(dev, "no-read-rollover"))
>  		chip->flags |= AT24_FLAG_NO_RDROL;
>  
> +	err = device_property_read_u32(dev, "address-width", &val);
> +	if (!err) {
> +		switch (val) {
> +		case 8:
> +			if (chip->flags & AT24_FLAG_ADDR16)
> +				dev_warn(dev, "Override address width
> to be 8, while default is 16\n");
> +			chip->flags &= ~AT24_FLAG_ADDR16;
> +			break;
> +		case 16:
> +			chip->flags |= AT24_FLAG_ADDR16;
> +			break;
> +		default:
> +			dev_warn(dev, "Bad \"address-width\"
> property: %u\n",
> +				 val);
> +		}
> +	}
> +
>  	err = device_property_read_u32(dev, "size", &val);
>  	if (!err)
>  		chip->byte_len = val;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
