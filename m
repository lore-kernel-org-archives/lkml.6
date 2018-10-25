Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF14ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D4720883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XnEy/M9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D4720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeJYWyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55540 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbeJYWyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9PEIhBG179619;
        Thu, 25 Oct 2018 14:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=K1LlBKWNyjwmEdLmixy7unJJpCA6QVASApDR99venAs=;
 b=XnEy/M9AE9a7XBYoRfABceN6d5btc9qMRuz4BwIWcPJ1JxWi7kqOPoEMWwn5mk2Gybx6
 TI0fu898VnDQ4vAL4RIa5MzaQtD4JBwbHWy2HRRoGLKtjpWljAFK/y1GensaEDVMhBTN
 r/yfhfy7kQBZWqKcJVEVIHcQ/dOvd6jEwUDqUIseekhBg9JMf+KYmm0kAP+FbiB2Wkgh
 r1bBIGbykA64jT3hJwe3jSJ9FIH/0C/khRjdPu2dacKlgBOMZ/1LxcgupdN0v48KsKrn
 M96lgZY13lbeVePwadUHEhYdVOKQ8xkpgnhtuVEXkGclkfMYi5IPVgH+kpLL3/GTL17d JQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n7vaq9wxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 14:20:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9PEKjNj029703
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 14:20:45 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9PEKjRo011673;
        Thu, 25 Oct 2018 14:20:45 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 07:20:28 -0700
Subject: Re: [PATCH 00/10] steal tasks to improve CPU utilization
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        subhra.mazumdar@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        Rohit Jain <rohit.k.jain@oracle.com>,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Rik van Riel <riel@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <CAKfTPtCUZfaz-ZT0N8ko3daeaBmjgYH-KQpQdt0EBfkaK9uVvw@mail.gmail.com>
 <89a6c01e-c911-04ed-b434-9f93f90da66c@oracle.com>
 <CAKfTPtDeMd4iN+WksK8+Pr-OhthEXPnkV2CRDG0KDyxTS6agJA@mail.gmail.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <7155f91e-b374-5fe5-33f7-2d708aed0813@oracle.com>
