Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeBUWjE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 17:39:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50185 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeBUWjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 17:39:03 -0500
Date: Wed, 21 Feb 2018 14:38:44 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGXu5jLB9WXdaHg7ox85BftejyHUBHrUe7EpCLU08e5eRLstLQ@mail.gmail.com>
References: <5A8AF1F802000078001A91E1@prv-mh.provo.novell.com> <CAGXu5jLB9WXdaHg7ox85BftejyHUBHrUe7EpCLU08e5eRLstLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86/asm: improve how GEN_*_SUFFIXED_RMWcc() specify clobbers
To: Kees Cook <keescook@chromium.org>, Jan Beulich <JBeulich@suse.com>
CC: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
From: hpa@zytor.com
Message-ID: <228E231D-AE31-4803-B630-051614CEE0B4@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 21, 2018 1:39:18 PM PST, Kees Cook <keescook@chromium.org> wrote:
>On Mon, Feb 19, 2018 at 6:49 AM, Jan Beulich <JBeulich@suse.com> wrote:
>> Commit df3405245a ("x86/asm: Add suffix macro for GEN_*_RMWcc()")
>> introduced "suffix" RMWcc operations, adding bogus clobber
>specifiers:
>> For one, on x86 there's no point explicitly clobbering "cc". In fact,
>
>Do you have more details on this? It seems from the GCC clobbers
>docs[1] that "cc" is needed for asm that changes the flags register.
>Given the explicit subl and decl being used for these macros, it seems
>needed to me.
>
>> with gcc properly fixed, this results in an overlap being detected by
>> the compiler between outputs and clobbers. Further more it seems bad
>
>Do you mean the flags register is already being included as an
>implicit clobber because there is an output of any kind? I can't find
>documentation that says this is true. If anything it looks like it
>could be "improved" from a full "cc" clobber to an output operand
>flag, like =@ccs.
>
>> practice to me to have clobber specification and use of the clobbered
>> register(s) disconnected - it should rather be at the invocation
>place
>> of that GEN_{UN,BIN}ARY_SUFFIXED_RMWcc() macros that the clobber is
>> specified which this particular invocation needs.
>>
>> Drop the "cc" clobber altogether and move the "cx" one to refcount.h.
>>
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/x86/include/asm/refcount.h |    4 ++--
>>  arch/x86/include/asm/rmwcc.h    |   16 ++++++++--------
>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> --- 4.16-rc2/arch/x86/include/asm/refcount.h
>> +++ 4.16-rc2-x86-rmwcc-clobbers/arch/x86/include/asm/refcount.h
>> @@ -67,13 +67,13 @@ static __always_inline __must_check
>>  bool refcount_sub_and_test(unsigned int i, refcount_t *r)
>>  {
>>         GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
>REFCOUNT_CHECK_LT_ZERO,
>> -                                 r->refs.counter, "er", i, "%0", e);
>> +                                 r->refs.counter, "er", i, "%0", e,
>"cx");
>>  }
>>
>>  static __always_inline __must_check bool
>refcount_dec_and_test(refcount_t *r)
>>  {
>>         GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
>REFCOUNT_CHECK_LT_ZERO,
>> -                                r->refs.counter, "%0", e);
>> +                                r->refs.counter, "%0", e, "cx");
>>  }
>>
>>  static __always_inline __must_check
>> --- 4.16-rc2/arch/x86/include/asm/rmwcc.h
>> +++ 4.16-rc2-x86-rmwcc-clobbers/arch/x86/include/asm/rmwcc.h
>> @@ -2,8 +2,7 @@
>>  #ifndef _ASM_X86_RMWcc
>>  #define _ASM_X86_RMWcc
>>
>> -#define __CLOBBERS_MEM         "memory"
>> -#define __CLOBBERS_MEM_CC_CX   "memory", "cc", "cx"
>> +#define __CLOBBERS_MEM(clb...) "memory", ## clb
>
>This leaves a trailing comma in the non-cx case. I thought that caused
>me problems in the past, but maybe that's GCC version-specific?
>
>>  #if !defined(__GCC_ASM_FLAG_OUTPUTS__) && defined(CC_HAVE_ASM_GOTO)
>>
>> @@ -40,18 +39,19 @@ do {                                             
>                          \
>>  #endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) ||
>!defined(CC_HAVE_ASM_GOTO) */
>>
>>  #define GEN_UNARY_RMWcc(op, var, arg0, cc)                          
>  \
>> -       __GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM)
>> +       __GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM())
>>
>> -#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, arg0, cc)         
>  \
>> +#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, arg0, cc,
>clobbers...)\
>>         __GEN_RMWcc(op " " arg0 "\n\t" suffix, var, cc,              
>  \
>> -                   __CLOBBERS_MEM_CC_CX)
>> +                   __CLOBBERS_MEM(clobbers))
>>
>>  #define GEN_BINARY_RMWcc(op, var, vcon, val, arg0, cc)              
>  \
>>         __GEN_RMWcc(op __BINARY_RMWcc_ARG arg0, var, cc,             
>  \
>> -                   __CLOBBERS_MEM, vcon (val))
>> +                   __CLOBBERS_MEM(), vcon (val))
>>
>> -#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, vcon, val, arg0,
>cc)        \
>> +#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, vcon, val, arg0,
>cc,        \
>> +                                 clobbers...)                       
>  \
>>         __GEN_RMWcc(op __BINARY_RMWcc_ARG arg0 "\n\t" suffix, var,
>cc,  \
>> -                   __CLOBBERS_MEM_CC_CX, vcon (val))
>> +                   __CLOBBERS_MEM(clobbers), vcon (val))
>>
>>  #endif /* _ASM_X86_RMWcc */
>
>Anyway, I'm fine to clean it up, sure, but I'd like more details on
>why this doesn't break things. :)
>
>Thanks!
>
>-Kees
>
>[1] https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html

On x86, gcc always assumes the flags are clobbered; technically it is because the x86 flags aren't implemented using the gcc "cc" internal.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
