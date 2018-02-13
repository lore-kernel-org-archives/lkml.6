Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518521321; cv=none;
        d=google.com; s=arc-20160816;
        b=GcRiylSm/nopAjzA/fr5SwToQIJHlRDomKy/Mak1z1Va3B7+AlZ2chojfOfgAcNrnv
         DZLuo5LV7NZEIq9ZWKcBusdah3LuptE/V0KutFzY0GhHIJsfLW3SSS06MBebLjSXUzHL
         QlFyRifiCgN8sbQuKK1fNd9HH4waEG8FEfSV8f5e7ZLbAeXMhRWdOxzVvxZDkPbxukMt
         0WQxUpjv87tmwelzrjGDg9W1OGItzBvCeKApPQv0VzGh8OTPsfwmRERIfqw6ojAGOKno
         iCufnfDQHR/5kIMa5LcidpV8JSg7XtdxCMpd+vSgw12/ABAqGSxuwwkivWcMNCwZs4A0
         tN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=HAsThtWkmVQG5pK98SmeY6gVVNdb8PF/c8rG6ZvZRZk=;
        b=uAHI0UEfOGAHBWI6/MTw9vH40pz69yDZjIS1BGHqxZrZhAxugTNJt0l3N/7awdnCku
         aSmni61bB5Qol7M/rawLG6Ua8qYFr6WJYrbfzDjRnETGX2UGl9CUd8APgpQydECgDzqb
         9la52Kd+GwteccNiped39NCt2NX+g/lQitUm1Y+ZyNWFS40Ej6WiLwsFe5cWjhDr8Qay
         DjTfTyhZRb7cNc1o4qcKI4dgY4EuhXsPRndv/lCGcL8ls6RAGpAfyQcwwmilFaN54j1F
         N3PuTtJBE2UD2lG0jYOEVFVpr1bP3pea6Ge+fzc4Y3cVR0/OFs0xHLCYDVlO83fa/pyM
         uk8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ifO9QSNL;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ifO9QSNL;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x2255J8dqpZqemxSpJsrGQOTCXFX5lz08NsBaS+6iaCXsVYkgidlulZp6bojZmdx0zvfWMS9/dw==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 13 Feb 2018 12:28:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
	bp@alien8.de, tglx@linutronix.de, arjan@linux.intel.com,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org, hpa@zytor.com,
	gregkh@linuxfoundation.org, dan.j.williams@intel.com,
	dwmw@amazon.co.uk, luto@kernel.org, jpoimboe@redhat.com,
	linux-tip-commits@vger.kernel.org,
	Joe Konno <joe.konno@linux.intel.com>
Subject: Re: [tip:x86/pti] Revert "x86/speculation: Simplify
 indirect_branch_prediction_barrier()"
Message-ID: <20180213112838.v2xu4qdnend5tflv@gmail.com>
References: <1518305967-31356-3-git-send-email-dwmw@amazon.co.uk>
 <tip-f208820a321f9b23d77d7eed89945d862d62a3ed@git.kernel.org>
 <20180213094132.GF25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213094132.GF25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592160265203742206?=
X-GMAIL-MSGID: =?utf-8?q?1592285013201292148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> 
> On Tue, Feb 13, 2018 at 12:58:21AM -0800, tip-bot for David Woodhouse wrote:
> 
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -164,10 +164,15 @@ static inline void vmexit_fill_RSB(void)
> >  
> >  static inline void indirect_branch_prediction_barrier(void)
> >  {
> > +	asm volatile(ALTERNATIVE("",
> > +				 "movl %[msr], %%ecx\n\t"
> > +				 "movl %[val], %%eax\n\t"
> > +				 "movl $0, %%edx\n\t"
> > +				 "wrmsr",
> > +				 X86_FEATURE_USE_IBPB)
> > +		     : : [msr] "i" (MSR_IA32_PRED_CMD),
> > +			 [val] "i" (PRED_CMD_IBPB)
> > +		     : "eax", "ecx", "edx", "memory");
> >  }
> 
> Joe Konno pointed out that we now need the below line too, because we're
> using MSR_IA32_PRED_CMD in this header.
> 
> With the existing code that's not a problem per-se, but my objtool
> retpoline annotation things did do stumble over this.
> 
> Do we want to fold it into the objtool annotation patch or have it
> separate?

Separate would be better, it makes sense and is one problem less to worry about?

Thanks,

	Ingo
