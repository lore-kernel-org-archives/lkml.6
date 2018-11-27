Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A60C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EF52133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EF52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeK1BZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:25:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:39362 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbeK1BZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:25:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 06:27:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="285494607"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 27 Nov 2018 06:27:32 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gReKp-0001oo-4t; Tue, 27 Nov 2018 16:27:31 +0200
Date:   Tue, 27 Nov 2018 16:27:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
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
Message-ID: <20181127142731.GS10650@smile.fi.intel.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
 <20181126150858.16901-8-andriy.shevchenko@linux.intel.com>
 <20181127090719.GM2296@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127090719.GM2296@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:07:19AM +0200, Mika Westerberg wrote:
> On Mon, Nov 26, 2018 at 05:08:52PM +0200, Andy Shevchenko wrote:
> > Besides current two users one more is coming. Definitely makes sense to
> > introduce a helper.

> Since this is exported, you may want to add kernel-doc here.

OK.

> > +++ b/include/linux/acpi.h
> > @@ -1054,6 +1054,17 @@ static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
> >  }
> >  #endif
> >  
> > +#if defined(CONFIG_ACPI) && IS_ENABLED(CONFIG_I2C)
> > +bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
> > +			       struct acpi_resource_i2c_serialbus **i2c);
> > +#else
> > +static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
> > +					     struct acpi_resource_i2c_serialbus **i2c)
> > +{
> > +	return false;
> > +}
> 
> I think this belongs to include/linux/i2c.h where we have
> i2c_acpi_find_bus_speed() and friends.

I don't think so. It operates on top of data structures defined solely under
ACPI umbrella. If I move them to i2c.h it would look inconsistent.

Perhaps you would like to have different namespace for it (like acpi_i2c_ ?).

-- 
With Best Regards,
Andy Shevchenko


