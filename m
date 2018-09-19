Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92962ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F24420858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IGlVkPTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F24420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbeITDeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:34:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43902 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeITDeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:34:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8JLn6JT151752;
        Wed, 19 Sep 2018 21:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=D3Q75baxHQ9nN0q2Kgn1UR8GWmWUmb3JhpRDnZBDmTc=;
 b=IGlVkPTuEsd3lelHx9f4RM6u7urDA3tWOL9eAP4OuSrAj9JkWVYdIAHsLKRYswhDjLiF
 zWYzsJvs1Ojcfay+OP0V7eWymCR4gbLnDlWOjqcXjSZiql9VM3xRVHQXfISCzwclDNZF
 bFkLpq1IKA2gPFAS0c/P4k0xgkWLLCG9NPemn0HmwcM/CgEAHSvgfagpR2/2Mlxlq5Ox
 bIM2PeL0z6v7zSOOIkeb2AWJ93bgbNapr28tU3TMO/A+1qzOXtsK6R404azNEq8JEgEl
 qz1uLmDEM04kTa80SLyGBT2fjpnoGMwbruCiIdcrP7PDsv7Ww7ULlw7swUq6T3+j7eLX 5Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mgtqr5mbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 21:53:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8JLrkGs026445
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 21:53:46 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8JLrimL000382;
        Wed, 19 Sep 2018 21:53:44 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Sep 2018 14:53:43 -0700
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <3336974a-38f7-41dd-25a7-df05e077444f@oracle.com>
 <90282ce3-dd14-73dc-fb9f-e78bb4042221@amazon.de>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <a68891ae-468b-da35-61ee-a3136c6e64c1@oracle.com>
Date:   Wed, 19 Sep 2018 14:53:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <90282ce3-dd14-73dc-fb9f-e78bb4042221@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9021 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809190210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/18/2018 04:44 AM, Jan H. Schönherr wrote:
> On 09/18/2018 02:33 AM, Subhra Mazumdar wrote:
>> On 09/07/2018 02:39 PM, Jan H. Schönherr wrote:
>>> A) Quickstart guide for the impatient.
>>> --------------------------------------
>>>
>>> Here is a quickstart guide to set up coscheduling at core-level for
>>> selected tasks on an SMT-capable system:
>>>
>>> 1. Apply the patch series to v4.19-rc2.
>>> 2. Compile with "CONFIG_COSCHEDULING=y".
>>> 3. Boot into the newly built kernel with an additional kernel command line
>>>      argument "cosched_max_level=1" to enable coscheduling up to core-level.
>>> 4. Create one or more cgroups and set their "cpu.scheduled" to "1".
>>> 5. Put tasks into the created cgroups and set their affinity explicitly.
>>> 6. Enjoy tasks of the same group and on the same core executing
>>>      simultaneously, whenever they are executed.
>>>
>>> You are not restricted to coscheduling at core-level. Just select higher
>>> numbers in steps 3 and 4. See also further below for more information, esp.
>>> when you want to try higher numbers on larger systems.
>>>
>>> Setting affinity explicitly for tasks within coscheduled cgroups is
>>> currently necessary, as the load balancing portion is still missing in this
>>> series.
>>>
>> I don't get the affinity part. If I create two cgroups by giving them only
>> cpu shares (no cpuset) and set their cpu.scheduled=1, will this ensure
>> co-scheduling of each group on core level for all cores in the system?
> Short answer: Yes. But ignoring the affinity part will very likely result in
>                a poor experience with this patch set.
>
>
> I was referring to the CPU affinity of a task, that you can set via
> sched_setaffinity() from within a program or via taskset from the command
> line. For each task/thread within a cgroup, you should set the affinity to
> exactly one CPU. Otherwise -- as the load balancing part is still missing --
> you might end up with all tasks running on one CPU or some other unfortunate
> load distribution.
>
> Coscheduling itself does not care about the load, so each group will be
> (co-)scheduled at core level, no matter where the tasks ended up.
>
> Regards
> Jan
>
> PS: Below is an example to illustrate the resulting schedules a bit better,
> and what might happen, if you don't bind the to-be-coscheduled tasks to
> individual CPUs.
>
>
>
> For example, consider a dual-core system with SMT (i.e. 4 CPUs in total),
> two task groups A and B, and tasks within them a0, a1, ..  and b0, b1, ..
> respectively.
>
> Let the system topology look like this:
>
>          System          (level 2)
>        /        \
>    Core 0      Core 1    (level 1)
>    /    \      /    \
> CPU0  CPU1  CPU2  CPU3  (level 0)
>
>
> If you set cpu.scheduled=1 for A and B, each core will be coscheduled
> independently, if there are tasks of A or B on the core. Assuming there
> are runnable tasks in A and B and some other tasks on a core, you will
> see a schedule like:
>
>    A -> B -> other tasks -> A -> B -> other tasks -> ...
>
> (or some permutation thereof) happen synchronously across both CPUs
> of a core -- with no guarantees which tasks within A/within B/
> within the other tasks will execute simultaneously -- and with no
> guarantee what will execute on the other two CPUs simultaneously. (The
> distribution of CPU time between A, B, and other tasks follows the usual
> CFS weight proportional distribution, just at core level.) If neither
> CPU of a core has any runnable tasks of a certain group, it won't be part
> of the schedule (e.g., A -> other -> A -> other).
>
> With cpu.scheduled=2, you lift this schedule to system-level and you would
> see it happen across all four CPUs synchronously. With cpu.scheduled=0, you
> get this schedule at CPU-level as we're all used to with no synchronization
> between CPUs. (It gets a tad more interesting, when you start mixing groups
> with cpu.scheduled=1 and =2.)
>
>
> Here are some schedules, that you might see, with A and B coscheduled at
> core level (and that can be enforced this way (along the horizontal dimension)
> by setting the affinity of tasks; without setting the affinity, it could be
> any of them):
>
> Tasks equally distributed within A and B:
>
> t   CPU0  CPU1  CPU2  CPU3
> 0    a0    a1    b2    b3
> 1    a0    a1   other other
> 2    b0    b1   other other
> 3    b0    b1    a2    a3
> 4   other other  a2    a3
> 5   other other  b2    b3
>
> All tasks within A and B on one CPU:
>
> t   CPU0  CPU1  CPU2  CPU3
> 0    a0    --   other other
> 1    a1    --   other other
> 2    b0    --   other other
> 3    b1    --   other other
> 4   other other other other
> 5    a2    --   other other
> 6    a3    --   other other
> 7    b2    --   other other
> 8    b3    --   other other
>
> Tasks within a group equally distributed across one core:
>
> t   CPU0  CPU1  CPU2  CPU3
> 0    a0    a2    b1    b3
> 1    a0    a3   other other
> 2    a1    a3   other other
> 3    a1    a2    b0    b3
> 4   other other  b0    b2
> 5   other other  b1    b2
>
> You will never see an A-task sharing a core with a B-task at any point in time
> (except for the 2 microseconds or so, that the collective context switch takes).
>
Ok got it. Can we have a more generic interface, like specifying a set of
task ids to be co-scheduled with a particular level rather than tying this
with cgroups? KVMs may not always run with cgroups and there might be other
use cases where we might want co-scheduling that doesn't relate to cgroups.
