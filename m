Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeFDT2t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:28:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52938 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeFDT2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:28:48 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="176491398"
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <albert@sifive.com>
References: <20180601152123.47256-1-luc.vanoostenryck@gmail.com>
 <20180601152123.47256-4-luc.vanoostenryck@gmail.com>
 <235fec3e-be2e-874a-8313-e7390fcdca74@wdc.com>
 <20180604190927.7jrdlulgowt5umce@ltop.local>
From: Atish Patra <atish.patra@wdc.com>
Message-ID: <6a0ab99d-6e4d-eb80-bc4d-854d154ae827@wdc.com>
Date: Mon, 4 Jun 2018 12:28:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604190927.7jrdlulgowt5umce@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/18 12:09 PM, Luc Van Oostenryck wrote:
> On Mon, Jun 04, 2018 at 11:46:50AM -0700, Atish Patra wrote:
>> On 6/1/18 8:22 AM, Luc Van Oostenryck wrote:
>>> __copy_user() is a function, written in assembly, used to copy
>>> memory between kernel & user space. As such its to & from args
>>> may both take a user pointer or a kernel pointer.
>>>
>>> However the prototype for this function declare these two args
>>> as 'void __user *', which is no more & no less correct than
>>> declaring them as 'void *'. In fact theer is no possible correct
>>
>> /s/theer/there
>>
>>> annotation for such a function.
>>>
>>> The problem is worked around here by declaring these args as
>>> unsigned long and casting them to the right type in each of
>>> two callers raw_copy_{to,from}_user() as some kind of cast would
>>> be needed anyway.
>>>
>>> Note: another solution, maybe cleaner but slightly more complex,
>>>         would be to declare two version of __copy_user,
>>>         either in the asm file or via an alias, each having already
>>>         the correct typing for raw_copy_{to,from}_user().
>>>
>>
>> I feel that would be a better solution as it is implemented similarly
>> in ARM as well.
>>
>> I am unable to understand how "unsigned long" is better than "void*".
>> x86 implementation has both arguments as void*. Can you please clarify ?
> 
> "better" is quite relative and it must be understood that sparse
> allow to cast pointers o fany kinds to and from unsigned long
> without any warnings (while doing a cast between different address
> space will emit a warning unless you use '__force').
> 

Got it.
> As I tried to explain here above, the fact that this function is
> declared as taking 2 __user pointers requires to use of casts
> (ugly casts with __force) to get over the __user. By declaring
> them as taking unsigned long, you still have to use casts but, IMO,
> it's cleaner
> 

Thanks for the detailed explanation.

> Note: they're generic pointers/addresses anyway, they can't be
>        dereferenced anyway so unsigned is as good as a plain void*
>        or a void __user*
> Note: using unsigned long here, fundamentally to bypass the __user,
>        is the same as casting a const pointer back to a plain pointer
>        via an intermediate cast to unsigned long. People can argue
>        that's kinda cheating, and they would be right of course, but
>        using __force or declaring twice the function with two different
>        names and prototype is also a form of cheating.
> Note: if this would be my code, I would choose the solution with
>        two declarations.

I prefer that as well.

Regards,
Atish
> 
> 
> Best regards,
> -- Luc
> 
