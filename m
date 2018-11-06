Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD32C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002B82081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002B82081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbeKFRf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:35:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:13183 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbeKFRf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:35:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 00:11:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="101887378"
Received: from dgao1-mobl1.ccr.corp.intel.com ([10.255.30.243])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2018 00:11:54 -0800
Message-ID: <1541491911.2124.91.camel@intel.com>
Subject: Re: [PATCH v2 01/17] thermal: add thermal_zone_set_mode() helper
From:   Zhang Rui <rui.zhang@intel.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Amit kucheria <amit.kucheria@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 16:11:51 +0800
In-Reply-To: <1539791563-5959-2-git-send-email-b.zolnierkie@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
         <CGME20181017155320epcas2p439b713149d94aa485b3c2ffba063ea03@epcas2p4.samsung.com>
         <1539791563-5959-2-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 三, 2018-10-17 at 17:52 +0200, Bartlomiej Zolnierkiewicz wrote:
> In order to remove the code duplication and prepare for further
> changes:
> 
> * Add thermal_zone_set_mode() helper. Then update core code and
>   drivers to use it.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/hisi_thermal.c     | 14 ++------------
>  drivers/thermal/of-thermal.c       |  3 ++-
>  drivers/thermal/rockchip_thermal.c | 26 +++++++++-----------------
>  drivers/thermal/thermal_helpers.c  | 14 ++++++++++++++
>  drivers/thermal/thermal_sysfs.c    |  8 +++++---
>  include/linux/thermal.h            |  5 +++++
>  6 files changed, 37 insertions(+), 33 deletions(-)
> 
> 
>  
> diff --git a/drivers/thermal/thermal_helpers.c
> b/drivers/thermal/thermal_helpers.c
> index 2ba756a..b18cee2 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -224,3 +224,17 @@ int thermal_zone_get_offset(struct
> thermal_zone_device *tz)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
> +
> +/**
> + * thermal_zone_set_mode() - sets mode of thermal zone device
> + * @tz: a valid pointer to a struct thermal_zone_device
> + * @mode: mode to be set
> + *
> + * Return: On success returns 0, an error code otherwise.
> + */
> +int thermal_zone_set_mode(struct thermal_zone_device *tz,
> +			  enum thermal_device_mode mode)
> +{
> +	return tz->ops->set_mode(tz, mode);

better to check tz->ops->set_mode first.

thanks,
rui
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_set_mode);
> diff --git a/drivers/thermal/thermal_sysfs.c
> b/drivers/thermal/thermal_sysfs.c
> index 2241cea..2e9e762 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -69,17 +69,19 @@
>  {
>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
>  	int result;
> +	enum thermal_device_mode mode;
>  
>  	if (!tz->ops->set_mode)
>  		return -EPERM;
>  
>  	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
> -		result = tz->ops->set_mode(tz,
> THERMAL_DEVICE_ENABLED);
> +		mode = THERMAL_DEVICE_ENABLED;
>  	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
> -		result = tz->ops->set_mode(tz,
> THERMAL_DEVICE_DISABLED);
> +		mode = THERMAL_DEVICE_DISABLED;
>  	else
> -		result = -EINVAL;
> +		return -EINVAL;
>  
> +	result = thermal_zone_set_mode(tz, mode);
>  	if (result)
>  		return result;
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5f4705f..9d21fd1 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -452,6 +452,8 @@ struct thermal_cooling_device *
>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int
> *temp);
>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
> +int thermal_zone_set_mode(struct thermal_zone_device *tz,
> +			  enum thermal_device_mode mode);
>  
>  int get_tz_trend(struct thermal_zone_device *, int);
>  struct thermal_instance *get_thermal_instance(struct
> thermal_zone_device *,
> @@ -518,6 +520,9 @@ static inline int thermal_zone_get_slope(
>  static inline int thermal_zone_get_offset(
>  		struct thermal_zone_device *tz)
>  { return -ENODEV; }
> +static inline int thermal_zone_set_mode(
> +		struct thermal_zone_device *tz, enum
> thermal_device_mode mode)
> +{ return -ENODEV; }
>  static inline int get_tz_trend(struct thermal_zone_device *tz, int
> trip)
>  { return -ENODEV; }
>  static inline struct thermal_instance *
