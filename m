Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeC3IV5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 04:21:57 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50953 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750741AbeC3IVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 04:21:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=yuwang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T-MBAEC_1522398091;
Subject: Re: [PATCH] ftrace: fix task's invalid comm of <...> when big pid
To: Steven Rostedt <rostedt@goodmis.org>
References: <1522240347-24465-1-git-send-email-yuwang@linux.alibaba.com>
 <20180328113522.21b4298b@gandalf.local.home>
 <20180328114434.3a05d3bc@gandalf.local.home>
 <5ABC4C76.3090202@linux.alibaba.com>
 <20180329102642.23fa246a@gandalf.local.home>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
From: Wang Yu <yuwang@linux.alibaba.com>
Message-ID: <6ea3f860-c7ae-6400-3f15-842a06f20ae8@linux.alibaba.com>
Date: Fri, 30 Mar 2018 16:21:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180329102642.23fa246a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 18/3/29 下午10:26, Steven Rostedt 写道:
> On Thu, 29 Mar 2018 10:16:22 +0800
> Wang Yu <yuwang@linux.alibaba.com> wrote:
>
>>> What you can do is make that map_pid_to_cmdline array bigger.
>>>
>>> -- Steve
>> I am sorry about it, and as the number of cpu cores increases, the current
>>
>> PID_MAX_DEFAULT is too small, our online machines set the pid_max 65536 as default, so the task
>> pid number bigger than PID_MAX_DEFAULT can't show the real comm (only <...>), so i want to
>> ajust the PID_MAX_DEFAULT upto 4x, and what do you think?
>>
>>     * This controls the default maximum pid allocated to a process
>>     */
>> -#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
>> +#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x20000)
> What I was thinking is to make the map_pid_to_cmdline array dynamic
> (not static), and be set to pid_max (after pid_max is determined).
>
> Now, pid_max can be changed at run time. Thus, the tracing code will
> need to keep a separate variable for that array to store the length. It
> can not rely on pid_max. But if a pid that is greater than pid_max is
> found, we could kick off a work thread to increase the array.
thanks for your reply, thanks, if map_pid_to_cmdline need dynamic, 
saved_cmdlines_buffer
