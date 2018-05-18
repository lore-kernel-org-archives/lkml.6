Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeERWL7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:11:59 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.133]:17866 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750763AbeERWLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:11:54 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH] kernel: sys: fix potential Spectre v1
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
 <f6be31b7-a6f8-3d7f-f621-09490a1b0489@embeddedor.com>
 <CAPcyv4husQPy601-JKpud7C3YZFcxk4BAJJhcztu_yOeC=7U-w@mail.gmail.com>
 <c22b86a0-5d35-72af-679d-0d237d386a32@embeddedor.com>
 <CAPcyv4hG_ue7WPWZHzQmKXpZD-ZCovXOUHurVa59-Zs6bdBe=w@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <9521b7db-0ff5-21db-f744-b818cd640783@embeddedor.com>
Date: Fri, 18 May 2018 17:11:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hG_ue7WPWZHzQmKXpZD-ZCovXOUHurVa59-Zs6bdBe=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.252.93
X-Source-L: No
X-Exim-ID: 1fJnbN-002Pz0-RC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-93.static.axtel.net ([192.168.15.106]) [187.162.252.93]:51246
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/18/2018 05:08 PM, Dan Williams wrote:
>>
>> Oh I see now. Just to double check, then something like the following would
>> be broken too, because is basically the same as the code above, and well, it
>> doesn't make much sense to store the value returned by macro
>> array_index_nospec into x, correct?:
> 
> Correct, broken:
> 
>>
>> bool foo(int x)
>> {
>>          if(x >= MAX)
>>                  return false;
> 
> Under speculation we may not return here when x is greater than max.
> 
>>          x = array_index_nospec(x, MAX);
> 
> x is now sanitized under speculation to zero, but the compiler would
> likely just throw this away because nothing consumes it.
> 
>>          return true;
>> }
>>
>> int vulnerable(int x)
>> {
>>          if(!foo(x))
>>                  return -1;
> 
> cpu might speculate that this branch is not taken...
> 
>>
>>          temp = array[x];
> 
> ...so x had better be bounded here, otherwise Spectre.
> 

I got it.

I appreciate the feedback.

Thanks, Dan.
--
Gustavo
