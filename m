Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtgFa6JGTUcAixyQq+AL9BhWg+WsLlKbMrT2yWlX96bjRz/mIbzGmkCC3MqJnPwUX2MA4L5
ARC-Seal: i=1; a=rsa-sha256; t=1520268291; cv=none;
        d=google.com; s=arc-20160816;
        b=QgARO3jZgVUJxHGK1fkVTcE/O+FH7+mxYw0j22pI9xY+SxrN3m9jNUP7z8KV2kekmC
         Vrsn7S+WrxGOPrSxrakoYKBPJ7XoM8HtFDUv8yjT7vu32K43UIOc11YzAywJDjjECVUX
         bqAmF65a34k1xFl6MRkMmfuDCSBif35SBaUagcU46pThkp3ooAy8LUyPRNlKEhKlq29g
         /dy8k7TPaTtum+ti2dGKzZ7ORHS2CLWJ+NjsCIQ4iCQQpC5YsFc1Gud4b+d4b9N5g0D+
         bo794aZoCQ8100fG9UQzH6ViDa+1VOYzKh63VILQWa8YsbmrfZMQtX5+H9mQVAUwmA3F
         Phcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=dhSSgF5pqqXrV4zYRkhOmgwj5jsT3zysbHVuXnpd2v4=;
        b=C7WrdZAjf1ltEnVSYyfDzRd3ZkKGHnO+7+oTtnZIKjcnbMAXs+7vLH75uj5YzGrDBP
         Wl7SYXCMPG0wtBw9q4edvNHFwOOpHtrdqfan+/HTqmYP2xpm+MopeXcds/kXMKdwYXjA
         vQZjtkjm2qJOEZwom/yRHMKI9c4EP+QMtBmmf6ju/XqIugtW4OD1i0+SiByjbdDAeBa+
         t9qsB9C4vcouooWJqAsk/XW36LJvsF+xajr+ibwItHem/qXJzQTiQ7uDEp4ZxygCVwYh
         khdVvv8rtUDA2C7eDerIVQXGSjz8x+EGrNqGb8LxgVte9AL33fesMG9hGPzEp2QSGMek
         Bp8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=J5fH9eHF;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=J5fH9eHF;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Mon, 5 Mar 2018 17:44:48 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
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
Message-ID: <20180305164448.GS16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org>
 <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org>
 <CAMzpN2gQ0pfSZES_cnNJSzvvGxbzuHdP0iAjx5GG5kJ6FGudbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2gQ0pfSZES_cnNJSzvvGxbzuHdP0iAjx5GG5kJ6FGudbw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594116843946269177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 09:51:29AM -0500, Brian Gerst wrote:
> For the IRET fault case you will still need to catch it in the
> exception code.  See the 64-bit code (.Lerror_bad_iret) for example.
> For 32-bit, you could just expand that check to cover the whole exit
> prologue after the CR3 switch, including the data segment loads.

I had a look at the 64 bit code and the exception-in-kernel case seems
to be handled differently than on 32 bit. The 64 bit entry code has
checks for certain kinds of errors like iret exceptions.

On 32 bit this is implemented via the standard exception tables which
get an entry for every EIP that might fault (usually segment loading
operations, but also iret).

So, unless I am missing something, all the exception entry code has to
do is to remember the stack and the cr3 with which it was entered (if
entered from kernel mode) and restore those before iret. And this is
what I implemented in v3 of this patch-set.


Regards,

	Joerg
