Return-Path: <dan.j.williams@intel.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517953047; cv=none;
        d=google.com; s=arc-20160816;
        b=v3dCzlTh5q/ZYQ8p2AobUKL5EFoLUjEXDeKCKU4k8vsla1cOAIobo0Zj9JqhRqiA/G
         haEk5KEWiEZuE8OW2ZXAYtWuxpZP33xfgySPen5+8jVipK2C7APDWPHVI9dmpXbJuj8o
         oyQpYCPzKhrSU/7bn4qSi1oYVHdlrCjaXmZsr2VFJqQs5XJNpnuG2VsgJNL27mUkfg0H
         MI4JtIdrLM4NzhLaKqGkuQL2eWBvAbAUOwzPDChrBYQj0O/Kq0t90gfu1CbdC6ufVi9P
         6+Nyw6gygRl/e2pcYHILMiqJ+NHDw0SgZyYkZGmpHtT1JMG1atGTkGuGYzUauW9UMv6p
         s87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=cnJYmqeAjxKeSdIx7OWdChiGS+9XEX4W+rIh/nMzRt0=;
        b=x+Pk7I5ha5smcxvicGldWsFeA63f4BeVNIOSWobH9JX0hagW963cJs8nu1wci6u/WZ
         X9iW0h8W6DeWVEfk/z2hlFCqOzcuoTHpFxP1EKytPzI/8m0hwcjCQQqUxgNayv/0LDme
         fixt9RJ03vAhN6gkWY5OktODp8Jb0U26Symvh2meAfn74hMZU3qzAxez1o68Co8C64LW
         gofxFU2XBU7CRIxLhFBdOsjB2tGXkLX/TusywIJA9J48Z6A94NIxFsD6x9zb2kePHXst
         UjQ5pv0CEfcBf9smlPUW3QKFnr15ffMymTQQaIkSxXWQJ+lBT6foMYHtBtIE/R1BqEaJ
         ItQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=x1kC0GKA;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=x1kC0GKA;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Google-Smtp-Source: AH8x2245irANnY0AiRN9kWPX2FTK1AAtnv3jxuu+0QjGv7GdAQbzdkYfxn+X5S9ekV6g7oleZQbkgVH5KfNcs3DKGa4=
MIME-Version: 1.0
In-Reply-To: <CA+55aFy2-OMMCatHTXL7wfP7H=4CEKv4Y_pRvfeEOCwxriDP4Q@mail.gmail.com>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp> <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
 <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com>
 <CAPcyv4i5oORdk-Fzypxw_+gCLUa8f=w1e_n0=47P7uHR-jT6GQ@mail.gmail.com>
 <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com>
 <CALCETrXV3rHb7Z8iaoieAJ5hRY0+UT7eTknxe4-FiOoke9XoGg@mail.gmail.com> <CA+55aFy2-OMMCatHTXL7wfP7H=4CEKv4Y_pRvfeEOCwxriDP4Q@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Feb 2018 13:37:27 -0800
Message-ID: <CAPcyv4hELJQMEBQ_gi+_bh4D=7h47ypzK++XTdQjhDGnOs2uRg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] x86: narrow out of bounds syscalls to sys_read
 under speculation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Luis Henriques <lhenriques@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Greg KH <gregkh@linuxfoundation.org>,
	X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
	Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589977480308913684?=
X-GMAIL-MSGID: =?utf-8?q?1591689134912602357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 12:58 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Feb 6, 2018 at 12:49 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>
>> Can you use @cc to make an asm statement that outputs both the masked
>> array index and the "if" condition?  I can never remember the syntax,
>> but something like:
>
> Yes. Although I'd actually suggest just using an "asm goto" if we
> really want to optimize this. Give the "index_mask_nospec()" a third
> argument that is the label to jump to for overflow.
>
> Then you can just decide how to implement it best for any particular
> architecture (and compiler limitation).

At that point we're basically just back to the array_ptr() version
that returned a sanitized pointer to an array element.

        call = array_ptr(sys_call_table, nr & __SYSCALL_MASK, NR_syscalls);
        if (likely(call))
                regs->ax = (*call)(
                        regs->di, regs->si, regs->dx,
                        regs->r10, regs->r8, regs->r9);


     e1e:       ba 4d 01 00 00          mov    $0x14d,%edx
     e23:       48 39 d5                cmp    %rdx,%rbp
     e26:       48 19 d2                sbb    %rdx,%rdx
        call = array_ptr(sys_call_table, nr & __SYSCALL_MASK, NR_syscalls);
     e29:       48 21 d5                and    %rdx,%rbp
     e2c:       48 8d 04 ed 00 00 00    lea    0x0(,%rbp,8),%rax
     e33:       00
        if (likely(call))
     e34:       48 21 d0                and    %rdx,%rax
     e37:       74 1e                   je     e57 <do_syscall_64+0x77>
                regs->ax = (*call)(
     e39:       48 8b 4b 38             mov    0x38(%rbx),%rcx
     e3d:       48 8b 53 60             mov    0x60(%rbx),%rdx
     e41:       48 8b 73 68             mov    0x68(%rbx),%rsi
     e45:       48 8b 7b 70             mov    0x70(%rbx),%rdi
     e49:       4c 8b 4b 40             mov    0x40(%rbx),%r9
     e4d:       4c 8b 43 48             mov    0x48(%rbx),%r8
     e51:       ff 10                   callq  *(%rax)
     e53:       48 89 43 50             mov    %rax,0x50(%rbx)
     e57:       65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
