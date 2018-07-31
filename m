Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70DCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6846D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6846D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbeGaQDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:03:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:65373 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbeGaQDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:03:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 07:23:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,427,1526367600"; 
   d="scan'208";a="77071059"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2018 07:23:05 -0700
Message-ID: <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/6] i2c: designware: use generic table matching
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Date:   Tue, 31 Jul 2018 17:23:04 +0300
In-Reply-To: <44e52856371e4b5c102df8f2efebd527fd26b066.camel@linux.intel.com>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
         <20180731134740.441-2-alexandre.belloni@bootlin.com>
         <44e52856371e4b5c102df8f2efebd527fd26b066.camel@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 17:02 +0300, Andy Shevchenko wrote:
> On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
> > Switch to device_get_match_data in probe to match the device
> > specific
> > data
> > instead of using the acpi specific function.
> > 
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Oops. See below.

> > -	id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> > &pdev->dev);
> > -	if (id && id->driver_data)
> > -		dev->flags |= (u32)id->driver_data;

It seems you forgot to remove unused variable.

> > -
> >  	if (acpi_bus_get_device(handle, &adev))
> >  		return -ENODEV;
> >  
> > @@ -269,6 +265,8 @@ static int dw_i2c_plat_probe(struct
> > platform_device *pdev)
> >  	else
> >  		i2c_parse_fw_timings(&pdev->dev, t, false);
> >  
> > +	dev->flags |= (u32)device_get_match_data(&pdev->dev);
> > +

And since it would be changed anyway, can you actually move this line
closet to  if (has_acpi_companion()) one ?

> >  	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
> >  	/*
> >  	 * Some DSTDs use a non standard speed, round down to the
> > lowest
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
