Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeBUFVz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:21:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:10356 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeBUFVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:21:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,542,1511856000";
   d="scan'208";a="29505645"
Subject: Re: [PATCH ipmi/kcs_bmc v2] ipmi: kcs_bmc: make the code be more
 clean
To: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1519055731-18923-1-git-send-email-haiyue.wang@linux.intel.com>
 <9b5afddc-1c28-d5cf-d7ee-71a389592073@acm.org>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <f9d06554-e15c-d163-6d5c-729ba4551fbd@linux.intel.com>
Date: Wed, 21 Feb 2018 13:21:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9b5afddc-1c28-d5cf-d7ee-71a389592073@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-02-20 21:29, Corey Minyard wrote:
> On 02/19/2018 09:55 AM, Haiyue Wang wrote:
>> ---
> When you use ---, it means everything following is not in the commit 
> text,
> including your signature.
>
Got it.
>> v1 -> v2:
>
> Do you want me to fold this into the previous patch?  That's generally
> not how things work, a new patch is fine for this, with a list of things
> done like below.
>
I will submit a new patch.
> One comment inline below...
>
>>
>> Add 'SPDX-License-Identifier' style for header files modification.
>> ---
>>
>> 1. Add the missed key word '__user' for read / write.
>> 2. Remove the prefix 'file' of 'file_to_kcs_bmc', no need this
>> duplicated word as its parameter has 'struct file *filp'.
>> 3. Change the 'unsigned int' to '__poll_t' to meet the new 'poll'
>> definition.
>> 4. Correct the 'SPDX-License-Identifier' style for header files.
>>
>> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> ---
>>   drivers/char/ipmi/kcs_bmc.c        | 32 
>> +++++++++++++++++---------------
>>   drivers/char/ipmi/kcs_bmc.h        |  6 ++++--
>>   drivers/char/ipmi/kcs_bmc_aspeed.c |  4 +++-
>>   include/uapi/linux/ipmi_bmc.h      |  6 ++++--
>>   4 files changed, 28 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
>> index 6476bfb..fbfc05e 100644
>> --- a/drivers/char/ipmi/kcs_bmc.c
>> +++ b/drivers/char/ipmi/kcs_bmc.c
>> @@ -1,5 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>> -// Copyright (c) 2015-2018, Intel Corporation.
>> +/*
>> + * Copyright (c) 2015-2018, Intel Corporation.
>> + */
>>     #define pr_fmt(fmt) "kcs-bmc: " fmt
>>   @@ -242,14 +244,14 @@ int kcs_bmc_handle_event(struct kcs_bmc 
>> *kcs_bmc)
>>   }
>>   EXPORT_SYMBOL(kcs_bmc_handle_event);
>>   -static inline struct kcs_bmc *file_to_kcs_bmc(struct file *filp)
>> +static inline struct kcs_bmc *to_kcs_bmc(struct file *filp)
>>   {
>>       return container_of(filp->private_data, struct kcs_bmc, miscdev);
>>   }
>>     static int kcs_bmc_open(struct inode *inode, struct file *filp)
>>   {
>> -    struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
>> +    struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>>       int ret = 0;
>>         spin_lock_irq(&kcs_bmc->lock);
>> @@ -262,25 +264,25 @@ static int kcs_bmc_open(struct inode *inode, 
>> struct file *filp)
>>       return ret;
>>   }
>>   -static unsigned int kcs_bmc_poll(struct file *filp, poll_table *wait)
>> +static __poll_t kcs_bmc_poll(struct file *filp, poll_table *wait)
>>   {
>> -    struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
>> -    unsigned int mask = 0;
>> +    struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>> +    __poll_t mask = 0;
>>         poll_wait(filp, &kcs_bmc->queue, wait);
>>         spin_lock_irq(&kcs_bmc->lock);
>>       if (kcs_bmc->data_in_avail)
>> -        mask |= POLLIN;
>> +        mask |= EPOLLIN;
>
> I get this:
>
>   CC [M]  drivers/char/ipmi/kcs_bmc.o
> ../drivers/char/ipmi/kcs_bmc.c: In function ‘kcs_bmc_poll’:
> ../drivers/char/ipmi/kcs_bmc.c:276:11: error: ‘EPOLLIN’ undeclared 
> (first use in this function)
>    mask |= EPOLLIN;
>            ^
> ../drivers/char/ipmi/kcs_bmc.c:276:11: note: each undeclared 
> identifier is reported only once for each function it appears in
>
> probably need to include linux/eventpoll.h
>
I forgot to tell you that you need update the git tree, it is merged in 
from 'Linux 4.16-rc1'. Like bt-bmc.c. :)

git log -p drivers/char/ipmi/bt-bmc.c
commit a9a08845e9acbd224e4ee466f5c1275ed50054e8
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Feb 11 14:34:03 2018 -0800

     vfs: do bulk POLL* -> EPOLL* replacement

     This is the mindless scripted replacement of kernel use of POLL*
     variables as described by Al, done by this script:

         for V in IN OUT PRI ERR RDNORM RDBAND WRNORM WRBAND HUP RDHUP 
