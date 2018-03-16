Return-Path: <adrian.hunter@intel.com>
X-Google-Smtp-Source: AG47ELuQMfvBVLL/+Z23z7TotuwxrpDFzc8jN237L8jfNfNDRRjJAo5AoKaZ4WiKmwteVmOfikQN
ARC-Seal: i=1; a=rsa-sha256; t=1521210000; cv=none;
        d=google.com; s=arc-20160816;
        b=c0WZDj05c3z+CkTueM6yPZ3h+XjCtgUr6zePqI6FQJ5Ft+5bbCEocH+JdrNA8KY3oK
         ntC20C9aVHXryXEQfzQMASDfYjQ58WiYoj4Da8Aqd5SD1Nd4S6FVisB6xvW1kcicmpgx
         ZzL+88x37ChX5wki2yWxrjHTocem7GKApBqdWXLEyJsBcQ5ySRaLCRlqPtQvAYd9Xmdr
         Knp4Zc1iWBa56evqBfi5pYhMQhbthgOKC8w7YhvTlWnrrN2oioTYX2Ec/HMXh+mQDYVS
         MMg0U3WSv22wAFCL9mCLbfB42dgzn7q86m4+WEt/7lLljJqm2pS60X6pQAd5Ogbv1gGX
         6G/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=p5GsyNIs1ghs0QcX5trl5as51/OcktlNMfrI3CVGjHE=;
        b=RuAI/VqzOoRirW35589N1yN9VOM5SXX1gexrDtas1TK1TslttKKKMvCsOch5KUmQIs
         z/+lAhW68jFmzbRQ+Zgif5Xb2KdYJUBwHUOyjA6PsJK02cVSG1ll4VPUHPGtwBP1MCVZ
         g/VOqeWUyxkw5+kfkVkfNut+mgJWgp620wug7OZNo1GLrLsJOZUVtloLuSqqGe/1mRhR
         fEbmPg495N+VgMUyG7g5SrfbhVWGJo/3WgvmKU69b+gj70PkP9fs8/3+ZL5CyF0FhGu+
         z4T1h5zweuC4GR/kYpBlZbd/n9N8IRHtj2G2GUISVHwFyJRV7ZqNsP0MY82swPDP9ZKj
         wxBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adrian.hunter@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=adrian.hunter@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adrian.hunter@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=adrian.hunter@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,316,1517904000";
   d="scan'208";a="28539402"
Subject: Re: [PATCH] scsi: ufs: sysfs: reworking of the rpm_lvl and spm_lvl
 entries
To: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, subhashj@codeaurora.org
Cc: alex.lemberg@wdc.com
References: <1519901286-17496-1-git-send-email-stanislav.nijnikov@wdc.com>
 <1519901286-17496-2-git-send-email-stanislav.nijnikov@wdc.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fbea3b00-7497-cb3f-746f-65f793677568@intel.com>
