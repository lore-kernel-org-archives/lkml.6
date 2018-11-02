Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA88C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B66A20833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B66A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeKCAXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:23:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:57126 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeKCAXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:23:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 08:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="102902795"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 02 Nov 2018 08:15:49 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gIbAq-000707-EK; Fri, 02 Nov 2018 17:15:48 +0200
Date:   Fri, 2 Nov 2018 17:15:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Message-ID: <20181102151548.GA10650@smile.fi.intel.com>
References: <20181102110653.118257-1-arnd@arndb.de>
 <3c6ddd48-b419-52db-38d3-e0ebf9c46dfc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6ddd48-b419-52db-38d3-e0ebf9c46dfc@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:09:34PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 02-11-18 12:06, Arnd Bergmann wrote:
> > We still get a link failure with IOSF_MBI=m when the xpower driver
> > is built-in:
> > 
> > drivers/acpi/pmic/intel_pmic_xpower.o: In function `intel_xpower_pmic_update_power':
> > intel_pmic_xpower.c:(.text+0x4f2): undefined reference to `iosf_mbi_block_punit_i2c_access'
> > intel_pmic_xpower.c:(.text+0x5e2): undefined reference to `iosf_mbi_unblock_punit_i2c_access'
> > 
> > This makes the dependency stronger, so we can only build when IOSF_MBI
> > is built-in.
> > 
> > Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Hmm, it is probably better to make IOSF_MBI a bool, it is selected by:
> X86_INTEL_QUARK and X86_INTEL_LPSS which are both bools themselves.
> 
> Arguably it should also be hidden and only enabled through these selects.
> Does someone from Intel have an opinion on making it hidden?

We have number of cases where tristate modules depend on or select it.
So, I have not seen a good argument to make it boolean.

-- 
With Best Regards,
Andy Shevchenko


