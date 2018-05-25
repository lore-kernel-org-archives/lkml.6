Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967706AbeEYSL7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:11:59 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.184]:19467 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967452AbeEYSL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:11:58 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH] kernel: sys: fix potential Spectre v1
To: Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <50481b83-4c03-f354-bd11-cef7aecdd85f@embeddedor.com>
 <b5e5e160-6ac7-87c8-af1a-4eb88f1f020d@embeddedor.com>
 <CAPcyv4iO67AG5ytc7gRBTnu6V8bdTOMb9eBwjGJtkGpMLKkpwg@mail.gmail.com>
 <3d2e5771-c2c9-6e45-3e85-21c0bc86876e@embeddedor.com>
 <58df7ae3-8ef0-4f42-9ab2-b551d2ffff00@embeddedor.com>
 <161a0513-1029-a76c-f967-1e606081599d@embeddedor.com>
 <CAPcyv4i6zOJZakNVW=y8NyUFB1EzOxBtoOGVhWCwysuTi6grvg@mail.gmail.com>
 <112349fb-837c-7b91-e256-a1c443710150@embeddedor.com>
 <20180523090840.GU12217@hirez.programming.kicks-ass.net>
 <20180523150737.ycuulapggtu3hpc3@lakrids.cambridge.arm.com>
 <20180523163118.x2n7odcu34tf6wax@lakrids.cambridge.arm.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <5684a277-464d-dbad-8e3a-d766e66626ec@embeddedor.com>
Date: Fri, 25 May 2018 13:11:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523163118.x2n7odcu34tf6wax@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fMHC1-003cFe-27
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.192.46.223]:55422
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/23/2018 11:31 AM, Mark Rutland wrote:
> On Wed, May 23, 2018 at 04:07:37PM +0100, Mark Rutland wrote:
>> I think that either way, we have a potential problem if the compiler
>> generates a branch dependent on the result of validate_index_nospec().
>>
>> In that case, we could end up with codegen approximating:
>>
>> 	bool safe = false;
>>
>> 	if (idx < bound) {
>> 		idx = array_index_nospec(idx, bound);
>> 		safe = true;
>> 	}
>>
>> 	// this branch can be mispredicted
>> 	if (safe) {
>> 		foo = array[idx];
>> 	}
>>
>> ... and thus we lose the nospec protection.
> 
> I see GCC do this at -O0, but so far I haven't tricked it into doing
> this at -O1 or above.
> 
> Regardless, I worry this is fragile -- GCC *can* generate code as per
> the above, even if it's unlikely to.
> 
>> I also suspect that compiler transformations mean that this might
>> already be the case for patterns like:
>>
>> 	if (idx < bound)  {
>> 		safe_idx = array_index_nospec(idx, bound)];
>> 		...
>> 		foo = array[safe_idx];
>> 	}
>>
>> ... if the compiler can transform that to something like:
>>
>> 	if (idx < bound) {
>> 		idx = array_index_nospec(idx, bound);
>> 	}
>>
>> 	// can be mispredicted
>> 	if (idx < bound) {
>> 		foo = array[idx];
>> 	}
>>
>> ... which I think a compiler might be capable of, depending on the rest
>> of the function body (e.g. if there's a common portion shared with the
>> else case).
>>
>> I'll see if I can trigger that in a test case. :/
> 
> No luck so far, but I'll keeep fighting...
> 
> GCC will happily pull a common suffix after the branch, e.g.
> 
> 	if (cond) {
> 		foo();
> 		bar();
> 	} else {
> 		bar();
> 	}
> 
> .. goes to:
> 
> 	if (cond)
> 		foo()
> 
> 	bar();
> 
> ... but I can't convince it to pull a common prefix before the branch.
> 
> Mark.
> 
I will send the following patch once Dan's [1] has been applied upstream.

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index e791ebc..2a1ab2e 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -55,4 +55,21 @@ static inline unsigned long 
array_index_mask_nospec(unsigned long index,
                                                                        \
         (typeof(_i)) (_i & _mask);                                     \
  })
+
+#define validate_index_nospec(index, size)                            \
+({                                                                    \
+       bool ret = false;                                              \
+       typeof(index) *ptr = &(index);                                 \
+       typeof(size) _s = (size);                                      \
+                                                                      \
+       BUILD_BUG_ON(sizeof(*ptr) > sizeof(long));                     \
+       BUILD_BUG_ON(sizeof(_s) > sizeof(long));                       \
+                                                                      \
+       if (*ptr < _s) {                                               \
+               *ptr = array_index_nospec(*ptr, _s);                   \
+               ret = true;                                            \
+       }                                                              \
+                                                                      \
+       ret;                                                           \
+})

[1] https://marc.info/?l=linux-kernel&m=152726947109104&w=2

Thank you, Dan, Peter and Mark for your feedback.
--
Gustavo
