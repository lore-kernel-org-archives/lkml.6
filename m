Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeB0CUQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:20:16 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:51403 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeB0CUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:20:14 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        linux-arch@vger.kernel.org
References: <87373b6ghs.fsf@xmission.com>
        <20180112005940.23279-4-ebiederm@xmission.com>
        <20180112222944.GA22642@ls3530.fritz.box>
        <87fu5s4l4b.fsf@xmission.com>
        <68641c9e-99c6-34d3-83aa-1241bddef33c@gmx.de>
Date: Mon, 26 Feb 2018 20:19:35 -0600
In-Reply-To: <68641c9e-99c6-34d3-83aa-1241bddef33c@gmx.de> (Helge Deller's
        message of "Sun, 25 Feb 2018 20:49:41 +0100")
Message-ID: <87r2p7uqbs.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eqUsA-0005BQ-JK;;;mid=<87r2p7uqbs.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX181MjbviIBrqFbPh2c7uCFcTV5bYgFfU+Q=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Helge Deller <deller@gmx.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 271 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (1.0%), b_tie_ro: 1.96 (0.7%), parse: 1.08 (0.4%),
        extract_message_metadata: 15 (5.5%), get_uri_detail_list: 2.4 (0.9%),
        tests_pri_-1000: 8 (3.0%), tests_pri_-950: 1.14 (0.4%), tests_pri_-900: 0.98
        (0.4%), tests_pri_-400: 24 (8.8%), check_bayes: 23 (8.5%), b_tokenize: 8
        (2.8%), b_tok_get_all: 8 (3.0%), b_comp_prob: 2.5 (0.9%), b_tok_touch_all:
        2.8 (1.0%), b_finish: 0.60 (0.2%), tests_pri_0: 210 (77.4%),
        check_dkim_signature: 0.67 (0.2%), check_dkim_adsp: 2.4 (0.9%),
        tests_pri_500: 6 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 04/11] signal/parisc: Document a conflict with SI_USER with SIGFPE
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Deller <deller@gmx.de> writes:

> On 23.02.2018 01:15, Eric W. Biederman wrote:
>> Helge Deller <deller@gmx.de> writes:
>> 
>>> * Eric W. Biederman <ebiederm@xmission.com>:
>>>> Setting si_code to 0 results in a userspace seeing an si_code of 0.
>>>> This is the same si_code as SI_USER.  Posix and common sense requires
>>>> that SI_USER not be a signal specific si_code.  As such this use of 0
>>>> for the si_code is a pretty horribly broken ABI.
>>>>
>>>> Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
>>>> value of __SI_KILL and now sees a value of SIL_KILL with the result
>>>> that uid and pid fields are copied and which might copying the si_addr
>>>> field by accident but certainly not by design.  Making this a very
>>>> flakey implementation.
>>>>
>>>> Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
>>>> appropriate fields will reliably be copied.
>>>>
>>>> This bug is 13 years old and parsic machines are no longer being built
>>>> so I don't know if it possible or worth fixing it.  But it is at least
>>>> worth documenting this so other architectures don't make the same
>>>> mistake.
>>>
>>>
>>> I think we should fix it, even if we now break the ABI.
>>>
>>> It's about a "conditional trap" which needs to be handled by userspace.
>>> I doubt there is any Linux code out which is utilizing this
>>> parisc-specific trap.
>>>
>>> I'd suggest to add a new FPE trap si_code (e.g. FPE_CONDTRAP).
>>> While at it, maybe we should include the already existing FPE_MDAOVF
>>> from the frv architecture, so that arch/frv/include/uapi/asm/siginfo.h
>>> can go completely.
>>>
>>> Suggested patch is below.
>>>
>>> I'm willing to test the patch below on the parisc architecture for a few
>>> weeks. And it will break arch/x86/kernel/signal_compat.c which needs
>>> looking at then too.
>> 
>> Have you managed to test this change?
>
> Sadly I haven't done any further testing yet.

So at this point for purposed of testing I don't think it matters which
number FPE_CONDTRAP gets as long as it is non-zero.
>  
>> I am sitting looking at another new FPE si_code and if this has been tested
>> I figure FPE_CONDTRAP should get the next available FPE si_code and the
>> other change should get the one that follows.
>
> I'm fine either way. Do you have a git tree I can pull which includes
> all your patches? I can then start testing.

Everything finalized is in Linus's tree.  There is a patch pending
review on linux-arch that defines FPE_FLTUNK that looks to be useful
on several architectures.

I had probably misread our earlier exchange.  I had hoped you had tested
that FPE_CONDTRAP did not cause problems.

If that level of testing was complete I would have given FPE_CONDTRAP
the next FPE number and FPE_FLTUNK the one after.

As it sounds like FPE_CONDTRAP hasn't been tested enough to know if it
causes problems I will encourage the patches to be merged in the other
order.

Eric
