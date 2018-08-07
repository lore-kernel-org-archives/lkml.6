Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BD9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90D52156B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90D52156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388895AbeHGNdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:33:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:8871 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeHGNdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:33:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 04:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,455,1526367600"; 
   d="scan'208";a="222611361"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 07 Aug 2018 04:19:40 -0700
Message-ID: <00e16cb09c171b536449b61124473291f2b30d0b.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/4] ACPI / scan: Create platform device for fwnodes
 with multiple i2c devices
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
Date:   Tue, 07 Aug 2018 14:19:40 +0300
In-Reply-To: <20180807080539.17811-3-hdegoede@redhat.com>
References: <20180807080539.17811-1-hdegoede@redhat.com>
         <20180807080539.17811-3-hdegoede@redhat.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-07 at 10:05 +0200, Hans de Goede wrote:
> Some devices have multiple I2cSerialBus resources and for things to
> work
> an i2c-client must be instantiated for each, each with its own
> i2c_device_id.
> 
> Normally we only instantiate an i2c-client for the first resource,
> using
> the ACPI HID as id.
> 
> This commit adds a list of HIDs of devices, which need multiple i2c-
> clients
> instantiated from a single fwnode, to
> acpi_device_enumeration_by_parent and
> makes acpi_device_enumeration_by_parent return false for these devices
> so
> that a platform device will be instantiated.
> 
> This allows the drivers/platform/x86/i2c-multi-instantiate.c driver,
> which
> knows which i2c_device_id to use for each resource, to bind to the
> fwnode
> and initiate an i2c-client for each resource.
> 

> +	/*
> +	 * These devices have multiple I2cSerialBus resources and an
> i2c-client
> +	 * must be instantiated for each, each with its own
> i2c_device_id.
> +	 * Normally we only instantiate an i2c-client for the first
> resource,
> +	 * using the ACPI HID as id. These special cases are handled by
> the
> +	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which
> knows
> +	 * which i2c_device_id to use for each resource.
> +	 */
> +	static const struct acpi_device_id i2c_multi_instantiate_ids[] =
> {
> +		{"BSG1160", 0},
> +		{"", 0},
> +	};

Style nits:
- can we move it outside of function?
- terminator better without comma
- is this existing style in the file and / or files in this folder for
IDs? (I mean unnecessary 0:s and empty string?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
