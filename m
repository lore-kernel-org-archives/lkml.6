Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF136C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F94213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="FBGD+nKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F94213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeK3DSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:18:43 -0500
Received: from vern.gendns.com ([98.142.107.122]:51812 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbeK3DSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LMHsRwp3CjjL/trFzNhJGjfy3tlyWHYOHfcG5/ntbtQ=; b=FBGD+nKkpUl0Z7X5bNOWvDBApQ
        +jfQ2BVxfdnnr3qx1KrA7ure9LRmq2bjVLGj/XJUv/EuzVlsuPXAhnZtGGjoEL+/KOOHeQMl9LBvD
        /kD4fPIHKl1jPZNdWFJSOXhNHv/MUZw6Eh6bB696VUP7LEnAukI6rGnn7psJCBnm3+okU938661W5
        VpMjiUX5/ro3VY+Z+ngBK9bsofHO2s6gaUGyrAM/OGECO62sDHkJ+7Clc3iDJVJMFChThNAR74kdN
        D8SQ219yFD0fOILV+G/RaW/kS3zmUlWnV5xae5hd9wUb295zCEjQ4NQEevWvsdSKtTvZKelegla7A
        8Lf/V9EQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44110 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gSOuq-0001gx-OM; Thu, 29 Nov 2018 11:11:48 -0500
Subject: Re: [PATCH 01/16] remoteproc: Extend rproc_da_to_va() API with a
 flags parameter
To:     Roger Quadros <rogerq@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, s-anna@ti.com
Cc:     tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com,
        ssantosh@kernel.org, nsekhar@ti.com, t-kristo@ti.com,
        nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com,
        woods.technical@gmail.com, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-2-git-send-email-rogerq@ti.com>
 <d93c4c96-e0b9-59cd-6098-92684bc2360b@lechnology.com>
 <5BFFBFA0.9000104@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <ec83108c-1748-cec4-bebf-119d261fb229@lechnology.com>
Date:   Thu, 29 Nov 2018 10:12:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BFFBFA0.9000104@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 4:29 AM, Roger Quadros wrote:
> Bjorn, Suman,
> 
> On 26/11/18 23:29, David Lechner wrote:
>> On 11/26/18 1:52 AM, Roger Quadros wrote:
>>> From: Suman Anna <s-anna@ti.com>
>>>
>>> The rproc_da_to_va() API is currently used to perform any device
>>> to kernel address translations to meet the different needs of the
>>> remoteproc core/platform drivers (eg: loading). The function also
>>> invokes the da_to_va ops, if present, to allow the remoteproc
>>> platform drivers to provide address translation. However, not all
>>> platform implementations have linear address spaces, and may need
>>> an additional parameter to be able to perform proper translations.
>>>
>>> The rproc_da_to_va() API and the rproc .da_to_va ops have therefore
>>> been expanded to take in an additional flags field enabling some
>>> remoteproc implementations (like the TI PRUSS remoteproc driver)
>>> to use these flags. Also, define some semantics for this flags
>>> argument as this can vary from one implementation to another. A
>>> new flags type is encoded into the upper 16 bits along side the
>>> actual value in the lower 16-bits for the flags argument, to
>>> allow different individual implementations to have better
>>> flexibility in interpreting the flags as per their needs.
>>
>> This seems like an overly complex solution for a rather simple
>> problem. Instead of passing all sorts of flags, could we just add
>> a parameter named "page" to da_to_va() that indicates the memory
>> page of the address in the remote processor?
>>
>> Or perhaps there is some other use for all of these flags that I
>> am not aware of?
> 
> I'm not a big fan of this patch either.
> 
> rproc_da_to_va() is used at the following places
> 
> 2 qcom_q6v5_mss.c         qcom_q6v5_dump_segment           974 void *ptr = rproc_da_to_va(rproc, segment->da, segment->size,
> 3 remoteproc_core.c       rproc_da_to_va                   197 void *rproc_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
> 4 remoteproc_core.c       rproc_handle_trace               582 ptr = rproc_da_to_va(rproc, rsc->da, rsc->len, RPROC_FLAGS_NONE);
> 5 remoteproc_core.c       rproc_coredump                  1592 ptr = rproc_da_to_va(rproc, segment->da, segment->size,
> 6 remoteproc_elf_loader.c rproc_elf_load_segments          185 ptr = rproc_da_to_va(rproc, da, memsz,
> 7 remoteproc_elf_loader.c rproc_elf_find_loaded_rsc_table  337 return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size,
> 
> At rproc_elf_load_segments() we need to pass enough information so that
> the rproc driver can load the segment into proper area (IRAM vs DRAM).
> So providing page should suffice.

FYI, the PRU series I sent a while back has some patches to do
something like this so feel free to use them if they are helpful.

https://lore.kernel.org/lkml/20180623210810.21232-2-david@lechnology.com/
https://lore.kernel.org/lkml/20180623210810.21232-3-david@lechnology.com/

> 
> I want to understand more about rproc_elf_find_loaded_rsc_table() myself.
> rproc_elf_find_loaded_rsc_table() is called only in rproc_start() in remoteproc_core.c
> with the comment
> 
>          /*
>           * The starting device has been given the rproc->cached_table as the
>           * resource table. The address of the vring along with the other
>           * allocated resources (carveouts etc) is stored in cached_table.
>           * In order to pass this information to the remote device we must copy
>           * this information to device memory. We also update the table_ptr so
>           * that any subsequent changes will be applied to the loaded version.
>           */
>          loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
> 
> Why isn't cached_table sufficient?
> Why do we need to call rproc_find_loaded_rsc_table()?
> 
> why do we need to load the resource table into remote processor memory at all.
> As discussed earlier, some PRU systems have very little memory (512 bytes?)
> and we want to avoid unnecessary loading.
> 
> cheers,
> -roger
> 

