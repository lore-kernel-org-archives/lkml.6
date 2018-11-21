Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB51C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96642147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96642147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbeKVAuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:50:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:35280 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbeKVAuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:50:03 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 06:15:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="110014939"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 21 Nov 2018 06:15:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 21 Nov 2018 16:15:22 +0200
Date:   Wed, 21 Nov 2018 16:15:22 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/15] i2c: acpi: Assign fwnode for devices created
 via i2c_acpi_new_device()
Message-ID: <20181121141522.GA16476@kuha.fi.intel.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-7-andriy.shevchenko@linux.intel.com>
 <c2ad13ad-cf27-2700-a051-4dda56755ebd@redhat.com>
 <20181121133549.GL10650@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121133549.GL10650@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Wed, Nov 21, 2018 at 03:35:49PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 21, 2018 at 12:44:27PM +0100, Hans de Goede wrote:

> > I see 2 possible solutions here:
> > 
> > 1) Changing this patch so that i2c_acpi_new_device() does:
> > 
> >         /*
> >          * The fwnode can not be shared between instantiated clients when
> >          * adding device-properties to the instantiated client.
> >          */
> > 	if (!info->properties)
> > 		info->fwnode = acpi_fwnode_handle(adev);
> > 
> > 2) Leave whether info->fwnode should be set or not up to the
> > caller of i2c_acpi_new_device() (info is already passed in as
> > a param). E.g. i2c-multi-instantiate.c could do this (for now,
> > maybe in the future we will also want to add properties for
> > some HIDs).
> > 
> > I think that 1. is the best solution and this is all kernel internal,
> > so we can always revisit this if necessary.
> 
> Heikki told me he has some ideas, but for now I will drop this patch.

I think the only thing that we can do is to assign the ACPI node as the
secondary node to this kind of mfd "cells". It would most likely
require some changes to the apci code in Linux kernel, probable
nothing major, but no driver needs this for now (I think), so we don't
need to worry about it right now.


thanks,

-- 
heikki
