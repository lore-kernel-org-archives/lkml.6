Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3EBC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D968D20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D968D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbeLBRjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 12:39:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:33137 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbeLBRjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 12:39:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2018 09:38:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,307,1539673200"; 
   d="scan'208";a="114955412"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2018 09:38:55 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gTVhm-0003mP-6x; Sun, 02 Dec 2018 19:38:54 +0200
Date:   Sun, 2 Dec 2018 19:38:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/15] platform/x86: intel_cht_int33fe: Accept errors
 of i2c_acpi_new_device()
Message-ID: <20181202173854.GG10650@smile.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-3-andriy.shevchenko@linux.intel.com>
 <20181202155606.16b55703@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202155606.16b55703@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 03:56:06PM +0000, Jonathan Cameron wrote:
> On Wed, 28 Nov 2018 13:45:22 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > In the future i2c_acpi_new_device() will return error pointer in some cases.
> > Prepare intel_cht_int33fe driver to support that.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Really trivial comment inline.  I haven't checked back to see if there
> has been any previous discussion on that bit of code.
> 
> Otherwise looks sensible to me.

> >  		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
> > -		if (!data->max17047)
> > -			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
> > +		if (IS_ERR(data->max17047))
> > +			ret = PTR_ERR(data->max17047);
> Every so slightly nicer to just return directly in these error cases?
> > +		else if (!data->max17047)
> > +			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
> > +		else
> > +			ret = 0;

> Particularly so as then you don't need to set this ret as it's set in all
> paths where it is used below anyway...

It doesn't matter much, since the logically it's split to 3 stages:
- preparation
- change API
- drop obsoleted pieces of code

This one is preparation stage. After 3rd stage it will be as you suggested.

> > +		if (ret)
> > +			return ret;

-- 
With Best Regards,
Andy Shevchenko


