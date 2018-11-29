Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCF7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012EB2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JMfhBkl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012EB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeK2Vfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:35:41 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57464 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeK2Vfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:35:41 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wATATwfD073931;
        Thu, 29 Nov 2018 04:29:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543487398;
        bh=B0NFVY1BHE0+JdvAEnEoCl0k08F+72BWvDC4S9IW9k0=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=JMfhBkl9wnWxxCJ7d51KNyKT8vgdHiXuCtVt53KAj5fsiwNm1FNP63MNKoSpV1TGz
         1cv0PzG46vwyTjN9R/CXPJvWqM9UjoId3Z5oIAHQJBgd5v3OrVGe+XKjcTs2sJadZk
         kSFK2mzATALNcY7FC96ostsZGsUmikkRj7ay/2Gw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wATATwp1011661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 04:29:58 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 29
 Nov 2018 04:29:56 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 29 Nov 2018 04:29:56 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wATATqjf007259;
        Thu, 29 Nov 2018 04:29:53 -0600
Subject: Re: [PATCH 01/16] remoteproc: Extend rproc_da_to_va() API with a
 flags parameter
To:     David Lechner <david@lechnology.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-2-git-send-email-rogerq@ti.com>
 <d93c4c96-e0b9-59cd-6098-92684bc2360b@lechnology.com>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFFBFA0.9000104@ti.com>
Date:   Thu, 29 Nov 2018 12:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <d93c4c96-e0b9-59cd-6098-92684bc2360b@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn, Suman,

On 26/11/18 23:29, David Lechner wrote:
> On 11/26/18 1:52 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The rproc_da_to_va() API is currently used to perform any device
>> to kernel address translations to meet the different needs of the
>> remoteproc core/platform drivers (eg: loading). The function also
>> invokes the da_to_va ops, if present, to allow the remoteproc
>> platform drivers to provide address translation. However, not all
>> platform implementations have linear address spaces, and may need
>> an additional parameter to be able to perform proper translations.
>>
>> The rproc_da_to_va() API and the rproc .da_to_va ops have therefore
>> been expanded to take in an additional flags field enabling some
>> remoteproc implementations (like the TI PRUSS remoteproc driver)
>> to use these flags. Also, define some semantics for this flags
>> argument as this can vary from one implementation to another. A
>> new flags type is encoded into the upper 16 bits along side the
>> actual value in the lower 16-bits for the flags argument, to
>> allow different individual implementations to have better
>> flexibility in interpreting the flags as per their needs.
> 
> This seems like an overly complex solution for a rather simple
> problem. Instead of passing all sorts of flags, could we just add
> a parameter named "page" to da_to_va() that indicates the memory
> page of the address in the remote processor?
> 
> Or perhaps there is some other use for all of these flags that I
> am not aware of?

I'm not a big fan of this patch either.

rproc_da_to_va() is used at the following places

2 qcom_q6v5_mss.c         qcom_q6v5_dump_segment           974 void *ptr = rproc_da_to_va(rproc, segment->da, segment->size,
3 remoteproc_core.c       rproc_da_to_va                   197 void *rproc_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
4 remoteproc_core.c       rproc_handle_trace               582 ptr = rproc_da_to_va(rproc, rsc->da, rsc->len, RPROC_FLAGS_NONE);
5 remoteproc_core.c       rproc_coredump                  1592 ptr = rproc_da_to_va(rproc, segment->da, segment->size,
6 remoteproc_elf_loader.c rproc_elf_load_segments          185 ptr = rproc_da_to_va(rproc, da, memsz,
7 remoteproc_elf_loader.c rproc_elf_find_loaded_rsc_table  337 return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size,

At rproc_elf_load_segments() we need to pass enough information so that
the rproc driver can load the segment into proper area (IRAM vs DRAM).
So providing page should suffice.

I want to understand more about rproc_elf_find_loaded_rsc_table() myself.
rproc_elf_find_loaded_rsc_table() is called only in rproc_start() in remoteproc_core.c
with the comment

        /*
         * The starting device has been given the rproc->cached_table as the
         * resource table. The address of the vring along with the other
         * allocated resources (carveouts etc) is stored in cached_table.
         * In order to pass this information to the remote device we must copy
         * this information to device memory. We also update the table_ptr so
         * that any subsequent changes will be applied to the loaded version.
         */
        loaded_table = rproc_find_loaded_rsc_table(rproc, fw);

Why isn't cached_table sufficient?
Why do we need to call rproc_find_loaded_rsc_table()?

why do we need to load the resource table into remote processor memory at all.
As discussed earlier, some PRU systems have very little memory (512 bytes?)
and we want to avoid unnecessary loading.

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
