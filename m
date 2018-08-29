Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45459C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C72320652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C72320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeH2WSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:18:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:25282 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbeH2WSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:18:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 11:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,304,1531810800"; 
   d="scan'208";a="68840588"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 11:20:13 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1fv54d-0003b3-Os; Wed, 29 Aug 2018 21:20:11 +0300
Date:   Wed, 29 Aug 2018 21:20:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Add Intel ISP dummy driver
Message-ID: <20180829182011.GG11447@smile.fi.intel.com>
References: <20180829135744.16205-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829135744.16205-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:57:44PM +0200, Hans de Goede wrote:
> The Image Signal Processor found on Cherry Trail devices is brought up in
> D0 state on devices which have camera sensors attached to it. The ISP will
> not enter D3 state again without some massaging of its registers beforehand
> and the ISP not being in D3 state blocks the SoC from entering S0ix modes.
> 
> There was a driver for the ISP in drivers/staging but that got removed
> again because it never worked. It does not seem likely that a real
> driver for the ISP will be added to the mainline kernel anytime soon.
> 
> This commit adds a dummy driver which contains the necessary magic from
> the staging driver to powerdown the ISP, so that Cherry Trail devices where
> the ISP is used will properly use S0ix modes when suspended.
> 
> Together with other recent S0ix related fixes this allows S0ix modes to
> be entered on e.g. a Chuwi Hi8 Pro and a HP x2 210.
> 

Thanks for the patch, my comments below.

>  drivers/platform/x86/intel_isp_dummy.c | 119 +++++++++++++++++++++++++

First of all, I would like to see that this is about pm and pm only, so,
perhaps

intel_isp_pm ?

OTOH, it would be nice to have less confusing of what ISP we are talking about,
so,

intel_atomisp2_pm ?

> +config INTEL_ISP_DUMMY
> +	tristate "Intel ISP dummy driver"

> +	depends on PCI && IOSF_MBI && PM

If someone decides to port this to kernels where ATOMISP driver is still
available, it might be a conflict here. I dunno if it's a good idea to put
something like depends !ATOMISP here taking into consideration that it would be
staled option.

> +	while (1) {

A nit: I would rather put it like

do {
...
} while (time_after(...));

> +		/* Wait until ISPSSPM0 bit[25:24] shows 0x3 */
> +		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, ISPSSPM0, &val);
> +		val = (val & ISPSSPM0_ISPSSS_MASK) >> ISPSSPM0_ISPSSS_OFFSET;
> +		if (val == ISPSSPM0_IUNIT_POWER_OFF)
> +			break;
> +
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(&dev->dev, "IUNIT power-off timeout.\n");
> +			return -EBUSY;
> +		}
> +		usleep_range(1000, 2000);
> +	}

-- 
With Best Regards,
Andy Shevchenko


