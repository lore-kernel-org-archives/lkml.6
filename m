Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2937C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6D220838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hIp5DZrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6D220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeLGWhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:37:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60162 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGWhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:37:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7MU5IF077117;
        Fri, 7 Dec 2018 22:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=P64nhxgD9XqWYi7Ze1BSgWc14eVWeIHH9zF7B4MFDPc=;
 b=hIp5DZrlWVGP7HEltQgiL9PBIvUlc/AmciCLd1/geIaj0zRVnsWCIH4vtB3WLxp5hcpW
 BgvMCFDs588Yqd4A7yhJ5SaqrhtEDb3wrvyo2TuFmTjl6cOWikzzw1FMG1dVEFZgsr6l
 eRCQWvhkqENRNHPi+j+htl0Q2Z1OgADxt7ku6c/vzaDrbAu25uR1QhPVc/ol2opPUZsg
 4+lPdgO1md7Cs9/8OwHZkZw6bJd74NTz3xeBPwqM5s2opLCpqTSV3jn4dbIvvSEXWcbp
 WUmHp7sFsKD8v0NtcUujoTHMgdv1QH8eWMi6IDjnO57dTg3dh+auAmbaKuJDa1UnY8GI zw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2p3jxs038y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 22:36:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB7MasAw030989
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 22:36:54 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB7MasrG027163;
        Fri, 7 Dec 2018 22:36:54 GMT
Received: from [10.39.214.172] (/10.39.214.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 14:36:53 -0800
Subject: Re: [PATCH v4 00/10] steal tasks to improve CPU utilization
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <e9ba0a93-4799-c230-8dcb-6580f6c00635@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <cdf38b30-a5eb-3579-0965-6cc3f6d78dde@oracle.com>
Date:   Fri, 7 Dec 2018 17:36:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <e9ba0a93-4799-c230-8dcb-6580f6c00635@arm.com>
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

On 12/7/2018 3:30 PM, Valentin Schneider wrote:
> Hi Steve,
> 
> On 06/12/2018 21:28, Steve Sistare wrote:
>> When a CPU has no more CFS tasks to run, and idle_balance() fails to
>> find a task, then attempt to steal a task from an overloaded CPU in the
>> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
>> identify candidates.  To minimize search time, steal the first migratable
>> task that is found when the bitmap is traversed.  For fairness, search
>> for migratable tasks on an overloaded CPU in order of next to run.
>>
>> This simple stealing yields a higher CPU utilization than idle_balance()
>> alone, because the search is cheap, so it may be called every time the CPU
>> is about to go idle.  idle_balance() does more work because it searches
>> widely for the busiest queue, so to limit its CPU consumption, it declines
>> to search if the system is too busy.  Simple stealing does not offload the
>> globally busiest queue, but it is much better than running nothing at all.
>>
>> The bitmap of overloaded CPUs is a new type of sparse bitmap, designed to
>> reduce cache contention vs the usual bitmap when many threads concurrently
>> set, clear, and visit elements.
>>
>> Patch 1 defines the sparsemask type and its operations.
>>
>> Patches 2, 3, and 4 implement the bitmap of overloaded CPUs.
>>
>> Patches 5 and 6 refactor existing code for a cleaner merge of later
>>   patches.
>>
>> Patches 7 and 8 implement task stealing using the overloaded CPUs bitmap.
>>
>> Patch 9 disables stealing on systems with more than 2 NUMA nodes for the
>> time being because of performance regressions that are not due to stealing
>> per-se.  See the patch description for details.
>>
>> Patch 10 adds schedstats for comparing the new behavior to the old, and
>>   provided as a convenience for developers only, not for integration.
>>
> [...]
> 
> I've run my usual tests ([1]) on my HiKey960 with 
> 
> - Just stealing (only misfit tests)
> - Stealing rebased on top of EAS (misfit + EAS tests), and with stealing
>   gated by:
> 
> ----->8-----
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 17ab4db..8b5172f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7152,7 +7152,8 @@ done: __maybe_unused;
>         rq_idle_stamp_update(rq);
>  
>         new_tasks = idle_balance(rq, rf);
> -       if (new_tasks == 0)
> +       if (new_tasks == 0 &&
> +           (!static_key_unlikely(&sched_energy_present) || READ_ONCE(rq->rd->overutilized))
>                 new_tasks = try_steal(rq, rf);
>  
>         if (new_tasks)
> -----8<-----
> 
> It all looks good from my end - if things were to go wrong on big.LITTLE
> platforms it'd be here. It might be a convoluted way of using this tag,
> but you can have my
> 
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> as a "it doesn't break my stuff" seal.
>  
> As far as the patches go, with my last comments in mind it looks good to me
> so you can also have:
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> for patches [2-8]. I haven't delved on the sparsemask details. As for patch
> 9, you might want to run other benchmarks (Peter suggested specjbb) to see
> if it is truly need.
> 
> [1]: https://github.com/ARM-software/lisa/tree/next/lisa/tests/kernel/scheduler

Hi Valentin, thanks for all your testing and review, I appreciate it - Steve
