Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC020C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CC62473C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CFVRgeMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CC62473C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933482AbeGCQNC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:13:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53126 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeGCQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:13:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w63G9SR7158319;
        Tue, 3 Jul 2018 16:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=1lhr4vW9+w8/LSzAohbQeMUo1Hes/9kzB2tmCKS0DCw=;
 b=CFVRgeMHj2FRWqB9rcTxCVwNKKtlJKyxq74LlmpH4U5ME1retP4/82pvDGek8UpL8wuj
 MM5FEQvWm86EugaBvwyKbHUO29jKkcGnW4bWupZ57HLoshkZx+8XPYEaqOUAB6fGLNYx
 WVaxITWOmzqT/J3wSojd9CKca/j2l6ggRXXa609e0a/0YsQ4/7YWvDR8tI2pMbrdpVzx
 C2i3AahxoKv12cBpMcAc/XEmdXoGRYNcJ8L4oUPEzCbIeUoCAG6rM5QtrCldc4FZU97Y
 3F2D4+XNyylP6VzB553zBDhHSP3+jxDoL0bBRTkzgzfrmZ6oDW5ClLHVJ9PbxRflvNQj uw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jwyccse5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jul 2018 16:12:28 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w63GCQR8032509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 16:12:27 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w63GCPXP008177;
        Tue, 3 Jul 2018 16:12:25 GMT
Received: from [192.168.1.106] (/107.182.68.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 09:12:25 -0700
Subject: Re: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via
 /proc/iomem
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org,
        al.stone@linaro.org, bhsharma@redhat.com, tbaicar@codeaurora.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com,
        linux-arm-kernel@lists.infradead.org
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-2-takahiro.akashi@linaro.org>
 <72307608-90e0-4842-edc1-d3b284782940@oracle.com>
 <ca9e5d9d-e090-f9e0-bc10-3297c9e3b7e1@arm.com>
 <891c3e5a-9760-1353-4a2c-0900082dd245@oracle.com>
 <20180703064726.GU23681@linaro.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <a9c38b0d-db67-2f5b-ea0e-ec6e45d2c4c9@oracle.com>
Date:   Tue, 3 Jul 2018 11:12:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703064726.GU23681@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8943 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 01:47 AM, AKASHI Takahiro wrote:
> On Tue, Jun 19, 2018 at 10:22:46AM -0500, Dave Kleikamp wrote:
>> On 06/19/2018 10:00 AM, James Morse wrote:
>>> Hi Dave,
>>>
>>> On 19/06/18 14:37, Dave Kleikamp wrote:
>>>> On 06/19/2018 01:44 AM, AKASHI Takahiro wrote:
>>>>> +static int __init reserve_memblock_reserved_regions(void)
>>>>> +{
>>>>> +	phys_addr_t start, end, roundup_end = 0;
>>>>> +	struct resource *mem, *res;
>>>>> +	u64 i;
>>>>> +
>>>>> +	for_each_reserved_mem_region(i, &start, &end) {
>>>>> +		if (end <= roundup_end)
>>>>> +			continue; /* done already */
>>>>> +
>>>>> +		start = __pfn_to_phys(PFN_DOWN(start));
>>>>> +		end = __pfn_to_phys(PFN_UP(end)) - 1;
>>>>> +		roundup_end = end;
>>>>> +
>>>>> +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
>>>>> +		if (WARN_ON(!res))
>>>>> +			return -ENOMEM;
>>>>> +		res->start = start;
>>>>> +		res->end = end;
>>>>> +		res->name  = "reserved";
>>>>> +		res->flags = IORESOURCE_MEM;
>>>>> +
>>>>> +		mem = request_resource_conflict(&iomem_resource, res);
>>>>> +		/*
>>>>> +		 * We expected memblock_reserve() regions to conflict with
>>>>> +		 * memory created by request_standard_resources().
>>>>> +		 */
>>>>> +		if (WARN_ON_ONCE(!mem))
>>>>> +			continue;
>>>>> +		kfree(res);
>>>>
>>>> Why is kfree() after the conditional continue? This is a memory leak.
>>>
>>> request_resource_conflict() inserts res into the iomem_resource tree, or returns
>>> the conflict if there is already something at this address.
>>>
>>> We expect something at this address: a 'System RAM' section added by
>>> request_resource(). This code wants the conflicting 'System RAM' entry so that
>>> reserve_region_with_split() can fill in the gaps below it with 'reserved'. See
>>> the commit-message for an example.
>>>
>>> If there was no conflict, it means the memory map doesn't look like we expect,
>>> we can't pass NULL to reserve_region_with_split(), and we just inserted the
>>> 'reserved' at the top level. Freeing res at this point would be a use-after-free
>>> hanging from /proc/iomem.
>>> This code generates a WARN_ON_ONCE() and leaves the 'reserved' description where
>>> it is.
>>
>> Okay. I get it.
>>
>>> Trying to cleanup here is pointless, we can remove the resource entry and free
>>> it ... but we still want to report it as reserved, which is what just happened,
>>> just not quite how we we wanted it.
>>>
>>> If you ever see this warning, it means some RAM stopped being nomap between
>>> request_resources() and reserve_memblock_reserved_regions(). I can't find any
>>> case where that ever happens.
>>>
>>>
>>> If all that makes sense: how can I improve the comment above the WARN_ON_ONCE()
>>> to make it clearer?
>>
>> I guess something like you described above.
>>
>> /*
>>  * We expect a 'System RAM' section at this address. In the unexpected
>>  * case where one is not found, request_resource_conflict() will insert
>>  * res into the iomem_resource tree.
>>  */
>>
>> Do you think this is clearer?
> 
> If this is the only change needed in my patchset, I'd like the maintainers
> to take care of it instead of my posting another version.

Agreed. The sooner this gets fixed, the better.

Thanks,
Dave

> 
> Thanks,
> -Takahiro AKASHI
> 
>>>
>>>
>>> Thanks,
>>>
>>> James
>>>
>>>
>>>>> +
>>>>> +		reserve_region_with_split(mem, start, end, "reserved");
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +arch_initcall(reserve_memblock_reserved_regions);
>>>>> +
>>>>>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>>>>>  
>>>>>  void __init setup_arch(char **cmdline_p)
>>>>>
>>>
