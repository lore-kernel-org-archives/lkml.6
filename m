Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49CFC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D91B26AA3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D91B26AA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932991AbeF0Hq0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:46:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:23337 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752979AbeF0HqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:46:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 00:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="62544843"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2018 00:46:20 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 2D5A2205FC; Wed, 27 Jun 2018 10:46:19 +0300 (EEST)
Date:   Wed, 27 Jun 2018 10:46:19 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     alanx.chiang@intel.com
Cc:     linux-i2c@vger.kernel.org, andy.yeh@intel.com,
        andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com,
        rajmohan.mani@intel.com, andy.shevchenko@gmail.com,
        tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] eeprom: at24: Add support for address-width
 property
Message-ID: <20180627074618.65wcohw5fohbu7cv@paasikivi.fi.intel.com>
References: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
 <1530078385-1546-3-git-send-email-alanx.chiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530078385-1546-3-git-send-email-alanx.chiang@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 01:46:25PM +0800, alanx.chiang@intel.com wrote:
> From: Alan Chiang <alanx.chiang@intel.com>
> 
> Provide a flexible way to determine the addressing bits of eeprom.
> Pass the addressing bits to driver through address-width property.
> 
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> 
> ---
> since v1
> -- Add a warn message for 8-bit addressing.
> since v2
> -- Modify the warning message for clear.
> -- Move the clearing bit operation outside of a statement.
> 
> ---
>  drivers/misc/eeprom/at24.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 0c125f2..d606f3b 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -478,6 +478,24 @@ static void at24_properties_to_pdata(struct device *dev,
>  	if (device_property_present(dev, "no-read-rollover"))
>  		chip->flags |= AT24_FLAG_NO_RDROL;
>  
> +	err = device_property_read_u32(dev, "address-width", &val);
> +	if (!err) {
> +		switch (val) {
> +		case 8:
> +			if (chip->flags & AT24_FLAG_ADDR16)
> +				dev_warn(dev, "Override address width to be 8,"
> +					 "while default is 16\n");

Please don't wrap strings --- it breaks grep. Exceeding 80 is ok in this
case.

> +			chip->flags &= ~AT24_FLAG_ADDR16;
> +			break;
> +		case 16:
> +			chip->flags |= AT24_FLAG_ADDR16;
> +			break;
> +		default:
> +			dev_warn(dev, "Bad \"address-width\" property: %u\n",
> +				 val);
> +		}
> +	}
> +
>  	err = device_property_read_u32(dev, "size", &val);
>  	if (!err)
>  		chip->byte_len = val;
> -- 
> 2.7.4
> 

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
