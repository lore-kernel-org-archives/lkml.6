Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeC2CQ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 22:16:26 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38403 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750732AbeC2CQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 22:16:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=yuwang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T-Gey9M_1522289782;
Message-ID: <5ABC4C76.3090202@linux.alibaba.com>
Date: Thu, 29 Mar 2018 10:16:22 +0800
From: Wang Yu <yuwang@linux.alibaba.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix task's invalid comm of <...> when big pid
References: <1522240347-24465-1-git-send-email-yuwang@linux.alibaba.com>        <20180328113522.21b4298b@gandalf.local.home> <20180328114434.3a05d3bc@gandalf.local.home>
In-Reply-To: <20180328114434.3a05d3bc@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


于 18/3/28 下午11:44, Steven Rostedt 写道:
> On Wed, 28 Mar 2018 11:35:22 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Wed, 28 Mar 2018 20:32:27 +0800
>> Wang Yu <yuwang@linux.alibaba.com> wrote:
>>
>>> when pid is bigger than PID_MAX_DEFAULT, the comm of task
>>> is <...>, it is better use pid_max to compare
>>>
>>> Signed-off-by: Wang Yu <yuwang@linux.alibaba.com>
>>> ---
>>>   kernel/trace/trace.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>   mode change 100644 => 100755 kernel/trace/trace.c
>>>
>>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>>> old mode 100644
>>> new mode 100755
>>> index 20a2300..0d4bc7a
>>> --- a/kernel/trace/trace.c
>>> +++ b/kernel/trace/trace.c
>>> @@ -1976,7 +1976,7 @@ static void __trace_find_cmdline(int pid, char comm[])
>>>   		return;
>>>   	}
>>>   
>>> -	if (pid > PID_MAX_DEFAULT) {
>>> +	if (pid > pid_max) {
>> Thanks! this probably should go to stable.
> I take that back. This patch can cause a buffer overflow access.
>
> If you looked at the line after this check, you would see:
>
> 	if (pid > PID_MAX_DEFAULT) {
> 		strcpy(comm, "<...>");
> 		return;
> 	}
>
> 	map = savedcmd->map_pid_to_cmdline[pid];
>
> And if you looked to see what map_pid_to_cmdline is:
>
> struct saved_cmdlines_buffer {
> 	unsigned map_pid_to_cmdline[PID_MAX_DEFAULT+1];
>
> Your patch will access memory past the end of that array, and cause a
> bug.
>
> If you want to support more than PID_MAX_DEFAULT, a lot more needs to
> change than this. And a change like this isn't going to go to stable.
>
> What you can do is make that map_pid_to_cmdline array bigger.
>
> -- Steve

I am sorry about it, and as the number of cpu cores increases, the current

PID_MAX_DEFAULT is too small, our online machines set the pid_max 65536 as default, so the task
pid number bigger than PID_MAX_DEFAULT can't show the real comm (only <...>), so i want to
ajust the PID_MAX_DEFAULT upto 4x, and what do you think?

   * This controls the default maximum pid allocated to a process
   */
-#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
+#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x20000)

>   
>
>> -- Steve
>>
>>>   		strcpy(comm, "<...>");
>>>   		return;
>>>   	}
