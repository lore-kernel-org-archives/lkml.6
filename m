Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA6EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D76218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfADQEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:04:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17115 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfADQEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:04:34 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A022DDF777DD;
        Sat,  5 Jan 2019 00:04:30 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Sat, 5 Jan 2019
 00:04:30 +0800
Subject: Re: [PATCH] scsi/mvsas/mv_init.c: Use dma_zalloc_coherent
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
References: <5bf56248.1c69fb81.21a6e.5a72@mx.google.com>
 <CAJr6mf11gp9iV=NiFEFyo7kSZfCfMsEySdijem_PhMFEAwqucA@mail.gmail.com>
 <CAJr6mf2kr4BmCWZU0=EwXURWUZWRHHLifi_2aiUrJSCjnWusZg@mail.gmail.com>
 <CAJr6mf29hJft=rurUK8EJRQ1MS_3_MXb7f-zX0vyXUrQNLcWYA@mail.gmail.com>
 <ff090818-2f5f-1fa0-2eff-6988e1660345@huawei.com>
 <CAJr6mf1ebw16j0AZSDDxnK2t_=8wdzZBm=X_3DW=zP+XRbRFsw@mail.gmail.com>
CC:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <jthumshirn@suse.de>, Souptick Joarder <jrdr.linux@gmail.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8af8ef0a-add1-1010-6ef3-7e5c6ff51aa9@huawei.com>
Date:   Fri, 4 Jan 2019 16:04:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAJr6mf1ebw16j0AZSDDxnK2t_=8wdzZBm=X_3DW=zP+XRbRFsw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2019 15:11, Sabyasachi Gupta wrote:
> On Fri, Jan 4, 2019 at 6:43 PM John Garry <john.garry@huawei.com> wrote:
>>
>> On 04/01/2019 12:48, Sabyasachi Gupta wrote:
>>> On Wed, Dec 19, 2018 at 6:49 PM Sabyasachi Gupta
>>> <sabyasachi.linux@gmail.com> wrote:
>>>>
>>>> On Sat, Dec 1, 2018 at 6:40 PM Sabyasachi Gupta
>>>> <sabyasachi.linux@gmail.com> wrote:
>>>>>
>>>>> On Wed, Nov 21, 2018 at 7:18 PM Sabyasachi Gupta
>>>>> <sabyasachi.linux@gmail.com> wrote:
>>>>>>
>>>>>> Replace dma_alloc_coherent + memset with dma_zalloc_coherent
>>>>>>
>>
>> If you're going to make this change, then how about change these to the
>> managed version, so that we can avoid the explicit free'ing at driver
>> removal?
>
> I can't get it

Please see dmam_alloc_coherent(). You can set __GFP_ZERO in the gfp 
argument to memset(0).

I would say that this is a more useful change.

>
>>
>>>>>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>>>>>
>>>>> Any comment on this patch?
>>>>
>>>> Any comment on this patch?
>>>
>>> Any comment on this patch?
>>>
>>>>
>>>>>
>>>>>> ---
>>>>>>  drivers/scsi/mvsas/mv_init.c | 12 ++++--------
>>>>>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
>>>>>> index 3ac3437..495bddb 100644
>>>>>> --- a/drivers/scsi/mvsas/mv_init.c
>>>>>> +++ b/drivers/scsi/mvsas/mv_init.c
>>>>>> @@ -253,33 +253,29 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>>>>>>         /*
>>>>>>          * alloc and init our DMA areas
>>>>>>          */
>>>>>> -       mvi->tx = dma_alloc_coherent(mvi->dev,
>>>>>> +       mvi->tx = dma_zalloc_coherent(mvi->dev,
>>>>>>                                      sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ,
>>>>>>                                      &mvi->tx_dma, GFP_KERNEL);
>>
>> I'm guessing that this does not pass checkpatch with --strict option.
>>
>> Thanks,
>> John
>
> I have not not checked with --strict option

It may warn that you're not maintaining alignment.

>
>>
>>>>>>         if (!mvi->tx)
>>>>>>                 goto err_out;
>>>>>> -       memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
>>>>>> -       mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
>>>>>> +       mvi->rx_fis = dma_zalloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
>>>>>>                                          &mvi->rx_fis_dma, GFP_KERNEL);
>>>>>>         if (!mvi->rx_fis)
>>>>>>                 goto err_out;
>>>>>> -       memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
>>>>>>
>>>>>> -       mvi->rx = dma_alloc_coherent(mvi->dev,
>>>>>> +       mvi->rx = dma_zalloc_coherent(mvi->dev,
>>>>>>                                      sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
>>>>>>                                      &mvi->rx_dma, GFP_KERNEL);
>>>>>>         if (!mvi->rx)
>>>>>>                 goto err_out;
>>>>>> -       memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
>>>>>>         mvi->rx[0] = cpu_to_le32(0xfff);
>>>>>>         mvi->rx_cons = 0xfff;
>>>>>>
>>>>>> -       mvi->slot = dma_alloc_coherent(mvi->dev,
>>>>>> +       mvi->slot = dma_zalloc_coherent(mvi->dev,
>>>>>>                                        sizeof(*mvi->slot) * slot_nr,
>>>>>>                                        &mvi->slot_dma, GFP_KERNEL);
>>>>>>         if (!mvi->slot)
>>>>>>                 goto err_out;
>>>>>> -       memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
>>>>>>
>>>>>>         mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
>>>>>>                                        TRASH_BUCKET_SIZE,
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>>>
>>> .
>>>
>>
>>
>
> .
>


