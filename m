Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x227NOy40Ofxjt+QtPtKBRUBzVgCbmSLkyrLbVIYoflVCv1pH8yir+3Ae3uMyhWnsoDE++39z
ARC-Seal: i=1; a=rsa-sha256; t=1517499017; cv=none;
        d=google.com; s=arc-20160816;
        b=My/RzAT3RGVNtV2aLDOtbvwtANeQ2sZjSI3LDepcrxFM06vlTkVq93jv6Hk45dj/iL
         UqMpHgFvBFPjoEsh7wBA9WXrJkTeWhZ3tCXkXn9bVEtbvTK02aR2AYKjoE8gsbpvBILZ
         9GsEHbW07U1rFhIFLR0r0Xm7ds/wnElD3O2ZcNAoNO3+mZbk+ek4pQn2fCvI/OvX364j
         KmhsYxbsSifUb/SWefxjQQbf/o74zTt/8KW6g2ldBkmBgwVCOUD+ds91v+3gkH+jTV+9
         gwVxmL+0nYVmgSd/QvtxGz7zZe0ca/Lh6RPAlwp694JZ1KmsNMPGXwJpmdMpQMrp1APV
         1T6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=kzJ344V+jOb+h1Rw/DdXAUmiIBOrVbP13XQlYawQAAU=;
        b=NZzNvxS9gMQDjtfpKP9TNx6Yugm63DU9SQa2EtlaP/Ut64yK8OCkncOJ0SXkD57hc6
         Z/Oi8b/tBjzkVw51sho60MCyWCbmZdY/zvhrPGxkVehskzAGGcXIiKQV/uxGN3oOcgqw
         VGJpfmiNJuNqh20VNGKQAwt6IxWQNzJTjNVu+t0CFr54rF0QQEoiHt5beVTXz22AVuvc
         40Gy8+BN47sDHgQ1g/zxDIxVpVnFDl8E12drOmhJnXIUJ2u8LTxJFnWqw/0JHaxPEQup
         B4hYWsZKnoJGxtnXifsyehxc/BckL28NfLput2e6cdeWMbNOxEe1K6C2mjJCG4m7j0bo
         NoZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=D9E+F2zi;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=D9E+F2zi;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 1 Feb 2018 16:30:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
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
Subject: Re: [PATCH 4/7] x86,nospec: Annotate indirect calls/jumps
Message-ID: <20180201153005.GY2249@hirez.programming.kicks-ass.net>
References: <20180201143421.088202488@infradead.org>
 <20180201143821.959147604@infradead.org>
 <1517496926.18619.315.camel@infradead.org>
 <20180201151136.GX2249@hirez.programming.kicks-ass.net>
 <20180201151348.GK2295@hirez.programming.kicks-ass.net>
 <20180201152134.63e553pvoq7mbm4p@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201152134.63e553pvoq7mbm4p@treble>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210458303680239?=
X-GMAIL-MSGID: =?utf-8?q?1591213049322544222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 09:21:34AM -0600, Josh Poimboeuf wrote:
> On Thu, Feb 01, 2018 at 04:13:48PM +0100, Peter Zijlstra wrote:

> > arch/x86/entry/.tmp_entry_64.o: warning: objtool: .altinstr_replacement+0x19: indirect jump found in RETPOLINE build
> 
> Right, objtool was recently made smarter, such that it actually decodes
> the ignored alternatives.

I think it always did, you just ignored the alternatives for the code
flow stuff.

> The check for that warning needs to also check that insn->ignore isn't
> set.

So I tried to keep the two annotations independent, thinking the code
flow ignore would eventually go away when we got smarter about it. It
even has a comment about that:

/*
 * FIXME: For now, just ignore any alternatives which add retpolines.  This is
 * a temporary hack, as it doesn't allow ORC to unwind from inside a retpoline.
 * But it at least allows objtool to understand the control flow *around* the
 * retpoline.
 */

So I'm not seeing how making retpoline_safe depend on nospec_ignores is
a good thing.
