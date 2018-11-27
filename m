Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2706DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC04A20645
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC04A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeK1G0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:26:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:11295 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeK1G0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:26:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 11:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="91387684"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 27 Nov 2018 11:27:47 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gRj1O-0003jJ-75; Tue, 27 Nov 2018 21:27:46 +0200
Date:   Tue, 27 Nov 2018 21:27:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
Message-ID: <20181127192746.GZ10650@smile.fi.intel.com>
References: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
 <20181127153728.47866-6-andriy.shevchenko@linux.intel.com>
 <c6a0201e-d69e-7646-dcae-0b1b6fe42451@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a0201e-d69e-7646-dcae-0b1b6fe42451@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 05:14:06PM +0100, Hans de Goede wrote:
> On 27-11-18 16:37, Andy Shevchenko wrote:
> > The caller would like to know the reason why the i2c_acpi_new_device() fails.
> > For example, if adapter is not available, it might be in the future and we
> > would like to re-probe the clients again. But at the same time we would like to
> > bail out if the error seems unrecoverable, such as invalid argument supplied.
> > To achieve this, return error pointer in some cases.

> >   	acpi_dev_free_resource_list(&resource_list);
> > -	if (ret < 0 || !info->addr)
> > -		return NULL;
> > +	if (!info->addr)
> > +		return ERR_PTR(-EADDRNOTAVAIL);
> >   	adapter = i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
> >   	if (!adapter)
> > -		return NULL;
> > +		return ERR_PTR(-ENODEV);

> Why not simply return -EPROBE_DEFER here (and simplify the callers a lot).

> This is the only case where we really want to defer.

> > +	client = i2c_new_device(adapter, info);
> > +	if (!client)
> > +		return ERR_PTR(-ENODEV);
> 
> If you look at i2c_new_device, it can fail because it is
> out of memory, the i2c slave address is invalid, or
> their already is an i2c slave with the same address,
> iow if this were to return an ERR_PTR itself, this
> would return -ENOMEM, -EINVAL or -EBUSY and never
> -EPROBE_DEFER.

It would change the behaviour.

In any case, it's only two users and both written by you, so, just to be sure
you aware of this change and bless it.

-- 
With Best Regards,
Andy Shevchenko


