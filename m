Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EDFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E49920652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kZj6BKMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E49920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966661AbeFSPXZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:23:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40560 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966631AbeFSPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:23:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JFJIS5021436;
        Tue, 19 Jun 2018 15:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=FL/2cYmoHYihpPd88i9pbZKEkP80BND4eVPeIkvT1KA=;
 b=kZj6BKMoLsH7uwJuOk6A2JSenLpY8xMcXoCfffXAHnmrkO6h9clu+9K/MPJv0sdmi1rv
 5EgFIQUIe1bbgClCd2WcjStZrc578H4euN7ZJIYMvbi1MlfNLHPzu4xFOh6X7JPiROcT
 u0Eiu+9Nl/TfGgeLnvGhRCudeKyx2xPHfbkBq6kd/9uLW/I/vq2O97wS1iukT69h8Bjh
 AC50jq3IrRSCLML/Hx6gmow7vRUkwAPRr+PxYkERHyJxyvgacD6DD0u/w0yq1udRY4qj
 fKkJMXX0BIsvSly36Au9wVgdWiDYNkEHZnB7GkRfxJeiEg9QHArNkhn5o2fGgMwTMdPj qw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jmtgwrns6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 15:22:50 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5JFMnij028708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 15:22:49 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5JFMmGJ031797;
        Tue, 19 Jun 2018 15:22:48 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 08:22:47 -0700
Subject: Re: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via
 /proc/iomem
To:     James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        graeme.gregory@linaro.org, al.stone@linaro.org,
        bhsharma@redhat.com, tbaicar@codeaurora.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com,
        linux-arm-kernel@lists.infradead.org
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-2-takahiro.akashi@linaro.org>
 <72307608-90e0-4842-edc1-d3b284782940@oracle.com>
 <ca9e5d9d-e090-f9e0-bc10-3297c9e3b7e1@arm.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <891c3e5a-9760-1353-4a2c-0900082dd245@oracle.com>
Date:   Tue, 19 Jun 2018 10:22:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ca9e5d9d-e090-f9e0-bc10-3297c9e3b7e1@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 10:00 AM, James Morse wrote:
> Hi Dave,
> 
> On 19/06/18 14:37, Dave Kleikamp wrote:
>> On 06/19/2018 01:44 AM, AKASHI Takahiro wrote:
>>> +static int __init reserve_memblock_reserved_regions(void)
>>> +{
>>> +	phys_addr_t start, end, roundup_end = 0;
>>> +	struct resource *mem, *res;
>>> +	u64 i;
>>> +
>>> +	for_each_reserved_mem_region(i, &start, &end) {
>>> +		if (end <= roundup_end)
>>> +			continue; /* done already */
>>> +
>>> +		start = __pfn_to_phys(PFN_DOWN(start));
>>> +		end = __pfn_to_phys(PFN_UP(end)) - 1;
>>> +		roundup_end = end;
>>> +
>>> +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
>>> +		if (WARN_ON(!res))
>>> +			return -ENOMEM;
>>> +		res->start = start;
>>> +		res->end = end;
>>> +		res->name  = "reserved";
>>> +		res->flags = IORESOURCE_MEM;
>>> +
>>> +		mem = request_resource_conflict(&iomem_resource, res);
>>> +		/*
>>> +		 * We expected memblock_reserve() regions to conflict with
>>> +		 * memory created by request_standard_resources().
>>> +		 */
>>> +		if (WARN_ON_ONCE(!mem))
>>> +			continue;
>>> +		kfree(res);
>>
>> Why is kfree() after the conditional continue? This is a memory leak.
> 
> request_resource_conflict() inserts res into the iomem_resource tree, or returns
> the conflict if there is already something at this address.
> 
> We expect something at this address: a 'System RAM' section added by
> request_resource(). This code wants the conflicting 'System RAM' entry so that
> reserve_region_with_split() can fill in the gaps below it with 'reserved'. See
> the commit-message for an example.
> 
> If there was no conflict, it means the memory map doesn't look like we expect,
> we can't pass NULL to reserve_region_with_split(), and we just inserted the
> 'reserved' at the top level. Freeing res at this point would be a use-after-free
> hanging from /proc/iomem.
> This code generates a WARN_ON_ONCE() and leaves the 'reserved' description where
> it is.

Okay. I get it.

> Trying to cleanup here is pointless, we can remove the resource entry and free
> it ... but we still want to report it as reserved, which is what just happened,
> just not quite how we we wanted it.
> 
> If you ever see this warning, it means some RAM stopped being nomap between
> request_resources() and reserve_memblock_reserved_regions(). I can't find any
> case where that ever happens.
> 
> 
> If all that makes sense: how can I improve the comment above the WARN_ON_ONCE()
> to make it clearer?

I guess something like you described above.

/*
 * We expect a 'System RAM' section at this address. In the unexpected
 * case where one is not found, request_resource_conflict() will insert
 * res into the iomem_resource tree.
 */

Do you think this is clearer?

> 
> 
> Thanks,
> 
> James
> 
> 
>>> +
>>> +		reserve_region_with_split(mem, start, end, "reserved");
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +arch_initcall(reserve_memblock_reserved_regions);
>>> +
>>>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>>>  
>>>  void __init setup_arch(char **cmdline_p)
>>>
> 
