Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3E120854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3E120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeKKEWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:22:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:65482 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeKKEWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:22:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2018 10:36:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,488,1534834800"; 
   d="scan'208";a="91056032"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2018 10:36:30 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gLY7R-0003w1-0r; Sat, 10 Nov 2018 20:36:29 +0200
Date:   Sat, 10 Nov 2018 20:36:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Grant Likely <grant.likely@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Message-ID: <20181110183629.GE10650@smile.fi.intel.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <20181110182622.GA32657@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110182622.GA32657@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 10:26:22AM -0800, Greg Kroah-Hartman wrote:
> On Sat, Nov 10, 2018 at 08:10:57PM +0200, Andy Shevchenko wrote:
> > Consider the following scenario.
> > 
> > There are two independent devices coupled together by functional dependencies:
> >  - USB OTG (dwc3-pci)
> >  - extcon (tested with extcon-intel-mrfld, not yet in upstream)
> > 
> > Each of the driver services a corresponding device is built as a module. In the
> > Buildroot environment the modules are probed by alphabetical ordering of their
> > modaliases. The latter comes to the case when USB OTG driver will be probed
> > first followed by extcon one.
> > 
> > So, if the platform anticipates extcon device to be appeared, in the above case
> > we will get deferred probe of USB OTG, because of ordering.
> > 
> > Now, a cherry on top of the cake, the deferred probing list contains
> > the only two modules, i.e. USB OTG and extcon. Due to above circumstances,
> > values in the local_trigger_count and deferred_trigger_count are not the same,
> > and thus provokes deferred probe triggering again and again.
> > 
> > ...
> > [   20.678332] platform dwc3.0.auto: Retrying from deferred list
> > [   20.694743] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > [   20.701254] platform dwc3.0.auto: Added to deferred list
> > [   20.706620] platform dwc3.0.auto: driver_deferred_probe_add_trigger 1 2
> > [   20.713732] platform dwc3.0.auto: Retrying from deferred list
> > [   20.730035] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > [   20.736540] platform dwc3.0.auto: Added to deferred list
> > [   20.741889] platform dwc3.0.auto: driver_deferred_probe_add_trigger 3 4
> > [   20.748991] platform dwc3.0.auto: Retrying from deferred list
> > [   20.765416] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > [   20.771914] platform dwc3.0.auto: Added to deferred list
> > [   20.777279] platform dwc3.0.auto: driver_deferred_probe_add_trigger 5 6
> > ...
> > 
> > Deeper investigation shows the culprit commit 58b116bce136
> > ("drivercore: deferral race condition fix") which was dedicated to fix some
> > other issue while bringing a regression.
> > 
> > This reverts commit 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835 for good until
> > we will have better solution.
> > 
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/base/dd.c | 27 ++-------------------------
> >  1 file changed, 2 insertions(+), 25 deletions(-)
> 
> Shouldn't there be a "Fixes:" line and cc: stable here?

I'm not sure (yet). I would like to hear from people first, especially from
Grant (I spoke to him already for the matters at ELCE in Edinburg).

Perhaps, Hans can have a chance to test this and comment on.

-- 
With Best Regards,
Andy Shevchenko


