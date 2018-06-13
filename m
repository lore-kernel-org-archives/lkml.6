Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C67DFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FEC204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FEC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935573AbeFMMxN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:53:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:53892 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935348AbeFMMxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:53:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 05:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,218,1526367600"; 
   d="scan'208";a="56980515"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2018 05:53:08 -0700
Message-ID: <6a387b8b67497fa4a656c252a010d6d4e72e7774.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from
 S3
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        P HeLiOn <perryhelionsemail@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Wed, 13 Jun 2018 15:53:07 +0300
In-Reply-To: <1568228.RgPNub1osy@aspire.rjw.lan>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
         <2505591.oRh3ktjo9V@aspire.rjw.lan>
         <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
         <1568228.RgPNub1osy@aspire.rjw.lan>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 13:17 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that commit a192aa923b66a (ACPI / LPSS: Consolidate
> runtime PM and system sleep handling) introduced a system suspend
> regression on some machines, but the only functional change made by
> it was to cause the PM quirks in the LPSS to also be used during
> system suspend and resume.  While that should always work for
> suspend-to-idle, it turns out to be problematic for S3
> (suspend-to-RAM).
> 
> To address that issue restore the previous S3 suspend and resume
> behavior of the LPSS to avoid applying PM quirks then.
> 

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: a192aa923b66a (ACPI / LPSS: Consolidate runtime PM and system
> sleep handling)
> Link: https://bugs.launchpad.net/bugs/1774950
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpi_lpss.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpi_lpss.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> +++ linux-pm/drivers/acpi/acpi_lpss.c
> @@ -22,6 +22,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> +#include <linux/suspend.h>
>  #include <linux/delay.h>
>  
>  #include "internal.h"
> @@ -940,9 +941,10 @@ static void lpss_iosf_exit_d3_state(void
>  	mutex_unlock(&lpss_iosf_mutex);
>  }
>  
> -static int acpi_lpss_suspend(struct device *dev, bool wakeup)
> +static int acpi_lpss_suspend(struct device *dev, bool runtime)
>  {
>  	struct lpss_private_data *pdata =
> acpi_driver_data(ACPI_COMPANION(dev));
> +	bool wakeup = runtime || device_may_wakeup(dev);
>  	int ret;
>  
>  	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
> @@ -955,13 +957,14 @@ static int acpi_lpss_suspend(struct devi
>  	 * wrong status for devices being about to be powered off.
> See
>  	 * lpss_iosf_enter_d3_state() for further information.
>  	 */
> -	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON &&
> iosf_mbi_available())
> +	if ((runtime || !pm_suspend_via_firmware()) &&
> +	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON &&
> iosf_mbi_available())
>  		lpss_iosf_enter_d3_state();
>  
>  	return ret;
>  }
>  
> -static int acpi_lpss_resume(struct device *dev)
> +static int acpi_lpss_resume(struct device *dev, bool runtime)
>  {
>  	struct lpss_private_data *pdata =
> acpi_driver_data(ACPI_COMPANION(dev));
>  	int ret;
> @@ -970,7 +973,8 @@ static int acpi_lpss_resume(struct devic
>  	 * This call is kept first to be in symmetry with
>  	 * acpi_lpss_runtime_suspend() one.
>  	 */
> -	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON &&
> iosf_mbi_available())
> +	if ((runtime || !pm_resume_via_firmware()) &&
> +	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON &&
> iosf_mbi_available())
>  		lpss_iosf_exit_d3_state();
>  
>  	ret = acpi_dev_resume(dev);
> @@ -994,12 +998,12 @@ static int acpi_lpss_suspend_late(struct
>  		return 0;
>  
>  	ret = pm_generic_suspend_late(dev);
> -	return ret ? ret : acpi_lpss_suspend(dev,
> device_may_wakeup(dev));
> +	return ret ? ret : acpi_lpss_suspend(dev, false);
>  }
>  
>  static int acpi_lpss_resume_early(struct device *dev)
>  {
> -	int ret = acpi_lpss_resume(dev);
> +	int ret = acpi_lpss_resume(dev, false);
>  
>  	return ret ? ret : pm_generic_resume_early(dev);
>  }
> @@ -1014,7 +1018,7 @@ static int acpi_lpss_runtime_suspend(str
>  
>  static int acpi_lpss_runtime_resume(struct device *dev)
>  {
> -	int ret = acpi_lpss_resume(dev);
> +	int ret = acpi_lpss_resume(dev, true);
>  
>  	return ret ? ret : pm_generic_runtime_resume(dev);
>  }
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
