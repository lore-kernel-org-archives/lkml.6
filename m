Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeBWAP4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:15:56 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:54072 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeBWAPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:15:51 -0500
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
Date: Thu, 22 Feb 2018 18:15:16 -0600
In-Reply-To: <20180112222944.GA22642@ls3530.fritz.box> (Helge Deller's message
        of "Fri, 12 Jan 2018 23:29:44 +0100")
Message-ID: <87fu5s4l4b.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ep11c-0003gS-8V;;;mid=<87fu5s4l4b.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX187bNIGCeUWt2fuNURbcgKizbtnfnPhUOA=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Helge Deller <deller@gmx.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 586 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 3.5 (0.6%), b_tie_ro: 2.4 (0.4%), parse: 1.19 (0.2%),
        extract_message_metadata: 29 (4.9%), get_uri_detail_list: 2.7 (0.5%),
        tests_pri_-1000: 16 (2.7%), tests_pri_-950: 2.2 (0.4%), tests_pri_-900: 1.74
        (0.3%), tests_pri_-400: 33 (5.7%), check_bayes: 31 (5.3%), b_tokenize: 11
        (2.0%), b_tok_get_all: 8 (1.4%), b_comp_prob: 4.8 (0.8%), b_tok_touch_all:
        2.6 (0.4%), b_finish: 0.86 (0.1%), tests_pri_0: 486 (83.0%),
        check_dkim_signature: 1.54 (0.3%), check_dkim_adsp: 5 (0.9%), tests_pri_500:
        8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 04/11] signal/parisc: Document a conflict with SI_USER with SIGFPE
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Deller <deller@gmx.de> writes:

> * Eric W. Biederman <ebiederm@xmission.com>:
>> Setting si_code to 0 results in a userspace seeing an si_code of 0.
>> This is the same si_code as SI_USER.  Posix and common sense requires
>> that SI_USER not be a signal specific si_code.  As such this use of 0
>> for the si_code is a pretty horribly broken ABI.
>> 
>> Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
>> value of __SI_KILL and now sees a value of SIL_KILL with the result
>> that uid and pid fields are copied and which might copying the si_addr
>> field by accident but certainly not by design.  Making this a very
>> flakey implementation.
>> 
>> Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
>> appropriate fields will reliably be copied.
>> 
>> This bug is 13 years old and parsic machines are no longer being built
>> so I don't know if it possible or worth fixing it.  But it is at least
>> worth documenting this so other architectures don't make the same
>> mistake.
>
>
> I think we should fix it, even if we now break the ABI.
>
> It's about a "conditional trap" which needs to be handled by userspace.
> I doubt there is any Linux code out which is utilizing this
> parisc-specific trap.
>
> I'd suggest to add a new FPE trap si_code (e.g. FPE_CONDTRAP).
> While at it, maybe we should include the already existing FPE_MDAOVF
> from the frv architecture, so that arch/frv/include/uapi/asm/siginfo.h
> can go completely.
>
> Suggested patch is below.
>
> I'm willing to test the patch below on the parisc architecture for a few
> weeks. And it will break arch/x86/kernel/signal_compat.c which needs
> looking at then too.

Have you managed to test this change?

I am sitting looking at another new FPE si_code and if this has been tested
I figure FPE_CONDTRAP should get the next available FPE si_code and the
other change should get the one that follows.

Eric
