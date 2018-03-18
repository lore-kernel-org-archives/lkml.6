Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeCRDt2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 23:49:28 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38365 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbeCRDt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 23:49:26 -0400
X-Google-Smtp-Source: AG47ELs4sUBQO63wzsEWC53QwtKF5VDXfnCGYEQJW4uxwrTkkdViDDhFZ5p6v754XrElR/hXnRyQVjlubHlMOpd+iE0=
MIME-Version: 1.0
In-Reply-To: <CALyZvKz8f=uKMWGQwE-H7nOQzpS81adVdy8Ava=EPkj0LGFLHA@mail.gmail.com>
References: <1521296974-12142-1-git-send-email-jason.vas.dias@gmail.com>
 <1521296974-12142-3-git-send-email-jason.vas.dias@gmail.com>
 <20180317230020.ensccrtuajqgxsxa@two.firstfloor.org> <CALyZvKz8f=uKMWGQwE-H7nOQzpS81adVdy8Ava=EPkj0LGFLHA@mail.gmail.com>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Sun, 18 Mar 2018 03:49:24 +0000
Message-ID: <CALyZvKzR6xUMCCS9duV2VLgbHrTMQaPnFjA1dB1oUX2O6XF=XQ@mail.gmail.com>
Subject: Re: [PATCH v4.16-rc5 2/2] x86/vdso: VDSO should handle
 clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
To: Andi Kleen <andi@firstfloor.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mingo@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2018, Jason Vas Dias <jason.vas.dias@gmail.com> wrote:
(should have CC'ed to list, sorry)
> On 17/03/2018, Andi Kleen <andi@firstfloor.org> wrote:
>>
>> That's quite a mischaracterization of the issue. gcc works as intended,
>> but the kernel did not correctly supply a indirect call retpoline thunk
>> to the vdso, and it just happened to work by accident with the old
>> vdso.
>>
>>>
>>>          The automated test builds should now succeed with this patch.
>>
>> How about just adding the thunk function to the vdso object instead of
>> this cheap hack?
>>
>> The other option would be to build vdso with inline thunks.
>>
>> But just disabling is completely the wrong action.
>>
>> -Andi
>>
>
> Aha! Thanks for the clarification , Andi!
>
> I will do so and resend the 2nd patch.
>
> But is everyone agreed we should accept any slowdown for the timer
> functions ? I personally don't think it is a good idea, but I will
> regenerate the patch with the thunk function and without
> the Makefile change.
>
> Thanks & Best Regards,
> Jason
>


I am wondering if it is not better to avoid the thunk being generated
and remove the Makefile patch ?

I know that changing the switch in __vdso_clock_gettime() like
this avoids the thunk :

       switch(clock) {
       case CLOCK_MONOTONIC:
 		if (do_monotonic(ts) == VCLOCK_NONE)
			goto fallback;
		break;
        default:
          	switch (clock) {
	        case CLOCK_REALTIME:
		        if (do_realtime(ts) == VCLOCK_NONE)
			       goto fallback;
		        break;
	         case CLOCK_MONOTONIC_RAW:
		         if (do_monotonic_raw(ts) == VCLOCK_NONE)
			           goto fallback;
		         break;
	         case CLOCK_REALTIME_COARSE:
		         do_realtime_coarse(ts);
		         break;
	         case CLOCK_MONOTONIC_COARSE:
		         do_monotonic_coarse(ts);
		         break;
	         default:
		        goto fallback;
     }
     return 0;
     fallback: ...
}


So at the cost of an unnecessary extra test of the clock parameter,
the thunk is avoided .

I wonder if the whole switch should be changed to an if / else clause ?

Or, I know this might be unorthodox, but might work :
        #define _CAT(V1,V2) V1##V2
        #define GTOD_CLK_LABEL(CLK) _CAT(_VCG_L_,CLK)
        #define  MAX_CLK 16
                                        //^^ ??
         __vdso_clock_gettime(  ... ) { ...
                 static const void *clklbl_tab[MAX_CLK]
                 ={ [ CLOCK_MONOTONIC ]
                      =   &&GTOD_CLK_LABEL(CLOCK_MONOTONIC) ,
                     [ CLOCK_MONOTONIC_RAW ]
                      =   &&GTOD_CLK_LABEL(CLOCK_MONOTONIC_RAW) ,
                    // and similarly for all clocks handled ...
                    };

                   goto clklbl_tab[ clock & 0xf ] ;

                   GTOD_CLK_LABEL(CLOCK_MONOTONIC) :
                            if ( do_monotonic(ts) == VCLOCK_NONE )
                                          goto fallback ;

                   GTOD_CLK_LABEL(CLOCK_MONOTONIC_RAW) :
                            if ( do_monotonic_raw(ts) == VCLOCK_NONE )
                                          goto fallback ;

                     ... // similarly for all clocks

                    fallback:
                         return vdso_fallback_gettime(clock,ts);
}


If a restructuring like that might be acceptable (with correct tab-based
formatting) , and the VDSO can have such a table in its .BSS ,  I think it
would avoid the thunk, and have the advantage of
precomputing the jump table at compile-time, and would not require any
indirect branches, I think.

Any thoughts ?

Thanks & Best regards,
Jason




          ;

         G
