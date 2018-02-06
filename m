Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AH8x225+g6XeLCD0/nBG5MyucquZwrpg0fhAF0UwuGVM07OM2oxWfH1ok6zekveKsZq/MsdrvKTr
ARC-Seal: i=1; a=rsa-sha256; t=1517959518; cv=none;
        d=google.com; s=arc-20160816;
        b=LLpBTu+TgrZhKjxQxKieUH6Y+nzCs5iwnQMuUza0wrR72RPgsEGEY4Xf3wtDTV/wve
         UGyeTbyTjSkQCH/66w4yVY5WSwH/nuRUCKXkFpH93aqx71Bqy9TPlgKjtRCHJUotQfxG
         ymMjKYybNLKCCE7aGewp6swjPHYrqVwppOZbn6ClnuZekuUY3BhakYzAXQtNcd8SFt4F
         B8u7pv5Sh6YD049noPbjI+gbx7YAYo6NBdBElmS0lBzNXpaHhb9h2TUYoX1+HsV4Y0Pm
         qGizr8IVq/12heEooJYiLpFN8Kk3VQxo/vuYj1uazI45jke4/v33BZp3IOq8/ty0ktSw
         9HHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=/E+DD1lKNfktXsOkirTNdvxFmjKwyYx0nE7RrENYXVQ=;
        b=JgUa5PpOqHrVhbe3DjrHk18XZOYGFaVq6X+il2SDEUcwWHklU+G4Co5OASlqFKK74z
         PNQva85puHaLkoNIFWG6NbDEGOxsfXlIpBwTht4DHOGA1dEYhx9pCqxDB5z49Pl2q4Zo
         fYyEFKVvrDy4LA3/GxY0M6aGuSWOmYUxD5lPdYV4nFZ5W5vFhuo6bPq6g5Cozr2lwWdC
         8IvkiUlT9Wm8yL2hDcpkdOSDFUGI4sQRLP5URkUInHgXwtFHG79xzyvnV8mheaQdzdKU
         WV49jcjsBGfteY5Rmasz+jOywdq/irfuIaAW0gm1CCFkWJuxrhRW+6YMDJxhmzaHjN7M
         OnlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 6 Feb 2018 17:25:14 -0600
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
Message-ID: <20180206232514.qcy4y3dzfkjo3xdg@treble>
References: <20180126121139.31959-1-bp@alien8.de>
 <20180126121139.31959-4-bp@alien8.de>
 <1516970011.30244.223.camel@infradead.org>
 <20180126132431.fsbd3c3g2yreazy6@pd.tnic>
 <1516983879.30244.236.camel@infradead.org>
 <20180126164746.dpo7dswid5tjk2tz@pd.tnic>
 <20180126200616.5xfn244uzeu7ptyo@pd.tnic>
 <20180126200813.cignvfovk2dhlzbh@pd.tnic>
 <1517946292.3677.22.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517946292.3677.22.camel@infradead.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590686965266539786?=
X-GMAIL-MSGID: =?utf-8?q?1591695920249412393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 07:44:52PM +0000, David Woodhouse wrote:
> On Fri, 2018-01-26 at 21:08 +0100, Borislav Petkov wrote:
> > Make it all a function which does the WRMSR instead of having a hairy
> > inline asm.
> 
> ...
> 
> > +	alternative_input("",
> > +			 "call __ibp_barrier",
> > +			 X86_FEATURE_IBPB,
> > +			 ASM_NO_INPUT_CLOBBER("eax", "ecx", "edx", "memory"));
> >  }
> 
> Dammit. I know the best time to comment is *before* I add my own sign-
> off to it and before Linus has merged it but... I think this is broken.
> 
> If you're calling a C function then you have to mark *all* the call-
> clobbered registers as, well, clobbered.
> 
> If you really really really want to *call* something out of line, then
> it would need to be implemented in asm.

Hm.  In theory I agree this seems like a bug.  On x86_64 I believe we
would need to mark the following registers as clobbered: r8-r11, ax, cx,
dx, si, di, plus "memory" and "cc".

But I'm scratching my head a bit, because we seem to have this bug all
over the kernel.  (Grep for ASM_CALL_CONSTRAINT to see them.)

Many of those inline asm calls have been around a long time.  So why
hasn't it ever bitten us?

-- 
Josh
