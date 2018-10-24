Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B1C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0D62082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0D62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJXSlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:41:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:34650 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbeJXSlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:41:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 03:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="98120672"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 24 Oct 2018 03:13:41 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gFGAW-0003cn-58; Wed, 24 Oct 2018 13:13:40 +0300
Date:   Wed, 24 Oct 2018 13:13:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan O'Donovan <dan@emutex.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
Message-ID: <20181024101340.GR10650@smile.fi.intel.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-3-git-send-email-dan@emutex.com>
 <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com>
 <16591e6735e32baad10f083c688119ce79d12911.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16591e6735e32baad10f083c688119ce79d12911.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 12:23:13PM -0700, Joe Perches wrote:
> On Tue, 2018-10-23 at 20:50 +0200, Jacek Anaszewski wrote:
> > > diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
> > > new file mode 100644
> > > index 0000000..34a6973
> > > --- /dev/null
> > > +++ b/drivers/leds/leds-upboard.c
> > > @@ -0,0 +1,104 @@
> []
> > > +#include <linux/kernel.h>
> > > +#include <linux/leds.h>
> > > +#include <linux/mfd/upboard.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/acpi.h>
> > 
> > The last include should go first to keep alphabetical order.
> 
> There is no accepted single kernel style for #include
> file ordering.

There is a rule of (subtly) better maintenance.
If you need to add / remove some header later in a (long) list of unordered
list, it would be error prone.

Just run `make includecheck` and see the result.

I personally fixed some header duplications and removal of init.h in unsorted
lists, which have been missed by some reasons.

> drivers/leds does not use a single style nor is this
> particular variant documented anywhere to my knowledge.

Neither does kernel in general.
But kernel is evolving and styles also. When you do such statement consider to
divide by a time period when certain code was pushed to upstream.

> Until such a time when either a local preferred style
> document or a treewide preferred style exists, please
> stop asking people to modify #include ordering for
> various styles like reverse christmas tree by length,
> alphabetic ordering, or other individual styles.

Why? It makes a sense to ask for new code (and even for patches against old one in some cases).

> My preferred style would always have kernel.h first
> as that may help with precompiled headers and overall
> kernel compilation time one day.

How ordering would screw this up?

-- 
With Best Regards,
Andy Shevchenko


