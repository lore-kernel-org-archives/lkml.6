Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDBEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D67D214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D67D214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeKVAKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:10:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:64726 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKVAKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:10:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 05:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="91044323"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 21 Nov 2018 05:35:50 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gPSfV-0003s8-Co; Wed, 21 Nov 2018 15:35:49 +0200
Date:   Wed, 21 Nov 2018 15:35:49 +0200
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
Subject: Re: [PATCH v1 06/15] i2c: acpi: Assign fwnode for devices created
 via i2c_acpi_new_device()
Message-ID: <20181121133549.GL10650@smile.fi.intel.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-7-andriy.shevchenko@linux.intel.com>
 <c2ad13ad-cf27-2700-a051-4dda56755ebd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ad13ad-cf27-2700-a051-4dda56755ebd@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:44:27PM +0100, Hans de Goede wrote:
> On 20-11-18 16:59, Andy Shevchenko wrote:
> > i2c_acpi_new_device() doesn't assign fwnode like it's done, for example,
> > in i2c_acpi_register_devices() path.
> > 
> > Assign fwnode in i2c_acpi_new_device() as it's done elsewhere.

> As already mentioned in my reply to the cover letter, a NACK from me for
> this one.
> 
> The problem is that this causes the fwnode to be shared by all the
> "struct device"-s (embedded in the i2c-clients created).
> 
> This in itself is not necessarily a problem, but it does become a
> problem when combined with using device_add_properties as
> intel_cht_int33fe.c does.
> 
> Since the info in the ACPI tables for devices which use this
> driver is pretty terrible, we add a bunch of properties to notify
> the drivers about how the different parts which make up the Type-C
> functionality are tied together.
> 
> device_add_properties creates a new fwnode and then calls
> set_secondary_fwnode. For devices which already have a fwnode
> assigned (which the i2c-clients will have after this patch)
> set_secondary_fwnode sets dev->fwnode->secondary to the fwnode
> which has been newly created to hold the added properties.
> 
> Since all i2c-clients instantiated now share dev->fwnode,
> the result of this is that all i2c-clients created now will
> have the properties of the last i2c-client instantiated for
> an acpi-node which describes multiple clients in a single
> node.
> 
> Also the fwnodes created  for the properties of earlier
> instantiated i2c-clients will be leaked.

Thanks for this very detailed problem report.

> 
> I see 2 possible solutions here:
> 
> 1) Changing this patch so that i2c_acpi_new_device() does:
> 
>         /*
>          * The fwnode can not be shared between instantiated clients when
>          * adding device-properties to the instantiated client.
>          */
> 	if (!info->properties)
> 		info->fwnode = acpi_fwnode_handle(adev);
> 
> 2) Leave whether info->fwnode should be set or not up to the
> caller of i2c_acpi_new_device() (info is already passed in as
> a param). E.g. i2c-multi-instantiate.c could do this (for now,
> maybe in the future we will also want to add properties for
> some HIDs).
> 
> I think that 1. is the best solution and this is all kernel internal,
> so we can always revisit this if necessary.

Heikki told me he has some ideas, but for now I will drop this patch.


-- 
With Best Regards,
Andy Shevchenko


