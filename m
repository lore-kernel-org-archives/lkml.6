Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520319882; cv=none;
        d=google.com; s=arc-20160816;
        b=N3o2kJfSTMA1xLfJ6FTUB8NnvevulL2WT2QE/NKPlhY7wuyl8OY2mVmxYZ6a9L5gNR
         17YJIf1NsOW8+TSaM5yQuHnmsRRMbf4/MO4ogfLe6kwSv1Mva/1DOscy1y5P5KYl9p1B
         HN5W3mEjtc7e/Gm3YbHPv0gsIMO9mrNT5EZufZ60lsJlEsddBss6QZq26UZrghF3G1FQ
         7pAo35KS4U4fJd6woOC1n+bzx2xYE/bHFoV5Hd7KPGTxZAxBiXgmtIV8jRnjdbHyk1qW
         dRR5hwwGG8MG9L0T8nv8sx8Xy8MweyDvnPXNapYQCpdmrk9frhGW/TfrPinQN1OzzFcH
         my5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=nh2CFa/dplVlNrvpsaJBS56wf0GM7Jwe6EzydpCW7LU=;
        b=QBJwK9gyP1QST1mDVZqqrzqGt46EzWygmYxiePckDEAOkNrnRxWmFs7VAxazG2CBu5
         +wDdMn8huToewCM01zsrfNaM3E01N8rnrxkR/IcDEM81nY4BG0IuWwfwA9kk9rX+t38c
         oRt4QDRXmCVL4dSUO1E2lcAka48Jwt21EJ+uxLZh39vpVFx3r72C5JqQv253Q+qeP7EY
         d2b6vaRPVTw4UNfORbMGTWa+rVnQzIU2O3H3CHqKRcalV6QtSCqK1LDjbl/vgNfb7YLh
         iJXrPNSAO6SzPLufHP+lBH3e6d72grVWIEA9zhYiXRdq6WkzSX7Yb8+9HpgVJb+vqdy4
         d+DA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZwXQpKus;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZwXQpKus;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AG47ELuDungSINWrZ8dL9i4llgx13058Yj+/3Ub95UTsTQK2D5MHFdYzoCYAkd5oEZSJNMyvOptQeg==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 6 Mar 2018 08:04:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, Brian Gerst <brgerst@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	=?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
Message-ID: <20180306070437.kf3fkevqj6cuxptz@gmail.com>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org>
 <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org>
 <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
 <CAMzpN2hscOXJFzm07Hk=2Ttr3wQFSisxP=EZhRMtAU6xSm8zSw@mail.gmail.com>
 <CA+55aFwxiZ9bD2Zu5xV0idz_dDctPvrrWA2r54+NL4aj9oeN8Q@mail.gmail.com>
 <20180305213550.GV16484@8bytes.org>
 <CA+55aFx2dxZmL487CnhV6rWRiqmJwZNAspyPqCD4Hwqxwncs6Q@mail.gmail.com>
 <12c11262-5e0f-2987-0a74-3bde4b66c352@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c11262-5e0f-2987-0a74-3bde4b66c352@zytor.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594170941542824057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* H. Peter Anvin <hpa@zytor.com> wrote:

> On NX-enabled hardware NX works with PDE, but the PDPDT in general doesn't
> have permission bits (it's really more of a set of four CR3s than a page
> table level.)

The 4 PDPDT entries are also shadowed in the CPU and are only refreshed
on CR3 loads, not spontaneously reloaded from memory during TLB walk
like regular page table entries, right?

This too strengthens the notion that the third page table level of PAE is more 
like a special in-memory CR3[4] array.

Thanks,

	Ingo
