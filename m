Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B9EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76615214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76615214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLFPiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:38:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbeLFPiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:38:00 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C8088F0F1662A;
        Thu,  6 Dec 2018 23:37:56 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 6 Dec 2018
 23:37:51 +0800
Subject: Re: [PATCH v4 2/5] scsi: hisi_sas: Relocate some code to reduce
 complexity
To:     Johannes Thumshirn <jthumshirn@suse.de>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <1544103284-100497-1-git-send-email-john.garry@huawei.com>
 <1544103284-100497-3-git-send-email-john.garry@huawei.com>
 <c7ec9e23-6da8-35e0-1996-02db3d640f4b@suse.de>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2da87e22-1bbc-aff9-c0be-85a3fd8f4393@huawei.com>
Date:   Thu, 6 Dec 2018 15:37:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <c7ec9e23-6da8-35e0-1996-02db3d640f4b@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 14:17, Johannes Thumshirn wrote:
> On 06/12/2018 14:34, John Garry wrote:
> [...]
>> +static void hisi_sas_dma_unmap(struct hisi_hba *hisi_hba,
>> +			       struct sas_task *task, int n_elem,
>> +			       int n_elem_req, int n_elem_resp)
>> +{
>> +	struct device *dev = hisi_hba->dev;
>> +
>> +	if (!sas_protocol_ata(task->task_proto)) {
>> +		if (task->num_scatter) {
>> +			if (n_elem)
>> +				dma_unmap_sg(dev, task->scatter,
>> +					     task->num_scatter,
>> +					     task->data_dir);
>> +		} else if (task->task_proto & SAS_PROTOCOL_SMP) {
>> +			if (n_elem_req)
>> +				dma_unmap_sg(dev, &task->smp_task.smp_req,
>> +					     1, DMA_TO_DEVICE);
>> +			if (n_elem_resp)
>> +				dma_unmap_sg(dev, &task->smp_task.smp_resp,
>> +					     1, DMA_FROM_DEVICE);
>> +		}
>> +	}
>
> 	if (sas_protocol_ata(task->task_proto))
> 		return;
>
> Would save you a level of indentation and make the above more readable.
>
>

Hi Johannes,

Whilst I agree with the idea, the current approach makes the function 
more symmetic with its mapping buddy, hisi_sas_dma_map():

static void hisi_sas_dma_unmap(struct hisi_hba *hisi_hba,
                    struct sas_task *task, int n_elem,
                    int n_elem_req, int n_elem_resp)
{
     struct device *dev = hisi_hba->dev;

     if (!sas_protocol_ata(task->task_proto)) {
         if (task->num_scatter) {
             if (n_elem)
                 dma_unmap_sg(dev, task->scatter,

	...
}

static int hisi_sas_dma_map(struct hisi_hba *hisi_hba,
                 struct sas_task *task, int *n_elem,
                 int *n_elem_req, int *n_elem_resp)
{
     struct device *dev = hisi_hba->dev;
     int rc;

     if (sas_protocol_ata(task->task_proto)) {
         *n_elem = task->num_scatter;
     } else {
         unsigned int req_len, resp_len;

         if (task->num_scatter) {
             *n_elem = dma_map_sg(dev, task->scatter,
                          task->num_scatter, task->data_dir);
    		...

}

which is important. Let me know if you disagree and I can change it.

Thanks,
John


