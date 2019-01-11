Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7613C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0932177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfAKKZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:25:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:32691 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfAKKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:25:35 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0BAPRwn040504;
        Fri, 11 Jan 2019 19:25:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Fri, 11 Jan 2019 19:25:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0BAPMli040481
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 11 Jan 2019 19:25:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e55fb27c-f23b-0ac5-acfd-7265c0a3b8dc@i-love.sakura.ne.jp>
 <20190109120212.GT31793@dhcp22.suse.cz>
 <201901102359.x0ANxIbn020225@www262.sakura.ne.jp>
Message-ID: <fbdfdfeb-5664-ddf3-4d65-c64f9851ac26@i-love.sakura.ne.jp>
Date:   Fri, 11 Jan 2019 19:25:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <201901102359.x0ANxIbn020225@www262.sakura.ne.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/11 8:59, Tetsuo Handa wrote:
> Michal Hocko wrote:
>> On Wed 09-01-19 20:34:46, Tetsuo Handa wrote:
>>> On 2019/01/09 20:03, Michal Hocko wrote:
>>>> Tetsuo,
>>>> can you confirm that these two patches are fixing the issue you have
>>>> reported please?
>>>>
>>>
>>> My patch fixes the issue better than your "[PATCH 2/2] memcg: do not
>>> report racy no-eligible OOM tasks" does.
>>
>> OK, so we are stuck again. Hooray!
> 
> Andrew, will you pick up "[PATCH 3/2] memcg: Facilitate termination of memcg OOM victims." ?
> Since mm-oom-marks-all-killed-tasks-as-oom-victims.patch does not call mark_oom_victim()
> when task_will_free_mem() == true, memcg-do-not-report-racy-no-eligible-oom-tasks.patch
> does not close the race whereas my patch closes the race better.
> 

I confirmed that mm-oom-marks-all-killed-tasks-as-oom-victims.patch and
memcg-do-not-report-racy-no-eligible-oom-tasks.patch are completely failing
to fix the issue I am reporting. :-(

Reproducer:
----------
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sched.h>
#include <sys/mman.h>

#define NUMTHREADS 256
#define MMAPSIZE 4 * 10485760
#define STACKSIZE 4096
static int pipe_fd[2] = { EOF, EOF };
static int memory_eater(void *unused)
{
	int fd = open("/dev/zero", O_RDONLY);
	char *buf = mmap(NULL, MMAPSIZE, PROT_WRITE | PROT_READ,
			 MAP_ANONYMOUS | MAP_SHARED, EOF, 0);
	read(pipe_fd[0], buf, 1);
	read(fd, buf, MMAPSIZE);
	pause();
	return 0;
}
int main(int argc, char *argv[])
{
	int i;
	char *stack;
	FILE *fp;
	const unsigned long size = 1048576UL * 200;
	mkdir("/sys/fs/cgroup/memory/test1", 0755);
	fp = fopen("/sys/fs/cgroup/memory/test1/memory.limit_in_bytes", "w");
	fprintf(fp, "%lu\n", size);
	fclose(fp);
	fp = fopen("/sys/fs/cgroup/memory/test1/tasks", "w");
	fprintf(fp, "%u\n", getpid());
	fclose(fp);
	if (setgid(-2) || setuid(-2) || pipe(pipe_fd))
		return 1;
	stack = mmap(NULL, STACKSIZE * NUMTHREADS, PROT_WRITE | PROT_READ,
		     MAP_ANONYMOUS | MAP_SHARED, EOF, 0);
	for (i = 0; i < NUMTHREADS; i++)
		if (clone(memory_eater, stack + (i + 1) * STACKSIZE,
			  CLONE_VM | CLONE_FS | CLONE_FILES, NULL) == -1)
			break;
	close(pipe_fd[1]);
	pause(); // Manually enter Ctrl-C immediately after dump_header() started.
	return 0;
}
----------

Complete log is at http://I-love.SAKURA.ne.jp/tmp/serial-20190111.txt.xz :
----------
[   71.146532][ T9694] a.out invoked oom-killer: gfp_mask=0x6200ca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
[   71.151647][ T9694] CPU: 1 PID: 9694 Comm: a.out Kdump: loaded Not tainted 5.0.0-rc1-next-20190111 #272
(...snipped...)
[   71.304689][ T9694] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/test1,task_memcg=/test1,task=a.out,pid=9692,uid=-2
[   71.304703][ T9694] Memory cgroup out of memory: Kill process 9692 (a.out) score 904 or sacrifice child
[   71.309149][   T54] oom_reaper: reaped process 9750 (a.out), now anon-rss:0kB, file-rss:0kB, shmem-rss:185532kB
[   71.328523][ T9748] a.out invoked oom-killer: gfp_mask=0x7080c0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), order=0, oom_score_adj=0
[   71.328552][ T9748] CPU: 4 PID: 9748 Comm: a.out Kdump: loaded Not tainted 5.0.0-rc1-next-20190111 #272
(...snipped...)
[   71.328785][ T9748] Out of memory and no killable processes...
[   71.329194][ T9771] a.out invoked oom-killer: gfp_mask=0x7080c0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), order=0, oom_score_adj=0
(...snipped...)
[   99.696592][ T9924] Out of memory and no killable processes...
[   99.699001][ T9838] a.out invoked oom-killer: gfp_mask=0x6200ca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
(...snipped...)
[   99.833413][ T9838] Out of memory and no killable processes...
----------

$ grep -F 'Out of memory and no killable processes...' serial-20190111.txt | wc -l
213
