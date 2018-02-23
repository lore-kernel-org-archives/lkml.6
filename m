Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934496AbeBWTmy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:42:54 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:42093 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934450AbeBWTmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:42:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SyP6n3F_1519414954;
Subject: Re: [PATCH] fs: proc: use down_read_killable in
 proc_pid_cmdline_read()
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
References: <1519156169-11883-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180220223825.GA6705@avx2>
 <fa1e9b6b-efaf-79c5-00ea-1f58d5078c2d@linux.alibaba.com>
 <20180221195720.GA639@avx2>
 <b82e9c62-0c8d-205b-9887-8ea2c18eaccb@linux.alibaba.com>
 <20180223193338.GA5708@avx2>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <e8cdbc7d-45ef-ab1f-6df0-1d8ef1d4f1eb@linux.alibaba.com>
Date: Fri, 23 Feb 2018 11:42:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180223193338.GA5708@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/18 11:33 AM, Alexey Dobriyan wrote:
> On Wed, Feb 21, 2018 at 03:13:10PM -0800, Yang Shi wrote:
>
>>>>> 2) access_remote_vm() et al will do the same ->mmap_sem, and
>>>> Yes, it does. But, __access_remote_vm() is called by access_process_vm()
>>>> too, which is used by much more places, i.e. ptrace, so I was not sure
>>>> if it is preferred to convert to killable version. So, I leave it untouched.
>>> Yeah, but ->mmap_sem is taken 3 times per /proc/*/cmdline read
>>> and your scalability tests should trigger next backtrace right away.
>> Yes, however, I didn't run into it if mmap_sem is acquired earlier.
>>
>> How about defining a killable version, like
>> __access_remote_vm_killable() which use down_read_killable(), then the
>> killable version can be used by proc/*/cmdline? There might be other
>> users in the future.
> It would be a disaster as interfaces multiply.

Might be not that bad. Just need add:

__access_remote_vm_killable()
access_remote_vm_killable()

Then access_process_vm() keep using __access_remote_vm(). And, use 
access_remote_vm_killable() in fs/proc/base. And, it looks the 
access_process_vm() calls in get_cmdline() can be changed to 
access_remote_vm() (non killable version).

Yang
