Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE65C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F9B20844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vvydNmFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfAUUYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:24:30 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41754 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfAUUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:24:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0LKOAIV085156;
        Mon, 21 Jan 2019 14:24:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548102250;
        bh=Y6clMbjs3UAgpjX9jOCJO8phMjQgQnd5LACs21ik7GU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vvydNmFyrRd12Md7aIjUXK8g/ROpNmVPNct39mNHQ295drwdIuCLd4/+agvoT28/a
         YA3OztcA0KIyRYQz4UGDfcm117xUD8kZUAasZCs2C72gQKrbgUKlIl7oCG8rdcTKkJ
         SDv5el2ZQ0akZNlBtdrpIP1YVfqM2Civ8vS5mAyQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0LKOA45041379
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 14:24:10 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 14:24:10 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 14:24:10 -0600
Received: from [172.22.66.82] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0LKO9Lb029285;
        Mon, 21 Jan 2019 14:24:09 -0600
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
To:     Liam Mark <lmark@codeaurora.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Laura Abbott <labbott@redhat.com>, <sumit.semwal@linaro.org>,
        <arve@android.com>, <tkjos@android.com>, <maco@android.com>,
        <joel@joelfernandes.org>, <christian@brauner.io>,
        <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
 <20190119102527.GA17723@infradead.org>
 <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com>
 <20190121083046.GD12420@infradead.org>
 <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com>
 <0ed7875f-15e9-184f-5b99-9a53df7c8d14@ti.com>
 <alpine.DEB.2.10.1901211214570.11004@lmark-linux.qualcomm.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <4925c9db-fc73-1ccb-1766-ef68d014d55a@ti.com>
Date:   Mon, 21 Jan 2019 14:24:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1901211214570.11004@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 2:20 PM, Liam Mark wrote:
> On Mon, 21 Jan 2019, Andrew F. Davis wrote:
> 
>> On 1/21/19 1:44 PM, Liam Mark wrote:
>>> On Mon, 21 Jan 2019, Christoph Hellwig wrote:
>>>
>>>> On Sat, Jan 19, 2019 at 08:50:41AM -0800, Laura Abbott wrote:
>>>>>> And who is going to decide which ones to pass?  And who documents
>>>>>> which ones are safe?
>>>>>>
>>>>>> I'd much rather have explicit, well documented dma-buf flags that
>>>>>> might get translated to the DMA API flags, which are not error checked,
>>>>>> not very well documented and way to easy to get wrong.
>>>>>>
>>>>>
>>>>> I'm not sure having flags in dma-buf really solves anything
>>>>> given drivers can use the attributes directly with dma_map
>>>>> anyway, which is what we're looking to do. The intention
>>>>> is for the driver creating the dma_buf attachment to have
>>>>> the knowledge of which flags to use.
>>>>
>>>> Well, there are very few flags that you can simply use for all calls of
>>>> dma_map*.  And given how badly these flags are defined I just don't want
>>>> people to add more places where they indirectly use these flags, as
>>>> it will be more than enough work to clean up the current mess.
>>>>
>>>> What flag(s) do you want to pass this way, btw?  Maybe that is where
>>>> the problem is.
>>>>
>>>
>>> The main use case is for allowing clients to pass in 
>>> DMA_ATTR_SKIP_CPU_SYNC in order to skip the default cache maintenance 
>>> which happens in dma_buf_map_attachment and dma_buf_unmap_attachment. In 
>>> ION the buffers aren't usually accessed from the CPU so this allows 
>>> clients to often avoid doing unnecessary cache maintenance.
>>>
>>
>> How can a client know that no CPU access has occurred that needs to be
>> flushed out?
>>
> 
> I have left this to clients, but if they own the buffer they can have the 
> knowledge as to whether CPU access is needed in that use case (example for 
> post-processing).
> 
> For example with the previous version of ION we left all decisions of 
> whether cache maintenance was required up to the client, they would use 
> the ION cache maintenance IOCTL to force cache maintenance only when it 
> was required.
> In these cases almost all of the access was being done by the device and 
> in the rare cases CPU access was required clients would initiate the 
> required cache maintenance before and after the CPU access.
> 

I think we have different definitions of "client", I'm talking about the
DMA-BUF client (the importer), that is who can set this flag. It seems
you mean the userspace application, which has no control over this flag.

> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
