Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A30EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF47F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF47F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbeGQNkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:40:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:10120 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbeGQNkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:40:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 06:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="57156688"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2018 06:07:43 -0700
Subject: Re: [PATCH V6] scsi: ufs: Add configfs support for UFS provisioning
To:     Sayali Lokhande <sayalil@codeaurora.org>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, evgreen@chromium.org,
        riteshh@codeaurora.org
Cc:     linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <1531734237-27421-1-git-send-email-sayalil@codeaurora.org>
 <1531734237-27421-2-git-send-email-sayalil@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fc305cad-a0db-9c4b-9d5f-14e8e48a23b3@intel.com>
Date:   Tue, 17 Jul 2018 16:06:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1531734237-27421-2-git-send-email-sayalil@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/18 12:43, Sayali Lokhande wrote:
> This patch adds configfs support to provision UFS device at
> runtime. This feature can be primarily useful in factory or
> assembly line as some devices may be required to be configured
> multiple times during initial system development phase.
> Configuration Descriptors can be written multiple times until
> bConfigDescrLock attribute is zero.
> 
> Configuration descriptor buffer consists of Device and Unit
> descriptor configurable parameters which are parsed from vendor
> specific provisioning file and then passed via configfs node at
> runtime to provision ufs device.
> CONFIG_CONFIGFS_FS needs to be enabled for using this feature.
> 
> Usage:
> 1) To read current configuration descriptor :
>    cat /config/XXXX.ufshc/ufs_provision
> 2) To provision ufs device:
>    echo <config_desc_buf> > /config/XXXX.ufshc/ufs_provision
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  Documentation/ABI/testing/configfs-driver-ufs |  18 +++
>  drivers/scsi/ufs/Kconfig                      |  10 ++
>  drivers/scsi/ufs/Makefile                     |   1 +
>  drivers/scsi/ufs/ufs-configfs.c               | 162 ++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.c                     |   2 +
>  drivers/scsi/ufs/ufshcd.h                     |  19 +++
>  6 files changed, 212 insertions(+)
>  create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
>  create mode 100644 drivers/scsi/ufs/ufs-configfs.c
> 
> diff --git a/Documentation/ABI/testing/configfs-driver-ufs b/Documentation/ABI/testing/configfs-driver-ufs
> new file mode 100644
> index 0000000..eeee499c
> --- /dev/null
> +++ b/Documentation/ABI/testing/configfs-driver-ufs
> @@ -0,0 +1,18 @@
> +What:		/config/ufshcd/ufs_provision
> +Date:		Jun 2018
> +KernelVersion:	4.14
> +Description:
> +		This file shows the current ufs configuration descriptor set in device.
> +		This can be used to provision ufs device if bConfigDescrLock is 0.
> +		For more details, refer 14.1.6.3 Configuration Descriptor and
> +		Table 14-12 - Unit Descriptor configurable parameters from specs for
> +		description of each configuration descriptor parameter.
> +		Configuration descriptor buffer needs to be passed in space separated
> +		format specificied as below:
> +		echo <bLength> <bDescriptorIDN> <bConfDescContinue> <bBootEnable>
> +		<bDescrAccessEn> <bInitPowerMode> <bHighPriorityLUN>
> +		<bSecureRemovalType> <bInitActiveICCLevel> <wPeriodicRTCUpdate>
> +		<0Bh:0Fh_ReservedAs_0> <bLUEnable> <bBootLunID> <bLUWriteProtect>
> +		<bMemoryType> <dNumAllocUnits> <bDataReliability> <bLogicalBlockSize>
> +		<bProvisioningType> <wContextCapabilities> <0Dh:0Fh_ReservedAs_0>
> +		> /config/XXXX.ufshc/ufs_provision
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index e27b4d4..34d89c2 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -100,3 +100,13 @@ config SCSI_UFS_QCOM
>  
>  	  Select this if you have UFS controller on QCOM chipset.
>  	  If unsure, say N.
> +
> +config UFS_PROVISION
> +	tristate "Runtime UFS Provisioning support"
> +	depends on SCSI_UFSHCD_PLATFORM && CONFIGFS_FS

Why SCSI_UFSHCD_PLATFORM instead of SCSI_UFSHCD?

Also please cc me in future revisions.
