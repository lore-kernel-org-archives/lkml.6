Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507C9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F1E213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nSBLsx6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F1E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbeKTD5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:57:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39950 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390965AbeKTD5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:57:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAJHTWQR181103;
        Mon, 19 Nov 2018 17:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=X35vDiXCDTaVhviJNzlqUpuIU3mpIIcv4WII44DVcYw=;
 b=nSBLsx6hObnaDwNFuSYcxEuubnUCiLQ7ErlMIAgulgfRveb+PGHissoPmrXkStjVmvMp
 3Dt6WsUhdzF4pXsag7RyeA7V6mViH82AFleat1LEu8wpOPSVIj0gRqU8py2NfJ/4fOxz
 3p6dzsV0f3y13puMZwt6j57IGQVK34CJq1KOP+XJsYm+KP0QHsCAEyShnmW2Vd65bmP9
 Z48s9Tyki24zTwS03GLaEa40Zc/zeCTHBayLaaEEhtNzalkCTM2SMg7ULfBbLyXtbBN4
 /PclWyDIkUAvIYUj5NKQqamLuDwNm13aAe4LxJjPWLcyiGGZY37fUClr8EPcev1Q0P8x 4A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2ntbmqfc24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 17:32:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAJHWrIo009595
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 17:32:54 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAJHWqbH006186;
        Mon, 19 Nov 2018 17:32:52 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Nov 2018 09:32:52 -0800
Subject: Re: [PATCH v3 03/10] sched/topology: Provide cfs_overload_cpus bitmap
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-4-git-send-email-steven.sistare@oracle.com>
 <b103563e-fdf3-62a1-473e-cde1cd7e2d5d@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <2efadddc-ebc0-1cdb-5580-4a9ab5610e61@oracle.com>
Date:   Mon, 19 Nov 2018 12:32:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <b103563e-fdf3-62a1-473e-cde1cd7e2d5d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811190160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2018 12:38 PM, Valentin Schneider wrote:
> Hi Steve,
> 
> On 09/11/2018 12:50, Steve Sistare wrote:
> [...]
>> @@ -482,6 +484,10 @@ static void update_top_cache_domain(int cpu)
>>  	dirty_sched_domain_sysctl(cpu);
>>  	destroy_sched_domains(tmp);
>>  
>> +	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
>> +	cfs_overload_cpus = (sd ? sd->shared->cfs_overload_cpus : NULL);
>> +	rcu_assign_pointer(rq->cfs_overload_cpus, cfs_overload_cpus);
>> +
> 
> Why not do this in update_top_cache_domain() where we also look for the
> highest SD_SHARE_PKG_RESOURCES and setup shortcut pointers?

My snippet needs rq which is currently referenced in cpu_attach_domain() but
not in update_top_cache_domain().  I could just as easily do it in 
update_top_cache_domain().  Either way is fine with me.

>>  	update_top_cache_domain(cpu);
>>  }
>>  
>> @@ -1619,9 +1625,19 @@ static void __sdt_free(const struct cpumask *cpu_map)
>>  	}
>>  }
>>  
>> +#define ZALLOC_MASK(maskp, nelems, node)				  \
>> +	(!*(maskp) && !zalloc_sparsemask_node(maskp, nelems,		  \
>> +					      SPARSEMASK_DENSITY_DEFAULT, \
>> +					      GFP_KERNEL, node))	  \
>> +
>>  static int sd_llc_alloc(struct sched_domain *sd)
>>  {
>> -	/* Allocate sd->shared data here. Empty for now. */
>> +	struct sched_domain_shared *sds = sd->shared;
>> +	struct cpumask *span = sched_domain_span(sd);
>> +	int nid = cpu_to_node(cpumask_first(span));
>> +
>> +	if (ZALLOC_MASK(&sds->cfs_overload_cpus, nr_cpu_ids, nid))
> 
> Mmm so this is called once on every CPU, but the !*(maskp) check in the
> macro makes it so there is only one allocation per sd_llc_shared.
> 
> I wouldn't mind having that called out in a comment, or having the
> pointer check done explicitly outside of the macro.

OK, will add a comment.  I like the macro because the code is cleaner if/when 
multiple sets are created.

- Steve
