Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AH8x227lb7sCzTEqInaufKUny8QKKRIHp0lzfM9QdNVzdYeyFsSG1JRMW5zXbwefTgfNlNUp3onE
ARC-Seal: i=1; a=rsa-sha256; t=1517507018; cv=none;
        d=google.com; s=arc-20160816;
        b=RJTSKkBtRjGNORKhE2yS9kxVYiPmD0PW4zh5xdS6mnhquFO2CxF1MJREBaF5HkBhIK
         eJEx6zhM1ob1dwaIXao04x2Vu3eVyA8nt7qrFceWbo0FetJlU8fCvt8jvAvaPJhsYVig
         xPtDe1ZDpM61oq8kkwr/7B4QCkg7nVIpUwoXwxDJ4HYD9ROidLkYVdY7viHkQrR+cebS
         9XnaKYD9I6c1d7mF3KRSE4/PnzsEwIljfG89d/qZHTIkSRFeTwERktDj5RDYpklp+Kiy
         mgD7lC8z7uywEqwCcP2v2bwb2SUr3MmBU4fOq/+VqP5vQaEJCMLeowsqmB1xxqZ8081u
         A4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=vbNvSjiwbyMJxOXJ7Y7yMWIqjg6YjP3zHv7dNa+YF2A=;
        b=QEYbtx8P5Ucc4hfM8/9AXfAwmPDX5yOXpGfraRqpkPST5Dyeiz8lPcnOyaTWnwUz04
         JC9stoelmaSnbv7quCrkWMNNCfHowLx/Rv6/opJxvkdzQOZc3tlP64s2ACNhhTg+MbHY
         K4BvjX2Dq40jjnwgtYB4ABmMrDoNR0UA9yPO5BAY3y/kFsVfgK9mwuxwdIX4ux9c+4pi
         zFP5uwe4zN/Kwcy0BZUsaqltbsHtXPyawEcoZlU0/OXcbXu4xiiJR/kOxfdc4Nl0hihF
         tLanXm8KsHlNKvdpoTC7YCqTYavDtY4M0DHXm7yLoKvKN48TpvoimRh5Of48vEGU3azi
         QVow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 1 Feb 2018 11:43:35 -0600
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
Subject: Re: [PATCH 0/7] objtool: retpoline validation
Message-ID: <20180201174335.3tccxfotu7slriuu@treble>
References: <20180201143421.088202488@infradead.org>
 <20180201152856.okzhqvdlledykzps@treble>
 <1517499131.18619.317.camel@infradead.org>
 <20180201154028.GA2249@hirez.programming.kicks-ass.net>
 <1517503895.18619.319.camel@infradead.org>
 <20180201171427.GD2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180201171427.GD2249@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210454988302775?=
X-GMAIL-MSGID: =?utf-8?q?1591221440186755877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 06:14:27PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 01, 2018 at 04:51:35PM +0000, David Woodhouse wrote:
> > > Ideally we'd have a way to mark the module 'unsafe' or something.
> > 
> > No, we just need to set IBRS before doing it. 
> 
> That would work, assuming IBRS is available to begin with of course. Do
> we WARN if we hit this code and don't have IBRS available?

Perhaps it should just be reported in the spectre_v2 sysfs file.

So

  "Mitigation: Full generic retpoline"

would instead be something like

  "Vulnerable: Retpoline without IBRS"

?

> > The same applies to any
> > EFI runtime calls, APM and all kinds of other random crap that calls
> > into firmware. I'm not sure why those aren't showing up.
> 
> arch/x86/platform/efi/Makefile:OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
> arch/x86/platform/efi/Makefile:OBJECT_FILES_NON_STANDARD_efi_stub_$(BITS).o := y
> 
> And similar things tell objtool to please not look..

Right, some of the corner cases like efi, vdso, and bpf tend to be
ignored by objtool right now.

-- 
Josh
