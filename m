Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA81DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81259208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81259208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbeGKKus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:50:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:51998 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbeGKKur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:50:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 03:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="215117973"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2018 03:46:56 -0700
Subject: Re: [PATCH v1 2/9] scsi: Allow auto suspend override by low-level
 driver
To:     Asutosh Das <asutoshd@codeaurora.org>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     Sujit Reddy Thumma <sthumma@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1530880006.git.asutoshd@codeaurora.org>
 <8135b00502f7e089478c9b988806ed40b7d5d40b.1530880006.git.asutoshd@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3890d040-b282-70b5-9e1b-fa7fcd84b716@intel.com>
Date:   Wed, 11 Jul 2018 13:45:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <8135b00502f7e089478c9b988806ed40b7d5d40b.1530880006.git.asutoshd@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/18 15:30, Asutosh Das wrote:
> From: Sujit Reddy Thumma <sthumma@codeaurora.org>
> 
> Until now the scsi mid-layer forbids runtime suspend till userspace
> enables it. This is mainly to quarantine some disks with broken
> runtime power management or have high latencies executing suspend
> resume callbacks. If the userspace doesn't enable the runtime suspend
> the underlying hardware will be always on even when it is not doing
> any useful work and thus wasting power.
> 
> Some low-level drivers for the controllers can efficiently use runtime
> power management to reduce power consumption and improve battery life.
> Allow runtime suspend parameters override within the LLD itself
> instead of waiting for userspace to control the power management.
> 
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>

Notwithstanding one minor comment below:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/scsi/scsi_scan.c   | 4 ++++
>  drivers/scsi/scsi_sysfs.c  | 3 ++-
>  drivers/scsi/sd.c          | 2 ++
>  include/scsi/scsi_device.h | 3 +++
>  4 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 0880d97..5b7232a 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -969,6 +969,10 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
>  
>  	transport_configure_device(&sdev->sdev_gendev);
>  
> +	/* The LLD can override auto suspend tunables in ->slave_configure() */
> +	sdev->use_rpm_auto = 0;
> +	sdev->autosuspend_delay = SCSI_DEFAULT_AUTOSUSPEND_DELAY;
> +
>  	if (sdev->host->hostt->slave_configure) {
>  		ret = sdev->host->hostt->slave_configure(sdev);
>  		if (ret) {
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 7943b76..706e778 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -1266,7 +1266,8 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
>  	device_enable_async_suspend(&sdev->sdev_gendev);
>  	scsi_autopm_get_target(starget);
>  	pm_runtime_set_active(&sdev->sdev_gendev);
> -	pm_runtime_forbid(&sdev->sdev_gendev);
> +	if (!sdev->use_rpm_auto)
> +		pm_runtime_forbid(&sdev->sdev_gendev);
>  	pm_runtime_enable(&sdev->sdev_gendev);
>  	scsi_autopm_put_target(starget);
>  
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a6201e6..205624f 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3269,6 +3269,8 @@ static void sd_probe_async(void *data, async_cookie_t cookie)
>  	}
>  
>  	blk_pm_runtime_init(sdp->request_queue, dev);
> +	if (sdp->autosuspend_delay >= 0)
> +		pm_runtime_set_autosuspend_delay(dev, sdp->autosuspend_delay);

Wouldn't it be nicer to pass the autosuspend_delay into blk_pm_runtime_init()?

>  	device_add_disk(dev, gd);
>  	if (sdkp->capacity)
>  		sd_dif_config_host(sdkp);
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index 4c36af6..1d5ae90 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -197,7 +197,10 @@ struct scsi_device {
>  	unsigned broken_fua:1;		/* Don't set FUA bit */
>  	unsigned lun_in_cdb:1;		/* Store LUN bits in CDB[1] */
>  	unsigned unmap_limit_for_ws:1;	/* Use the UNMAP limit for WRITE SAME */
> +	unsigned use_rpm_auto:1; /* Enable runtime PM auto suspend */
>  
> +#define SCSI_DEFAULT_AUTOSUSPEND_DELAY  -1
> +	int autosuspend_delay;
>  	atomic_t disk_events_disable_depth; /* disable depth for disk events */
>  
>  	DECLARE_BITMAP(supported_events, SDEV_EVT_MAXBITS); /* supported events */
> 

