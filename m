Return-Path: <jroedel@suse.de>
X-Google-Smtp-Source: AG47ELuwvS8S59YAywGkLvR2749DbOt1li+OHYKZnOqmZiBlh8WKbkmrv44i8NM/1O7F2NMzD5F/
ARC-Seal: i=1; a=rsa-sha256; t=1519923025; cv=none;
        d=google.com; s=arc-20160816;
        b=NSkrJ6CCa+S/eIApLAF0i7ktY9wNz0darsDuqafMsWFI5W0K0O+kmpKkLC72VTDRbh
         goSXT4tArJeh5mxhYJ640nvBPfRuIXXbkZpQ6YGfCp3VCneGEPLphh2Ko2Cir0ADFnMr
         RGBa3oNkUe3jaQT3QWuRXsPpzLWjVcDSmhP6K6iewu9qVuRwmadQvR7KvvEJW3nMyElg
         Yg/AXC7mrc9SmJ21gs9DntKfUxI/XLHfsPCX75LMNR0A6as9veBphPg8tqomApagvfMS
         ctndXMqXSLp5bG4/p0PrbT52n9bq+xhrkcTh2wZSDW8eJxDS85qZ0r6aiq5PshC2wjRP
         Wc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/NBnnsH6aC49uqtRSFdV32ymaemQbSrXL07KK5SpuC4=;
        b=fnSvlvj5YqfwawSQ95s50/7F0e1EFTYW4reHfzUY/HY4xB7eyGDvXNYyOiYA1XXMtj
         A9KSNcWh7MgM5L8OIgBgaJMWLjgWUKwq1hA2XN2PLrBxxAgFKyGe63IN/8bEUgLPePVn
         h5K3KBfx4J3rfoTcXC0gERJf2gi0kLZ7pLRsHbG9cM8CDFICBVOp3ukpY4CFHAWPnQUi
         1zcCoESS47Act96C0fzUUJqgcchGqAJXvYgXw6+H2JobCt7I6bkbOZw6xPVSTxgKenah
         1KwMnZNFMAo/8Cfpp5TmNjXFNmZSGsinKFhYTbPdo/DW1NBvAgTL+dFRgs3yhNSqkS4s
         /0Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Date: Thu, 1 Mar 2018 17:50:19 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Waiman Long <longman@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 12/31] x86/entry/32: Add PTI cr3 switch to non-NMI
 entry/exit points
Message-ID: <20180301165019.kuynvb6fkcwdpxjx@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-13-git-send-email-joro@8bytes.org>
 <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
 <20180301133430.wda4qesqhxnww7d6@8bytes.org>
 <2ae8b01f-844b-b8b1-3198-5db70c3e083b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae8b01f-844b-b8b1-3198-5db70c3e083b@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904588119761?=
X-GMAIL-MSGID: =?utf-8?q?1593754806392789777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 09:33:11AM -0500, Waiman Long wrote:
> On 03/01/2018 08:34 AM, Joerg Roedel wrote:
> I think that should fix the issue of debug exception from userspace.
> 
> One thing that I am not certain about is whether debug exception can
> happen even if the IF flag is cleared. If it can, debug exception should
> be handled like NMI as the state of the CR3 can be indeterminate if the
> exception happens in the entry/exit code.

I am actually not 100% sure where it can happen, from the code it can
happen from anywhere, except when we are running on an espfix stack.

So I am not sure we need the same complex handling NMIs need wrt. to
switching the cr3s.


	Joerg
