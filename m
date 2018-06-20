Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1209C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C742083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k726EaZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C742083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933589AbeFTWUv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:20:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41518 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeFTWUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:20:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KMIdoQ038037;
        Wed, 20 Jun 2018 22:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=uVEH1AemV5HdyHkFL4hpVuYSF8AlWE8d7rLM7PblFjU=;
 b=k726EaZKTtDsDHFI3VASQbLcqUfjoJr3QpJiH9Kq5wLHGV1T0FvevQUWRp4skPSvhysA
 fiElMi8651AOAvqWJb2xoca3o8IRMZOISezVjy8mSrMajdVOvWI217jP8E38DUZo6a+U
 vI9t7bJkyJVno18/uM9YoRTFxs3MhNUoDHdClvr1y+jwdC26Ij9fUvR/10ImDdCcujAk
 KW3SVks+9MmGunuD7H76k8+pIZ+N1y116rFzaAxqiG9mhRTtHyYtXZQQe0OfQ9Yyp7v1
 SGzVtR25E7IiSd77mQ3ejY4eM0UhIyJjOH7I7B+I4QAeFI5WTMZNNk6bsAYlfRemdAzH qA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jmt01pfjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 22:20:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KMKOOa020916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 22:20:24 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5KMKOjm028615;
        Wed, 20 Jun 2018 22:20:24 GMT
Received: from [10.39.229.144] (/10.39.229.144)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 15:20:24 -0700
Subject: Re: [RFC 00/11] select_idle_sibling rework
To:     Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        subhra.mazumdar@oracle.com, rohit.k.jain@oracle.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dhaval.giani@oracle.com, umgwanakikbuti@gmail.com, riel@surriel.com
References: <20180530142236.667774973@infradead.org>
 <20180619220639.GA14960@codeblueprint.co.uk>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <52394289-639e-38e0-727d-8b8d91e3dd35@oracle.com>
Date:   Wed, 20 Jun 2018 18:20:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619220639.GA14960@codeblueprint.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/2018 6:06 PM, Matt Fleming wrote:
> On Wed, 30 May, at 04:22:36PM, Peter Zijlstra wrote:
>> Hi all,
>>
>> This is all still very preliminary and could all still go up in flames (it has
>> only seen hackbench so far). This is mostly the same code I posted yesterday,
>> but hopefully in a more readable form.
>>
>> This fixes the SIS_PROP as per the outline here:
>>
>>   https://lkml.kernel.org/r/20180425153600.GA4043@hirez.programming.kicks-ass.net
>>
>> and Rohit's suggestion of folding the iteration loops.
>>
>> For testing I would suggest to ignore the last 3 patches, those are purely
>> cleanups once the first lot is found to actually work as advertised.
> 
> This series looks pretty good from my testing. I see double-digit
> improvements to hackbench results and only one case of a clear
> regression (easily offset by all the wins).
> 
> Are you aware of any regressions for particular benchmarks I should
> take a look at?

Hi folks,
  Just a heads up that I am working on a different patch series for
improving the utilization of idle CPUs.  After reviewing Subhra's series
and Peter's series for inspiration (thanks guys), I started from scratch.
My series improves efficiency on both the push side (find idle) and
the pull side (find a task), and is showing substantial speedups: a 10%
to 88% improvement in hackbench depending on load level.  I will send
an RFC soon, but here is a quick summary.

On the push side, I start by extending Rohit's proposal to use an idle
cpu mask.  I define a per-LLC bitmask of idle CPUs and a bitmask of idle
cores, maintained using atomic operations during idle_task transitions
with the help of a per-core busy-cpu counter.  select_idle_core,
select_idle_cpu, and select_idle_smt search the masks and claim bits
atomically.  However, to reduce contention amongst readers and writers
of the masks, I define a new sparsemask type which only uses 8 bits in
the first word of every 64 bytes; the remaining 63*8 bits are not used.
For example, a set that can hold 128 items is 128/8*64 = 1024 bytes
in size.  This reduces contention for the atomic operations that update
the mask, but still allows efficient traversal of the mask when searching
for set bits.  The number of bits per 64 bytes is a creation time parameter.

On the pull side, I define a per-LLC sparsemask of overloaded CPUs, which
are those with 2 or more runable CFS tasks, updated whenever h_nr_running
changes from 1 to greater, or from 2 to less.  Before pick_next_task_fair
calls idle_balance(), it tries to steal a task from an overloaded CPU,
using the mask to efficiently find candidates.  It first looks on
overloaded CPUs on the same core, then looks on all overloaded CPUs.
It steals the first migrateable task it finds, searching each overloaded
CPU starting at the leftmost task on cfs_rq->tasks_timeline for fairness.
The cost to steal is very low compared to the cost of idle_balance.  If
stealing fails to find a task, idle_balance is called, with no changes to 
its algorithm.

To measure overhead, I added a timer around all the code that
updates masks, searches for idle CPUs, searches for overloaded CPUs,
and steals a task.  The sum of this time is exposed as a schedstat,
labelled as search_time below.  This is temporary, for evaluation purposes.
I added timers around select_idle_sibling in the baseline kernel for
comparison.

More testing is needed, but in my limited testing so far using hackbench,
all the metrics look good: throughput is up, CPU utilization is up, and
search time is down.

Test is "hackbench <groups> process 100000"
Configuration is a single node Xeon, 28 cores, 56 CPUs.
In the tables below:
  Time = elapsed time in seconds.  
         Number in parens is improvement vs baseline.  
  %util is the overall CPU utilization.
  %search_time is the fraction of CPU time spent in the scheduler code
    mentioned above.

baseline:

groups  tasks   Time              %util   %search_time
1       40      13.023            46.95   0.0
2       80      16.939            76.97   0.2
3       120     18.866            79.29   0.3
4       160     23.454            85.31   0.4
8       320     44.095            98.54   1.3

new:

groups  tasks   Time              %util   %search_time
1       40      13.171 (- 1.1%)   39.97   0.2
2       80       8.993 (+88.4%)   98.74   0.1
3       120     13.446 (+40.3%)   99.02   0.3
4       160     20.249 (+15.8%)   99.70   0.3
8       320     40.121 (+ 9.9%)   99.91   0.3

For this workload, most of the improvement comes from the pull side changes,
but I still like the push side changes because they guarantee we find an
idle core or cpu if one is available, at low cost.  This is important if
an idle CPU has transitioned to the idle_task and is no longer trying to
steal work.

I only handle CFS tasks, but the same algorithms could be applied for RT.
The pushing and pulling only occurs within the LLC, but it could be
applied across nodes if the LLC search fails.  Those are potential future
patches if all goes well.  I will send a patch series for the CFS LLC work
soon.

- Steve
