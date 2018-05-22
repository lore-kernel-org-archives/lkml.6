Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeEVMMU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:12:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33304 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751441AbeEVMMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:12:06 -0400
Subject: Re: [PATCH 27/33] sched/debug: use match_string() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-28-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VcTpAkMeKa0YXpp91WooVPs5X7jPGk0w2ruitp4siKLVw@mail.gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <8a7108ce-a109-a1b5-ace7-38a189d2352d@huawei.com>
Date: Tue, 22 May 2018 20:10:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcTpAkMeKa0YXpp91WooVPs5X7jPGk0w2ruitp4siKLVw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2018/5/22 6:13, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used intead of open coded variant.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>>  kernel/sched/debug.c | 20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 15b10e2..9e34499 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -111,16 +111,14 @@ static int sched_feat_set(char *cmp)
>>                 cmp += 3;
>>         }
>>
>> -       for (i = 0; i < __SCHED_FEAT_NR; i++) {
>> -               if (strcmp(cmp, sched_feat_names[i]) == 0) {
>> -                       if (neg) {
>> -                               sysctl_sched_features &= ~(1UL << i);
>> -                               sched_feat_disable(i);
>> -                       } else {
>> -                               sysctl_sched_features |= (1UL << i);
>> -                               sched_feat_enable(i);
>> -                       }
>> -                       break;
>> +       i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);
> 
>> +       if (i >= 0) {
> 
> Why not
> 
> if (i < 0)
>  return i;

if i >=0 it will also return i. so need return i just if (i < 0), right ?

> 
> ?
> 
>> +               if (neg) {
>> +                       sysctl_sched_features &= ~(1UL << i);
>> +                       sched_feat_disable(i);
>> +               } else {
>> +                       sysctl_sched_features |= (1UL << i);
>> +                       sched_feat_enable(i);
>>                 }
>>         }
>>
>> @@ -150,7 +148,7 @@ static int sched_feat_set(char *cmp)
>>         inode_lock(inode);
>>         i = sched_feat_set(cmp);
>>         inode_unlock(inode);
> 
>> -       if (i == __SCHED_FEAT_NR)
>> +       if (i < 0)
>>                 return -EINVAL;
> 
> Now it would be
> 
> if (i < 0)
>  return i;

Right, will change it in next version

Thanks
Yisheng Xie
> 
