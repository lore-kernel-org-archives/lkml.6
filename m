Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AG47ELuN3tZqPjzGiIgQddUvtRB3D52fHxspMYYt3TRb1goHZJfvXyZ+ZKfElj1EWxQsYl/Iz0Fo
ARC-Seal: i=1; a=rsa-sha256; t=1520522275; cv=none;
        d=google.com; s=arc-20160816;
        b=xqMvXPpr3D5e91dH1u0qyf6Ttj0icyooWFLAMjlY/MGh6LcCcCVmw80dv6g/bJMF+P
         HRoGW++pgtVWCMsn2owinWCERdh4lECzu0Sdmn/VBrjUeRD3PdS94jyfYF0vSpr7w46k
         Cd8Jn5JEp34H/vuqU0+IJEpz7y+cbghMHWBNhWBUuwgnlhC1y4gIf2Q2wAU7Y66kZyiT
         1l8jrfUX8B1KuTA4g6CY60wGBHBglLnkFxblesD0tW3Zq2w0AJ7vmxFaPnSlbCbSyzEQ
         DG+OdjmgLJivsF0w8zNUyIgVBzm2MHEa4vLbdTRcsyiO/c0vUoojjGOgcVOuHbspRck0
         0sCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=XLDlG1ayQrHgcJVmgqHNvAzIHO+uGbl9799YPd18G7k=;
        b=0XrCiRTM3qt4pl+N4Ut5YNtGmL23RWX7TQw8qluBVtvzocTpmwF2vZYEDE1v4jRBN6
         V2VaK+oWLu/CWy0moTjiMjbqGAn4JtIiY19l/vFGyAm13P39PnKaI4DZigRMzWUxc5YM
         P0IAUxREUd1r6aRZME3MF03rh1AM6DyoL/1+6/V6Afs75Hr1SYfKoVZjzryEP8J9vKUn
         mf6ChbhsZvTuHg/Lodn454yrOgjfWrokM7ShbpIp0CogVLwhMG+LXtbgpis5YgDLjW6P
         dKU00LCT2HSz0GcVpw2tzeMghHGOlfWWRm/Om0Pws4ALzxdLVEuM9TQVXA38KgNIT958
         YeKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 8 Mar 2018 09:17:54 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix compilation of 64-bit kernel with 32-bit compiler
Message-ID: <20180308151754.d7wozkcuapi4bpvn@treble>
References: <alpine.LRH.2.02.1803080107001.7847@file01.intranet.prod.int.rdu2.redhat.com>
 <20180308073940.GT25181@hirez.programming.kicks-ass.net>
 <alpine.LRH.2.02.1803080406590.2871@file01.intranet.prod.int.rdu2.redhat.com>
 <20180308093944.GU25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308093944.GU25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594348785980298320?=
X-GMAIL-MSGID: =?utf-8?q?1594383165773232178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 10:39:44AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 08, 2018 at 04:09:30AM -0500, Mikulas Patocka wrote:
> > 
> > 
> > On Thu, 8 Mar 2018, Peter Zijlstra wrote:
> > 
> > > On Thu, Mar 08, 2018 at 01:11:26AM -0500, Mikulas Patocka wrote:
> > > > The patch b5bc2231b8ad4387c9641f235ca0ad8cd300b6df ("objtool: Add 
> > > > retpoline validation") broke compiling 64-bit kernel with 32-bit compiler.
> > > > 
> > > > This patch fixes the following error and a large number of "can't find
> > > > rela for retpoline_safe" errors that occur when using x32 or i386 gcc.
> > > > 
> > > > You shouldn't use the type 'unsigned long' in objtool at all - because its
> > > > size depends on the compiler and not on the kernel you are compiling.
> > > 
> > > Your patch is wrong because the data field is actually a long. A correct
> > > patch is already in merged in tip.
> > 
> > I'm wondering, why is objtool using 'unsigned long' at all? Why not 
> > uint32_t and uint64_t? The size of 'unsigned long' is dependent on the 
> > compiler, so it will lead to different behavior.
> 
> Because pointers... As Josh said, I should've used the right ELF methods
> which use the object's ABI.

But there are still a few other places where objtool uses longs
unnecessarily.  Those should probably be converted.  Patches welcome...

-- 
Josh
