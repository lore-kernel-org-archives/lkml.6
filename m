Return-Path: <mpatocka@redhat.com>
X-Google-Smtp-Source: AG47ELt3JmWpcrKJxmSOWWu5C6UYzy5824wfJOHj/g/UkF8QH4WJ5lln7CI4AZ9II+MTFwxCF/MB
ARC-Seal: i=1; a=rsa-sha256; t=1520500173; cv=none;
        d=google.com; s=arc-20160816;
        b=P816iNCek+mD+jiOLKsw/eDdxVWxPN1IqobTQuTSAhiPma+I8D0VH6xXlBONjwZJ9o
         0+HNlHImxLnAoby8yscQ/9cIjk/KIDOWKWMTfvtPgaMFhWlfQMwg9cJLqu86ObTS7dvi
         XAKbtJDHiAV6NlDFyauIh+IHI1QTLJpHQKeBCf9uE81/nPbFOXnuzjebhHoePNbvn+Id
         Dobf40Y+LIQQdsOfUA37WqKhClo0TqblGXB0jVYqUr5/qwUqEUCOsHo1mStODXWN5CiB
         WgFFbnGqoKgnmzjHkFN6IkepEcgrHAbODZBf+VGHZhahZLHNpLfrbwsot3fYT1UD0m3p
         Lp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=96ODxCtSKwu6KSp4LaMKSTQvT3kqtaQX60IE4oWwjCE=;
        b=DjGFnm5vso+nQcMbb7ighcyX0ex1EF5qLTQUaX/7n6ycamQuz3G5WNM/cxCfH4WTO6
         kcIxDW9ieYiqaK99cBRX9NS3Vr5HJRcNO4cfdeQaFVvyCAgiKfbB7T2O61tzDADFnFMp
         9aXp1JDqlrqFt4Gpjs4DryA6VsZgc5vwcNmugBN2NM7+X1L/RVCtu9hFTlDnzFrNPGdX
         WDpDCVXpQzLNRxHg4GbQ7RkRxh8fK+H5uh1mZ0fkkVkTklPR780fVb1uzBZ4IUWU+rvl
         V7pawuxFyBVH3kCW3gLPwZgNvAJvOF/y1IQjG8XQzjMKQ5wGw4H+DaNCkQSPIu9AV+lt
         /MNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mpatocka@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mpatocka@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mpatocka@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mpatocka@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 8 Mar 2018 04:09:30 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Peter Zijlstra <peterz@infradead.org>
cc: David Woodhouse <dwmw2@infradead.org>,
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
In-Reply-To: <20180308073940.GT25181@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LRH.2.02.1803080406590.2871@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1803080107001.7847@file01.intranet.prod.int.rdu2.redhat.com> <20180308073940.GT25181@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594348785980298320?=
X-GMAIL-MSGID: =?utf-8?q?1594359990128667494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Thu, 8 Mar 2018, Peter Zijlstra wrote:

> On Thu, Mar 08, 2018 at 01:11:26AM -0500, Mikulas Patocka wrote:
> > The patch b5bc2231b8ad4387c9641f235ca0ad8cd300b6df ("objtool: Add 
> > retpoline validation") broke compiling 64-bit kernel with 32-bit compiler.
> > 
> > This patch fixes the following error and a large number of "can't find
> > rela for retpoline_safe" errors that occur when using x32 or i386 gcc.
> > 
> > You shouldn't use the type 'unsigned long' in objtool at all - because its
> > size depends on the compiler and not on the kernel you are compiling.
> 
> Your patch is wrong because the data field is actually a long. A correct
> patch is already in merged in tip.

I'm wondering, why is objtool using 'unsigned long' at all? Why not 
uint32_t and uint64_t? The size of 'unsigned long' is dependent on the 
compiler, so it will lead to different behavior.

Mikulas
