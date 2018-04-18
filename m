Return-Path: <ak@linux.intel.com>
X-Google-Smtp-Source: AIpwx48INb0WgGPyvbFSSKqBBfxk0nLWk4b3tPGEewE4Tnkyxc7/sqGho7aCsZMVmZJToIgRF+A9
ARC-Seal: i=1; a=rsa-sha256; t=1524093989; cv=none;
        d=google.com; s=arc-20160816;
        b=ausk5XEF7nqXFpf4m0Bdp75Pd70kghoUZJzNRAmbUcv6cHDV9ErkBEgXoAeuyPjWJT
         jpKZBgYRwHyKu9ZBmx/WA8ev85DTx7v+t/aYRTjtYeVZ3ERi73X3JzvBrbqye6m2e60h
         n9SHt/NRjDIEqGe9vY8OiTNnEyXPOU+bjLDNog7X8a6xR5+LF+ib6j1FDepB6lFGQN7H
         zBDRybaxpqpi4Ex3Skg8LjWLfn+PrMDPzVyn0DpIsZ9qR8tGl0Hn0CIRXOZJpPQstivj
         phyVBlwR1846oQLzuIKzmQvduhHHOLHBkRmf4Vbjh0xCPCSfNF9F7T+AdjsZkFxs3CVf
         APUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:arc-authentication-results;
        bh=Y6vDmzOGPF7aTzUs7gR6ZJ0UPZuz4YljP53JHWx15y0=;
        b=XpHgr85f9qn+tutATMoLLF/nw6dqcQIwpxgfSzVaJuoaiePaVjzFpwocYzOTWmxgjO
         FWKkCLBww2/Kb032nlfRAFUAmyoNEPN5f3894B233IPEMLH8XOGHPm6x3dVGKjslULou
         sxJqHWKsQQ2HjR1q7b6u9+bODfPKofdJ34EM+BoullucG6dGNb3350q6wkAY0dxUb3u/
         LbG8Ddwu+0mhA1ybMSSHqjRUkbNG21McFTFmYWyJ2uzr3MTggSOxqd4TCk/VY01OR83E
         mphWOtcKnk8ghe+rD4S+wONQ4WDr6eZT0ZKynSdUGbws10uqrFHezx/lUx3prIYXOOut
         xnww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of ak@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=ak@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of ak@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=ak@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="48989804"
From: Andi Kleen <ak@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>, Waim@linux.intel.com
Subject: Re: [PATCH 03/35] x86/entry/32: Load task stack from x86_tss.sp1 in SYSENTER handler
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
	<1523892323-14741-4-git-send-email-joro@8bytes.org>
Date: Wed, 18 Apr 2018 16:26:19 -0700
In-Reply-To: <1523892323-14741-4-git-send-email-joro@8bytes.org> (Joerg
	Roedel's message of "Mon, 16 Apr 2018 17:24:51 +0200")
Message-ID: <87k1t4t7tw.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916934570630846?=
X-GMAIL-MSGID: =?utf-8?q?1598128378694956739?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Joerg Roedel <joro@8bytes.org> writes:

> From: Joerg Roedel <jroedel@suse.de>
>
> We want x86_tss.sp0 point to the entry stack later to use
> it as a trampoline stack for other kernel entry points
> besides SYSENTER.
>
> So store the task stack pointer in x86_tss.sp1, which is
> otherwise unused by the hardware, as Linux doesn't make use
> of Ring 1.

Seems like a hack. Why can't that be stored in a per cpu variable?

-Andi
