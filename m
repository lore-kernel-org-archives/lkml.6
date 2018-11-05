Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB42C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843F02081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HibBJ6y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843F02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeKFJDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:03:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49664 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeKFJDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:03:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5NOPCI184925;
        Mon, 5 Nov 2018 23:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=+7PKQ2DOMGZZOir9IDRdhpK6fHCI1IdkkRrN+FYv54U=;
 b=HibBJ6y0hmiGvPJ1kQM0DibuPWGe3STp9z+H5JGGfSX8z7NQLTa717F6XKTpA7hoojEE
 dbdGehFnXqW32bNgIDMT1oIVRJDrNUhXkF/WnO4ks4taFl0+KK8nVTF9RhboJE2gLzLk
 ctb4Pb8WdsmE0iAne6tqD5OYkz8SYqwwq0tg/bQ4c/Aw+0RNRSSbLb0LUXSti47bfAbs
 xAY/pAEnRMo/UPGx7epnEchcaZo+RxKODlzi48hZkhqgj+gWdOTZyzeK/uYyDX4MkA56
 6A5uOob7ggnvcH25sWyBO9DIctZpFf5HecfKSFBi0c5C6Qld9hTp2ksW66mGn+lNCGRt MA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nh4aqj232-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 23:40:26 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA5NeL2N014355
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 23:40:21 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA5NeKGh009460;
        Mon, 5 Nov 2018 23:40:20 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 15:40:20 -0800
Subject: Re: [RFC PATCH v2 1/1] pipe: busy wait for pipe
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, dhaval.giani@oracle.com,
        steven.sistare@oracle.com, Alexander Viro <viro@zeniv.linux.org.uk>
References: <20180925233240.24451-1-subhra.mazumdar@oracle.com>
 <20180925233240.24451-2-subhra.mazumdar@oracle.com>
 <20181105100841.GG23537@techsingularity.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <e750e230-a49b-de61-86f1-25dc47170d18@oracle.com>
