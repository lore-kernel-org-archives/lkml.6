Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4225EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35CE26579
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35CE26579
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeFZGrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:47:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:59842 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750942AbeFZGrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:47:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 23:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,273,1526367600"; 
   d="scan'208";a="66360292"
Received: from cblaim-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.34.55])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jun 2018 23:47:38 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 0082621E18; Tue, 26 Jun 2018 09:47:36 +0300 (EEST)
Date:   Tue, 26 Jun 2018 09:47:36 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     alanx.chiang@intel.com
Cc:     linux-i2c@vger.kernel.org, andy.yeh@intel.com,
        andriy.shevchenko@intel.com, rajmohan.mani@intel.com,
        andy.shevchenko@gmail.com, brgl@bgdev.pl, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] eeprom: at24: Add support for address-width
 property
Message-ID: <20180626064736.msxcnsi5rsnxp62k@kekkonen.localdomain>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
 <1529994128-26770-3-git-send-email-alanx.chiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529994128-26770-3-git-send-email-alanx.chiang@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, Jun 26, 2018 at 02:22:08PM +0800, alanx.chiang@intel.com wrote:
> From: "alanx.chiang" <alanx.chiang@intel.com>
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
> 
> ---
>  drivers/misc/eeprom/at24.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 0c125f2..231afcd 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -478,6 +478,22 @@ static void at24_properties_to_pdata(struct device *dev,
>  	if (device_property_present(dev, "no-read-rollover"))
>  		chip->flags |= AT24_FLAG_NO_RDROL;
>  
> +	err = device_property_read_u32(dev, "address-width", &val);
> +	if (!err) {
> +		switch (val) {
> +		case 8:
> +			chip->flags &= ~AT24_FLAG_ADDR16;
> +			dev_warn(dev, "address-width is 8, clear the ADD16 bit\n");

Even though the default is 8 address bits, I don't see a need to issue a
warning if the address-width property sets that to 8 explicitly. I.e. only
warn if the flag was set.

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

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
