Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x224sJIAvcZOoVsX+7kfeuxJLyvexwouysH5PORfHaPlv8Ze7zyWlop288gA9dB2Ec62xu+B+
ARC-Seal: i=1; a=rsa-sha256; t=1517497910; cv=none;
        d=google.com; s=arc-20160816;
        b=DRccg5MQsl049KlTE48TKeJYjAiBH7pyZRMHF8ec8Q44s1DhcpbxXdcwOl4sM94sI3
         t0N0ugkn3zCsZ7/T5UgK7uviOyYnFnMdROtoh6Ukgnjgetxe3YyEaASW9rH3cvG3ucgn
         xCQi9ilcEgiMzisjCq86b6FDPqQQrDPEYb2LefPS+qFuj+EdwhZQLmYNmpcl+oKHkcdV
         plpKC13ToDi462z4mG/Ayxsg1/fMku/2bw2uiTjDgf+szFL6hpuMk7c6bfPxAs3nExAD
         ih5+zD7YOxwHRZ+hy7V8GJofMgmM+2MWmSoQUDnk1bznOz3Z3O3kq2xr1qHx4lqt041L
         7I5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=PxLyXeEYj0pL4wDT3djdRK/42yrGw9jhFKbgR001xkk=;
        b=IrDE3qyGbEQnpSdWY2Zo7JFBxiYTy33HRnUS1fVuF2Mew9oei2eqyfEPkFFjclnoeU
         eEXJ3peI9gJC+AfgyCAOGmBJm1xFH4FnTokOVDhafOQHB/ZuopjXy2oD62Ixy0H+AqI+
         AFQqXN5UbC9Dqwotkhw7lkmXlpeX2+WmFXXCOuNBOwvqBo8MlE1RQ99rCe4Bnj64/3nE
         y58cY5JRNGqsi1wEzUmIy4IXF6cWoTmr31rJNfrJtmQCTnEHkC2d1GKOUi1vjDojD3Xw
         Xn9Y/jrPQlnIMlgT2SKTZiS0Ix4qtAHXUBPqU3bb4U9PEDlPOhQ2G+qYYk6KWz/T9J54
         lIJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=FaeA9IdE;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=FaeA9IdE;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 1 Feb 2018 16:11:36 +0100
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
Message-ID: <20180201151136.GX2249@hirez.programming.kicks-ass.net>
References: <20180201143421.088202488@infradead.org>
 <20180201143821.959147604@infradead.org>
 <1517496926.18619.315.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517496926.18619.315.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210458303680239?=
X-GMAIL-MSGID: =?utf-8?q?1591211888274869588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 02:55:26PM +0000, David Woodhouse wrote:
> 
> 
> On Thu, 2018-02-01 at 15:34 +0100, Peter Zijlstra wrote:
> > 
> >   * These are the bare retpoline primitives for indirect jmp and call.
> >   * Do not use these directly; they only exist to make the ALTERNATIVE
> >   * invocation below less ugly.
> > @@ -102,9 +114,9 @@
> >  .macro JMP_NOSPEC reg:req
> >  #ifdef CONFIG_RETPOLINE
> >         ANNOTATE_NOSPEC_ALTERNATIVE
> > -       ALTERNATIVE_2 __stringify(jmp *\reg),                           \
> > +       ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),  \
> >                 __stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE, \
> > -               __stringify(lfence; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
> > +               __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
> >  #else
> >         jmp     *\reg
> >  #endif
> 
> The first one, yes. But the second one for the AMD retpoline is
> redundant, isn't it? Objtool isn't going to look there.

It was when I wrote it.. lemme try again.