NVAL MSG; do
             L=`git grep -l -w POLL$V | grep -v '^t' | grep -v /um/ | 
grep -v '^sa' | grep -v '/poll.h$'|grep -v '^D'`
             for f in $L; do sed -i 
"-es/^\([^\"]*\)\(\<POLL$V\>\)/\\1E\\2/" $f; done
         done

     with de-mangling cleanups yet to come.

     NOTE! On almost all architectures, the EPOLL* constants have the same
     values as the POLL* constants do.  But they keyword here is "almost".
     For various bad reasons they aren't the same, and epoll() doesn't
     actually work quite correctly in some cases due to this on Sparc et al.

     The next patch from Al will sort out the final differences, and we
     should be all done.

     Scripted-by: Al Viro <viro@zeniv.linux.org.uk>
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index 7992c87..c95b93b 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -349,10 +349,10 @@ static __poll_t bt_bmc_poll(struct file *file, 
poll_table *wait)
         ctrl = bt_inb(bt_bmc, BT_CTRL);

         if (ctrl & BT_CTRL_H2B_ATN)
-               mask |= POLLIN;
+               mask |= EPOLLIN;

         if (!(ctrl & (BT_CTRL_H_BUSY | BT_CTRL_B2H_ATN)))
-               mask |= POLLOUT;
+               mask |= EPOLLOUT;

         return mask;

> -corey
>
>> spin_unlock_irq(&kcs_bmc->lock);
>>         return mask;
>>   }
>>   -static ssize_t kcs_bmc_read(struct file *filp, char *buf,
>> -                size_t count, loff_t *offset)
>> +static ssize_t kcs_bmc_read(struct file *filp, char __user *buf,
>> +                size_t count, loff_t *ppos)
>>   {
>> -    struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
>> +    struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>>       bool data_avail;
>>       size_t data_len;
>>       ssize_t ret;
>> @@ -339,10 +341,10 @@ static ssize_t kcs_bmc_read(struct file *filp, 
>> char *buf,
>>       return ret;
>>   }
>>   -static ssize_t kcs_bmc_write(struct file *filp, const char *buf,
>> -                 size_t count, loff_t *offset)
>> +static ssize_t kcs_bmc_write(struct file *filp, const char __user *buf,
>> +                 size_t count, loff_t *ppos)
>>   {
>> -    struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
>> +    struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>>       ssize_t ret;
>>         /* a minimum response size '3' : netfn + cmd + ccode */
>> @@ -378,7 +380,7 @@ static ssize_t kcs_bmc_write(struct file *filp, 
>> const char *buf,
>>   static long kcs_bmc_ioctl(struct file *filp, unsigned int cmd,
>>                 unsigned long arg)
>>   {
>> -    struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
>> +    struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>>       long ret = 0;
>>         spin_lock_irq(&kcs_bmc->lock);
>> @@ -410,7 +412,7 @@ static long kcs_bmc_ioctl(struct file *filp, 
>> unsigned int cmd,
>>     static int kcs_bmc_release(struct inode *inode, struct file *filp)
>>   {
>> -    struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
>> +    struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
>>         spin_lock_irq(&kcs_bmc->lock);
>>       kcs_bmc->running = 0;
>> diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
>> index c19501d..69d9a70 100644
>> --- a/drivers/char/ipmi/kcs_bmc.h
>> +++ b/drivers/char/ipmi/kcs_bmc.h
>> @@ -1,5 +1,7 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -// Copyright (c) 2015-2018, Intel Corporation.
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2015-2018, Intel Corporation.
>> + */
>>     #ifndef __KCS_BMC_H__
>>   #define __KCS_BMC_H__
>> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c 
>> b/drivers/char/ipmi/kcs_bmc_aspeed.c
>> index 0c4d1a3..dba6075 100644
>> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
>> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
>> @@ -1,5 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>> -// Copyright (c) 2015-2018, Intel Corporation.
>> +/*
>> + * Copyright (c) 2015-2018, Intel Corporation.
>> + */
>>     #define pr_fmt(fmt) "aspeed-kcs-bmc: " fmt
>>   diff --git a/include/uapi/linux/ipmi_bmc.h 
>> b/include/uapi/linux/ipmi_bmc.h
>> index 2f9f97e..d3efacd 100644
>> --- a/include/uapi/linux/ipmi_bmc.h
>> +++ b/include/uapi/linux/ipmi_bmc.h
>> @@ -1,5 +1,7 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -// Copyright (c) 2015-2018, Intel Corporation.
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2015-2018, Intel Corporation.
>> + */
>>     #ifndef _UAPI_LINUX_IPMI_BMC_H
>>   #define _UAPI_LINUX_IPMI_BMC_H
>
>
