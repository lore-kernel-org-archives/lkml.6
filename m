Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeERTES (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:04:18 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.124]:12058 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751049AbeERTEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:04:15 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH] kernel: sys: fix potential Spectre v1
To: Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180515030038.GA11822@embeddedor.com>
 <20180515150859.1bccbd8d4543848b30fea859@linux-foundation.org>
 <alpine.DEB.2.21.1805160027260.1605@nanos.tec.linutronix.de>
 <CAPcyv4iksLzZ=eMjWw6Wi87F2OSXHd16gKRLExgGhx=Mdr+AwQ@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <50481b83-4c03-f354-bd11-cef7aecdd85f@embeddedor.com>
Date: Fri, 18 May 2018 14:04:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iksLzZ=eMjWw6Wi87F2OSXHd16gKRLExgGhx=Mdr+AwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fJkfl-000ArE-Qe
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.172.56.86]:52704
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/15/2018 05:57 PM, Dan Williams wrote:
> On Tue, May 15, 2018 at 3:29 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Tue, 15 May 2018, Andrew Morton wrote:
>>> On Mon, 14 May 2018 22:00:38 -0500 "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>>>
>>>> resource can be controlled by user-space, hence leading to a
>>>> potential exploitation of the Spectre variant 1 vulnerability.
>>>>
>>>> This issue was detected with the help of Smatch:
>>>>
>>>> kernel/sys.c:1474 __do_compat_sys_old_getrlimit() warn: potential
>>>> spectre issue 'get_current()->signal->rlim' (local cap)
>>>> kernel/sys.c:1455 __do_sys_old_getrlimit() warn: potential spectre issue
>>>> 'get_current()->signal->rlim' (local cap)
>>>>
>>>> Fix this by sanitizing *resource* before using it to index
>>>> current->signal->rlim
>>>>
>>>> Notice that given that speculation windows are large, the policy is
>>>> to kill the speculation on the first load and not worry if it can be
>>>> completed with a dependent load/store [1].
>>>
>>> hm.  Not my area, but I'm always willing to learn ;)
>>>
>>>> --- a/kernel/sys.c
>>>> +++ b/kernel/sys.c
>>>> @@ -69,6 +69,9 @@
>>>>   #include <asm/io.h>
>>>>   #include <asm/unistd.h>
>>>>
>>>> +/* Hardening for Spectre-v1 */
>>>> +#include <linux/nospec.h>
>>>> +
>>>>   #include "uid16.h"
>>>>
>>>>   #ifndef SET_UNALIGN_CTL
>>>> @@ -1451,6 +1454,7 @@ SYSCALL_DEFINE2(old_getrlimit, unsigned int, resource,
>>>>      if (resource >= RLIM_NLIMITS)
>>>>              return -EINVAL;
>>>>
>>>> +   resource = array_index_nospec(resource, RLIM_NLIMITS);
>>>>      task_lock(current->group_leader);
>>>>      x = current->signal->rlim[resource];
>>>
>>> Can the speculation proceed past the task_lock()?  Or is the policy to
>>> ignore such happy happenstances even if they are available?
>>
>> Locks are not in the way of speculation. Speculation has almost no limits
>> except serializing instructions. At least they respect the magic AND
>> limitation in array_index_nospec().
> 
> I'd say it another way, because they don't respect the magic AND, we
> just make the result in the speculation path safe. So, it's controlled
> speculation.
> 

Dan,

What do you think about adding the following function to the nospec API:

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index e791ebc..81e9a77 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -55,4 +55,17 @@ static inline unsigned long 
array_index_mask_nospec(unsigned long index,
                                                                         \
         (typeof(_i)) (_i & _mask);                                      \
  })
+
+
+#ifndef sanitize_index_nospec
+inline bool sanitize_index_nospec(unsigned long index,
+                                 unsigned long size)
+{
+       if (index >= size)
+               return false;
+       index = array_index_nospec(index, size);
+
+       return true;
+}
+#endif
  #endif /* _LINUX_NOSPEC_H */


And here is an example of its use:

diff --git a/drivers/media/i2c/tvp7002.c b/drivers/media/i2c/tvp7002.c
index 4599b7e..27b39c0 100644
--- a/drivers/media/i2c/tvp7002.c
+++ b/drivers/media/i2c/tvp7002.c
@@ -35,6 +35,8 @@
  #include <media/v4l2-ctrls.h>
  #include <media/v4l2-fwnode.h>

+#include <linux/nospec.h>
+
  #include "tvp7002_reg.h"

  MODULE_DESCRIPTION("TI TVP7002 Video and Graphics Digitizer driver");
@@ -784,7 +786,7 @@ static int tvp7002_enum_dv_timings(struct 
v4l2_subdev *sd,
                 return -EINVAL;

         /* Check requested format index is within range */
-       if (timings->index >= NUM_TIMINGS)
+       if (!sanitize_index_nospec(timings->index, NUM_TIMINGS))
                 return -EINVAL;

         timings->timings = tvp7002_timings[timings->index].timings;

This patter is very common. So, it may be a good idea to unify both 
bounds checking and the serialization of instructions into a single 
function.

What do you think?

Thanks
--
Gustavo
