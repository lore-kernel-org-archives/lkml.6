Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4948ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE5A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h/8+wxBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE5A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJYUB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:01:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53848 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYUB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:01:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9PBT27r023065;
        Thu, 25 Oct 2018 11:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wMokk2O+zI/6oAUVJtLigYRBW3nS1rtC/oZhoh3PFLs=;
 b=h/8+wxBWWqDeYw4+dR5u+S4QBgOBihTf7x04W6oNNky3vckv91zHbIf9y93bgU7AJYpS
 U03r8V6XRG+JkEHLBAhjHeVHQrDt8an6z+o3z5csYiCumBsPtt2dU3VPFrHEZ/kOLfcN
 caDhXaMho6f/THQPXEmXPCl7Y6hgsKwkjpVf2rKBLzgp0ugt3vCziMYBzEeUVKpY751S
 dk0IfsYfyVfiv74FaPQ/kFp2hbnOo0oJCt0QiCRBejJmlVGglzPUFd2ZgVV/53so8+5q
 3HYOu/JLAGYMww8o1HMmvrIt8yfxaRu9U/ZutD8N54doEN7ROToDcqPtSZcjvxGctlNM Wg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7usuh0r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 11:29:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9PBT8CM012887
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 11:29:09 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9PBT7AM006004;
        Thu, 25 Oct 2018 11:29:07 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 04:29:07 -0700
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
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <89a6c01e-c911-04ed-b434-9f93f90da66c@oracle.com>
Date:   Thu, 25 Oct 2018 07:28:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCUZfaz-ZT0N8ko3daeaBmjgYH-KQpQdt0EBfkaK9uVvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 3:50 AM, Vincent Guittot wrote:
> Hi Steve,
> 
> On Mon, 22 Oct 2018 at 17:10, Steve Sistare <steven.sistare@oracle.com> wrote:
>>
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
>> The patch series is based on kernel 4.19.0-rc7.  It compiles, boots, and
>> runs with/without each of CONFIG_SCHED_SMT, CONFIG_SMP, CONFIG_SCHED_DEBUG,
>> and CONFIG_PREEMPT.  It runs without error with CONFIG_DEBUG_PREEMPT +
>> CONFIG_SLUB_DEBUG + CONFIG_DEBUG_PAGEALLOC + CONFIG_DEBUG_MUTEXES +
>> CONFIG_DEBUG_SPINLOCK + CONFIG_DEBUG_ATOMIC_SLEEP.  CPU hot plug and CPU
>> bandwidth control were tested.
>>
>> Stealing imprroves utilization with only a modest CPU overhead in scheduler
>> code.  In the following experiment, hackbench is run with varying numbers
>> of groups (40 tasks per group), and the delta in /proc/schedstat is shown
>> for each run, averaged per CPU, augmented with these non-standard stats:
>>
>>   %find - percent of time spent in old and new functions that search for
>>     idle CPUs and tasks to steal and set the overloaded CPUs bitmap.
>>
>>   steal - number of times a task is stolen from another CPU.
>>
>> X6-2: 1 socket * 10 cores * 2 hyperthreads = 20 CPUs
>> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
>> hackbench <grps> process 100000
>> sched_wakeup_granularity_ns=15000000
> 
> Why do you mention this sched_wakeup_granularity_ns value ?
> It is something that you changed for you tests ?
> The comment for this tunable says that default value is 1ms *
> ilog(ncpus) = 4ms for 20CPUs

I changed it for the test, and I explain why a few paragraphs later.  
The value matches the one set by tuned.service, for those running it.

- Steve

> 
>>
>>   baseline
>>   grps  time  %busy  slice   sched   idle     wake %find  steal
>>   1    8.084  75.02   0.10  105476  46291    59183  0.31      0
>>   2   13.892  85.33   0.10  190225  70958   119264  0.45      0
>>   3   19.668  89.04   0.10  263896  87047   176850  0.49      0
>>   4   25.279  91.28   0.10  322171  94691   227474  0.51      0
>>   8   47.832  94.86   0.09  630636 144141   486322  0.56      0
>>
>>   new
>>   grps  time  %busy  slice   sched   idle     wake %find  steal  %speedup
>>   1    5.938  96.80   0.24   31255   7190    24061  0.63   7433  36.1
>>   2   11.491  99.23   0.16   74097   4578    69512  0.84  19463  20.9
>>   3   16.987  99.66   0.15  115824   1985   113826  0.77  24707  15.8
>>   4   22.504  99.80   0.14  167188   2385   164786  0.75  29353  12.3
>>   8   44.441  99.86   0.11  389153   1616   387401  0.67  38190   7.6
>>
>> Elapsed time improves by 8 to 36%, and CPU busy utilization is up
>> by 5 to 22% hitting 99% for 2 or more groups (80 or more tasks).
>> The cost is at most 0.4% more find time.
> 
>>
