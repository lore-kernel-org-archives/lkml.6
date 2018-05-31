Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeEaUiN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754160AbeEaUiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:38:12 -0400
X-Google-Smtp-Source: ADUXVKJiP7eh7CLma045vrLB1khYlpa+SiPXsvbDfLaZeufREtj8jIYE5BOwUFT2fBWvfR6n3r8qkKAb7hwx3DhgLTA=
MIME-Version: 1.0
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 31 May 2018 13:37:58 -0700
X-Gmail-Original-Message-ID: <CALCETrVAW5wuABK63h8frMuW_-tT29ZWPH2fPMiffOWQn8Lp2g@mail.gmail.com>
Message-ID: <CALCETrVAW5wuABK63h8frMuW_-tT29ZWPH2fPMiffOWQn8Lp2g@mail.gmail.com>
Subject: Re: [PATCH V2 00/15] x86: Enable FSGSBASE instructions
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:58 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> FSGSBASE is 64-bit instruction set to allow read/write
> FS/GS base from any privilege. As introduced from
> Ivybridge, enabling effort has been revolving quite long
> [2,3,4] for various reasons. After extended discussions [1],
> this patchset is proposed to introduce new ABIs of
> customizing FS/GS base (separate from its selector).


Thanks!

I have two general comments:

1. Can you try and generate a new version of patches 1-5 quickly?  I
think it would be nice to get them merged this cycle.

2. I spoke to hpa, and he said that, after further investigation of
how gdb works, a command like 'p $gs = 0x7' results in
PTRACE_POKEUSER.  He further suggested that it would therefore be
reasonable to have POKEUSER on gs refresh gsindex (assuming the poked
value is nonzero, sigh) and to make PTRACE_SETREGS iterate over the
registers in reverse order so that it behaves sanely.  Is this indeed
the case?

3. The ptrace behavior is sufficiently subtle that I think it needs a
test case.  Can you add a new selftest (or extend the existing
fsgsbase selftest) to do something like this:

 - Create an LDT entry in slot zero with base == 1.
 - Read out the hwcap bit indicating whether we have the new instructions on.
 - MOV 0x7 to %gs and use ptrace to read gsbase.  Confirm that the result is 1.
 - MOV 0x7 to %gs, do wrgsbase to change the base to 2 (if supported),
and use ptrace to read gsbase.  Confirm that the result is 2.
 - Same as previous test, but with 0x0 instead of 0x7.
 - Allocate a TLS segment with base == 3.  Load it into %gs. Use
ptrace to read gsbase.  Confirm that the result is 3.
 - Use ptrace to toggle %gs (using POKEUSER) back and forth between
0x0, 0x7, and the TLS segment.  In each case, immediately use ptrace
to read the base and confirm that you get the expected result.  Then
resume the tracee and read the base directly, confirming that you get
the expected result.
 - Use PTRACE_SETREGS to load gs = 0, gsbase = 4.  Confirm that
GETREGS returns those values back and confirm that they are in fact
loaded into the tracee.
 - Use PTRACE_SETREGS to load gs = 0x7, gsbase = 4.  Confirm that
GETREGS returns those values back and confirm that they have the
expected values (which will depend on the hwcap bit).  Also confirm
that the expected values are loaded into the tracee.

Does this seem reasonable?  The mov_ss_trap testcase has a nice bit of
code you can borrow to invoke ptrace operations on yourself.
