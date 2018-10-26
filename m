Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047FDECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FA020868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t5pPxrwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FA020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJ0DHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:07:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43678 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbeJ0DHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:07:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9QINes0122038;
        Fri, 26 Oct 2018 18:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=R9uACg9SdmwN6nJy21U1jf9J53oj6lTIOEMLHqwLUbQ=;
 b=t5pPxrwetXDEOmN5oi9WfxN9/+94z71NLe3TfqfxmGMdKfclwqYWVE7GoBPW+RvM0yv0
 xq9iTl98/HgVBQIyUlktVD6EmtwGWkS0v6aDmKjcY8lz3kWXpi+OmiZ1fT+xXC04fFjd
 /eNag2le9oqlM3zr4RnBtVmDw2x6dTBdYqjxbe3bxGThXWcW/VT1hhg65V2bMkavm1Da
 3Ll0usuv30vyolZt6ivL9cHi7CkS4lLd7SVNYs2mCFXFobWHk7T1yddkc/hVTH3Hl40V
 zESuuteEPhUmvHjoUCT5H9mrTXF/gLppmjkSLPtm1/y3mLEIBIWFHxu9wGNAnzTULAaX Ag== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n7vaqgqab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 18:29:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9QISxvb004350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 18:28:59 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9QISwAL024301;
        Fri, 26 Oct 2018 18:28:58 GMT
Received: from [10.39.226.138] (/10.39.226.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 11:28:57 -0700
Subject: Re: [PATCH 07/10] sched/fair: Provide can_migrate_task_llc
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-8-git-send-email-steven.sistare@oracle.com>
 <f75ddcd5-f9a0-30c5-94e4-c4077e17ffb0@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <b9915490-661b-0d0e-ae60-d5803357e1ec@oracle.com>
Date:   Fri, 26 Oct 2018 14:28:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f75ddcd5-f9a0-30c5-94e4-c4077e17ffb0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9058 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2018 2:04 PM, Valentin Schneider wrote:
> Hi Steve,
> On 22/10/2018 15:59, Steve Sistare wrote:
>> Define a simpler version of can_migrate_task called can_migrate_task_llc
>> which does not require a struct lb_env argument, and judges whether a
>> migration from one CPU to another within the same LLC should be allowed.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  kernel/sched/fair.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 4acdd8d..6548bed 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7168,6 +7168,34 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>  }
>>  
>>  /*
>> + * Return true if task @p can migrate from @rq to @dst_rq in the same LLC.
>> + * No need to test for co-locality, and no need to test task_hot(), as sharing
>> + * LLC provides cache warmth at that level.
> 
> I was thinking that perhaps we could have scenarios where some rq's
> keep stealing tasks off of each other and we end up circulating tasks 
> between CPUs. Now, that would only happen if we had a handful of tasks
> with a very tiny period, and I'm not familiar with (real) such hyperactive
> workloads similar to those generated by hackbench where that could happen.

That will not happen with the current code, as it only steals if nr_running > 1.
The src loses a task, the dst gains it and has nr_running == 1, so it will not
be re-stolen.

If we modify the code to handle misfits, we may steal when src nr_running == 1,
but a fast CPU will only steal the lone task from a slow one, never fast from fast, 
and never slow from fast, so no tug of war.

> In short, I wonder if we should have task_hot() in there. Drawing a
> parallel with load_balance(), even if load-balancing is happening between
> rqs of the same LLC, we do go check task_hot(). Have you already experimented
> with adding a task_hot() check in here?

I tried task_hot, to see if L1/L2 cache warmth matters much on L1/L2/L3 systems, 
and it reduced steals and overall performance.

> I've run some iterations of hackbench (hackbench 2 process 100000) to
> investigate this task bouncing, but I didn't really see any of it. That was
> just a 4+4 big.LITTLE system though, I'll try to get numbers on a system
> with more CPUs.
> 
> ----->8-----
> 
> activations: # of task activations (task starts running)
> cpu_migrations: # of activations where cpu != prev_cpu
> % stats are percentiles
> 
> - STEAL:
> 
>   | stat  | cpu_migrations | activations |
>   |-------+----------------+-------------|
>   | count |    2005.000000 | 2005.000000 |
>   | mean  |      16.244888 |  290.608479 |
>   | std   |      38.963138 |  253.003528 |
>   | min   |       0.000000 |    3.000000 |
>   | 50%   |       3.000000 |  239.000000 |
>   | 75%   |       8.000000 |  436.000000 |
>   | 90%   |      45.000000 |  626.000000 |
>   | 99%   |     188.960000 | 1073.000000 |
>   | max   |     369.000000 | 1417.000000 |
> 
> - NO_STEAL:
> 
>   | stat  | cpu_migrations | activations |
>   |-------+----------------+-------------|
>   | count |    2005.000000 | 2005.000000 |
>   | mean  |      15.260848 |  297.860848 |
>   | std   |      46.331890 |  253.210813 |
>   | min   |       0.000000 |    3.000000 |
>   | 50%   |       3.000000 |  252.000000 |
>   | 75%   |       7.000000 |  444.000000 |
>   | 90%   |      32.600000 |  643.600000 |
>   | 99%   |     214.880000 | 1127.520000 |
>   | max   |     467.000000 | 1547.000000 |
> 
> ----->8-----
> 
> Otherwise, my only other concern at the moment is that since stealing
> doesn't care about load, we could steal a task that would cause a big
> imbalance, which wouldn't have happened with a call to load_balance().
> 
> I don't think this can be triggered with a symmetrical workload like
> hackbench, so I'll go explore something else.

The dst is about to go idle with zero load, so stealing can only improve the
instantaneous balance between src and dst.  For longer term average load, we
still rely on periodic load_balance to make adjustments.

All good questions, keep them coming.

- Steve