Date:   Thu, 25 Oct 2018 10:19:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDeMd4iN+WksK8+Pr-OhthEXPnkV2CRDG0KDyxTS6agJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 8:43 AM, Vincent Guittot wrote:
> On Thu, 25 Oct 2018 at 13:29, Steven Sistare <steven.sistare@oracle.com> wrote:
>>
>> On 10/25/2018 3:50 AM, Vincent Guittot wrote:
>>> Hi Steve,
>>>
>>> On Mon, 22 Oct 2018 at 17:10, Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>
>>>> When a CPU has no more CFS tasks to run, and idle_balance() fails to
>>>> find a task, then attempt to steal a task from an overloaded CPU in the
>>>> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
>>>> identify candidates.  To minimize search time, steal the first migratable
>>>> task that is found when the bitmap is traversed.  For fairness, search
>>>> for migratable tasks on an overloaded CPU in order of next to run.
>>>>
>>>> This simple stealing yields a higher CPU utilization than idle_balance()
>>>> alone, because the search is cheap, so it may be called every time the CPU
>>>> is about to go idle.  idle_balance() does more work because it searches
>>>> widely for the busiest queue, so to limit its CPU consumption, it declines
>>>> to search if the system is too busy.  Simple stealing does not offload the
>>>> globally busiest queue, but it is much better than running nothing at all.
>>>>
>>>> The bitmap of overloaded CPUs is a new type of sparse bitmap, designed to
>>>> reduce cache contention vs the usual bitmap when many threads concurrently
>>>> set, clear, and visit elements.
>>>>
>>>> Patch 1 defines the sparsemask type and its operations.
>>>>
>>>> Patches 2, 3, and 4 implement the bitmap of overloaded CPUs.
>>>>
>>>> Patches 5 and 6 refactor existing code for a cleaner merge of later
>>>>   patches.
>>>>
>>>> Patches 7 and 8 implement task stealing using the overloaded CPUs bitmap.
>>>>
>>>> Patch 9 disables stealing on systems with more than 2 NUMA nodes for the
>>>> time being because of performance regressions that are not due to stealing
>>>> per-se.  See the patch description for details.
>>>>
>>>> Patch 10 adds schedstats for comparing the new behavior to the old, and
>>>>   provided as a convenience for developers only, not for integration.
>>>>
>>>> The patch series is based on kernel 4.19.0-rc7.  It compiles, boots, and
>>>> runs with/without each of CONFIG_SCHED_SMT, CONFIG_SMP, CONFIG_SCHED_DEBUG,
>>>> and CONFIG_PREEMPT.  It runs without error with CONFIG_DEBUG_PREEMPT +
>>>> CONFIG_SLUB_DEBUG + CONFIG_DEBUG_PAGEALLOC + CONFIG_DEBUG_MUTEXES +
>>>> CONFIG_DEBUG_SPINLOCK + CONFIG_DEBUG_ATOMIC_SLEEP.  CPU hot plug and CPU
>>>> bandwidth control were tested.
>>>>
>>>> Stealing imprroves utilization with only a modest CPU overhead in scheduler
>>>> code.  In the following experiment, hackbench is run with varying numbers
>>>> of groups (40 tasks per group), and the delta in /proc/schedstat is shown
>>>> for each run, averaged per CPU, augmented with these non-standard stats:
>>>>
>>>>   %find - percent of time spent in old and new functions that search for
>>>>     idle CPUs and tasks to steal and set the overloaded CPUs bitmap.
>>>>
>>>>   steal - number of times a task is stolen from another CPU.
>>>>
>>>> X6-2: 1 socket * 10 cores * 2 hyperthreads = 20 CPUs
>>>> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
>>>> hackbench <grps> process 100000
>>>> sched_wakeup_granularity_ns=15000000
>>>
>>> Why do you mention this sched_wakeup_granularity_ns value ?
>>> It is something that you changed for you tests ?
>>> The comment for this tunable says that default value is 1ms *
>>> ilog(ncpus) = 4ms for 20CPUs
>>
>> I changed it for the test, and I explain why a few paragraphs later.
>> The value matches the one set by tuned.service, for those running it.
> 
> ok. I haven't noticed that later explanation.
> 
> You said " Note: for all hackbench runs, sched_wakeup_granularity_ns
> is set to 15 msec.  Otherwise, preemptions increase at higher loads and
> distort the comparison between baseline and new."
> 
> What do you mean exactly by distort ?

With the default value of sched_wakeup_granularity_ns and the load range
I tested, as load and CPU utilization increases, preemptions increase, average 
timeslice decreases, and time per task goes up.  For a given task count, stealing
achieves higher utilization than base for the same count, so is hit harder by the 
preemption effect than the base.  Raising sched_wakeup_granularity_ns factors this 
out of the comparison.

- Steve

>>>>   baseline
>>>>   grps  time  %busy  slice   sched   idle     wake %find  steal
>>>>   1    8.084  75.02   0.10  105476  46291    59183  0.31      0
>>>>   2   13.892  85.33   0.10  190225  70958   119264  0.45      0
>>>>   3   19.668  89.04   0.10  263896  87047   176850  0.49      0
>>>>   4   25.279  91.28   0.10  322171  94691   227474  0.51      0
>>>>   8   47.832  94.86   0.09  630636 144141   486322  0.56      0
>>>>
>>>>   new
>>>>   grps  time  %busy  slice   sched   idle     wake %find  steal  %speedup
>>>>   1    5.938  96.80   0.24   31255   7190    24061  0.63   7433  36.1
>>>>   2   11.491  99.23   0.16   74097   4578    69512  0.84  19463  20.9
>>>>   3   16.987  99.66   0.15  115824   1985   113826  0.77  24707  15.8
>>>>   4   22.504  99.80   0.14  167188   2385   164786  0.75  29353  12.3
>>>>   8   44.441  99.86   0.11  389153   1616   387401  0.67  38190   7.6
>>>>
>>>> Elapsed time improves by 8 to 36%, and CPU busy utilization is up
>>>> by 5 to 22% hitting 99% for 2 or more groups (80 or more tasks).
>>>> The cost is at most 0.4% more find time.
>>>
>>>>
