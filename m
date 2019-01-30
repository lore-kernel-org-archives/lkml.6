Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C12C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7EC2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfA3Q0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:26:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40542 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727371AbfA3Q0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:26:50 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B393965C72E10CEA2CC0;
        Thu, 31 Jan 2019 00:26:43 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 00:26:37 +0800
Subject: Re: [PATCH v2 2/7] scsi: libsas: only clear phy->in_shutdown after
 shutdown event done
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20190130082412.9357-1-yanaijie@huawei.com>
 <20190130082412.9357-3-yanaijie@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>, <tj@kernel.org>, <miaoxie@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5643a038-a62f-e19c-1073-d845a8344b9f@huawei.com>
Date:   Wed, 30 Jan 2019 16:26:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190130082412.9357-3-yanaijie@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2019 08:24, Jason Yan wrote:
> When the event queue is full of phy up and down events and reached the
> threshold, we will queue a shutdown-event, and set phy->in_shutdown so
> that we will not queue a shutdown-event again. But before the
> shutdown-event can be executed, every phy-down event will clear
> phy->in_shutdown and a new shutdown-event will be queued. The queue will
> be full of these shutdown-events.
>
> Fix this by only clear phy->in_shutdown in sas_phye_shutdown(), that is
> after the first shutdown-event has been executed.
>

Seems ok as a fix:
Reviewed-by: John Garry <john.garry@huawei.com>

After this fix, could we change to use a static per-PHY shutdown event 
so that we cannot re-queue it? I know that this is going against idea of 
dynamic events, but it's easier than messing with flags like this.

> Fixes: f12486e06ae8 ("scsi: libsas: shut down the PHY if events reached the threshold")
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> CC: John Garry <john.garry@huawei.com>
> CC: Johannes Thumshirn <jthumshirn@suse.de>
> CC: Ewan Milne <emilne@redhat.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Tomas Henzl <thenzl@redhat.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/libsas/sas_phy.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/libsas/sas_phy.c b/drivers/scsi/libsas/sas_phy.c
> index 0374243c85d0..762bb13cca74 100644
> --- a/drivers/scsi/libsas/sas_phy.c
> +++ b/drivers/scsi/libsas/sas_phy.c
> @@ -35,7 +35,6 @@ static void sas_phye_loss_of_signal(struct work_struct *work)
>  	struct asd_sas_event *ev = to_asd_sas_event(work);
>  	struct asd_sas_phy *phy = ev->phy;
>
> -	phy->in_shutdown = 0;
>  	phy->error = 0;
>  	sas_deform_port(phy, 1);
>  }
> @@ -45,7 +44,6 @@ static void sas_phye_oob_done(struct work_struct *work)
>  	struct asd_sas_event *ev = to_asd_sas_event(work);
>  	struct asd_sas_phy *phy = ev->phy;
>
> -	phy->in_shutdown = 0;
>  	phy->error = 0;
>  }
>
> @@ -127,6 +125,7 @@ static void sas_phye_shutdown(struct work_struct *work)
>  	} else
>  		pr_notice("phy%02d is not enabled, cannot shutdown\n",
>  			  phy->id);
> +	phy->in_shutdown = 0;
>  }
>
>  /* ---------- Phy class registration ---------- */
>


