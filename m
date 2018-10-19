Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F9C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692522145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692522145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeJSI5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:57:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39027 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbeJSI5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:57:53 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0793D5AB79F7C;
        Fri, 19 Oct 2018 08:54:10 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Fri, 19 Oct 2018
 08:54:05 +0800
Subject: Re: [PATCH v2] scsi: hisi_sas: Fix NULL pointer dereference
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20181018165939.GA26491@embeddedor.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <8bf37d22-8416-2b0b-1049-9c93b73ffc4d@hisilicon.com>
Date:   Fri, 19 Oct 2018 08:54:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181018165939.GA26491@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018/10/19 0:59, Gustavo A. R. Silva 写道:
> There is a NULL pointer dereference in case *slot* happens to
> be NULL at lines 1053 and 1878:
>
> struct hisi_sas_cq *cq =
> 	&hisi_hba->cq[slot->dlvry_queue];
>
> Notice that *slot* is being NULL checked at lines 1057 and 1881:
> if (slot), which implies it may be NULL.
>
> Fix this by placing the declaration and definition of variable cq,
> which contains the pointer dereference slot->dlvry_queue, after
> slot has been properly NULL checked.
>
> Addresses-Coverity-ID: 1474515 ("Dereference before null check")
> Addresses-Coverity-ID: 1474520 ("Dereference before null check")
> Fixes: 584f53fe5f52 ("scsi: hisi_sas: Fix the race between IO completion and timeout for SMP/internal IO")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
Thanks!

> ---
> Changes in v2:
>   - Fix another instance of the same issue at line 1053.
>   - Update commit log.
>
>   drivers/scsi/hisi_sas/hisi_sas_main.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index 2e5eaf1..b3f01d5 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -1050,11 +1050,11 @@ static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
>   		if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
>   			if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
>   				struct hisi_sas_slot *slot = task->lldd_task;
> -				struct hisi_sas_cq *cq =
> -					&hisi_hba->cq[slot->dlvry_queue];
>   
>   				dev_err(dev, "abort tmf: TMF task timeout and not done\n");
>   				if (slot) {
> +					struct hisi_sas_cq *cq =
> +					       &hisi_hba->cq[slot->dlvry_queue];
>   					/*
>   					 * flush tasklet to avoid free'ing task
>   					 * before using task in IO completion
> @@ -1875,10 +1875,10 @@ hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
>   	if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
>   		if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
>   			struct hisi_sas_slot *slot = task->lldd_task;
> -			struct hisi_sas_cq *cq =
> -				&hisi_hba->cq[slot->dlvry_queue];
>   
>   			if (slot) {
> +				struct hisi_sas_cq *cq =
> +					&hisi_hba->cq[slot->dlvry_queue];
>   				/*
>   				 * flush tasklet to avoid free'ing task
>   				 * before using task in IO completion


