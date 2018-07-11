Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451AAC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C56208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C56208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbeGKKvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:51:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:18717 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbeGKKvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:51:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 03:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="215118191"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2018 03:47:46 -0700
Subject: Re: [PATCH v1 3/9] scsi: ufs: Override auto suspend tunables for ufs
To:     Asutosh Das <asutoshd@codeaurora.org>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     Sujit Reddy Thumma <sthumma@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Gilad Broner <gbroner@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1530880006.git.asutoshd@codeaurora.org>
 <6981189193244970a912c8b3f390a00bc37ed14a.1530880006.git.asutoshd@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c68abdb3-a32c-6309-8992-66267b6e392f@intel.com>
Date:   Wed, 11 Jul 2018 13:46:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <6981189193244970a912c8b3f390a00bc37ed14a.1530880006.git.asutoshd@codeaurora.org>
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
> Override auto suspend tunables for UFS device LUNs during
> initialization so as to efficiently manage background operations
> and the power consumption.
> 
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Gilad Broner <gbroner@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/scsi/ufs/ufshcd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 77e2b3e..b03f3ea 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -89,6 +89,9 @@
>  /* Interrupt aggregation default timeout, unit: 40us */
>  #define INT_AGGR_DEF_TO	0x02
>  
> +/* default value of auto suspend is 3 seconds */
> +#define UFSHCD_AUTO_SUSPEND_DELAY_MS 3000 /* millisecs */
> +
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
>  	({                                                              \
>  		int _ret;                                               \
> @@ -4528,6 +4531,9 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
>  	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
>  	blk_queue_max_segment_size(q, PRDT_DATA_BYTE_COUNT_MAX);
>  
> +	sdev->autosuspend_delay = UFSHCD_AUTO_SUSPEND_DELAY_MS;
> +	sdev->use_rpm_auto = 1;
> +
>  	return 0;
>  }
>  
> 

