Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAE320843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAE320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeIZN7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:59:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:22595 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeIZN7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:59:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 00:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,305,1534834800"; 
   d="scan'208";a="76280579"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 26 Sep 2018 00:47:57 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 26 Sep 2018 10:47:56 +0300
Date:   Wed, 26 Sep 2018 10:47:56 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't
 fallback to _CRS?
Message-ID: <20180926074756.GD2664@lahna.fi.intel.com>
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 25, 2018 at 01:54:57PM -0700, Rajat Jain wrote:
> * Use con_id=NULL if it is dealing with a legacy BIOS (i.e. no _DSD
> properties in the ACPI).
> * Use con_id=<actual string> if it is dealing with a modern BIOS (i.e.
> which provides _DSD for the <string> property)

Or you can use con_id=<actual string> everywhere and supply
acpi_dev_add_driver_gpios() where needed to cover cases where BIOS does
not provide _DSD. See also Documentation/acpi/gpio-properties.txt for
more information.

In case of SDHCI I think the correct way is to stick using _CRS lookup
only because there typically is just one GpioInt() and I have not seen a
single BIOS yet where they implement _DSD for this besides yours. If
there is not way to change the BIOS implementation then I guess we just
need to amend the driver to call acpi_dev_add_driver_gpios().