Date:   Mon, 5 Nov 2018 15:40:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105100841.GG23537@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/5/18 2:08 AM, Mel Gorman wrote:
> Adding Al Viro as per get_maintainers.pl.
>
> On Tue, Sep 25, 2018 at 04:32:40PM -0700, subhra mazumdar wrote:
>> Introduce pipe_ll_usec field for pipes that indicates the amount of micro
>> seconds a thread should spin if pipe is empty or full before sleeping. This
>> is similar to network sockets.
> Can you point to what pattern from network sockets you are duplicated
> exactly? One would assume it's busy_loop_current_time and busy_loop_timeout
> but it should be in the changelog because there are differences in polling
> depending on where you are in the network subsystem (which I'm not very
> familiar with).
I was referring to the sk_busy_loop_timeout() that uses sk_ll_usec. By
similar I meant having a similar mechanism for pipes to busy wait
>
>> Workloads like hackbench in pipe mode
>> benefits significantly from this by avoiding the sleep and wakeup overhead.
>> Other similar usecases can benefit. A tunable pipe_busy_poll is introduced
>> to enable or disable busy waiting via /proc. The value of it specifies the
>> amount of spin in microseconds. Default value is 0 indicating no spin.
>>
> Your lead mail indicates the spin was set to a "suitable spin time". How
> should an administrator select this spin time? What works for hackbench
> might not be suitable for another workload. What if the spin time
> selected happens to be just slightly longer than the time it takes the
> reader to respond? In such a case, the result would be "all spin, no
> gain". While networking potentially suffers the same problem, it appears
> to be opt-in per socket so it's up to the application not to shoot
> itself in the foot.
Even for network, sk_ll_usec is assigned the value of the tunable
sysctl_net_busy_read in sock_init_data() for all sockets initialized by
default. There is way for per socket setting using sock_setsockopt(), for
pipes that can be added later if needed in case of different apps running
in one system. But there are cases where only one app runs (e.g big DBs)
and one tunable will suffice. It can be set to a value that is tested to be
beneficial under the operating conditions.
>
>> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
>> ---
>>   fs/pipe.c                 | 12 ++++++++++++
>>   include/linux/pipe_fs_i.h |  2 ++
>>   kernel/sysctl.c           |  7 +++++++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/fs/pipe.c b/fs/pipe.c
>> index bdc5d3c..35d805b 100644
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -26,6 +26,7 @@
>>   
>>   #include <linux/uaccess.h>
>>   #include <asm/ioctls.h>
>> +#include <linux/sched/clock.h>
>>   
>>   #include "internal.h"
>>   
>> @@ -40,6 +41,7 @@ unsigned int pipe_max_size = 1048576;
>>    */
>>   unsigned long pipe_user_pages_hard;
>>   unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
>> +unsigned int pipe_busy_poll;
>>   
>>   /*
>>    * We use a start+len construction, which provides full use of the
>> @@ -106,6 +108,7 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
>>   void pipe_wait(struct pipe_inode_info *pipe)
>>   {
>>   	DEFINE_WAIT(wait);
>> +	u64 start;
>>   
>>   	/*
>>   	 * Pipes are system-local resources, so sleeping on them
>> @@ -113,6 +116,10 @@ void pipe_wait(struct pipe_inode_info *pipe)
>>   	 */
>>   	prepare_to_wait(&pipe->wait, &wait, TASK_INTERRUPTIBLE);
>>   	pipe_unlock(pipe);
>> +	start = local_clock();
>> +	while (current->state != TASK_RUNNING &&
>> +	       ((local_clock() - start) >> 10) < pipe->pipe_ll_usec)
>> +		cpu_relax();
>>   	schedule();
>>   	finish_wait(&pipe->wait, &wait);
>>   	pipe_lock(pipe);
> Networking breaks this out better in terms of options instead of
> hard-coding. This does not handle need_resched or signal delivery
> properly where as networking does for example.
I don't disable preemption, so don't think checking need_resched is needed.
Can you point to what you mean by handling signal delivery in case of
networking? Not sure what I am missing. My initial version broke it out
like networking but after Peter's suggestion I clubbed it. I don't feel
strongly either way.
>
>> @@ -825,6 +832,7 @@ static int do_pipe2(int __user *fildes, int flags)
>>   	struct file *files[2];
>>   	int fd[2];
>>   	int error;
>> +	struct pipe_inode_info *pipe;
>>   
>>   	error = __do_pipe_flags(fd, files, flags);
>>   	if (!error) {
>> @@ -838,6 +846,10 @@ static int do_pipe2(int __user *fildes, int flags)
>>   			fd_install(fd[0], files[0]);
>>   			fd_install(fd[1], files[1]);
>>   		}
>> +		pipe = files[0]->private_data;
>> +		pipe->pipe_ll_usec = pipe_busy_poll;
>> +		pipe = files[1]->private_data;
>> +		pipe->pipe_ll_usec = pipe_busy_poll;
>>   	}
>>   	return error;
>>   }
> You add a pipe field but the value in always based on the sysctl
> so the information is redundantu (barring a race condition on one
> pipe write per sysctl update which is an irrelevant corner case). In
> comparison, the network subsystem appears to be explicitly opt-in via
> setsockopt(SO_BUSY_POLL) from a glance and the value appears to be tunable
> on a per-socket basis (I didn't check for sure, this is based on a glance
> at what networking does). It's not clear what a sensible way of replicating
> that for pipe file descriptors would be but it's possible that the only
> way would be to define the system-wide tunable as a max spin time and try
> detect the optimal spin time on a per-fd basis (not entirely dissimilar
> to how cpuidle menu guesses how long it'll be in an idle state for).
As I said above even networking assigns the global tunable value to each
socket during initialization. Trying to detect an optimal spin time will
be extremely difficult, I had tried a lot of heuristics but doesn't quite
work under all workloads/utilization level. This change also doesn't
preclude such work in future. In mean time some workloads can benefit from
straight forward constant tunable setting.
>
> It's not really my area but I feel that this patch is a benchmark-specific
> hack and that tuning it on a system-wide basis will be a game of "win
> some, lose some" that is never used in practice. Worse, it might end up
> in a tuning guide as "always set this sysctl" without considering the
> capabilities of the machine or the workload and falls victim to cargo
> cult tuning.
>
It is 0 by default so no spin. Workloads that do set this should know what
they are doing and if it's beneficial. I will try DB OLTP workload to see
any benefits.

Thanks,
Subhra

