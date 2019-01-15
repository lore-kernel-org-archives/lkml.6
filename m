Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B982C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5CA20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k5OmKCOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfAOPoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:44:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38806 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfAOPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:44:20 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FFi7JL031817;
        Tue, 15 Jan 2019 09:44:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547567047;
        bh=IGxTgVy13f9as6j62tsl+Z5tEovRz18/HM4R1eSpWFY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=k5OmKCOFb5TEcHBr6fTe6w7q/3gz2ouW3zo4U30kzib+S/Wpq+32XTSYc6yiO5TD7
         /fr2UZXWovVj9Y/wu4Sox/D3K2ZApUAqE03+5yx9r3KSJMoKzb+aS1et8RnX7mhL9Y
         mbRQXMbIZjrGIY5cGa0Jknhuq6tOlrtUvK6/AE+U=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FFi7bQ002538
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 09:44:07 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 09:44:07 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 09:44:07 -0600
Received: from [172.22.120.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FFi6si019699;
        Tue, 15 Jan 2019 09:44:07 -0600
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
To:     Liam Mark <lmark@codeaurora.org>
CC:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-14-afd@ti.com>
 <alpine.DEB.2.10.1901140910130.23879@lmark-linux.qualcomm.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
Date:   Tue, 15 Jan 2019 09:44:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1901140910130.23879@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 11:13 AM, Liam Mark wrote:
> On Fri, 11 Jan 2019, Andrew F. Davis wrote:
> 
>> Buffers may not be mapped from the CPU so skip cache maintenance here.
>> Accesses from the CPU to a cached heap should be bracketed with
>> {begin,end}_cpu_access calls so maintenance should not be needed anyway.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>  drivers/staging/android/ion/ion.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
>> index 14e48f6eb734..09cb5a8e2b09 100644
>> --- a/drivers/staging/android/ion/ion.c
>> +++ b/drivers/staging/android/ion/ion.c
>> @@ -261,8 +261,8 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
>>  
>>  	table = a->table;
>>  
>> -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
>> -			direction))
>> +	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
>> +			      direction, DMA_ATTR_SKIP_CPU_SYNC))
> 
> Unfortunately I don't think you can do this for a couple reasons.
> You can't rely on {begin,end}_cpu_access calls to do cache maintenance.
> If the calls to {begin,end}_cpu_access were made before the call to 
> dma_buf_attach then there won't have been a device attached so the calls 
> to {begin,end}_cpu_access won't have done any cache maintenance.
> 

That should be okay though, if you have no attachments (or all
attachments are IO-coherent) then there is no need for cache
maintenance. Unless you mean a sequence where a non-io-coherent device
is attached later after data has already been written. Does that
sequence need supporting? DMA-BUF doesn't have to allocate the backing
memory until map_dma_buf() time, and that should only happen after all
the devices have attached so it can know where to put the buffer. So we
shouldn't expect any CPU access to buffers before all the devices are
attached and mapped, right?

> Also ION no longer provides DMA ready memory, so if you are not doing CPU 
> access then there is no requirement (that I am aware of) for you to call 
> {begin,end}_cpu_access before passing the buffer to the device and if this 
> buffer is cached and your device is not IO-coherent then the cache maintenance
> in ion_map_dma_buf and ion_unmap_dma_buf is required.
> 

If I am not doing any CPU access then why do I need CPU cache
maintenance on the buffer?

Andrew

>>  		return ERR_PTR(-ENOMEM);
>>  
>>  	return table;
>> @@ -272,7 +272,8 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
>>  			      struct sg_table *table,
>>  			      enum dma_data_direction direction)
>>  {
>> -	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
>> +	dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents,
>> +			   direction, DMA_ATTR_SKIP_CPU_SYNC);
>>  }
>>  
>>  static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
>> -- 
>> 2.19.1
>>
>> _______________________________________________
>> devel mailing list
>> devel@linuxdriverproject.org
>> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
>>
> 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
