Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeDQTjP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:39:15 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35920 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDQTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:39:11 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Martin <Dave.Martin@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20180413094211.GN16141@n2100.armlinux.org.uk>
        <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
        <20180413170827.GB16308@e103592.cambridge.arm.com>
        <20180413175407.GO16141@n2100.armlinux.org.uk>
        <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
        <20180413184522.GD16308@e103592.cambridge.arm.com>
        <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
        <20180415131206.GR16141@n2100.armlinux.org.uk>
        <87604sa2fu.fsf_-_@xmission.com> <87zi248nte.fsf_-_@xmission.com>
        <20180417132328.GF16308@e103592.cambridge.arm.com>
Date: Tue, 17 Apr 2018 14:37:38 -0500
In-Reply-To: <20180417132328.GF16308@e103592.cambridge.arm.com> (Dave Martin's
        message of "Tue, 17 Apr 2018 14:23:30 +0100")
Message-ID: <87d0yxzksd.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f8WRQ-0007p3-11;;;mid=<87d0yxzksd.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+wza8CZ+pYaY6pWQMyNCSbA7yS2knf6+4=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Dave Martin <Dave.Martin@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1354 ms - load_scoreonly_sql: 1.09 (0.1%),
        signal_user_changed: 17 (1.2%), b_tie_ro: 9 (0.7%), parse: 6 (0.5%),
        extract_message_metadata: 42 (3.1%), get_uri_detail_list: 7 (0.5%),
        tests_pri_-1000: 19 (1.4%), tests_pri_-950: 7 (0.5%), tests_pri_-900: 2.3
        (0.2%), tests_pri_-400: 91 (6.7%), check_bayes: 87 (6.5%), b_tokenize: 31
        (2.3%), b_tok_get_all: 27 (2.0%), b_comp_prob: 9 (0.6%), b_tok_touch_all: 14
        (1.1%), b_finish: 1.08 (0.1%), tests_pri_0: 1140 (84.2%),
        check_dkim_signature: 2.9 (0.2%), check_dkim_adsp: 16 (1.2%), tests_pri_500:
        14 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 1/3] signal: Ensure every siginfo we send has all bits initialized
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Martin <Dave.Martin@arm.com> writes:

> Hmmm
>
> memset()/clear_siginfo() may ensure that there are no uninitialised
> explicit fields except for those in inactive union members, but I'm not
> sure that this approach is guaranteed to sanitise the padding seen by
> userspace.
>
> Rationale below, though it's a bit theoretical...
>
> With this in mind, I tend agree with Linus that hiding memset() calls
> from the maintainer may be a bad idea unless they are also hidden from
> the compiler.  If the compiler sees the memset() it may be able to
> optimise it in ways that wouldn't be possible for some other random
> external function call, including optimising all or part of the call
> out.
>
> As a result, the breakdown into individual put_user()s etc. in
> copy_siginfo_to_user() may still be valuable even if all paths have the
> memset().

The breakdown into individual put_user()s is known to be problematically
slow, and is actually wrong.

Even exclusing the SI_USER duplication in a small number of cases the
fields filled out in siginfo by architecture code are not the fields
that copy_siginfo_to_user is copying.  Which is much worse.  The code
looks safe but is not.

My intention is to leave 0 instances of clear_siginfo in the
architecture specific code.  Ideally struct siginfo will be limited to
kernel/signal.c but I am not certain I can quite get that far.
The function do_coredump appears to have a legit need for siginfo.


> (Rationale for an arch/arm example:)
>
>> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
>> index 4c375e11ae95..adda3fc2dde8 100644
>> --- a/arch/arm/vfp/vfpmodule.c
>> +++ b/arch/arm/vfp/vfpmodule.c
>> @@ -218,8 +218,7 @@ static void vfp_raise_sigfpe(unsigned int sicode, struct pt_regs *regs)
>>  {
>>  	siginfo_t info;
>>  
>> -	memset(&info, 0, sizeof(info));
>> -
>> +	clear_siginfo(&info);
>>  	info.si_signo = SIGFPE;
>
> /* by c11 (n1570) 6.2.6.1 para 6 [1], all padding bytes in info now take
>    unspecified values */
>
>>  	info.si_code = sicode;
>>  	info.si_addr = (void __user *)(instruction_pointer(regs) - 4);
>
> /* by c11 (n1570) 6.2.6.1 para 7 [2], all bytes of the union info._sifields
>    other than than those corresponding to _sigfault take unspecified
>    values */
>
> So I don't see why the compiler needs to ensure that any of the affected
> bytes are zero: it could potentially skip a lot of the memset() as a
> result, in theory.
>
> I've not seen a compiler actually take advantage of that, but I'm now
> not sure what forbids it.

I took a quick look at gcc-4.9 which I have handy.

The passes -f-no-strict-aliasing which helps, and gcc actually
documents that if you access things through the union it will
not take advantage of c11.

gcc-4.9 Documents it this way:

> -fstrict-aliasing'
>      Allow the compiler to assume the strictest aliasing rules
>      applicable to the language being compiled.  For C (and C++), this
>      activates optimizations based on the type of expressions.  In
>      particular, an object of one type is assumed never to reside at the
>      same address as an object of a different type, unless the types are
>      almost the same.  For example, an 'unsigned int' can alias an
>      'int', but not a 'void*' or a 'double'.  A character type may alias
>      any other type.
> 
>      Pay special attention to code like this:
>           union a_union {
>             int i;
>             double d;
>           };
> 
>           int f() {
>             union a_union t;
>             t.d = 3.0;
>             return t.i;
>           }
>      The practice of reading from a different union member than the one
>      most recently written to (called "type-punning") is common.  Even
>      with '-fstrict-aliasing', type-punning is allowed, provided the
>      memory is accessed through the union type.  So, the code above
>      works as expected.


> If this can happen, I only see two watertight workarounds:
>
> 1) Ensure that there is no implicit padding in any UAPI structure, e.g.
> aeb1f39d814b: ("arm64/ptrace: Avoid uninitialised struct padding in
> fpr_set()").  This would include tail-padding of any union member that
> is smaller than the containing union.
>
> It would be significantly more effort to ensure this for siginfo though.
>
> 2) Poke all values directly into allocated or user memory directly
> via pointers to paddingless types; never assign to objects on the kernel
> stack if you care what ends up in the padding, e.g., what your
> copy_siginfo_to_user() does prior to this series.
>
>
> If I'm not barking up the wrong tree, memset() cannot generally be
> used to determine the value of padding bytes, but it may still be
> useful for forcing otherwise uninitialised members to sane initial
> values.
>
> This likely affects many more things than just siginfo.

Unless gcc has changed it's stance on type-punning through unions
or it's semantics with -fno-strict_aliasing we should be good.

Eric
