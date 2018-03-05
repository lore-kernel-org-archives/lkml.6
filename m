Return-Path: <brgerst@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520281921; cv=none;
        d=google.com; s=arc-20160816;
        b=pwmvSGAmvDHN870+6PMkGVyIFe1ZeUizAi1NpKrcwiVktdeaBdIJoita4RhCKmsDTq
         jUmBhMHYEpkfvYOskvv6DuLejPTf4zIa7p7YDpkOM7PiBFYcsM7A7XpMpNsX1YiDmrX1
         9n26KxSYqAS/z+R6W2hxslYwW1f/G2725Uw6yQ2NatPv/Wh19Jk2BdfEOvk9NOYeGMKM
         Sb0S19Efoosutyjy1WbTUFgEWlLaVt0C80P3NnvnGtiAAGbhdGjhoi1JI7Xvb/Z1oIy7
         eBM53y4Fl/p6pg1ywRgyTQrjECS7g+KWaXV68Pva4c3njd/xBKZyMJk7dox/Ti+0K8kl
         1jJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=GCFX45c8zG1KkZpnQTpg2sNnK3mgriY+rxRHJ3D/eYI=;
        b=HaTLaU1Q1BHvOssOe4LsWov+S3dDyDpNYeMrHrfwEXDWfImReV/rh1zPKZiVHoMsuT
         5UQNTn9MnafPWrgHWKRLB5NOkx+gB4dJGzR8Ll06lz6IKVnksSlVkX1QOmJ6ufSABvYf
         KyziGLvV2vVflw6AMI2+byK9/sR4al8/L38qZF7ISVo42+CB+q56FQKOpIhEO3kfQ52U
         5W0hYSPfFibKT/hfB6Y8RjvyUb5B59uzCtbeksuPOEDw+VQ6RDWvVxh5tNKkFu5POS9o
         Y+jbaVsHvIdi81/jkY+2791KMk3XWFBLmXsPjT9pZWlb5Rpzky5WykC0XLfBQDcQsEEs
         xSgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ShlmOkuQ;
       spf=pass (google.com: domain of brgerst@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=brgerst@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ShlmOkuQ;
       spf=pass (google.com: domain of brgerst@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=brgerst@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs7IstZiFLVmJihoxRa4RkpreKJryOmYD6cHPgKHVVR5wnXS64VdIDoc3SBycYDbu/mejsFg0Unlusnnzq33KI=
MIME-Version: 1.0
In-Reply-To: <20180305182524.GT16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-12-git-send-email-joro@8bytes.org> <CAMzpN2h3xkhw_A4VeeA47=oykKgxXeumHM-q0QpaA8+fwFVRjw@mail.gmail.com>
 <20180305182524.GT16484@8bytes.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 5 Mar 2018 15:32:01 -0500
Message-ID: <CAMzpN2hHSpcxz+dTpHhZuXh7QuvOai9_Yc6W3dG6br4oCV56EQ@mail.gmail.com>
Subject: Re: [PATCH 11/34] x86/entry/32: Handle Entry from Kernel-Mode on Entry-Stack
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093022557312692?=
X-GMAIL-MSGID: =?utf-8?q?1594131136241593208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 1:25 PM, Joerg Roedel <joro@8bytes.org> wrote:
> Hi Brian,
>
> thanks for your review and helpful input.
>
> On Mon, Mar 05, 2018 at 11:41:01AM -0500, Brian Gerst wrote:
>> On Mon, Mar 5, 2018 at 5:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
>> > +.Lentry_from_kernel_\@:
>> > +
>> > +       /*
>> > +        * This handles the case when we enter the kernel from
>> > +        * kernel-mode and %esp points to the entry-stack. When this
>> > +        * happens we need to switch to the task-stack to run C code,
>> > +        * but switch back to the entry-stack again when we approach
>> > +        * iret and return to the interrupted code-path. This usually
>> > +        * happens when we hit an exception while restoring user-space
>> > +        * segment registers on the way back to user-space.
>> > +        *
>> > +        * When we switch to the task-stack here, we can't trust the
>> > +        * contents of the entry-stack anymore, as the exception handler
>> > +        * might be scheduled out or moved to another CPU. Therefore we
>> > +        * copy the complete entry-stack to the task-stack and set a
>> > +        * marker in the iret-frame (bit 31 of the CS dword) to detect
>> > +        * what we've done on the iret path.
>>
>> We don't need to worry about preemption changing the entry stack.  The
>> faults that IRET or segment loads can generate just run the exception
>> fixup handler and return.  Interrupts were disabled when the fault
>> occurred, so the kernel cannot be preempted.  The other case to watch
>> is #DB on SYSENTER, but that simply returns and doesn't sleep either.
>>
>> We can keep the same process as the existing debug/NMI handlers -
>> leave the current exception pt_regs on the entry stack and just switch
>> to the task stack for the call to the handler.  Then switch back to
>> the entry stack and continue.  No copying needed.
>
> Okay, I'll look into that. Will it even be true for fully preemptible
> and RT kernels that there can't be any preemption of these handlers?

See resume_kernel in the 32-bit entry for how preemption is handled on
return to kernel mode.  Looking at the RT patches, they still respect
disabling interrupts also disabling preemption.

--
Brian Gerst
