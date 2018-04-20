Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbeDTGoY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 02:44:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeDTGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 02:44:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Apr 2018 14:44:20 +0800
From: yuankuiz@codeaurora.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm-owner@vger.kernel.org, akpm@linux-foundation.org,
        joe@perches.com
Subject: Re: [PATCH] time: tick-sched: use bool for tick_stopped
In-Reply-To: <aaa5ae49ff33ce9c83c6cf520cc83c0b@codeaurora.org>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
 <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
 <f253686d26b3470f0e9b60502eb62315@codeaurora.org>
 <alpine.DEB.2.21.1804101110080.2058@nanos.tec.linutronix.de>
 <a7d6dddd7d4f9fdc0be8f94251af237f@codeaurora.org>
 <alpine.DEB.2.21.1804101242110.2058@nanos.tec.linutronix.de>
 <2f7755fae34bb65ef0a4b5a11c67f431@codeaurora.org>
 <c3e05a4aad4895046401519dc83fa623@codeaurora.org>
 <a98928c4a1ee719aba5f00932a41a2c3@codeaurora.org>
 <c08f28e5c0461384c8d9a9d2d8b04799@codeaurora.org>
 <aaa5ae49ff33ce9c83c6cf520cc83c0b@codeaurora.org>
Message-ID: <41aec3337f05316de118357fcbd9d175@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-20 09:47 AM, yuankuiz@codeaurora.org wrote:
> On 2018-04-11 07:20 AM, yuankuiz@codeaurora.org wrote:
>> ++
>> On 2018-04-11 07:09 AM, yuankuiz@codeaurora.org wrote:
>>> ++
>>> 
>>> On 2018-04-10 10:49 PM, yuankuiz@codeaurora.org wrote:
>>>> Typo...
>>>> 
>>>> On 2018-04-10 10:08 PM, yuankuiz@codeaurora.org wrote:
>>>>> On 2018-04-10 07:06 PM, Thomas Gleixner wrote:
>>>>>> On Tue, 10 Apr 2018, yuankuiz@codeaurora.org wrote:
>>>>>>> On 2018-04-10 05:10 PM, Thomas Gleixner wrote:
>>>>>>> > On Tue, 10 Apr 2018, yuankuiz@codeaurora.org wrote:
>>>>>>> > > On 2018-04-10 04:00 PM, Rafael J. Wysocki wrote:
>>>>>>> > > > On Tue, Apr 10, 2018 at 9:33 AM,  <yuankuiz@codeaurora.org> wrote:
>>>>>>> > > > > From: John Zhao <yuankuiz@codeaurora.org>
>>>>>>> > > > >
>>>>>>> > > > > Variable tick_stopped returned by tick_nohz_tick_stopped
>>>>>>> > > > > can have only true / false values. Since the return type
>>>>>>> > > > > of the tick_nohz_tick_stopped is also bool, variable
>>>>>>> > > > > tick_stopped nice to have data type as bool in place of unsigned int.
>>>>>>> > > > > Moreover, the executed instructions cost could be minimal
>>>>>>> > > > > without potiential data type conversion.
>>>>>>> > > > >
>>>>>>> > > > > Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
>>>>>>> > > > > ---
>>>>>>> > > > >  kernel/time/tick-sched.h | 2 +-
>>>>>>> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>> > > > >
>>>>>>> > > > > diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
>>>>>>> > > > > index 6de959a..4d34309 100644
>>>>>>> > > > > --- a/kernel/time/tick-sched.h
>>>>>>> > > > > +++ b/kernel/time/tick-sched.h
>>>>>>> > > > > @@ -48,8 +48,8 @@ struct tick_sched {
>>>>>>> > > > >         unsigned long                   check_clocks;
>>>>>>> > > > >         enum tick_nohz_mode             nohz_mode;
>>>>>>> > > > >
>>>>>>> > > > > +       bool                            tick_stopped    : 1;
>>>>>>> > > > >         unsigned int                    inidle          : 1;
>>>>>>> > > > > -       unsigned int                    tick_stopped    : 1;
>>>>>>> > > > >         unsigned int                    idle_active     : 1;
>>>>>>> > > > >         unsigned int                    do_timer_last   : 1;
>>>>>>> > > > >         unsigned int                    got_idle_tick   : 1;
>>>>>>> > > >
>>>>>>> > > > I don't think this is a good idea at all.
>>>>>>> > > >
>>>>>>> > > > Please see https://lkml.org/lkml/2017/11/21/384 for example.
>>>>>>> > > [ZJ] Thanks for this sharing. Looks like, this patch fall into the case of
>>>>>>> > > "Maybe".
>>>>>>> >
>>>>>>> > This patch falls into the case 'pointless' because it adds extra storage
>>>>>>> [ZJ] 1 bit vs 1 bit. no more.
>>>>>> 
>>>>>> Groan. No. Care to look at the data structure? You create a new 
>>>>>> storage,
>>>>> [ZJ] Say, {unsigned int, unsigned int, unsigned int, unsigned int,
>>>>> unsigned int} becomes
>>>>>           {bool        , unsigned int, unsigned int, unsigned int, 
>>>>> unsigned int}
>>>>> As specified by the rule No.10 at the section 6.7.2.1 of C99 TC2 
>>>>> as:
>>>>> "If enough space remains, a bit-field that immediately follows 
>>>>> another
>>>>> bit-field in a
>>>>> structure shall be packed into adjacent bits of the same unit." 
>>>>> What
>>>>> is the new storage so far?
> [ZJ] Further prototyping has been given based on gcc for both of
> x86_64 and armv8-a,
>      unsigned int and bool share the same 1 bytes without the
> addtional storage for sure.
>      Open this and welcome if any other difference behaviour could be 
> captured.
[ZJ] Typo.. change 4 bytes above to 1 byte actually.
>>>>> 
>>>>>> which is incidentally merged into the other bitfield by the 
>>>>>> compiler at a
>>>>>> different bit position, but there is no guarantee that a compiler 
>>>>>> does
>>>>>> that. It's free to use distinct storage for that bool based bit.
>>>>> [ZJ] Per the rule No.10 at section 6.7.2.1 of C99 TC2 as:
>>>>> " If insufficient space remains, whether  a  bit-field  that  does
>>>>> not  fit  is  put  into
>>>>> the  next  unit  or overlaps  adjacent  units  is 
>>>>> implementation-defined."
>>>>> So, implementation is never mind which type will be stored if any.
>>>>> 
>>>>>> >> > for no benefit at all.
>>>>>>> [ZJ] tick_stopped is returned by the tick_nohz_tick_stopped() 
>>>>>>> which is bool.
>>>>>>> The benefit is no any potiential type conversion could be minded.
>>>>>> 
>>>>>> A bit stays a bit. 'bool foo : 1;' or 'unsigned int foo : 1' has 
>>>>>> to be
>>>>>> evaluated as a bit. So there is a type conversion from BIT to bool 
>>>>>> required
>>>>>> because BIT != bool.
>>>>> [ZJ] Per the rule No.9 at section 6.7.2.1 of C99 TC2 as:
>>>>> "If  the  value  0  or  1  is  stored  into  a  nonzero-width
>>>>> bit-field  of  types
>>>>> _Bool, the value of the bit-field shall compare equal to the value 
>>>>> stored."
>>>>> Obviously, it is nothing related to type conversion actually.
>>>>>> 
>>>>>> By chance the evaluation can be done by evaluating the byte in 
>>>>>> which the
>>>>>> bit is placed just because the compiler knows that the remaining 
>>>>>> bits are
>>>>>> not used. There is no guarantee that this is done, it happens to 
>>>>>> be true
>>>>>> for a particular compiler.
>>>>> [ZJ] Actually, such as GCC owe that kind of guarantee to be 
>>>>> promised by ABI.
[ZJ] "-mone-byte-bool" could be used by alpha-linux-gcc to override the 
default bool size
      to become 1 byte for even Darwin / powerPC from it's manual.
>>>>>> 
>>>>>> But that does not make it any more interesting. It just makes the 
>>>>>> code
>>>>>> harder to read and eventually leads to bigger storage.
>>>>> [ZJ] To get the benctifit to be profiled, it is given as:
>>>>> number of instructions of function tick_nohz_tick_stopped():
>>>> [ZJ] Here, I used is not the tick_nohz_tick_stopped(), but an 
>>>> evaluation() as:
>>>> #include <stdio.h>
>>>> #include <stdbool.h>
>>>> 
>>>> struct tick_sched {
>>>>         unsigned int inidle             : 1;
>>>>         unsigned int tick_stopped       : 1;
>>>> };
>>>> 
>>>> bool get_status()
>>>> {
>>>>         struct tick_sched *ts;
>>>>         ts->tick_stopped = 1;
>>>>         return ts->tick_stopped;
>>>> }
>>>> 
>>>> int main()
>>>> {
>>>>         if (get_status()) return 0;
>>>>         return 0;
>>>> }
>>>> 
>>>> [ZJ] Toggle the declaration of tick_stopped in side of the 
>>>> tick_sched
>>>> structure for comparison.
>>>> 
>>>> 
>>>>>                         original: 17
>>>>>                         patched:  14
>>>>>      Which was saved is:
>>>>>                movzbl	%al, %eax
>>>>>                testl	%eax, %eax
>>>>>                setne    %al
>>>>>      Say, 3 / 17 = 17 % could be gained in the instruction executed
>>>>> for this function can be evaluated.
>>>>> 
>>>>> Note:
>>>>>      The environment I used is:
>>>>>                OS : Ubuntu Desktop 16.04 LTS
>>>>>                gcc: 6.3.0                       (without 
>>>>> optimization
>>>>> for in general purpose)
>>>>> 
>>>>>> 
>>>> 
>>>> Just FYI.
>>>> 
>>>> Thanks,
>>>> ZJ
