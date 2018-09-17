Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2F5ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FB72088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FB72088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeIQTZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:25:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728591AbeIQTZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:25:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 424C0AC9C;
        Mon, 17 Sep 2018 13:57:59 +0000 (UTC)
Subject: Re: [PATCH 5/5] scsi: libsas: fix a race condition when smp task
 timeout
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, zhaohongjiang@huawei.com,
        dan.j.williams@intel.com, jthumshirn@suse.de, hch@lst.de,
        huangdaode@hisilicon.com, chenxiang66@hisilicon.com,
        miaoxie@huawei.com, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>
References: <20180912082946.34814-1-yanaijie@huawei.com>
 <20180912082946.34814-6-yanaijie@huawei.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <58397edb-e05c-f782-1f2a-c9a1dae4b525@suse.com>
Date:   Mon, 17 Sep 2018 15:57:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912082946.34814-6-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 10:29 AM, Jason Yan wrote:
> When the lldd is processing the complete sas task in interrupt and set
> the task stat as SAS_TASK_STATE_DONE, the smp timeout timer is able to
> be triggered at the same time. And smp_task_timedout() will complete the
> task wheter the SAS_TASK_STATE_DONE is set or not. Then the sas task may
> freed before lldd end the interrupt process. Thus a use-after-free will
> happen.
> 
> Fix this by calling the complete() only when SAS_TASK_STATE_DONE is not
> set. And remove the check of the return value of the del_timer().
> 
> Reported-by: chenxiang <chenxiang66@hisilicon.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> CC: John Garry <john.garry@huawei.com>
> CC: Johannes Thumshirn <jthumshirn@suse.de>
> CC: Ewan Milne <emilne@redhat.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Tomas Henzl <thenzl@redhat.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/libsas/sas_expander.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index 52222940d398..0d1f72752ca2 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -48,17 +48,16 @@ static void smp_task_timedout(struct timer_list *t)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&task->task_state_lock, flags);
> -	if (!(task->task_state_flags & SAS_TASK_STATE_DONE))
> +	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
>  		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
> +		complete(&task->slow_task->completion);
> +	}
>  	spin_unlock_irqrestore(&task->task_state_lock, flags);
> -
> -	complete(&task->slow_task->completion);
>  }
>  
>  static void smp_task_done(struct sas_task *task)
>  {
> -	if (!del_timer(&task->slow_task->timer))
> -		return;
> +	del_timer(&task->slow_task->timer);
>  	complete(&task->slow_task->completion);
>  }
>  
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
