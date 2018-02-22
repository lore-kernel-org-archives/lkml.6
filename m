Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeBVIFN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:05:13 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:46382 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeBVIFL (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Thu, 22 Feb 2018 03:05:11 -0500
Message-Id: <5A8E87C502000078001AA3A3@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Thu, 22 Feb 2018 01:05:09 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Kees Cook" <keescook@chromium.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/asm: improve how GEN_*_SUFFIXED_RMWcc()
 specify clobbers
References: <5A8AF1F802000078001A91E1@prv-mh.provo.novell.com>
 <CAGXu5jLB9WXdaHg7ox85BftejyHUBHrUe7EpCLU08e5eRLstLQ@mail.gmail.com>
In-Reply-To: <CAGXu5jLB9WXdaHg7ox85BftejyHUBHrUe7EpCLU08e5eRLstLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 21.02.18 at 22:39, <keescook@chromium.org> wrote:
> On Mon, Feb 19, 2018 at 6:49 AM, Jan Beulich <JBeulich@suse.com> wrote:
>> Commit df3405245a ("x86/asm: Add suffix macro for GEN_*_RMWcc()")
>> introduced "suffix" RMWcc operations, adding bogus clobber specifiers:
>> For one, on x86 there's no point explicitly clobbering "cc". In fact,
> 
> Do you have more details on this? It seems from the GCC clobbers
> docs[1] that "cc" is needed for asm that changes the flags register.
> Given the explicit subl and decl being used for these macros, it seems
> needed to me.
> 
>> with gcc properly fixed, this results in an overlap being detected by
>> the compiler between outputs and clobbers. Further more it seems bad
> 
> Do you mean the flags register is already being included as an
> implicit clobber because there is an output of any kind? I can't find
> documentation that says this is true. If anything it looks like it
> could be "improved" from a full "cc" clobber to an output operand
> flag, like =@ccs.

As hpa has already said, "cc" has been automatically included as a
clobber forever on x86 (until the condition code outputs appeared,
at which point the clobber became added only if no such output
was present).

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
> This leaves a trailing comma in the non-cx case. I thought that caused
> me problems in the past, but maybe that's GCC version-specific?

No, it's formally specified to drop the comma. Note this is using a
gcc extension, not the C99 way of having a macro with variable
number of arguments (where - without again some gcc special
handling - this indeed would be a problem).

Jan
