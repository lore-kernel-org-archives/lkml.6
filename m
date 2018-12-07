Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB18CC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D42A20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bMZHulqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D42A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLGWgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:36:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGWgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:36:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7MTIhj114746;
        Fri, 7 Dec 2018 22:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=FWZVlJLDxqHwP0g1ZDqd2yHjLNo3EO/tjr7kU04x4Q8=;
 b=bMZHulqG0JrRBrInzL6pOUqKvt8RB4QJ20OB9wtBnFYxX/fVdsKfYYdbait4dxDReprF
 gDzA1oFte7FFLHDfN3M2xUY47FqXh082OZH2oLOVbFu840ZLZtJun/RIFNYjolMB+WBn
 6MyzjSE+XXxQeaQeJq0Or1QkfECBjzbGfNpCicj8r11t7F1O1DWr2CkFxxC1TqmGKY2T
 gZoZhS/ZQAn8gDgAueKk0395m6uPgB7Ki9y3DaDzkyP5l/Dw4uAhiGjbD973Q0cMzOGw
 6AhCZMWK8utMaouzmojjGcPeiVJ4ngY6ta42ngtPSl1/s9vHsJcE2ArJAwpt6f3mNHdT iQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2p3hqug7gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 22:35:53 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB7MZlrS027873
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 22:35:47 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB7MZjFr002612;
        Fri, 7 Dec 2018 22:35:46 GMT
Received: from [10.39.214.172] (/10.39.214.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 14:35:45 -0800
Subject: Re: [PATCH v4 03/10] sched/topology: Provide cfs_overload_cpus bitmap
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-4-git-send-email-steven.sistare@oracle.com>
 <9253783d-d53f-9587-61eb-2505bca5fc0c@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <5c145b18-773d-756d-b0b9-1b939c441bd6@oracle.com>
Date:   Fri, 7 Dec 2018 17:35:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <9253783d-d53f-9587-61eb-2505bca5fc0c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9100 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2018 3:20 PM, Valentin Schneider wrote:
> Hi Steve,
> 
> On 06/12/2018 21:28, Steve Sistare wrote:
> [...]
>> @@ -1621,7 +1626,22 @@ static void __sdt_free(const struct cpumask *cpu_map)
>>  
>>  static int sd_llc_alloc(struct sched_domain *sd)
>>  {
>> -	/* Allocate sd->shared data here. Empty for now. */
>> +	struct sched_domain_shared *sds = sd->shared;
>> +	struct cpumask *span = sched_domain_span(sd);
>> +	int nid = cpu_to_node(cpumask_first(span));
>> +	int flags = __GFP_ZERO | GFP_KERNEL;
>> +	struct sparsemask *mask;
>> +
>> +	/*
>> +	 * Allocate the bitmap if not already allocated.  This is called for
>> +	 * every CPU in the LLC but only allocates once per sd_llc_shared.
>> +	 */
>> +	if (!sds->cfs_overload_cpus) {
>> +		mask = sparsemask_alloc_node(nr_cpu_ids, 3, flags, nid);
>                                              ^^^^^^^^^^ ^^^
>                                                  (1)    (2)
> 
> (1): Is this necessary? Wouldn't cpumask_weight(span) suffice?

weight does not work because the ids are not consecutive.  As a future 
optimization I have a patch that computes a local CPU id within the LLC
and uses that as the bitmap index, and that uses weight.  For this first
series I am keeping things simple.

> (2): Could this get a name somewhere? In v3 this was
> SPARSEMASK_DENSITY_DEFAULT, I think it'd make sense to have it in
> sched/sparsemask.c

Darn, suspected someone would like this identifier after I deleted it.

- Steve

>> +		if (!mask)
>> +			return 1;
>> +		sds->cfs_overload_cpus = mask;
>> +	}
>>  
>>  	return 0;
>>  }
>> @@ -1633,7 +1653,8 @@ static void sd_llc_free(struct sched_domain *sd)
>>  	if (!sds)
>>  		return;
>>  
>> -	/* Free data here. Empty for now. */
>> +	sparsemask_free(sds->cfs_overload_cpus);
>> +	sds->cfs_overload_cpus = NULL;
>>  }
>>  
>>  static int sd_llc_alloc_all(const struct cpumask *cpu_map, struct s_data *d)
>>
