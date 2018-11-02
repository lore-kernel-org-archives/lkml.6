Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0149C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B045F20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B045F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeKCAYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:24:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:26726 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbeKCAYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:24:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 08:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="93232420"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2018 08:16:45 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gIbBk-00070U-0c; Fri, 02 Nov 2018 17:16:44 +0200
Date:   Fri, 2 Nov 2018 17:16:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Message-ID: <20181102151644.GB10650@smile.fi.intel.com>
References: <20181102110653.118257-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102110653.118257-1-arnd@arndb.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:06:43PM +0100, Arnd Bergmann wrote:
> We still get a link failure with IOSF_MBI=m when the xpower driver
> is built-in:
> 
> drivers/acpi/pmic/intel_pmic_xpower.o: In function `intel_xpower_pmic_update_power':
> intel_pmic_xpower.c:(.text+0x4f2): undefined reference to `iosf_mbi_block_punit_i2c_access'
> intel_pmic_xpower.c:(.text+0x5e2): undefined reference to `iosf_mbi_unblock_punit_i2c_access'
> 
> This makes the dependency stronger, so we can only build when IOSF_MBI
> is built-in.
> 
> Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 18851e7eedd5..31a3c4a03f61 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
>  
>  config XPOWER_PMIC_OPREGION
>  	bool "ACPI operation region support for XPower AXP288 PMIC"
> -	depends on MFD_AXP20X_I2C && IOSF_MBI
> +	depends on MFD_AXP20X_I2C && IOSF_MBI=y

To me sounds like

select IOSF_MBI would be more appropriate here.

>  	help
>  	  This config adds ACPI operation region support for XPower AXP288 PMIC.

-- 
With Best Regards,
Andy Shevchenko


