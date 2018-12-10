Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E356C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF6A2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w1qiH8v/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF6A2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeLJRVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:21:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41222 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeLJRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:21:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBAHJRM1028778;
        Mon, 10 Dec 2018 17:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=GwOT0W1CBpEYAJBAtzeaX0Dn2T6FgkGuua78Z3L0n0E=;
 b=w1qiH8v/h6I9QIGri8bdzBtbDjfblNcz/MuJV8duJPKKF1PMhNq+iYo08YGAXAMIGSfR
 vMOHTdkGswNQ4s70sECPB55cYQH3CcSZe4fx3I49ANv5GdYuQz8q9nWPyM7a/U/VEb3+
 bFWphVC38By4cxcnJE44guJb3mQCgo+8VzGtOYbZlY+RmSOkmCrdoxICxvsVCVKUlB9z
 BTkCONY6vqWMijA8a+suAh1IRPBvstiJCT/O8+QkBwhntYYbbdb5U+rgh3xdkLAPMcQN
 rJ4xNbzamB2UV2x/H7e3iS4EjRw0LHBxSpabcvs5bGOXTDZS87OrDWzQTb9g14nIaPVy zw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p86kqq8kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 17:20:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBAHKdeG021704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 17:20:39 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBAHKcQT021555;
        Mon, 10 Dec 2018 17:20:38 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 09:20:38 -0800
Subject: Re: [PATCH v4 00/10] steal tasks to improve CPU utilization
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        subhra.mazumdar@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Rik van Riel <riel@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <CAKfTPtBuAsbF2r8wSigM=ckpKCqj0hcHbi+y3ZAaC7dqYcFY2g@mail.gmail.com>
 <df0197ac-d4eb-437e-1176-dbc9b23a94bb@oracle.com>
 <CAKfTPtBh59Wt3+JiZ168WRAZ+AEsS+-GTqXzeUZTKQPcDAJ73g@mail.gmail.com>
 <CAKfTPtCePEwUDyH1on+fJbuUEBYR8v7U4doL-N-ymdT3woD7OA@mail.gmail.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <2ba354cf-72ec-ff81-0050-85e84c98b0c8@oracle.com>
