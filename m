Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524605557; cv=none;
        d=google.com; s=arc-20160816;
        b=TORPAigTkaqQ0DnmnxH8vI+jEb04Pn6+j0elH2ku3aGh+wmeuEAhKUZeIFDPMTOMFa
         XVdtRDWGqHIkBHFTQHvO17OZUOYeJMv9y3toa5etTUq2ohrf2/yGB4dNl3pp50qjydkY
         VuJ0t/vV6XaMP+2yrA0+dGolSmU4CRBMcBPWWiY9RW3G5mFJlWNULE+rUjusrHTvmKUE
         ZNICInCQKK3xFwNrCVKw6GNhLSBp5cOArVRQMAePqubtlm2TDP8Fu2AZcHlR5KccbMiz
         4rDoG3HLecgPbfZhr38eOKfITvPuztI0b1d/bIuZnRKlmcIWMuil/hvfqOYEf3OyciZj
         y5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9aXKerxFtPKCPc6DyAc0N0lubGRC4ftBrnjd1jSZn3E=;
        b=qs+p/CUemoxf6l12YsRaDiXa1YbCdvm6LRkqJLk7wIVW1u+5ptFwLKnZZ5ApNGygpi
         5FK6K3vAySCMU2UtO74GTFmACSXglAJFDDbsAJJhDnkifj+QLIBBI2xkjr0EEIEJ8GVV
         5yRJPdMV94vofmo+L/8jH0XbHvyYqrclFrUbLRHjPTwWlMC9a+jgmNSxnMjKiULB3sdD
         vX1mABcrA0qRPziJMjwyS0nYavMpo+Xu8Vydpy2ENl/xOA2Fn8fwwMf4RtPj7V6WIsC5
         hvZWyQ7gUzZcgIS02o1a4H0fYstx+0CwcooqwPEjUrIJ+npObtgKpnfpawlwddffMbhc
         5nSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ioCTuAB9;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ioCTuAB9;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/FDQF3XlDZE5PcMWJwsxnBHBMrWI0DCymG+yhgNxrRoF/2VXDftsXUHXlV5P+ojxA+Z3HmtxLDxPRUE9pP3g8=
MIME-Version: 1.0
References: <20180424180812.215900-1-wvw@google.com> <20180424145056.7c29ea18@gandalf.local.home>
 <CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
 <20180424151416.397fbbde@gandalf.local.home> <CAGXk5yriz2CtCN-vkL0q7gdpV+f8+9GJH-FT+v3KBLb-fWoCZA@mail.gmail.com>
 <20180424152607.71fbee34@gandalf.local.home> <CAGXk5yre3aDtVbtEz4=DdBnLrT3U=LPA69jOp9zmkfeYiZ7w=Q@mail.gmail.com>
 <20180424164505.0a4d15f7@gandalf.local.home> <20180424164837.3f1bcd20@gandalf.local.home>
In-Reply-To: <20180424164837.3f1bcd20@gandalf.local.home>
From: Wei Wang <wvw@google.com>
Date: Tue, 24 Apr 2018 21:32:26 +0000
Message-ID: <CAGXk5yo0FoBYdtbsg9b+ZqTuNu5wKNQokzHbu=33YF93ombgng@mail.gmail.com>
Subject: Re: [PATCH] do not call trace_printk on non-debug build
To: Steven Rostedt <rostedt@goodmis.org>
Cc: gregkh@linuxfoundation.org, Wei Wang <wei.vince.wang@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>,
	Alexei Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598664796655354877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I have seen case when LLVM appends postfix to most function names, causing
func such as tracing_mark_write becomes tracing_mark_write.XXX which messed
all post-processing.
Also I think this is a typo?
https://lkml.org/lkml/2018/4/24/1176
On Tue, Apr 24, 2018 at 1:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 24 Apr 2018 16:45:05 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:

> > On Tue, 24 Apr 2018 20:39:27 +0000
> > Wei Wang <wvw@google.com> wrote:
> >
> > > The config is not something new and it is controlling pr_debug and
> > > pr_devel, so might not be too annoying, IMHO. But I agree this is not
a
> > > problem from us but from abusers.
> >
> > And is the reason I never use pr_debug() and pr_devel().
> >

> Which reminds me, I need to replace pr_debug() to pr_info() for this
> line:

>    pr_debug("syscall %s metadata not mapped, disabling ftrace event\n",

> In trace_syscalls.c (I didn't add that), as a different commit that
> changed syscall names for x86 caused all syscall tracepoints to
> disappear. And if this was pr_info() and not pr_debug() the one that
> made the change would have noticed his change had impact someplace else.

> -- Steve
