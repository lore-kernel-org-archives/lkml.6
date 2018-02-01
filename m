Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AH8x224spYkCqkeLrxWhNyhmxer3gsq3agPHwipE2TzgAUpvnglGz/dcuTQfVfdcsq3JrDs/RAkh
ARC-Seal: i=1; a=rsa-sha256; t=1517498499; cv=none;
        d=google.com; s=arc-20160816;
        b=PUfYvwX3Rg7sqeNLobBjgExvFBzAvet/B5cqeUU6vfQ2eER0mQMstfimsmExcg0HD1
         zVruxxRV8UlQGesXKgti6xzKLJXv4mce5nB6JmVVuZbKRhc7H90X9x3ScHsGFTlns9RA
         OsLJJ+90w9Q6FPjn9HpA83Rz6FoObXH9s15lUaboBERlejqltVb5Nwpw2RUfxSCZqN24
         0ql2KKPgZNc3jE06RZR5rAG6cusQAVlGcjKnamWmzwaSNUL7KXnf6EfarFx/nO060WPi
         NfpaKHaVbuHjFNlgUsBuHXTcCDubRp/eMHhjNiJSMTESzIa8qysu7GhAPVL0s5Ai8fTn
         v/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=rmMeQMFhBNxEp6SmSa6H+3cBjUBYvA72S/wMLqKrxO0=;
        b=wu+TaamNvV7Pzu63kbeSKX5rYJZ+9809wOqHLlDuLOS4NChx3RZKSIcpygkdcRF6aB
         TeFYzeFy2DgGCNmJRnOa+u5BOntsjqQGK7pcKvgoJxfNuairCgMilAQOpNwCqHMZZnS3
         mrOnDRDKX48CXvPN9tA7YGuN3ly/Sk5CSjIB116G6ayZMymqaVI0cg2PZo87dSq1Xxq7
         rPTPi2GH9l5hLb+3tOxTic7CO8HSsT/4M2kL59AC3VHu8EJPhDTMmceA+uSBWGEzm1aC
         XlZns1wfcQN4nFWMbjkdAaBU32uzrnj6dJZNj3qVAWCOOQCaYYwjppILDN/zQZFSetlD
         qisA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 1 Feb 2018 09:21:34 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
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
Message-ID: <20180201152134.63e553pvoq7mbm4p@treble>
References: <20180201143421.088202488@infradead.org>
 <20180201143821.959147604@infradead.org>
 <1517496926.18619.315.camel@infradead.org>
 <20180201151136.GX2249@hirez.programming.kicks-ass.net>
 <20180201151348.GK2295@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180201151348.GK2295@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210458303680239?=
X-GMAIL-MSGID: =?utf-8?q?1591212506928773712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 04:13:48PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 01, 2018 at 04:11:36PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 01, 2018 at 02:55:26PM +0000, David Woodhouse wrote:
> > > 
> > > 
> > > On Thu, 2018-02-01 at 15:34 +0100, Peter Zijlstra wrote:
> > > > 
> > > >   * These are the bare retpoline primitives for indirect jmp and call.
> > > >   * Do not use these directly; they only exist to make the ALTERNATIVE
> > > >   * invocation below less ugly.
> > > > @@ -102,9 +114,9 @@
> > > >  .macro JMP_NOSPEC reg:req
> > > >  #ifdef CONFIG_RETPOLINE
> > > >         ANNOTATE_NOSPEC_ALTERNATIVE
> > > > -       ALTERNATIVE_2 __stringify(jmp *\reg),                           \
> > > > +       ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),  \
> > > >                 __stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE, \
> > > > -               __stringify(lfence; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
> > > > +               __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
> > > >  #else
> > > >         jmp     *\reg
> > > >  #endif
> > > 
> > > The first one, yes. But the second one for the AMD retpoline is
> > > redundant, isn't it? Objtool isn't going to look there.
> > 
> > It was when I wrote it.. lemme try again.
> 
> Insta complaint:
> 
> arch/x86/entry/.tmp_entry_64.o: warning: objtool: .altinstr_replacement+0x19: indirect jump found in RETPOLINE build

Right, objtool was recently made smarter, such that it actually decodes
the ignored alternatives.  The check for that warning needs to also
check that insn->ignore isn't set.

-- 
Josh