Date:   Mon, 10 Dec 2018 12:20:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCePEwUDyH1on+fJbuUEBYR8v7U4doL-N-ymdT3woD7OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2018 12:08 PM, Vincent Guittot wrote:
> On Mon, 10 Dec 2018 at 17:33, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> On Mon, 10 Dec 2018 at 17:29, Steven Sistare <steven.sistare@oracle.com> wrote:
>>>
>>> On 12/10/2018 11:10 AM, Vincent Guittot wrote:
>>>> Hi Steven,
>>>>
>>>> On Thu, 6 Dec 2018 at 22:38, Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>>
>>>>> When a CPU has no more CFS tasks to run, and idle_balance() fails to
>>>>> find a task, then attempt to steal a task from an overloaded CPU in the
>>>>> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
>>>>> identify candidates.  To minimize search time, steal the first migratable
>>>>> task that is found when the bitmap is traversed.  For fairness, search
>>>>> for migratable tasks on an overloaded CPU in order of next to run.
>>>>>
>>>>> This simple stealing yields a higher CPU utilization than idle_balance()
>>>>> alone, because the search is cheap, so it may be called every time the CPU
>>>>> is about to go idle.  idle_balance() does more work because it searches
>>>>> widely for the busiest queue, so to limit its CPU consumption, it declines
>>>>> to search if the system is too busy.  Simple stealing does not offload the
>>>>> globally busiest queue, but it is much better than running nothing at all.
>>>>>
>>>>> The bitmap of overloaded CPUs is a new type of sparse bitmap, designed to
>>>>> reduce cache contention vs the usual bitmap when many threads concurrently
>>>>> set, clear, and visit elements.
>>>>>
>>>>> Patch 1 defines the sparsemask type and its operations.
>>>>>
>>>>> Patches 2, 3, and 4 implement the bitmap of overloaded CPUs.
>>>>>
>>>>> Patches 5 and 6 refactor existing code for a cleaner merge of later
>>>>>   patches.
>>>>>
>>>>> Patches 7 and 8 implement task stealing using the overloaded CPUs bitmap.
>>>>>
>>>>> Patch 9 disables stealing on systems with more than 2 NUMA nodes for the
>>>>> time being because of performance regressions that are not due to stealing
>>>>> per-se.  See the patch description for details.
>>>>>
>>>>> Patch 10 adds schedstats for comparing the new behavior to the old, and
>>>>>   provided as a convenience for developers only, not for integration.
>>>>>
>>>>> The patch series is based on kernel 4.20.0-rc1.  It compiles, boots, and
>>>>> runs with/without each of CONFIG_SCHED_SMT, CONFIG_SMP, CONFIG_SCHED_DEBUG,
>>>>> and CONFIG_PREEMPT.  It runs without error with CONFIG_DEBUG_PREEMPT +
>>>>> CONFIG_SLUB_DEBUG + CONFIG_DEBUG_PAGEALLOC + CONFIG_DEBUG_MUTEXES +
>>>>> CONFIG_DEBUG_SPINLOCK + CONFIG_DEBUG_ATOMIC_SLEEP.  CPU hot plug and CPU
>>>>> bandwidth control were tested.
>>>>>
>>>>> Stealing improves utilization with only a modest CPU overhead in scheduler
>>>>> code.  In the following experiment, hackbench is run with varying numbers
>>>>> of groups (40 tasks per group), and the delta in /proc/schedstat is shown
>>>>> for each run, averaged per CPU, augmented with these non-standard stats:
>>>>>
>>>>>   %find - percent of time spent in old and new functions that search for
>>>>>     idle CPUs and tasks to steal and set the overloaded CPUs bitmap.
>>>>>
>>>>>   steal - number of times a task is stolen from another CPU.
>>>>>
>>>>> X6-2: 1 socket * 10 cores * 2 hyperthreads = 20 CPUs
>>>>> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
>>>>> hackbench <grps> process 100000
>>>>> sched_wakeup_granularity_ns=15000000
>>>>>
>>>>>   baseline
>>>>>   grps  time  %busy  slice   sched   idle     wake %find  steal
>>>>>   1    8.084  75.02   0.10  105476  46291    59183  0.31      0
>>>>>   2   13.892  85.33   0.10  190225  70958   119264  0.45      0
>>>>>   3   19.668  89.04   0.10  263896  87047   176850  0.49      0
>>>>>   4   25.279  91.28   0.10  322171  94691   227474  0.51      0
>>>>>   8   47.832  94.86   0.09  630636 144141   486322  0.56      0
>>>>>
>>>>>   new
>>>>>   grps  time  %busy  slice   sched   idle     wake %find  steal  %speedup
>>>>>   1    5.938  96.80   0.24   31255   7190    24061  0.63   7433  36.1
>>>>>   2   11.491  99.23   0.16   74097   4578    69512  0.84  19463  20.9
>>>>>   3   16.987  99.66   0.15  115824   1985   113826  0.77  24707  15.8
>>>>>   4   22.504  99.80   0.14  167188   2385   164786  0.75  29353  12.3
>>>>>   8   44.441  99.86   0.11  389153   1616   387401  0.67  38190   7.6
>>>>>
>>>>> Elapsed time improves by 8 to 36%, and CPU busy utilization is up
>>>>> by 5 to 22% hitting 99% for 2 or more groups (80 or more tasks).
>>>>> The cost is at most 0.4% more find time.
>>>>
>>>> I have run some hackbench tests on my hikey arm64 octo cores with your
>>>> patchset. My original intent was to send a tested-by but I have some
>>>> performances regressions.
>>>> This hikey is the smp one and not the asymetric hikey960 that Valentin
>>>> used for his tests
>>>> The sched domain topology is
>>>> domain-0: span=0-3 level=MC  and domain-0: span=4-7 level=MC
>>>> domain-1: span=0-7 level=DIE
>>>>
>>>> I have run 12 times hackbench -g $j -P -l 2000 with j equals to 1 2 3 4 8
>>>>
>>>> grps  time
>>>> 1      1.396
>>>> 2      2.699
>>>> 3      3.617
>>>> 4      4.498
>>>> 8      7.721
>>>>
>>>> Then after disabling STEAL in sched_feature with echo NO_STEAL >
>>>> /sys/kernel/debug/sched_features , the results become:
>>>> grps  time
>>>> 1      1.217
>>>> 2      1.973
>>>> 3      2.855
>>>> 4      3.932
>>>> 8      7.674
>>>>
>>>> I haven't looked in details about some possible reasons of such
>>>> difference yet and haven't collected the stats that you added with
>>>> patch 10.
>>>> Have you got a script to collect and post process them ?
>>>>
>>>> Regards,
>>>> Vincent
>>>
>>> Thanks Vincent.  What is the value of /proc/sys/kernel/sched_wakeup_granularity_ns?
>>
>> it's 4000000
>>
>>> Try 15000000.  Your 8-core system is heavily overloaded with 40 * groups tasks,
>>> and I suspect preemptions are killing performance.
>>
>> ok. I'm going to run the tests with the proposed value
> 
> Results look better after changing /proc/sys/kernel/sched_wakeup_granularity_ns
> 
> With STEAL
> grps  time
> 1      0.869
> 2      1.646
> 3      2.395
> 4      3.163
> 8      6.199
> 
> after echo NO_STEAL > /sys/kernel/debug/sched_features
> grps  time
> 1      0.928
> 2      1.770
> 3      2.597
> 4      3.407
> 8      6.431
> 
> There is a 7% improvement with steal and the larger value for
> /proc/sys/kernel/sched_wakeup_granularity_ns for all groups
> Should we set the STEAL feature disabled by default as this provides
> benefit only when changing sched_wakeup_granularity_ns value from
> default value?

The preemption effect is load dependent, and only bites on heavily loaded 
systems with long run queues *and* crazy high context switch rates with 
tiny timeslices, like hackbench. STEAL by default, with the default
sched_wakeup_granularity_ns, is suitable for realistic conditions IMO.

Also, the red hat tuned.service sets sched_wakeup_granularity_ns = 15000000.

Independent of this work, we really need another easy to run scheduler benchmark 
that is more realistic than hackbench.

- Steve
