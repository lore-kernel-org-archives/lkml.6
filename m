Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x227Jh+BKtKNwhwXGGPJpq3W9z8NURCcDPZaykXy1zz6KeDqtXLvSIhd0UF//66gcYwfNGLK5
ARC-Seal: i=1; a=rsa-sha256; t=1517505278; cv=none;
        d=google.com; s=arc-20160816;
        b=i2957MRf8as9pN/lz3t7riQ4p4lss+5zaLmUrXEUIqa8I+LHfnUavZEVXDQYNTwvQ2
         zT5JErV4nMgARo9YEeVZ+Qp+JyRyyUiRHXlaJiTHGCrfWFbuSzxIPAaK+c+PSLSc6L+O
         vRSDfhZxv6Vw+XxUPRxxNKIsLXYyXanTfYcXCYrkzMPO6z2fzCqdq1GV03TkHWwmTmsH
         SorJUfMks7VJdsnTxrA4vyvpDIIyohIpewGODXxAbnThuWz6rSMJC9lHYxi3quR1Urc1
         Y9WquM1C1QU6YXSVkKCvlFUdiu9Fp2jHCbsPfREFck/Di4bE5M/uZSmyL4FCm2yDtr5W
         Y+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=1CjD2Nc94Xw4h6tkoLwOQqG+MAd7pvLlNBUil3u8WHQ=;
        b=ArLgxibJG/VviKpXmcv4lGoCKr4u/xzqOMOOcNFk/yybmJdPjQ9hOh3XQQ/yp/yoJO
         5Rt3wjSrk6v5EaTeC5Mw0Liit2VDDJIoUeTzDFTQHXmDYY434mMKlvQnMZDMq6nk2gEG
         t0NJbZnOenAf6oB8vsA23Ssw/92UK45F4xRUOMX7wMNbJj7EtlIuyEaIt7ewlnuk/Lrt
         J1i7kFu51X+x8SyktcU9oCzRA7/4tCa/v5HUn+wgFSx4GNWNbmFMUDEEANVkYI2WTNdL
         glgHau9HGYakFYRdG48BDQu21MzWYomMMOMJPrwiXm1ky1SMzVn4/Lok/ZItGqrHemjo
         QdPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=NN71o+ml;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=NN71o+ml;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 1 Feb 2018 18:14:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <20180201171427.GD2249@hirez.programming.kicks-ass.net>
References: <20180201143421.088202488@infradead.org>
 <20180201152856.okzhqvdlledykzps@treble>
 <1517499131.18619.317.camel@infradead.org>
 <20180201154028.GA2249@hirez.programming.kicks-ass.net>
 <1517503895.18619.319.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517503895.18619.319.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210454988302775?=
X-GMAIL-MSGID: =?utf-8?q?1591219615006918876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 04:51:35PM +0000, David Woodhouse wrote:
> > Ideally we'd have a way to mark the module 'unsafe' or something.
> 
> No, we just need to set IBRS before doing it. 

That would work, assuming IBRS is available to begin with of course. Do
we WARN if we hit this code and don't have IBRS available?

> The same applies to any
> EFI runtime calls, APM and all kinds of other random crap that calls
> into firmware. I'm not sure why those aren't showing up.

arch/x86/platform/efi/Makefile:OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
arch/x86/platform/efi/Makefile:OBJECT_FILES_NON_STANDARD_efi_stub_$(BITS).o := y

And similar things tell objtool to please not look..
