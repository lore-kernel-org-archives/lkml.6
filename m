Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9348BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5864321A6D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5864321A6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbeHIMdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:33:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:4575 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeHIMdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:33:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 03:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,214,1531810800"; 
   d="scan'208";a="78851853"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 09 Aug 2018 03:08:48 -0700
Message-ID: <cddf24980ccbb312f1e02eed632038fc0aa8b6fe.camel@linux.intel.com>
Subject: Re: [PATCH v5 3/4] ACPI / x86-utils: Remove status workaround from
 acpi_device_always_present()
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
        linux-i2c@vger.kernel.org
Date:   Thu, 09 Aug 2018 13:08:47 +0300
In-Reply-To: <20180809091558.4317-4-hdegoede@redhat.com>
References: <20180809091558.4317-1-hdegoede@redhat.com>
         <20180809091558.4317-4-hdegoede@redhat.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 11:15 +0200, Hans de Goede wrote:
> Now that we init the status field to ACPI_STA_DEFAULT rather then to
> 0,
> the workaround for acpi_match_device_ids() always returning -ENOENT
> when
> status is 0 is no longer needed.
> 

Always good to have only "minus" statistics

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> -New patch in v3 of this patch-set
> ---
>  drivers/acpi/x86/utils.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index ec5b0f190231..a4fb97d64b3b 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -103,13 +103,9 @@ static const struct always_present_id
> always_present_ids[] = {
>  
>  bool acpi_device_always_present(struct acpi_device *adev)
>  {
> -	u32 *status = (u32 *)&adev->status;
> -	u32 old_status = *status;
>  	bool ret = false;
>  	unsigned int i;
>  
> -	/* acpi_match_device_ids checks status, so set it to default */
> -	*status = ACPI_STA_DEFAULT;
>  	for (i = 0; i < ARRAY_SIZE(always_present_ids); i++) {
>  		if (acpi_match_device_ids(adev,
> always_present_ids[i].hid))
>  			continue;
> @@ -125,15 +121,9 @@ bool acpi_device_always_present(struct
> acpi_device *adev)
>  		    !dmi_check_system(always_present_ids[i].dmi_ids))
>  			continue;
>  
> -		if (old_status != ACPI_STA_DEFAULT) /* Log only once */
> -			dev_info(&adev->dev,
> -				 "Device [%s] is in always present
> list\n",
> -				 adev->pnp.bus_id);
> -
>  		ret = true;
>  		break;
>  	}
> -	*status = old_status;
>  
>  	return ret;
>  }

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

