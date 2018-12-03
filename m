Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810CEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4476620661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4476620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeLCToI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:44:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:60580 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeLCToH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:44:07 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 11:44:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="115705703"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2018 11:44:02 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gTu8P-0005TP-E4; Mon, 03 Dec 2018 21:44:01 +0200
Date:   Mon, 3 Dec 2018 21:44:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/15] i2c-multi-instantiate: Adapt for INT3515 and
 alike
Message-ID: <20181203194401.GA10650@smile.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 01:45:20PM +0200, Andy Shevchenko wrote:
> Currently i2c-multi-instantiate driver does not support the case
> of INT3515 USB PD device, where:
> 
> - Interrupt() is used instead of GpioInt()
> - All slaves may be the same from IP point of view
> - There can be variadic amount of slaves
> 
> This series is addressing all above.
> 
> Note, series has been smoke tested (Heikki would do BAT or more)
> on Intel Coffee Lake system.
> 
> The idea is to push this either through PDx86 tree (needs Rafael's ACKs) or ACPI.
> In any case it needs tags from Heikki, Hans, Mika, Wolfram and Jonathan.
> 
> Testing and comments are warmly welcome.

Thank you everyone, who helped with this series, pushed to my review and testing queue!

> 
> In v5:
> - unmess with patches 3 and 4 (there were squashed by my mistake)
> - other than above no code change from v4
> 
> In v4:
> - directly return -EPROBE_DEFER from i2c_acpi_new_device()
> - due to above split error handling simplification to separate patches
> 
> In v3:
> - revisit error codes returned by i2c_acpi_new_device() (Hans, Mika)
> - add documentation to exported i2c_acpi_get_i2c_resource() (Mika)
> - drop Hans' Rb tag in patch 5 due to changes
> - append Mika's Ab tag to patch 6
> 
> In v2:
> - drop patches to copy fwnode and to handle BOSC0200 device
> - append check for amount of devices listed in the driver's mapping
> - add Rb tag given by Hans
> 
> Andy Shevchenko (15):
>   platform/x86: intel_cht_int33fe: Remove duplicate NULL check
>   platform/x86: intel_cht_int33fe: Accept errors of
>     i2c_acpi_new_device()
>   platform/x86: i2c-multi-instantiate: Accept errors of
>     i2c_acpi_new_device()
>   platform/x86: i2c-multi-instantiate: Defer probe when no adapter found
>   i2c: acpi: Return error pointers from i2c_acpi_new_device()
>   platform/x86: intel_cht_int33fe: Get rid of obsolete conditional
>   platform/x86: i2c-multi-instantiate: Get rid of obsolete conditional
>   i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
>   i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
>   platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
>   platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
>   platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
>   platform/x86: i2c-multi-instantiate: Allow to have same slaves
>   ACPI / scan: Create platform device for INT3515 ACPI nodes
>   iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper
> 
>  drivers/acpi/scan.c                          |  1 +
>  drivers/i2c/i2c-core-acpi.c                  | 64 +++++++++----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c   | 16 ++--
>  drivers/platform/x86/i2c-multi-instantiate.c | 97 ++++++++++++++++----
>  drivers/platform/x86/intel_cht_int33fe.c     | 20 ++--
>  drivers/usb/typec/tps6598x.c                 |  8 +-
>  include/linux/acpi.h                         | 11 +++
>  7 files changed, 157 insertions(+), 60 deletions(-)
> 
> --
> 2.19.2
> 

-- 
With Best Regards,
Andy Shevchenko


