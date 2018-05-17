Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeEQHSY convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:18:24 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:60644 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQHSX (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Thu, 17 May 2018 03:18:23 -0400
Message-Id: <5AFD2CBD02000078001C37BE@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Thu, 17 May 2018 01:18:21 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Nadav Amit" <namit@vmware.com>
Cc: <keescook@chromium.org>, "the arch/x86 maintainers" <x86@kernel.org>,
        <tglx@linutronix.de>, "Josh Poimboeuf" <jpoimboe@redhat.com>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [RFC 5/8] x86: refcount: prevent gcc distortions
References: <20180515141124.84254-1-namit@vmware.com>
 <20180515141124.84254-15-namit@vmware.com>
 <5AFBDA6302000078001C31AC@prv1-mh.provo.novell.com>
 <8B7DE95F-5E57-44F0-90E0-CCBA35F98A07@vmware.com>
In-Reply-To: <8B7DE95F-5E57-44F0-90E0-CCBA35F98A07@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 16.05.18 at 18:44, <namit@vmware.com> wrote:
> Jan Beulich <JBeulich@suse.com> wrote:
>>>>> On 15.05.18 at 16:11, <namit@vmware.com> wrote:
>>> --- a/arch/x86/include/asm/refcount.h
>>> +++ b/arch/x86/include/asm/refcount.h
>>> @@ -14,34 +14,43 @@
>>>  * central refcount exception. The fixup address for the exception points
>>>  * back to the regular execution flow in .text.
>>>  */
>>> -#define _REFCOUNT_EXCEPTION				\
>>> -	".pushsection .text..refcount\n"		\
>>> -	"111:\tlea %[counter], %%" _ASM_CX "\n"		\
>>> -	"112:\t" ASM_UD2 "\n"				\
>>> -	ASM_UNREACHABLE					\
>>> -	".popsection\n"					\
>>> -	"113:\n"					\
>>> +
>>> +asm ("\n"
>>> +	".macro __REFCOUNT_EXCEPTION counter:vararg\n\t"
>>> +	".pushsection .text..refcount\n"
>>> +	"111:\tlea \\counter, %" _ASM_CX "\n"
>>> +	"112:\t" ASM_UD2 "\n\t"
>>> +	ASM_UNREACHABLE
>>> +	".popsection\n\t"
>>> +	"113:\n"
>>> 	_ASM_EXTABLE_REFCOUNT(112b, 113b)
>>> +	".endm");
>> 
>> A few comments on assembly code formatting - while gas at present is
>> relatively lax in this regard, I wouldn't exclude that there might be a
>> more strict mode in the future, and that such a mode might eventually
>> become the default. Furthermore these formatting aspects affect
>> readability of the assembly produced, should anyone ever find a need
>> to look at it (perhaps because of some breakage) - I certainly do every
>> once in a while.
>> 
>> Labels should be placed without any indentation (but of course there
>> may be more than one on a line, in which case subsequent ones may
>> of course be arbitrarily indented). Instructions and directives, otoh,
>> should be placed with at least a single tab or space of indentation
>> (unless preceded by a label, in which case the extra white space still
>> helps readability).
> 
> Writing these patches, I looked at the generated assembly, and there did not
> appear to be a standard. IIRC, .pushsection directives were not always
> inlined. I will fix it according to your comments.

Right, I should have made explicit that there's no consistency at all in
pre-existing code. I merely think the issue shouldn't be made worse.

Jan
