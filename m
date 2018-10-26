Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C81ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798E420868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798E420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJZUtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:49:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:16125 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbeJZUtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:49:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 05:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,427,1534834800"; 
   d="scan'208";a="81114022"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 26 Oct 2018 05:12:29 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gG0ya-0002MB-8p; Fri, 26 Oct 2018 15:12:28 +0300
Date:   Fri, 26 Oct 2018 15:12:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v3 2/3] iio: adc128s052: add ACPI _HID AANT1280
Message-ID: <20181026121228.GE10650@smile.fi.intel.com>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
 <1540481742-23596-3-git-send-email-dan@emutex.com>
 <20181025174638.GB10650@smile.fi.intel.com>
 <c17cf6de-846b-aed3-7745-4f635495873e@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c17cf6de-846b-aed3-7745-4f635495873e@emutex.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:13:01AM +0100, Dan O'Donovan wrote:
> On 10/25/2018 06:46 PM, Andy Shevchenko wrote:
> > On Thu, Oct 25, 2018 at 04:35:41PM +0100, Dan O'Donovan wrote:

> >> +	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */

> > Looking how driver is organized and what ACPI can provide I would highly
> > recommend to look forward to PTYP field for utilization of the type of the HW.

> > Maybe it would not work with published BIOSes, but would be good for the future
> > (in that case anybody can utilize that _HID + PTYP pair on their platforms).

> Thanks Andy for your review and feedback.  Your _HID + PTYP suggestion sounds
> interesting, but I couldn't find any information in the ACPI spec or elsewhere
> about how/when/where to use it.  

I stand corrected, it's not in the spec, rather de facto use of it in some
cases, see below.

> It isn't used in the UP Squared ACPI tables.
> Do you have any links or other information you could share about it? Thanks!

As far as I can find the following code in the kernel and thus real ACPI tables
in the wild that utilize it.

drivers/acpi/dptf/dptf_power.c:84:      status = acpi_evaluate_integer(acpi_dev->handle, "PTYP", NULL, &ptype);
drivers/platform/x86/intel_cht_int33fe.c:101:   status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
drivers/thermal/int340x_thermal/int3403_thermal.c:237:  status = acpi_evaluate_integer(priv->adev->handle, "PTYP",


-- 
With Best Regards,
Andy Shevchenko


