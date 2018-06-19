Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3292FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCB9204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sazBSsG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCB9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937597AbeFSNh5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:37:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59906 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937544AbeFSNh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:37:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JDYh8K075669;
        Tue, 19 Jun 2018 13:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=OW5q91VJ425gZWCcsS07bpUuLmOpjQZcmBDT5XmjLM8=;
 b=sazBSsG6nCZ1MESeNq4o7ag4LNuzaqJpl6OWUdhzF945eci2BWL+l56SF0W1nl8FpmyG
 rVhJt8A7Tzb2WFed3fx+NIr9zKObORxTnAUf2ggxpURuv5SlU7GkYjnAGTwxH8of3SRk
 2ydI07X7KChxP8PVimW+bSw6Hp/W9cCKf/c/m2b4v1Rd80CncIQJ+y+JZ3w4KDlofjRT
 teioQpQlRdbTp/oRtgRAft7sEaAGGVZ7g/TbLgfdNNYW/4H3WY92VVAedygfTH2Shfx4
 PFhffOlHuEvXruKwmnCpegolMIviyJABZsrZ1CWVNcBckVBOCm/JbC3hA3EGHjbDMezE jA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jmt01g7ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 13:37:21 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5JDbJPr031892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 13:37:20 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5JDbISf019467;
        Tue, 19 Jun 2018 13:37:19 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 06:37:18 -0700
Subject: Re: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via
 /proc/iomem
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        graeme.gregory@linaro.org, al.stone@linaro.org,
        bhsharma@redhat.com, tbaicar@codeaurora.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com,
        dyoung@redhat.com, linux-arm-kernel@lists.infradead.org
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-2-takahiro.akashi@linaro.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <72307608-90e0-4842-edc1-d3b284782940@oracle.com>
Date:   Tue, 19 Jun 2018 08:37:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619064424.6642-2-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=492
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 01:44 AM, AKASHI Takahiro wrote:

> +static int __init reserve_memblock_reserved_regions(void)
> +{
> +	phys_addr_t start, end, roundup_end = 0;
> +	struct resource *mem, *res;
> +	u64 i;
> +
> +	for_each_reserved_mem_region(i, &start, &end) {
> +		if (end <= roundup_end)
> +			continue; /* done already */
> +
> +		start = __pfn_to_phys(PFN_DOWN(start));
> +		end = __pfn_to_phys(PFN_UP(end)) - 1;
> +		roundup_end = end;
> +
> +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
> +		if (WARN_ON(!res))
> +			return -ENOMEM;
> +		res->start = start;
> +		res->end = end;
> +		res->name  = "reserved";
> +		res->flags = IORESOURCE_MEM;
> +
> +		mem = request_resource_conflict(&iomem_resource, res);
> +		/*
> +		 * We expected memblock_reserve() regions to conflict with
> +		 * memory created by request_standard_resources().
> +		 */
> +		if (WARN_ON_ONCE(!mem))
> +			continue;
> +		kfree(res);

Why is kfree() after the conditional continue? This is a memory leak.

> +
> +		reserve_region_with_split(mem, start, end, "reserved");
> +	}
> +
> +	return 0;
> +}
> +arch_initcall(reserve_memblock_reserved_regions);
> +
>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>  
>  void __init setup_arch(char **cmdline_p)
> 
