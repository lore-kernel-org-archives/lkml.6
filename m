Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A3FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C33820831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hh0bCtm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C33820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJYUzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:55:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeJYUzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:55:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9PC8ZwC009088;
        Thu, 25 Oct 2018 12:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=pgQ6EQ/AQAFFlQXzTnnhFbQQC5Lc9Bpqh5SY+hqbWeo=;
 b=Hh0bCtm4OaSPfzRFPKnwQen3MwwBMD8Ox/w08ElZBHgEdZM7HkMYr+Z90BbUVmT/Mot5
 cbSzGmPGthqCipnbO/pHHtJy12+Cm/gsqalFoep4awWPw7n+Bz9QqP4SBqOQFnGd6jzd
 0b7Ipd2/CCWqtYtsuIT7Jtl0q4kOFxgpACjtQFmWkYfbvbUSwblrWrt+TAqrKBSUC+Ft
 aiDsZFidd9uLriA7mlrJuzjo435rf5tD+5Qxn8imQKVvsiWO9jLGsAyLedC1OoUivG7u
 Ubif/UGyn1xhbBvh2P6Sl2BXUSKRySTWVSw8HFzjiyxCYSV3uFUr50all7T+cIzFAX3J Mg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2n7w0r15ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 12:22:21 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9PCMF1L003174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 12:22:15 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9PCMEPf003504;
        Thu, 25 Oct 2018 12:22:14 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 05:22:14 -0700
Subject: Re: [PATCH 00/10] steal tasks to improve CPU utilization
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <20181022170421.GF3117@worktop.programming.kicks-ass.net>
 <8e38ce84-ec1a-aef7-4784-462ef754f62a@oracle.com>
 <a43db228-ddd0-c30f-6ba0-8d54f17f57c7@arm.com>
 <abf3ae2a-a7f4-2524-0da6-09599928b47a@oracle.com>
 <09b10abc-8357-2db3-3d30-8aa9e95e8655@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <495866f6-6ab8-55fa-1743-1b6910f94733@oracle.com>
Date:   Thu, 25 Oct 2018 08:21:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <09b10abc-8357-2db3-3d30-8aa9e95e8655@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 7:31 AM, Valentin Schneider wrote:
> 
> On 24/10/2018 20:27, Steven Sistare wrote:
> [...]
>> Hi Valentin,
>>
>> Asymmetric systems could maintain a separate bitmap for misfits; set a bit 
>> when a CPU goes on CPU, clear it going off.  When a fast CPU goes new idle,
>> it would first search the misfits mask, then search cfs_overload_cpus.
>> The misfits logic would be conditionalized with CONFIG or sched feat static 
>> branches so symmetric systems do not incur extra overhead.
> 
> That sounds reasonable - besides, misfit already introduces a
> sched_asym_cpucapacity static key. I'll try to play around with that.
> 
>>> We'd also lose the NOHZ update done in idle_balance(), though I think it's
>>> not such a big deal - were were piggy-backing this on idle_balance() just
>>> because it happened to be convenient, and we still have NOHZ_STATS_KICK
>>> anyway.
>>
>> Agreed.
>>  
>>> Another thing - in your test cases, what is the most prevalent cause of
>>> failure to pull a task in idle_balance()? Is it the load_balance() itself
>>> that fails to find a task (e.g. because the imbalance is not deemed big
>>> enough), or is it the idle migration cost logic that prevents
>>> load_balance() from running to completion?
>>
>> The latter.  Eg, for the test "X6-2, 40 CPUs, hackbench 3 process 50000",
>> CPU avg_idle is 355566 nsec, and sched_migration_cost_ns = 500000,
>> so idle_balance bails at the top:
>>           if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>>             ...
>>             goto out
>>
>> For other tests, we get past that clause but bail from a domain:
>>       if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
>>            ...
>>            break;
>>
>>> In the first case, try_steal() makes perfect sense to me. In the second
>>> case, I'm not sure if we really want to pull something if we know (well,
>>> we *think*) we're about to resume the execution of some other task.
>>
>> 355.566 microsec is enough time to steal, go on CPU, do useful work, and go 
>> off CPU, particularly for chatty workloads like hackbench.  The performance
>> data bear this out.  For the higher loads, the average timeslice for 
>> hackbench 
>>
> 
> Thanks for the explanation. AIUI the big difference here is that try_steal()
> is considerably cheaper than load_balance(), so the rq->avg_idle concerns
> matter less (or at least, on a considerably smaller scale).

Right.

>> Perhaps I could skip try_steal() if avg_idle is very small, although with
>> hackbench I have seen average time slice as small as 10 microsec under 
>> high load and preemptions.  I'll run some experiments.
> 
> That might be a safe thing to do. In the same department, maybe we could
> skip try_steal() if we bail out of idle_balance() because
> !(this_rq->rd->overload). Although rq->rd->overload and cfs_overload_cpus
> are decoupled, they should express the same thing here.

I tried that in an earlier version of my code:

    new_tasks = idle_balance(rq, rf);
    if (new_tasks == 0 && rq->rd->overload)
        new_tasks = try_steal(rq, rf);

but I did not see any performance improvement vs without the overload check,
so I omitted it for simplicity.

- Steve

>>>> We could merge the stealing code into the idle_balance() code to get a
>>>> union of the two, but IMO that would be less readable.
>>>>
>>>> We could remove the core and socket levels from idle_balance()
>>>
>>> I understand that as only doing load_balance() at DIE level in
>>> idle_balance(), as that is what makes most sense to me (with big.LITTLE
>>> those misfit migrations are done at DIE level), is that correct?
>>
>> Correct. 
>>> Also, with DynamIQ (next gen big.LITTLE) we could have asymmetry at MC
>>> level, which could cause issues there.
>>
>> We could keep idle_balance for this level and fall back to stealing as in
>> my patch, or you could extend the misfits bitmap to also include CPUs 
>> with reduced memory bandwidth and active tasks. (if I understand the asymmetry 
>> correctly).
>>
> 
> It's mostly µarch asymmetry, so by "asymmetry at MC level" I meant "we'll
> see the SD_ASYM_CPUCAPACITY flag at MC level". But if we tweak stealing
> to take misfit tasks into account (so we'd rely on SD_ASYM_CPUCAPACITY
> in some way or another), that could work.
> 
>>>> and let
>>>> stealing handle those levels.  I think that makes sense after stealing
>>>> performance is validated on more architectures, but we would still have
>>>> two different mechanisms.
>>>>
>>>> - Steve
>>>
>>> I'll try out those patches on top of the misfit series to see how the
>>> whole thing behaves.
>>
>> Very good, thanks.
>>
>> - Steve
>>
