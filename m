Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C68C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2BE20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/TUeHXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2BE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLGWgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:36:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48236 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGWgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:36:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7MUU8Q115506;
        Fri, 7 Dec 2018 22:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=puUfj62l5vpzs+urJqGDB6PhjFnYdMRiQHPte2Ve0hE=;
 b=d/TUeHXN8DxBwa7L6lwkEa2yEWv/Z3GJNwNZZw0gd2PUmE/BZd5CfG8VZUCFUu1oszwe
 QfHkNisNtiPu+bK+C1bdS2jIGo0fO6HlPkL7iXjW9O6MrAj2AJCFzk0UywX8U7RPVfX+
 GUG4hP2lfy8Qs44aHgM8j4PoJzP946HkdacNmVVbjluVTWveiLWNZ33DyF3/y/y6Aw2Z
 FA6WBD88efxHrLMpQekhaSP7eDDiqoMKomd9jnVpJqgSR+ukN5dnk33PBJDtlrzKo5p6
 WFU9ZiUdJcnVEIumsQu4q4m3FX7hfRnPhYGLffKudf4UbdYvMJsUR2fpvMkqN44bbnJ+ pg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqug7gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 22:36:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB7Ma1dB007735
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 22:36:02 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB7Ma1kM026793;
        Fri, 7 Dec 2018 22:36:01 GMT
Received: from [10.39.214.172] (/10.39.214.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 22:36:00 +0000
Subject: Re: [PATCH v4 04/10] sched/fair: Dynamically update cfs_overload_cpus
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-5-git-send-email-steven.sistare@oracle.com>
 <3ec57357-dc4e-be1b-963f-abcf760ecc5a@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <b72240f1-1067-025c-50ca-b231637d8657@oracle.com>
Date:   Fri, 7 Dec 2018 17:35:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <3ec57357-dc4e-be1b-963f-abcf760ecc5a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9100 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
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
>> @@ -3724,6 +3725,28 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>>  	rq->misfit_task_load = task_h_load(p);
>>  }
>>  
>> +static void overload_clear(struct rq *rq)
> 
> Nitpicky nit: cfs_overload_{clear, set} might be a bit better, just to
> explicitly differentiate this from rq->rd->overload. Although I suppose
> the naming problem will show up again if/when you try to expand this to
> other classes...

This is static within fair.c which is CFS, so I think the name is OK.

>> +{
>> +	struct sparsemask *overload_cpus;
>> +
>> +	rcu_read_lock();
>> +	overload_cpus = rcu_dereference(rq->cfs_overload_cpus);
>> +	if (overload_cpus)
>> +		sparsemask_clear_elem(overload_cpus, rq->cpu);
>> +	rcu_read_unlock();
>> +}
>> +
>> +static void overload_set(struct rq *rq)
>> +{
>> +	struct sparsemask *overload_cpus;
>> +
>> +	rcu_read_lock();
>> +	overload_cpus = rcu_dereference(rq->cfs_overload_cpus);
>> +	if (overload_cpus)
>> +		sparsemask_set_elem(overload_cpus, rq->cpu);
>> +	rcu_read_unlock();
>> +}
>> +
>>  #else /* CONFIG_SMP */
>>  
>>  #define UPDATE_TG	0x0
> [...]
>> @@ -4468,8 +4495,12 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>>  			dequeue = 0;
>>  	}
>>  
>> -	if (!se)
>> +	if (!se) {
>>  		sub_nr_running(rq, task_delta);
>> +		if (prev_nr >= 2 && prev_nr - task_delta < 2)
>> +			overload_clear(rq);
>> +
>> +	}
> 
> Eventually it'd be nice to squash those into {add, sub}_nr_running(), but
> you already mentioned wanting to stick to CFS for now, so I don't think
> it's *too* much of a big deal.

Maybe.  It depends on a design decision to be made if/when we add bitmap
based stealing to other scheduling classes.  Do we maintain one bitmap
for overloaded CPUs where the overload may be caused by any mix of different
task classes?  If yes, then the bitmap search for one class such as RT
will inspect and reject overloaded CPUs that only have CFS tasks, which 
making the search less efficient.  I am leaning towards a separate bitmap 
per class to avoid that.

- Steve
  
