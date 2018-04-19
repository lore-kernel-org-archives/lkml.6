Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753650AbeDSOl7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:41:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56537 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbeDSOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:41:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Martin <Dave.Martin@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
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
        <87604sa2fu.fsf_-_@xmission.com>
        <CA+55aFw1gmfFH1o+oWMo4TnU5hEczAOiY1g=eMxqYZmy9JqDYw@mail.gmail.com>
        <20180419092840.GL16308@e103592.cambridge.arm.com>
Date: Thu, 19 Apr 2018 09:40:28 -0500
In-Reply-To: <20180419092840.GL16308@e103592.cambridge.arm.com> (Dave Martin's
        message of "Thu, 19 Apr 2018 10:28:40 +0100")
Message-ID: <87lgdjp8df.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f9Akx-0008Fz-C0;;;mid=<87lgdjp8df.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/U7941FrPFoizEncyyuXuLTbYohEFzQNk=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Dave Martin <Dave.Martin@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 879 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.3%), b_tie_ro: 1.98 (0.2%), parse: 1.56 (0.2%),
        extract_message_metadata: 33 (3.8%), get_uri_detail_list: 6 (0.6%),
        tests_pri_-1000: 15 (1.7%), tests_pri_-950: 2.1 (0.2%), tests_pri_-900: 1.65
        (0.2%), tests_pri_-400: 47 (5.4%), check_bayes: 45 (5.1%), b_tokenize: 19
        (2.1%), b_tok_get_all: 12 (1.4%), b_comp_prob: 7 (0.8%), b_tok_touch_all: 3.0
        (0.3%), b_finish: 0.76 (0.1%), tests_pri_0: 762 (86.7%),
        check_dkim_signature: 0.97 (0.1%), check_dkim_adsp: 4.5 (0.5%),
        tests_pri_500: 6 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/3] Dealing with the aliases of SI_USER
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Martin <Dave.Martin@arm.com> writes:

> On Sun, Apr 15, 2018 at 11:16:04AM -0700, Linus Torvalds wrote:
>
> [...]
>
>> The other thing we should do is to get rid of the stupid padding.
>> Right now "struct siginfo" is pointlessly padded to 128 bytes. That is
>> completely insane, when it's always just zero in the kernel.
>
> Agreed, inside the kernel the padding achieves nothing.
>
>> So put that _pad[] thing inside #ifndef __KERNEL__, and make
>> copy_siginfo_to_user() write the padding zeroes when copying to user
>> space. The reason for the padding is "future expansion", so we do want
>> to tell the user space that it's maybe up to 128 bytes in size, but if
>> we don't fill it all, we shouldn't waste time and memory on clearing
>> the padding internally.
>> 
>> I'm certainly *hoping* nobody depends on the whole 128 bytes in
>> rt_sigqueueinfo(). In theory you can fill it all (as long as si_code
>> is negative), but the man-page only says "si_value", and the compat
>> function doesn't copy any more than that either, so any user that
>> tries to fill in more than si_value is already broken. In fact, it
>> might even be worth enforcing that in rt_sigqueueinfo(), just to see
>> if anybody plays any games..
>
> [...]
>
> Digression:
>
> Since we don't traditionally zero the tail-padding in the user sigframe,
> is there a reliable way for userspace to detect newly-added fields in
> siginfo other than by having an explicit sigaction sa_flags flag to
> request them?  I imagine something like [1] below from the userspace
> perspective.
>
> On a separate thread, the issue of how to report syndrome information
> for SIGSEGV came up [2] (such as whether the faulting instruction was a
> read or a write).  This information is useful (and used) by things like
> userspace sanitisers and qemu.  Currently, reporting this to userspace
> relies on arch-specific cruft in the sigframe.
>
> We're committed to maintaining what's already in each arch sigframe,
> but it would be preferable to have a portable way of adding information
> to siginfo in a generic way.  si_code doesn't really work for that,
> since si_codes are mutually exclusive: I can't see a way of adding
> supplementary information using si_code.
>
> Anyway, that would be a separate RFC in the future (if ever).

So far what I have seen done is ``registers'' added to sigcontext.
Which it looks like you have done with esr.

Scrubbing information from faults to where the addresses point
outside of the userspace mapping makes sense.

I think before I would pursue what you are talking about on a generic
level I would want to look at the fact that we handle unblockable faults
wrong.  While unlikely it is possible for someone to send a thread
specific signal at just the right time, and have that signal
delivered before the synchronous fault.

Then we could pass through additional arguments through that new
``generic'' path.  Especially what are arguments such as
tsk->thread.fault_address and tsk->thread.fault_code.

We can do anything we like with a new SA_flag as that allows us to
change the format of the sigframe.

If we are very careful we can add generic fields after that crazy union
anonymous union in the _sigfault case of struct siginfo.

The trick would be to find something that would be enough so that people
don't need to implement their own instruction decoder to see what is
going on.  Something that is applicable to every sigfault case not just
SIGSEGV.  Something that we can and want to implement on multiple
architectures.

The point being doing something generic can be a lot of work, even if it
is worth it in the end.


> [1]
>
> static volatile int have_extflags = 0;
>
> static void handler(int n, siginfo_t *si, void *uc)
> {
> 	/* ... */
>
> 	if (have_extflags) {
> 		/* Check si->si_extflags */
> 	} else {
> 		/* fallback */
> 	}
>
> 	/* ... */
> }
>
> int main(void)
> {
> 	/* ... */
>
> 	struct sigaction sa;
>
> 	/* ... */
>
> 	sa.sa_flags = SA_SIGINFO | SA_SIGINFO_EXTFLAGS;
> 	sa.sa_sigaction = handler;
> 	if (!sigaction(SIGSEGV, &sa, NULL)) {
> 		have_extflags = 1;
> 	} else {
> 		sa.sa_flags &= ~SA_SIGINFO_EXTFLAGS;
> 		if (sigaction(SIGSEGV, &sa, NULL))
> 			goto error;
> 	}
>
> 	/* ... */
> }
>
> [2] [RFC PATCH] arm64: fault: Don't leak data in ESR context for user fault on kernel VA
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/571428.html

Eric
