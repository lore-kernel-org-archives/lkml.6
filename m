Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x2267PYuDOfg9ra7fhX4f4XXi/X1TvOW7lu8DKG9iUJRD18xyVwxCKm1l6N3ZF5tv70tJcjmZ
ARC-Seal: i=1; a=rsa-sha256; t=1517498034; cv=none;
        d=google.com; s=arc-20160816;
        b=tRIIxPVzGEmWbTAbrDs4RClxqI11UEQ80Hbe0Q9YfKtcBbicWoGnc9fpFW41KKYiBt
         svXiEGOZiQOaZu7ZVOTQHIiru/6jjcxBehB04kw+xXj+xgTiJ6SbyrCOuSnmiMiW8iE4
         AM//w5p4llOBBvlvnimmBG3TvPT8s/XfI2kRmVXMSrf0tcB11HHnvZ71sC1dOBBQkYD4
         /iUAbNNRZQKMdrjPmNxPCpTp3GNHJgTL+MQlns1Q883p7BNSYgIxqkDWiTwCQ6PtddXK
         p0wf6wrlv0Pp3mP955S0Q3L0VFeIVVq55evmkTZB+JcyKaPxQJIicfshyhepQ9tCK6XL
         XUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=9XeLQCDIJ8trqimr3TXqJJs1nurDWmf3jLvSrixwpYI=;
        b=I1HDRpV03HoQ2wyq+3Bmrqiq1k3g/0APjttl0fHpmbuHzV7zqjAUeIB15uXJtOsRvi
         S+rkgz2N93D32OoLN0KBvTz+hUc9pNuHOh7spQDVTyNJ2Oq37/fP0x6xc7c/3npkiuTs
         jcCs7gpDlX4C+wMNAftR5L/RErLlhkXgCn5DUsVUyoTqumcSvnsgjhzx1/7iUTwIZyYd
         8NbySXKJDcBbq79HNrm5euuxhOKRk6eolO8Wti2rlWM97PBeXRyc8ECXO/QcN2q31jEk
         nnpgN5F/j+cZPByMH8WZb8jeF5DrPTsghIVDV0oCMq+zvLNGElgd1BkLyEM4MPhoNj/Q
         s/Eg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ASCYk8WH;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ASCYk8WH;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 1 Feb 2018 16:13:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Asit Mallick <asit.k.mallick@intel.com>
Subject: Re: [PATCH 4/7] x86,nospec: Annotate indirect calls/jumps
Message-ID: <20180201151348.GK2295@hirez.programming.kicks-ass.net>
References: <20180201143421.088202488@infradead.org>
 <20180201143821.959147604@infradead.org>
 <1517496926.18619.315.camel@infradead.org>
 <20180201151136.GX2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180201151136.GX2249@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210458303680239?=
X-GMAIL-MSGID: =?utf-8?q?1591212018538237092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 04:11:36PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 01, 2018 at 02:55:26PM +0000, David Woodhouse wrote:
> > 
> > 
> > On Thu, 2018-02-01 at 15:34 +0100, Peter Zijlstra wrote:
> > > 
> > >   * These are the bare retpoline primitives for indirect jmp and call.
> > >   * Do not use these directly; they only exist to make the ALTERNATIVE
> > >   * invocation below less ugly.
> > > @@ -102,9 +114,9 @@
> > >  .macro JMP_NOSPEC reg:req
> > >  #ifdef CONFIG_RETPOLINE
> > >         ANNOTATE_NOSPEC_ALTERNATIVE
> > > -       ALTERNATIVE_2 __stringify(jmp *\reg),                           \
> > > +       ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),  \
> > >                 __stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE, \
> > > -               __stringify(lfence; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
> > > +               __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
> > >  #else
> > >         jmp     *\reg
> > >  #endif
> > 
> > The first one, yes. But the second one for the AMD retpoline is
> > redundant, isn't it? Objtool isn't going to look there.
> 
> It was when I wrote it.. lemme try again.

Insta complaint:

arch/x86/entry/.tmp_entry_64.o: warning: objtool: .altinstr_replacement+0x19: indirect jump found in RETPOLINE build
