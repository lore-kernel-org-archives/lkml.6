Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x227iaPkIdkibid7twsqXC3MMlLsAf+TbDrycQfDc+6oO88IQZUqdKOPZ95eD2uEayeWPMbSc
ARC-Seal: i=1; a=rsa-sha256; t=1518447654; cv=none;
        d=google.com; s=arc-20160816;
        b=Zm89ot+kcOxze8aYEPH2X7WLnAhB+06H/NI5FrU4GrjxzIDX+v1QbqmCx4e/0I0AC0
         blimA4ap9kBZ+TwQjOUMHRnnmlfDpH3TnScl7G13JcT10jfdnGrzKuNX0IhrO1unicP9
         UiYNJEY5c2sP9ead6M6bGKz4m/5nT4KX49mGYKJff1VdlcszFCdCUMzHjUtBP9zbftMe
         jRs0fcsp9f77O/HA98AWip/EOHHYJfF3aA/TuzdM6XholflYHYntITRoQbBPHrL7S9YC
         jQiDlyWMAgtaq9yIW2nDaUsacWkE7iyvEEpiBZ9Un8hfNbJnr879PQ1sWCdHL7IEwEH4
         XeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=tUdYcVk7LpyI2jNX5cXSCOzfHVF6GKVt2KEEbLMMTpA=;
        b=EaueaKDkNyZNcbMmrd0N5wVx/HBioV8o9bt3isCutiNkfAhR29aiCpc+0EyKM0c7LZ
         g4uY3Cuk8x2VjvjXRv9/PTDXHbNRpSvZjnhqy/ipsBby/UH3fTwqzrUHWM5CRT9xKJS0
         HnFHk3WfAN+1qsDigLofrb3l/hKtXrB2KjlPN7ewdBzp2hfkzXovcnRauCnfvlL0S8EL
         V/Bcblnhp6tZLCfo/cDtvlq93ZHY4EFZEVvtaZLUji4V1hsR7VTpFQz4dzq7xiViwiY3
         F1O7HBhT46XGk252OvvW2mkmfbTOF4GqUTATTJHr/j3PFVLRYKgzo1XpQWl7FohHXlzS
         Bfwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=bi7CribP;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=e2OrIs6F;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=bi7CribP;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=e2OrIs6F;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 12 Feb 2018 15:59:24 +0100
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
Subject: Re: [PATCH v2 4/8] objtool: Retpoline validation tweaks
Message-ID: <20180212145924.GN25181@hirez.programming.kicks-ass.net>
References: <20180212124855.882405399@infradead.org>
 <20180212125033.448828374@infradead.org>
 <1518440260.6606.58.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518440260.6606.58.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199715849356959?=
X-GMAIL-MSGID: =?utf-8?q?1592207767848968655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 12:57:40PM +0000, David Woodhouse wrote:
> 
> 
> On Mon, 2018-02-12 at 13:48 +0100, Peter Zijlstra wrote:
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -486,6 +486,11 @@ KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG
> >  KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
> >  endif
> >  
> > +ifneq ($(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register),)
> > +  CC_HAS_RETPOLINE := 1
> > +endif
> > +export CC_HAS_RETPOLINE
> 
> Can't you do that with the existing check in arch/x86/Makefile? 

I couldn't make it work there, but it could be my makefile foo isn't
strong enough. The ordering of arch/*/Makefile vs scripts/Makefile.build
is forever confusing me.
