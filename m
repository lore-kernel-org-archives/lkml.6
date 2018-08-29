Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598C8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F3B20862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F3B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeH2PsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:48:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:21579 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeH2PsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:48:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 04:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="258170299"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2018 04:51:42 -0700
Subject: Re: [PATCH] scsi: ufs: Make sysfs flags writable
To:     Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180820213455.15092-1-evgreen@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3f262cb6-104a-f9be-3ec0-33ec7ec63455@intel.com>
Date:   Wed, 29 Aug 2018 14:50:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820213455.15092-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/18 00:34, Evan Green wrote:
> This change makes the UFS controller's sysfs flags writable. This
> will enable users to provision unprovisioned devices, and experiment
> with device features.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

Seems like a good idea:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> This is a follow-on patch to another patch [1] that makes the UFS attributes
> writable.
> 
> [1] https://lore.kernel.org/patchwork/patch/972959/
> 
>  Documentation/ABI/testing/sysfs-driver-ufs | 18 +++++++---
>  drivers/scsi/ufs/ufs-sysfs.c               | 54 +++++++++++++++++++++++++-----
>  2 files changed, 58 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index 016724ec26d5..6df8ccbc94f3 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -619,7 +619,6 @@ Date:		February 2018
>  Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
>  Description:	This file shows the device init status. The full information
>  		about the flag could be found at UFS specifications 2.1.
> -		The file is read only.
>  
>  What:		/sys/bus/platform/drivers/ufshcd/*/flags/permanent_wpe
>  Date:		February 2018
> @@ -627,7 +626,8 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
>  Description:	This file shows whether permanent write protection is enabled.
>  		The full information about the flag could be found at
>  		UFS specifications 2.1.
> -		The file is read only.
> +		Warning: This flag can only be written one time within the
> +		lifetime of the device. Once set, it cannot be unset.
>  
>  What:		/sys/bus/platform/drivers/ufshcd/*/flags/power_on_wpe
>  Date:		February 2018
> @@ -636,7 +636,7 @@ Description:	This file shows whether write protection is enabled on all
>  		logical units configured as power on write protected. The
>  		full information about the flag could be found at
>  		UFS specifications 2.1.
> -		The file is read only.
> +		Once set, this flag cannot be cleared without a device reset.
>  
>  What:		/sys/bus/platform/drivers/ufshcd/*/flags/bkops_enable
>  Date:		February 2018
> @@ -644,7 +644,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
>  Description:	This file shows whether the device background operations are
>  		enabled. The full information about the flag could be
>  		found at UFS specifications 2.1.
> -		The file is read only.
>  
>  What:		/sys/bus/platform/drivers/ufshcd/*/flags/life_span_mode_enable
>  Date:		February 2018
> @@ -654,13 +653,22 @@ Description:	This file shows whether the device life span mode is enabled.
>  		UFS specifications 2.1.
>  		The file is read only.
>  
> +What:		/sys/bus/platform/drivers/ufshcd/*/flags/purge_enable
> +Date:		August 2018
> +Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> +Description:	This file shall only be set when the command queue of all
> +		logical units are empty and purge status is idle. This flag is
> +		automatically cleared by the UFS device when the operation
> +		completes or an error occurs. This flag is write-only, it
> +		cannot be read. Complete information about the flag can be
> +		found in the UFS specification 2.20A.
> +
>  What:		/sys/bus/platform/drivers/ufshcd/*/flags/phy_resource_removal
>  Date:		February 2018
>  Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
>  Description:	This file shows whether physical resource removal is enable.
>  		The full information about the flag could be found at
>  		UFS specifications 2.1.
> -		The file is read only.
>  
>  What:		/sys/bus/platform/drivers/ufshcd/*/flags/busy_rtc
>  Date:		February 2018
> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> index 8d9332bb7d0c..2da927f4b7ff 100644
> --- a/drivers/scsi/ufs/ufs-sysfs.c
> +++ b/drivers/scsi/ufs/ufs-sysfs.c
> @@ -616,7 +616,7 @@ static const struct attribute_group ufs_sysfs_string_descriptors_group = {
>  	.attrs = ufs_sysfs_string_descriptors,
>  };
>  
> -#define UFS_FLAG(_name, _uname)						\
> +#define UFS_FLAG_SHOW(_name, _uname)					\
>  static ssize_t _name##_show(struct device *dev,				\
>  	struct device_attribute *attr, char *buf)			\
>  {									\
> @@ -626,17 +626,52 @@ static ssize_t _name##_show(struct device *dev,				\
>  		QUERY_FLAG_IDN##_uname, &flag))				\
>  		return -EINVAL;						\
>  	return sprintf(buf, "%s\n", flag ? "true" : "false");		\
> +}
> +
> +#define UFS_FLAG_STORE(_name, _uname)					\
> +static ssize_t _name##_store(struct device *dev,			\
> +	struct device_attribute *attr, const char *buf,			\
> +	size_t count)							\
> +{									\
> +	bool flag;							\
> +	struct ufs_hba *hba = dev_get_drvdata(dev);			\
> +	enum query_opcode op;						\
> +	if (kstrtobool(buf, &flag))					\
> +		return -EINVAL;						\
> +	op = flag ? UPIU_QUERY_OPCODE_SET_FLAG :			\
> +		UPIU_QUERY_OPCODE_CLEAR_FLAG;				\
> +	if (ufshcd_query_flag(hba, op, QUERY_FLAG_IDN##_uname, NULL))	\
> +		return -EINVAL;						\
> +	return count;							\
>  }									\
> +
> +#define UFS_FLAG_RO(_name, _uname)	\
> +UFS_FLAG_SHOW(_name, _uname)		\
>  static DEVICE_ATTR_RO(_name)
>  
> -UFS_FLAG(device_init, _FDEVICEINIT);
> -UFS_FLAG(permanent_wpe, _PERMANENT_WPE);
> -UFS_FLAG(power_on_wpe, _PWR_ON_WPE);
> -UFS_FLAG(bkops_enable, _BKOPS_EN);
> -UFS_FLAG(life_span_mode_enable, _LIFE_SPAN_MODE_ENABLE);
> -UFS_FLAG(phy_resource_removal, _FPHYRESOURCEREMOVAL);
> -UFS_FLAG(busy_rtc, _BUSY_RTC);
> -UFS_FLAG(disable_fw_update, _PERMANENTLY_DISABLE_FW_UPDATE);
> +#define UFS_FLAG_WO(_name, _uname)					\
> +UFS_FLAG_STORE(_name, _uname)						\
> +static ssize_t _name##_show(struct device *dev,				\
> +	struct device_attribute *attr, char *buf)			\
> +{									\
> +	return -EOPNOTSUPP;						\
> +}									\
> +static DEVICE_ATTR_RW(_name)
> +
> +#define UFS_FLAG_RW(_name, _uname)					\
> +UFS_FLAG_SHOW(_name, _uname)						\
> +UFS_FLAG_STORE(_name, _uname)						\
> +static DEVICE_ATTR_RW(_name)
> +
> +UFS_FLAG_RW(device_init, _FDEVICEINIT);
> +UFS_FLAG_RW(permanent_wpe, _PERMANENT_WPE);
> +UFS_FLAG_RW(power_on_wpe, _PWR_ON_WPE);
> +UFS_FLAG_RW(bkops_enable, _BKOPS_EN);
> +UFS_FLAG_RO(life_span_mode_enable, _LIFE_SPAN_MODE_ENABLE);
> +UFS_FLAG_WO(purge_enable, _PURGE_ENABLE);
> +UFS_FLAG_RW(phy_resource_removal, _FPHYRESOURCEREMOVAL);
> +UFS_FLAG_RO(busy_rtc, _BUSY_RTC);
> +UFS_FLAG_RO(disable_fw_update, _PERMANENTLY_DISABLE_FW_UPDATE);
>  
>  static struct attribute *ufs_sysfs_device_flags[] = {
>  	&dev_attr_device_init.attr,
> @@ -644,6 +679,7 @@ static struct attribute *ufs_sysfs_device_flags[] = {
>  	&dev_attr_power_on_wpe.attr,
>  	&dev_attr_bkops_enable.attr,
>  	&dev_attr_life_span_mode_enable.attr,
> +	&dev_attr_purge_enable.attr,
>  	&dev_attr_phy_resource_removal.attr,
>  	&dev_attr_busy_rtc.attr,
>  	&dev_attr_disable_fw_update.attr,
> 

