Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB73C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF50C214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfBPIoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:44:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726308AbfBPIoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:44:00 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D380E8BFB94C3C197C46;
        Sat, 16 Feb 2019 16:43:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 16:43:50 +0800
Subject: Re: [PATCH] ata: fix a race condition when internal cmd time out
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-ide@vger.kernel.org>, <tj@kernel.org>, <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>
References: <20190216034257.30226-1-yanaijie@huawei.com>
 <63bc665b-4f5f-0845-9767-825925ead80a@cogentembedded.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <98d269d2-da80-fdd4-13c3-84e2868c05d3@huawei.com>
Date:   Sat, 16 Feb 2019 16:43:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <63bc665b-4f5f-0845-9767-825925ead80a@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sergei

Thanks for the review.

On 2019/2/16 15:45, Sergei Shtylyov wrote:
> Hello!
> 
> On 16.02.2019 6:42, Jason Yan wrote:
> 
>> For internal cmds, we will unmap DMA memory associated with the cmd
>> before we abort the cmd. If DMA transfering data before the aborting,
> 
>     Transferring.
> 
>> bus error will occured.
> 
>     Occur.
> 
>> ata_exec_internal_sg
>>    ->ata_port_freeze if timeout
>>      ->ata_qc_complete
>>        ->ata_sg_clean
>>                                        dma transfering data = bus error
>>    ->ap->ops->post_internal_cmd
>>      ->sas_ata_post_internal
>>        ->sas_ata_internal_abort
>>          ->abort the cmd
>>
>> Fix this by move post_internal_cmd() before unmapping the DMA memory
> 
>     Moving.
> 
>> when time out. Notice that we have to set ATA_QCFLAG_FAILED flag before
>> calling post_internal_cmd() so that the aborting will work.
>>
>> Reported-by: luojian <luojian5@huawei.com>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> [...]
> 
> MBR, Sergei
> 
> 

