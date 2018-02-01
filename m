Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x22451o1Tgahpz0mj0WGaZ/ON0M16Jomea/Frv91Y9FEFE65hyi/QswvVuIMrHmdXvb/t1vps
ARC-Seal: i=1; a=rsa-sha256; t=1517499161; cv=none;
        d=google.com; s=arc-20160816;
        b=qJExgk8XprZ3Tj0ZVzrl5OQyZoMsV125xY1ojpy/PbAOmTpxF9Y3ql3U0jQWYHauRJ
         a+2/xbCkQxtCVyNT0zDb8YsfsPviqKwwE6N+fIjKebsM/PhjpuDXRaaBTrS99pMycgiP
         qmH7QoZRu4AFMbw1GQ5Gf4/pSF1gwf6W7KLieDbV+AAsrU7H7Yg3MZ/9c7C/e51rDlJU
         UOk73TrxuKJXYV41iRNrFXIJqWkNgwGu8aIpw28UioppyaDETEKxRcR+tGj0wyTwRIAs
         IKP1MdaZU2Jw3pwXWF+/cQKZWphS/20qrUXPhf2K6DWkbL1ciMMD/vmM2P3qTDZa4+jZ
         YgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=4P6B9YUhNTtgqkfGL/O2VuCkYScslCwuUb3bJ/n7ydk=;
        b=JWuLeQHF3fYfDIzbGUqvbya62KkIlKJXfaJ9u1GfXYgUL8eEilztVj/CaXHMO9s2Fe
         9b/Yk5jjL/TLqy9aBkTJY18ieRxroByj5PDl6GBk6dtYiX+0yPWjaVOCRAOtlT232wcf
         VR2gVvvB2Pg3pNaxne/LRlQ21Cmcc0qX8jBtEMaFFhGCdlkDlqIJJuyIMvvRDk5EJls5
         n7dtIWvn6QrkxehFVdy2ZXmnznK5WlUUoI7+xMpXPKlBJs6u1Nc2mbw5LBKdT2nOeZIj
         tzW6FgccPRn06DTzTy1zt+W70HeT5Nfqp6MbxGi2ISMgBwKClzFiIDoxXq4aEqdXPG1Z
         +A+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=wf5QpomG;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=wf5QpomG;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 1 Feb 2018 16:32:35 +0100
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
Subject: Re: [PATCH 0/7] objtool: retpoline validation
Message-ID: <20180201153235.GZ2249@hirez.programming.kicks-ass.net>
References: <20180201143421.088202488@infradead.org>
 <20180201152856.okzhqvdlledykzps@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201152856.okzhqvdlledykzps@treble>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210454988302775?=
X-GMAIL-MSGID: =?utf-8?q?1591213200955060256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 09:28:56AM -0600, Josh Poimboeuf wrote:
> On Thu, Feb 01, 2018 at 03:34:21PM +0100, Peter Zijlstra wrote:
> > There are the retpoline validation patches; they work with the __noretpoline
> > thing from David.
> 
> Have you run this through 0-day bot yet? 

Yes, it complains a _lot_ because no retpoline supported compiler.

> A manual awk/sed found another
> one, which objtool confirms:
> 
>   drivers/watchdog/.tmp_hpwdt.o: warning: objtool: .text+0x24: indirect call found in RETPOLINE build

That is the only known one left. It calls into BIOS code, so its not
safe and using a retpoline for it is pointless since nobody audited the
BIOS code.
