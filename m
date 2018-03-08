Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AG47ELsbitIqiun8vX25zabiWnoIbrT2kO9P1w+VaZUMt6utp2d/ESLAL6ABEhaXTUngRtjiUCIk
ARC-Seal: i=1; a=rsa-sha256; t=1520501999; cv=none;
        d=google.com; s=arc-20160816;
        b=ShQQdcB/KfYtcSqzZxRzCgkCrbgR1L7wCvVSMDaXzUDGdgTbTdQZCW1p7todfN9OJE
         3Rno9hLO1I4Qqt0iJFk27niT/oh5AAd5UCtWKSrctET9twF5zSgSnKHsL616ptk0Jv1P
         km9BBs1bFKq3c9oykZxDRsnoSxBWt3PEQEHsvOr5ddNg9T0EApVQb59ByyQdYA/HYToY
         L1Lf4w9Bm9L8y2ZO8RUTaX/Ze3uRXq4sZ/jbYk4T2xUpfd+fFh9WaWPx/NxYISfV5k1B
         KrHOVOKl74qsScfxLaMMVvOHbmKpK7JW0Js6vxUcpzKkjVl09bT2dQdmvoBvIFSHAvPd
         HbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=OL/Wy+O/sLK3dZFc5Z9vB29xhnOufzxdeTssvfeYwvI=;
        b=v45JvvhFkuPWv0teYn4SohyXwydlokmvCLSYK0qaOovau+wBMUpyPVl6NmzT9yNWYe
         dOPjc/jlJsCIYZtl6tJ67VKHlGWNrZCag75J9y2mokaq7dbln54BgSvHJbkJPbUfz5qd
         Q5SGUld06wjfmJdrit8QS+s/QfwlFk/Z9KQR/xKJleyug96t3623qPLUJrV10OxvWcSL
         RXzuGUF+YUjVHXyF+ISlnso9Y6+qLeBiPSFwGGKjsu7GweWVy9vjuNzYRxHKK2kMxhri
         VNIKUT1DVmQtwRiee8hVT4/DuuHLnjPxWmiaBaMaVMCq2kKtFIUpll1ZBdCwWllGWe6c
         DQJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=lnxXp5aF;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=lnxXp5aF;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 8 Mar 2018 10:39:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix compilation of 64-bit kernel with 32-bit compiler
Message-ID: <20180308093944.GU25181@hirez.programming.kicks-ass.net>
References: <alpine.LRH.2.02.1803080107001.7847@file01.intranet.prod.int.rdu2.redhat.com>
 <20180308073940.GT25181@hirez.programming.kicks-ass.net>
 <alpine.LRH.2.02.1803080406590.2871@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1803080406590.2871@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594348785980298320?=
X-GMAIL-MSGID: =?utf-8?q?1594361904147442901?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 04:09:30AM -0500, Mikulas Patocka wrote:
> 
> 
> On Thu, 8 Mar 2018, Peter Zijlstra wrote:
> 
> > On Thu, Mar 08, 2018 at 01:11:26AM -0500, Mikulas Patocka wrote:
> > > The patch b5bc2231b8ad4387c9641f235ca0ad8cd300b6df ("objtool: Add 
> > > retpoline validation") broke compiling 64-bit kernel with 32-bit compiler.
> > > 
> > > This patch fixes the following error and a large number of "can't find
> > > rela for retpoline_safe" errors that occur when using x32 or i386 gcc.
> > > 
> > > You shouldn't use the type 'unsigned long' in objtool at all - because its
> > > size depends on the compiler and not on the kernel you are compiling.
> > 
> > Your patch is wrong because the data field is actually a long. A correct
> > patch is already in merged in tip.
> 
> I'm wondering, why is objtool using 'unsigned long' at all? Why not 
> uint32_t and uint64_t? The size of 'unsigned long' is dependent on the 
> compiler, so it will lead to different behavior.

Because pointers... As Josh said, I should've used the right ELF methods
which use the object's ABI.
