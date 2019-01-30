Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAFAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5355B21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfA3Bxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:53:54 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:58605 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727618AbfA3Bxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:53:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TJEZP5._1548813231;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TJEZP5._1548813231)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Jan 2019 09:53:51 +0800
Subject: Re: [PATCH] sched/debug: Show intergroup and hierarchy sum wait time
 of a task group
To:     =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Wind Yu <yuzhoujian@didichuxing.com>,
        linux-kernel@vger.kernel.org
References: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com>
 <3680160f-a439-02a3-3d40-56de18096c4b@linux.alibaba.com>
 <CAHCio2iYoKOSgxJWFX6KcRcn7GK=aEJP7Sz0vU6SwXK2C56mew@mail.gmail.com>
 <6625b261-d199-6b37-de65-1b576dcbad5b@linux.alibaba.com>
 <CAHCio2jP7mZpE6sAb_Rewbc2nx4s0NY3sOYmsF69EqE4Ysbo=w@mail.gmail.com>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <4840cfe6-161a-5d2e-361d-732bedcaee87@linux.alibaba.com>
Date:   Wed, 30 Jan 2019 09:53:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHCio2jP7mZpE6sAb_Rewbc2nx4s0NY3sOYmsF69EqE4Ysbo=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/28 下午3:21, 禹舟键 wrote:
[snip]
>> No offense but I'm afraid you misunderstand the problem we try to solve
>> by wait_sum, if your purpose is to have a way to tell whether there are
>> sufficient CPU inside a container, please try lxcfs + top, if there are
>> almost no idle and load is high, then the CPU resource is not sufficient.
> 
> emmmm... Maybe I didn't make it clear.  We need to dynamically adjust the
> number of CPUs for a container based on the running state of tasks inside
> the container. If we find tasks' wait_sum are really high, we will add more
> CPU cores to this container, or else we will decline some CPU to this container.
> In a word, we want to ensure 'co-scheduling' for high priority containers.
> 

I understand that you want to use task wait time which is a raw metric, but IMHO
when task wait more, idle will be less and load will be high, they are more
general metric to tell whether there are CPU starving rather then task wait
time on rq, and we rely on these too.

The only issue we got previously is that we don't know what caused the less idle
and high load, could be wrong resource assignment or cgroup competition, and now
with wait_sum we can firstly make sure competition is low, then if idle is still
low and load is still high inside container, time to assign more CPU.

> 
>> Frankly speaking this sounds like a supplement rather than a missing piece,
>> although we don't rely on lxcfs and modify the kernel ourselves to support
>> container environment, I still don't think such kind of solutions should be
>> in kernel.
> 
> I don't care if this value is considered as a supplement or a missing piece. I
> only care about how can I assess the running state inside a container. I think
> lxcfs is really a good solution to improve the visibility of container
> resources,
> but it is not good enough at the moment.
> 
> /proc/cpuinfo
> /proc/diskstats
> /proc/meminfo
> /proc/stat
> /proc/swaps
> /proc/uptime
> 
> we can read this procfs file inside a container,but this file still
> cannot reflect
> real-time information. Please think about the following scenario: a
> 'rabbit' process
> will generate 2000 tasks in every 30ms, and these children tasks just run 1~5ms
> and then exit. How can we detect this thrashing workload without
> hierarchy wait_sum?

As mentioned, we implement the isolation on ourselves, so we will see the isolated
idle and load information inside container, rather then the host data, we don't
rely on lxcfs but we know it's something doing similar work, so what you got by
reading /proc/stat, does it tell the isolated idle data? And you need a isolated
/proc/loadavg too.

Anyway, IMHO this is a special requirement only for container environment, not a
general solution for kernel problem, so I would suggest either help improve
the lxcfs to make it useful for your production, or do the modification in your own
kernel.

Regards,
Michael Wang

> 
> Thanks,
> Yuzhoujian
> 
