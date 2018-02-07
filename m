Return-Path: <dan.j.williams@intel.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517963585; cv=none;
        d=google.com; s=arc-20160816;
        b=FqIEaHgy9XSCK8q+rb6F4O6vNj+kA2FvUlbX+Q7DMHt7wXp2okY7UHHCyPusgAanzA
         oj/EA8Q8zD4TRU7VgiHN7bqklBKNaLX6qwoVaOCuh0EuhTAot9qEl56AoFuKVX61NriB
         oCn7+gCron4GdraO+gGiEYSG5iaVWtEvwAw7ynBEY5GcdRZpBn5T6SEJjqLS4SrFRD5u
         qimxJEiyP8LqNkwmvhYWbiD2b1fBc99h7k3FcMsk7CBjDa1ZXT+PVnqZqvv3VW+x1+0A
         dPxQvoxj0Jb8VtSmLGd/ZmmPVHI74VzBwbh4stXff8bitabOJvs/ZpmBZlxwZmU5is+S
         1Isg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1Q0UfRApg17V5+sSryRii7TpBecbFJC8y3qs/GGb9jk=;
        b=Vfq87LCog8EcoyrTECPBpM97H49f/7ph5c7vpG5HVdeLzXAMuNCj2/v6JmrFDP0oMH
         vM3cVOwBLn1/HlTuRusf2sG6jh1F5Q8G+NTaFurWkdzJnDf0u0JdO1ugYQSPZqairNeZ
         08s8/hKXAkZw/34ejImQyd/BazHemCRBeY+ZyxfXb7/VAdTLhB7i4PTq2mlnN3xmJlMC
         /DVLYxq8GIYB4T5qP3oV5+hFnirTby+V60c78MKY7hJ0oC8Vg+NSdVLrB86eBcOt+z7Q
         D1n5zVlwGLfy1scyd3i1/KfHCq0H+X5dSXbQ3mcDLKLZDx6Xj22P4MB7Pa0VXcUxL4n3
         T9MA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=kcANx9rL;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=kcANx9rL;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Google-Smtp-Source: AH8x224yn28aRpiN97U3NJb+0rhJBFOtdvF1VQ4DnsbuBYKWvIdkYcAee3bzVEE6nWj7n3iFKPgI4BT6GQH1Gd5CP0g=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxU_vo+JFBZcvE5EOs2D_QHNXBf4G=-KT=3LeP2zjECHw@mail.gmail.com>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp> <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
 <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com>
 <CAPcyv4i5oORdk-Fzypxw_+gCLUa8f=w1e_n0=47P7uHR-jT6GQ@mail.gmail.com>
 <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com>
 <CALCETrXV3rHb7Z8iaoieAJ5hRY0+UT7eTknxe4-FiOoke9XoGg@mail.gmail.com>
 <CA+55aFy2-OMMCatHTXL7wfP7H=4CEKv4Y_pRvfeEOCwxriDP4Q@mail.gmail.com>
 <CAPcyv4hELJQMEBQ_gi+_bh4D=7h47ypzK++XTdQjhDGnOs2uRg@mail.gmail.com> <CA+55aFxU_vo+JFBZcvE5EOs2D_QHNXBf4G=-KT=3LeP2zjECHw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Feb 2018 16:33:04 -0800
Message-ID: <CAPcyv4gE6qgncGPWWu1aWxbK6fO-tvpDEpE+zkZPfeL+EJAr1w@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1591700184034965648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 2:52 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Feb 6, 2018 at 1:37 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> At that point we're basically just back to the array_ptr() version
>> that returned a sanitized pointer to an array element.
>
> .. that one does an extra unnecessary 'andq' instead of the duplicated
> cmp.  But at least it avoids comparing that 32-bit integer twice, so
> it's probably slightly smaller.
>
> (And your code generation is without the "r" -> "ir" fix for the size argument)
>
> Probably doesn't matter. But a "asm goto" would give you at least
> potentially optimal code.
>

Should we go with array_element_nospec() in the meantime? So we're not
depending on jump labels? With the constraint fix and killing that
superfluous AND the assembly is now:

     e26:       48 81 fd 4d 01 00 00    cmp    $0x14d,%rbp
     e2d:       48 19 d2                sbb    %rdx,%rdx
                        NR_syscalls);
        if (likely(call))
     e30:       48 21 d0                and    %rdx,%rax
     e33:       74 1e                   je     e53 <do_syscall_64+0x73>
                regs->ax = (*call)(regs->di, regs->si, regs->dx,
     e35:       48 8b 4b 38             mov    0x38(%rbx),%rcx
     e39:       48 8b 53 60             mov    0x60(%rbx),%rdx
     e3d:       48 8b 73 68             mov    0x68(%rbx),%rsi
     e41:       48 8b 7b 70             mov    0x70(%rbx),%rdi
     e45:       4c 8b 4b 40             mov    0x40(%rbx),%r9
     e49:       4c 8b 43 48             mov    0x48(%rbx),%r8
     e4d:       ff 10                   callq  *(%rax)
     e4f:       48 89 43 50             mov    %rax,0x50(%rbx)
     e53:       65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