Date: Fri, 16 Mar 2018 16:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519901286-17496-2-git-send-email-stanislav.nijnikov@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593732016815637504?=
X-GMAIL-MSGID: =?utf-8?q?1595104297700541742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/03/18 12:48, Stanislav Nijnikov wrote:
> Read from these files will return the integed value of the chosen power
> management level now. Separate entries were added to show the target
> UFS device and UIC link states. The description of the possible power
> managements levels was added to the ABI file. The on-write behaviour of
> these entries wasn't changed.
> 
> Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  Documentation/ABI/testing/sysfs-driver-ufs | 67 ++++++++++++++++++++++
>  drivers/scsi/ufs/ufs-sysfs.c               | 92 +++++++++++++++---------------
>  2 files changed, 114 insertions(+), 45 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index 07f1c2f..83735f7 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -802,3 +802,70 @@ Description:	This file shows the The amount of physical memory needed
>  		the particular logical unit. The full information about
>  		the attribute could be found at UFS specifications 2.1.
>  		The file is read only.
> +
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/rpm_lvl
> +Date:		September 2014
> +Contact:	Subhash Jadavani <subhashj@codeaurora.org>
> +Description:	This entry could be used to set or show the UFS device
> +		runtime power management level. The current driver
> +		implementation supports 6 levels with next target states:
> +		0 - an UFS device will stay active, an UIC link will
> +		stay active
> +		1 - an UFS device will stay active, an UIC link will
> +		hibernate
> +		2 - an UFS device will moved to sleep, an UIC link will
> +		stay active
> +		3 - an UFS device will moved to sleep, an UIC link will
> +		hibernate
> +		4 - an UFS device will be powered off, an UIC link will
> +		hibernate
> +		5 - an UFS device will be powered off, an UIC link will
> +		be powered off
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/rpm_target_dev_state
> +Date:		February 2018
> +Contact:	Subhash Jadavani <subhashj@codeaurora.org>
> +Description:	This entry shows the target power mode of an UFS device
> +		for the chosen runtime power management level.
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/rpm_target_link_state
> +Date:		February 2018
> +Contact:	Subhash Jadavani <subhashj@codeaurora.org>
> +Description:	This entry shows the target state of an UFS UIC link
> +		for the chosen runtime power management level.
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/spm_lvl
> +Date:		September 2014
> +Contact:	Subhash Jadavani <subhashj@codeaurora.org>
> +Description:	This entry could be used to set or show the UFS device
> +		system power management level. The current driver
> +		implementation supports 6 levels with next target states:
> +		0 - an UFS device will stay active, an UIC link will
> +		stay active
> +		1 - an UFS device will stay active, an UIC link will
> +		hibernate
> +		2 - an UFS device will moved to sleep, an UIC link will
> +		stay active
> +		3 - an UFS device will moved to sleep, an UIC link will
> +		hibernate
> +		4 - an UFS device will be powered off, an UIC link will
> +		hibernate
> +		5 - an UFS device will be powered off, an UIC link will
> +		be powered off
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/spm_target_dev_state
> +Date:		February 2018
> +Contact:	Subhash Jadavani <subhashj@codeaurora.org>
> +Description:	This entry shows the target power mode of an UFS device
> +		for the chosen system power management level.
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/spm_target_link_state
> +Date:		February 2018
> +Contact:	Subhash Jadavani <subhashj@codeaurora.org>
> +Description:	This entry shows the target state of an UFS UIC link
> +		for the chosen system power management level.
> +		The file is read only.
> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> index cd7174d..4ff9e0b 100644
> --- a/drivers/scsi/ufs/ufs-sysfs.c
> +++ b/drivers/scsi/ufs/ufs-sysfs.c
> @@ -57,29 +57,8 @@ static ssize_t rpm_lvl_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct ufs_hba *hba = dev_get_drvdata(dev);
> -	int curr_len;
> -	u8 lvl;
> -
> -	curr_len = snprintf(buf, PAGE_SIZE,
> -			    "\nCurrent Runtime PM level [%d] => dev_state [%s] link_state [%s]\n",
> -			    hba->rpm_lvl,
> -			    ufschd_ufs_dev_pwr_mode_to_string(
> -				ufs_pm_lvl_states[hba->rpm_lvl].dev_state),
> -			    ufschd_uic_link_state_to_string(
> -				ufs_pm_lvl_states[hba->rpm_lvl].link_state));
> -
> -	curr_len += snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> -			     "\nAll available Runtime PM levels info:\n");
> -	for (lvl = UFS_PM_LVL_0; lvl < UFS_PM_LVL_MAX; lvl++)
> -		curr_len += snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> -				     "\tRuntime PM level [%d] => dev_state [%s] link_state [%s]\n",
> -				    lvl,
> -				    ufschd_ufs_dev_pwr_mode_to_string(
> -					ufs_pm_lvl_states[lvl].dev_state),
> -				    ufschd_uic_link_state_to_string(
> -					ufs_pm_lvl_states[lvl].link_state));
> -
> -	return curr_len;
> +
> +	return sprintf(buf, "%d\n", hba->rpm_lvl);
>  }
>  
>  static ssize_t rpm_lvl_store(struct device *dev,
> @@ -88,33 +67,30 @@ static ssize_t rpm_lvl_store(struct device *dev,
>  	return ufs_sysfs_pm_lvl_store(dev, attr, buf, count, true);
>  }
>  
> +static ssize_t rpm_target_dev_state_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", ufschd_ufs_dev_pwr_mode_to_string(
> +			ufs_pm_lvl_states[hba->rpm_lvl].dev_state));
> +}
> +
> +static ssize_t rpm_target_link_state_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", ufschd_uic_link_state_to_string(
> +			ufs_pm_lvl_states[hba->rpm_lvl].link_state));
> +}
> +
>  static ssize_t spm_lvl_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct ufs_hba *hba = dev_get_drvdata(dev);
> -	int curr_len;
> -	u8 lvl;
> -
> -	curr_len = snprintf(buf, PAGE_SIZE,
> -			    "\nCurrent System PM level [%d] => dev_state [%s] link_state [%s]\n",
> -			    hba->spm_lvl,
> -			    ufschd_ufs_dev_pwr_mode_to_string(
> -				ufs_pm_lvl_states[hba->spm_lvl].dev_state),
> -			    ufschd_uic_link_state_to_string(
> -				ufs_pm_lvl_states[hba->spm_lvl].link_state));
>  
> -	curr_len += snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> -			     "\nAll available System PM levels info:\n");
> -	for (lvl = UFS_PM_LVL_0; lvl < UFS_PM_LVL_MAX; lvl++)
> -		curr_len += snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> -				     "\tSystem PM level [%d] => dev_state [%s] link_state [%s]\n",
> -				    lvl,
> -				    ufschd_ufs_dev_pwr_mode_to_string(
> -					ufs_pm_lvl_states[lvl].dev_state),
> -				    ufschd_uic_link_state_to_string(
> -					ufs_pm_lvl_states[lvl].link_state));
> -
> -	return curr_len;
> +	return sprintf(buf, "%d\n", hba->spm_lvl);
>  }
>  
>  static ssize_t spm_lvl_store(struct device *dev,
> @@ -123,12 +99,38 @@ static ssize_t spm_lvl_store(struct device *dev,
>  	return ufs_sysfs_pm_lvl_store(dev, attr, buf, count, false);
>  }
>  
> +static ssize_t spm_target_dev_state_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", ufschd_ufs_dev_pwr_mode_to_string(
> +				ufs_pm_lvl_states[hba->spm_lvl].dev_state));
> +}
> +
> +static ssize_t spm_target_link_state_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", ufschd_uic_link_state_to_string(
> +				ufs_pm_lvl_states[hba->spm_lvl].link_state));
> +}
> +
>  static DEVICE_ATTR_RW(rpm_lvl);
> +static DEVICE_ATTR_RO(rpm_target_dev_state);
> +static DEVICE_ATTR_RO(rpm_target_link_state);
>  static DEVICE_ATTR_RW(spm_lvl);
> +static DEVICE_ATTR_RO(spm_target_dev_state);
> +static DEVICE_ATTR_RO(spm_target_link_state);
>  
>  static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
>  	&dev_attr_rpm_lvl.attr,
> +	&dev_attr_rpm_target_dev_state.attr,
> +	&dev_attr_rpm_target_link_state.attr,
>  	&dev_attr_spm_lvl.attr,
> +	&dev_attr_spm_target_dev_state.attr,
> +	&dev_attr_spm_target_link_state.attr,
>  	NULL
>  };
>  
> 
