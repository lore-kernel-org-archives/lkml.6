Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeBZUAQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:00:16 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:38983 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbeBZUAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:00:15 -0500
Subject: Re: [PATCH 06/21] powerpc: Avoid comparison of unsigned long >= 0 in
 __access_ok
To: Mathieu Malaterre <malat@debian.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-7-malat@debian.org>
 <8862c1e1-d161-3410-1b2a-502ad06cef57@c-s.fr>
 <6cba215c-127e-f3eb-b525-773b6aed0eb7@c-s.fr>
 <CA+7wUswNE1ydgeESpG8Dqtz4SGFjZZJJiPp+SHN8Z1qtBtPLLQ@mail.gmail.com>
 <CA+7wUsx047shRJ92PJ+cvg24HNhMnYzM0t5zUdEOaSE00sXkSg@mail.gmail.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <4ddba8bc-b1e5-24a0-602e-672e7b51b203@c-s.fr>
Date: Mon, 26 Feb 2018 21:00:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUsx047shRJ92PJ+cvg24HNhMnYzM0t5zUdEOaSE00sXkSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/02/2018 à 18:50, Mathieu Malaterre a écrit :
> On Mon, Feb 26, 2018 at 8:44 AM, Mathieu Malaterre <malat@debian.org> wrote:
>> On Mon, Feb 26, 2018 at 7:50 AM, Christophe LEROY
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>>
>>> Le 26/02/2018 à 07:34, Christophe LEROY a écrit :
>>>>
>>>>
>>>>
>>>> Le 25/02/2018 à 18:22, Mathieu Malaterre a écrit :
>>>>>
>>>>> Rewrite check size - 1 <= Y as size < Y since `size` is unsigned value.
>>>>> Fix warning (treated as error in W=1):
>>>>>
>>>>>     CC      arch/powerpc/kernel/signal_32.o
>>>>> In file included from ./include/linux/uaccess.h:14:0,
>>>>>                    from ./include/asm-generic/termios-base.h:8,
>>>>>                    from ./arch/powerpc/include/asm/termios.h:20,
>>>>>                    from ./include/uapi/linux/termios.h:6,
>>>>>                    from ./include/linux/tty.h:7,
>>>>>                    from arch/powerpc/kernel/signal_32.c:36:
>>>>> ./include/asm-generic/termios-base.h: In function
>>>>> ‘user_termio_to_kernel_termios’:
>>>>> ./arch/powerpc/include/asm/uaccess.h:52:35: error: comparison of unsigned
>>>>> expression >= 0 is always true [-Werror=type-limits]
>>>>>      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
>>>>>                                      ^
>>>>> ./arch/powerpc/include/asm/uaccess.h:58:3: note: in expansion of macro
>>>>> ‘__access_ok’
>>>>>      __access_ok((__force unsigned long)(addr), (size), get_fs()))
>>>>>      ^~~~~~~~~~~
>>>>> ./arch/powerpc/include/asm/uaccess.h:262:6: note: in expansion of macro
>>>>> ‘access_ok’
>>>>>     if (access_ok(VERIFY_READ, __gu_addr, (size)))   \
>>>>>         ^~~~~~~~~
>>>>> ./arch/powerpc/include/asm/uaccess.h:80:2: note: in expansion of macro
>>>>> ‘__get_user_check’
>>>>>     __get_user_check((x), (ptr), sizeof(*(ptr)))
>>>>>     ^~~~~~~~~~~~~~~~
>>>>> ./include/asm-generic/termios-base.h:36:6: note: in expansion of macro
>>>>> ‘get_user’
>>>>>     if (get_user(termios->c_line, &termio->c_line) < 0)
>>>>>         ^~~~~~~~
>>>>> [...]
>>>>> cc1: all warnings being treated as errors
>>>>>
>>>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>>>> ---
>>>>>    arch/powerpc/include/asm/uaccess.h | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/powerpc/include/asm/uaccess.h
>>>>> b/arch/powerpc/include/asm/uaccess.h
>>>>> index 51bfeb8777f0..fadc406bd39d 100644
>>>>> --- a/arch/powerpc/include/asm/uaccess.h
>>>>> +++ b/arch/powerpc/include/asm/uaccess.h
>>>>> @@ -49,7 +49,7 @@
>>>>>    #define __access_ok(addr, size, segment)    \
>>>>>        (((addr) <= (segment).seg) &&        \
>>>>> -     (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
>>>>> +     (((size) == 0) || ((size) < ((segment).seg - (addr)))))
>>>>
>>>>
>>>> IIUC, ((2 - 1) <= 1) is the same as (2 < 1) ?????
>>>
>>
>> The whole series was pretty mediocre, but this one was actually pretty
>> destructive. Thanks for catching this.
>>
>>>
>>> Note that I already try to submit a fix for this warning 3 years ago
>>> (https://patchwork.ozlabs.org/patch/418075/) and it was rejected with the
>>> following comment:
> 
> Tested again today with gcc 6.3.0 and gcc is still producing the
> original warning (treated as error).

That's right, it seems that recent versions of gcc are not happy anymore 
with that change.

Maybe Segher has a suggestion for that one ?

> 
>>> Again, I don't think Linux enables this warning.  What did you do to
>>> produce this?  In any case, it's a bad warning that doesn't take macros
>>> into account, and the answer is not to make the code less clear by hiding
>>> the fact that zero is a special case.
>>
>> Right. I'll try to see how to make W=1 run without error with an
>> alternate solution.
> 
> So the other alternative is to update a bunch of ppc32 defconfig(s)
> with: CONFIG_PPC_DISABLE_WERROR=y.
> 
> Would that be preferable ?

No I don't think it is the solution. PPC is built with WERROR in order 
to catch warnings on real problems.
You could disable it selectively when you want to run 'make W=1' and see 
all possible warnings, then select by yourself which warnings are worth 
fixing up.

Christophe

> 
>>> Christophe
>>>
>>>
>>>>
>>>> Christophe
>>>>
>>>>>    #endif
>>>>>
>>>

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
