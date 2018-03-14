Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521034787; cv=none;
        d=google.com; s=arc-20160816;
        b=XMllTVWUlta64hYXVWeIAtQqRGF6n0kHYPJc9fbJAKWfZCOC/mpxf8NaX5Ro4TKJb5
         /RlWoT7mCyCOav6aMp6BsfqctU7Qd5dwPutWDQgvnJSn44I6wqNESR/PHSdNQQ8wzrln
         GchLSiKUrDf7jqBbHwGIbeFp8yjjMKyOf7Q+ls2Uxb0ZbpDWae0JNka9oHjRcelnk9Jv
         aB1821A6rce33viSyrxNGsukrOQgB9H/YR7p/OtkREedYNs4hDY2X39tj4FX2s6JA6gm
         eUyjcawa5HzP4AI9EBOGDlTfssMZtFf/85TYFhMdlTgUbUfG2cc4vgoOsXaoQqwdSEya
         mzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=wXk+Yy5DWnWiyBrTYRSCf+qnNTicb+qGHo+RDKS3lCs=;
        b=YTFWo86oT5B4LbHM6zfibsAC8PYSvGv+Fl4XX8FQBU5IZ7tAnZprhW4xACGdT+CwfZ
         P3EqkezIER2ClXFKuqYEyhhWltdE8oaXSGGfjtnz3+5mvzg6EpAxJBS23EJgVLKGPWSR
         o7375quec3fmz1HAxKM1Z0WtE8sg4tmmHAPsY1EwMyy1CEp9w1ireAfvqStEQKS32W+D
         juXdaGU4l+5Kti/FpomH0Z++40h6sZDS5Iq4EYml75xVfq0La19EtAU5AGRoVHL+KO+N
         Gvkj3faCoUcUaw9lPSbaK9a9+FGlRQ7hV66nc0M0zZQswWBKTROQiIkk2fpQsKVLmmDk
         VycA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z/h1Vvnr;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z/h1Vvnr;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AG47ELu7kPMZ1JLm4MYjxWk+vf6g0WGXhTjEzYcgI7I0j2+IrkPbX1nY79m1/HOGEgvNu7aju0xagg==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 14 Mar 2018 14:39:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tip-bot for Andy Whitcroft <tipbot@zytor.com>,
	linux-tip-commits@vger.kernel.org, hpa@zytor.com,
	dave.hansen@linux.intel.com, arjan@linux.intel.com,
	dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, apw@canonical.com, bp@alien8.de,
	luto@kernel.org, dan.j.williams@intel.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	peterz@infradead.org
Subject: Re: [tip:x86/pti] x86/speculation, objtool: Annotate indirect
 calls/jumps for objtool on 32-bit kernels
Message-ID: <20180314133943.t5dorqzvlieotljx@gmail.com>
References: <20180314112427.22351-1-apw@canonical.com>
 <tip-a14bff131108faf50cc0cf864589fd71ee216c96@git.kernel.org>
 <20180314130329.cmsc7mqnfrm2iop2@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314130329.cmsc7mqnfrm2iop2@treble>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594916116672090070?=
X-GMAIL-MSGID: =?utf-8?q?1594920573352348045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Mar 14, 2018 at 05:28:01AM -0700, tip-bot for Andy Whitcroft wrote:
> > Commit-ID:  a14bff131108faf50cc0cf864589fd71ee216c96
> > Gitweb:     https://git.kernel.org/tip/a14bff131108faf50cc0cf864589fd71ee216c96
> > Author:     Andy Whitcroft <apw@canonical.com>
> > AuthorDate: Wed, 14 Mar 2018 11:24:27 +0000
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Wed, 14 Mar 2018 13:24:31 +0100
> > 
> > x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32-bit kernels
> > 
> > In the following commit:
> > 
> >   9e0e3c5130e9 ("x86/speculation, objtool: Annotate indirect calls/jumps for objtool")
> > 
> > ... we added annotations for CALL_NOSPEC/JMP_NOSPEC on 64-bit x86 kernels,
> > but we did not annotate the 32-bit path.
> > 
> > Annotate it similarly.
> 
> This patch has no effect because objtool only supports 64-bit kernels.

Yeah, indeed - but it's still a good change for completeness, right?

Thanks,

	Ingo
