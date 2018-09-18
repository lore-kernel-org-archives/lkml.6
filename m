Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1F1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698DF206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="NuOIipyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698DF206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbeIRRQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:16:41 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:8399 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeIRRQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537271068; x=1568807068;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ViAuJ1t5QpwN1a6TwNRwNptDIUAlwtDEH4myCwcgGbg=;
  b=NuOIipyHxBS9X/AHNrx+xytZ8lVXfFATm/YvEk0nk25tJuqGgv/IoMWS
   +hYmZ9bwZTER3qEhHsMQ59lowwRNDGACj1fx+mrWxK6ZhT9seBiUzbB7b
   1zj7QNRI62X5F8PUJIdGUUahWZl736khefxlH1ztbY4cYgElFOQcQ35Da
   g=;
X-IronPort-AV: E=Sophos;i="5.53,389,1531785600"; 
   d="scan'208";a="758849018"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Sep 2018 11:44:25 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8IBiKiN037298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 18 Sep 2018 11:44:23 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8IBiHgn012468;
        Tue, 18 Sep 2018 13:44:17 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <3336974a-38f7-41dd-25a7-df05e077444f@oracle.com>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <90282ce3-dd14-73dc-fb9f-e78bb4042221@amazon.de>
Date:   Tue, 18 Sep 2018 13:44:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3336974a-38f7-41dd-25a7-df05e077444f@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 02:33 AM, Subhra Mazumdar wrote:
> On 09/07/2018 02:39 PM, Jan H. Schönherr wrote:
>> A) Quickstart guide for the impatient.
>> --------------------------------------
>>
>> Here is a quickstart guide to set up coscheduling at core-level for
>> selected tasks on an SMT-capable system:
>>
>> 1. Apply the patch series to v4.19-rc2.
>> 2. Compile with "CONFIG_COSCHEDULING=y".
>> 3. Boot into the newly built kernel with an additional kernel command line
>>     argument "cosched_max_level=1" to enable coscheduling up to core-level.
>> 4. Create one or more cgroups and set their "cpu.scheduled" to "1".
>> 5. Put tasks into the created cgroups and set their affinity explicitly.
>> 6. Enjoy tasks of the same group and on the same core executing
>>     simultaneously, whenever they are executed.
>>
>> You are not restricted to coscheduling at core-level. Just select higher
>> numbers in steps 3 and 4. See also further below for more information, esp.
>> when you want to try higher numbers on larger systems.
>>
>> Setting affinity explicitly for tasks within coscheduled cgroups is
>> currently necessary, as the load balancing portion is still missing in this
>> series.
>>
> I don't get the affinity part. If I create two cgroups by giving them only
> cpu shares (no cpuset) and set their cpu.scheduled=1, will this ensure
> co-scheduling of each group on core level for all cores in the system?

Short answer: Yes. But ignoring the affinity part will very likely result in
              a poor experience with this patch set.


I was referring to the CPU affinity of a task, that you can set via
sched_setaffinity() from within a program or via taskset from the command
line. For each task/thread within a cgroup, you should set the affinity to
exactly one CPU. Otherwise -- as the load balancing part is still missing --
you might end up with all tasks running on one CPU or some other unfortunate
load distribution.

Coscheduling itself does not care about the load, so each group will be
(co-)scheduled at core level, no matter where the tasks ended up.

Regards
Jan

PS: Below is an example to illustrate the resulting schedules a bit better,
and what might happen, if you don't bind the to-be-coscheduled tasks to
individual CPUs.



For example, consider a dual-core system with SMT (i.e. 4 CPUs in total),
two task groups A and B, and tasks within them a0, a1, ..  and b0, b1, ..
respectively.

Let the system topology look like this:

        System          (level 2)
      /        \
  Core 0      Core 1    (level 1)
  /    \      /    \
CPU0  CPU1  CPU2  CPU3  (level 0)


If you set cpu.scheduled=1 for A and B, each core will be coscheduled
independently, if there are tasks of A or B on the core. Assuming there
are runnable tasks in A and B and some other tasks on a core, you will
see a schedule like:

  A -> B -> other tasks -> A -> B -> other tasks -> ...

(or some permutation thereof) happen synchronously across both CPUs
of a core -- with no guarantees which tasks within A/within B/
within the other tasks will execute simultaneously -- and with no
guarantee what will execute on the other two CPUs simultaneously. (The
distribution of CPU time between A, B, and other tasks follows the usual
CFS weight proportional distribution, just at core level.) If neither
CPU of a core has any runnable tasks of a certain group, it won't be part
of the schedule (e.g., A -> other -> A -> other).

With cpu.scheduled=2, you lift this schedule to system-level and you would
see it happen across all four CPUs synchronously. With cpu.scheduled=0, you
get this schedule at CPU-level as we're all used to with no synchronization
between CPUs. (It gets a tad more interesting, when you start mixing groups
with cpu.scheduled=1 and =2.)


Here are some schedules, that you might see, with A and B coscheduled at
core level (and that can be enforced this way (along the horizontal dimension)
by setting the affinity of tasks; without setting the affinity, it could be
any of them):

Tasks equally distributed within A and B:

t   CPU0  CPU1  CPU2  CPU3
0    a0    a1    b2    b3
1    a0    a1   other other
2    b0    b1   other other
3    b0    b1    a2    a3
4   other other  a2    a3
5   other other  b2    b3

All tasks within A and B on one CPU:

t   CPU0  CPU1  CPU2  CPU3
0    a0    --   other other
1    a1    --   other other
2    b0    --   other other
3    b1    --   other other
4   other other other other
5    a2    --   other other
6    a3    --   other other
7    b2    --   other other
8    b3    --   other other

Tasks within a group equally distributed across one core:

t   CPU0  CPU1  CPU2  CPU3
0    a0    a2    b1    b3
1    a0    a3   other other
2    a1    a3   other other
3    a1    a2    b0    b3
4   other other  b0    b2
5   other other  b1    b2

You will never see an A-task sharing a core with a B-task at any point in time
(except for the 2 microseconds or so, that the collective context switch takes).

