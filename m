Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AH8x225os5yn/k3nu/gPD8FZ1So/b4Phc3HRZyfPMMp4DMcEX2YQY2ZciZNVvNnSC78IgHYs/93W
ARC-Seal: i=1; a=rsa-sha256; t=1517960975; cv=none;
        d=google.com; s=arc-20160816;
        b=uX7VWM9awigzznRVa4sYG48SJcxU8gLIT6IUaiB1uUJn8dYOC4GcBmT49yUxHnCp0r
         dhUjR6RST1XaugIcbppFsJMFP58jG0968FW1Yl6SRcyer7U9orcueUInCnkz047/m7/a
         83Ew7/QsKcHHZ4FF0icFNlScdtxZCA8CQBrMUyO36EPzEOYTvdeNcz3ldPUryDPa6ods
         SwoQmasAAhEjkuXt0UFWFXNs07w7F4SHme9iquYSix/mw/OoQ21HVVNDTrlWNXR63ZJy
         +R3qqKcCnNkF03gNBj8abWGbB0un++3zW2vMiQ+EeR3hSSe+1ah35mtErZ+pyVqM0uRW
         DhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=RK/jeEmPhxjWITqFEoItCXw4XaYBRHeI0/A0IDcro8c=;
        b=eqpAjvwpjgAA3s8aBNzV3bsNw7hshZSuEBMSyTEdsgdj8BqOCccbzWfO8zMiuYxx1a
         mpt0O9gzpDU3wMN5frhlZXLjD3KGNpOqtTNx0lhxP9pKbi/nOBwimCrLXxe5HTZoMmGy
         SkxeIdz30AW1X6BUBIRf5/N3iuETSy13nwrsFpQn+yalQ5TZbKmDBfeRGsoWsywswzcp
         kHA+Y2x1vOFVPyPqjDY7zCEUiQp9QVVsKfuFHLQgUUN0FrfJMbzLjXs8vBi3OZf484bN
         4B0WeENIF5QBnTETknfHXGQXE4ophFoTDHtNNKtxxlY/ePTPHlXHTp0aPHYsCe0giVnS
         ij9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 6 Feb 2018 17:49:32 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, tim.c.chen@linux.intel.com,
	pjt@google.com, jikos@kernel.org, gregkh@linux-foundation.org,
	dave.hansen@intel.com, riel@redhat.com, luto@amacapital.net,
	torvalds@linux-foundation.org, ak@linux.intel.com,
	keescook@google.com, peterz@infradead.org
Subject: Re: [PATCH 2/2] x86/speculation: Simplify
 indirect_branch_prediction_barrier()
Message-ID: <20180206234932.jlctz3u5ybq6gunz@treble>
References: <20180126121139.31959-4-bp@alien8.de>
 <1516970011.30244.223.camel@infradead.org>
 <20180126132431.fsbd3c3g2yreazy6@pd.tnic>
 <1516983879.30244.236.camel@infradead.org>
 <20180126164746.dpo7dswid5tjk2tz@pd.tnic>
 <20180126200616.5xfn244uzeu7ptyo@pd.tnic>
 <20180126200813.cignvfovk2dhlzbh@pd.tnic>
 <1517946292.3677.22.camel@infradead.org>
 <20180206232514.qcy4y3dzfkjo3xdg@treble>
 <1517959878.3677.54.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517959878.3677.54.camel@infradead.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590686965266539786?=
X-GMAIL-MSGID: =?utf-8?q?1591697448088742261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 11:31:18PM +0000, David Woodhouse wrote:
> 
> 
> On Tue, 2018-02-06 at 17:25 -0600, Josh Poimboeuf wrote:
> > On Tue, Feb 06, 2018 at 07:44:52PM +0000, David Woodhouse wrote:
> > > 
> > > On Fri, 2018-01-26 at 21:08 +0100, Borislav Petkov wrote:
> > > > 
> > > > Make it all a function which does the WRMSR instead of having a hairy
> > > > inline asm.
> > > ...
> > > 
> > > > 
> > > > +	alternative_input("",
> > > > +			 "call __ibp_barrier",
> > > > +			 X86_FEATURE_IBPB,
> > > > +			 ASM_NO_INPUT_CLOBBER("eax", "ecx", "edx", "memory"));
> > > >  }
> > > Dammit. I know the best time to comment is *before* I add my own sign-
> > > off to it and before Linus has merged it but... I think this is broken.
> > > 
> > > If you're calling a C function then you have to mark *all* the call-
> > > clobbered registers as, well, clobbered.
> > > 
> > > If you really really really want to *call* something out of line, then
> > > it would need to be implemented in asm.
> >
> > Hm.  In theory I agree this seems like a bug.  On x86_64 I believe we
> > would need to mark the following registers as clobbered: r8-r11, ax, cx,
> > dx, si, di, plus "memory" and "cc".
> > 
> > But I'm scratching my head a bit, because we seem to have this bug all
> > over the kernel.  (Grep for ASM_CALL_CONSTRAINT to see them.)
> > 
> > Many of those inline asm calls have been around a long time.  So why
> > hasn't it ever bitten us?
> 
> How many are actually calling C functions, not asm or other special
> cases like firmware entry points?

I think many, and maybe even most, are calling normal C functions.

-- 
Josh
