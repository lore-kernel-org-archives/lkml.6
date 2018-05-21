Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeEUBjS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 21:39:18 -0400
Received: from gateway20.websitewelcome.com ([192.185.54.2]:20874 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751514AbeEUBjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 21:39:16 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH] kernel: sys: fix potential Spectre v1
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180515030038.GA11822@embeddedor.com>
 <20180515150859.1bccbd8d4543848b30fea859@linux-foundation.org>
 <alpine.DEB.2.21.1805160027260.1605@nanos.tec.linutronix.de>
 <CAPcyv4iksLzZ=eMjWw6Wi87F2OSXHd16gKRLExgGhx=Mdr+AwQ@mail.gmail.com>
 <50481b83-4c03-f354-bd11-cef7aecdd85f@embeddedor.com>
 <b5e5e160-6ac7-87c8-af1a-4eb88f1f020d@embeddedor.com>
 <CAPcyv4iO67AG5ytc7gRBTnu6V8bdTOMb9eBwjGJtkGpMLKkpwg@mail.gmail.com>
 <3d2e5771-c2c9-6e45-3e85-21c0bc86876e@embeddedor.com>
Message-ID: <58df7ae3-8ef0-4f42-9ab2-b551d2ffff00@embeddedor.com>
Date: Sun, 20 May 2018 19:50:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3d2e5771-c2c9-6e45-3e85-21c0bc86876e@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fKZ1r-002Q9l-Hu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.192.46.223]:38158
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/18/2018 03:44 PM, Gustavo A. R. Silva wrote:
>>>
>>> #ifndef sanitize_index_nospec
>>> inline bool sanitize_index_nospec(unsigned long *index,
>>>                                    unsigned long size)
>>> {
>>>          if (*index >= size)
>>>                  return false;
>>>          *index = array_index_nospec(*index, size);
>>>
>>>          return true;
>>> }
>>> #endif
>>
>> I think this is fine in concept, we already do something similar in
>> mpls_label_ok(). Perhaps call it validate_index_nospec() since
>> validation is something that can fail, but sanitization in theory is
>> something that can always succeed.
>>
> 
> OK. I got it.
> 
>> However, the problem is the data type of the index. I expect you would
>> need to do this in a macro and use typeof() if you wanted this to be
>> generally useful, and also watch out for multiple usage of a macro
>> argument. Is it still worth it at that point?
>>
> 
> Yeah. I think it is worth it. I'll work on this during the weekend and 
> send a proper patch for review.
> 

Dan,

What do you think about this first draft:

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index e791ebc..6154183 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -55,4 +55,16 @@ static inline unsigned long 
array_index_mask_nospec(unsigned long index,
                                                                        \
         (typeof(_i)) (_i & _mask);                                     \
  })
+
+#define validate_index_nospec(index, size)                            \
+({                                                                    \
+       typeof(index) *ptr = &(index);                                 \
+       typeof(size) _s = (size);                                      \
+                                                                      \
+       BUILD_BUG_ON(sizeof(*ptr) > sizeof(long));                     \
+       BUILD_BUG_ON(sizeof(_s) > sizeof(long));                       \
+                                                                      \
+       *ptr >= _s ? false :                                           \
+       (*ptr = array_index_nospec(*ptr, _s) ? true : true);           \
+})
  #endif /* _LINUX_NOSPEC_H */

Thanks
--
Gustavo
