Return-Path: <kernel-hardening-return-12757-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+VhItPmSbfHQvIoBoGr9KqynszscXzDx8WIZIKFj1e5vuA+Cpdzx80/dgWl+VvA3/2zgYL
ARC-Seal: i=1; a=rsa-sha256; t=1522129690; cv=none;
        d=google.com; s=arc-20160816;
        b=f6AhncHnpzZfsDGTIyg+HXyYzWiKoHFvWkGXDHWd0D1xxVfV1z78sYUP1EhvIqJCbE
         FnaQhG3DYBOTwxbJvgXxapkF3LcmSUrdWEaJp7XzS16zS4RSXLB6/macDW5dGqkQwweP
         LVbWqyhdYrQCsB6lmsc9FfwsSJXEQVXootlVhIWRnlU2JnwZMSZn0/s8V6fop0nnpwYJ
         r8sjEUo9G/zntCeVdLSUFKxNUju2XWMTviBrAXr4QDOGkotSdAlqQuMb7Khvvf/bInh4
         7ojwOegWEdh4Y6Y7SXRiA+mnHMPkPQh3o887QRZ0cf81wejvrbIQHHa4YwpeBEdMhx7/
         Z/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=+jI87ffxbT+AyDRTU9GIxmvnK0zQaW4G4e3RVdF8i48=;
        b=eReV94rQBib5aiEUGJ4srhV8PUbTpNMkUhJIhpv+0FEypxn2PtHbO5JDMUa6D/JdBB
         pbHQYCj5gYI8zHxMAD4SUUev5COAEwx+vaVmilBLdnG+3+HSikcy11TFPbtGWR0rpSs0
         Xe9J4twMstQ5/5UhT3gH3QyIKVSwexi9mq1iCjnAZCKn9MXFV9zcfwnvs9t+bNSHJ36d
         E/We7iUNeaoHbb/0wL+w8h5VpDddpvdhe80nlJ08gnqmY2/agus4zTQkf1jFF26JN0eA
         JTVKyC+SELU55eaOOxcKZU8S4d/DpBwTBFhchm5eqdhXBif6oAWfBx9/oUboISA4XI4O
         zx6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ed+nWbwr;
       spf=pass (google.com: domain of kernel-hardening-return-12757-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12757-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ed+nWbwr;
       spf=pass (google.com: domain of kernel-hardening-return-12757-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12757-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 27 Mar 2018 07:47:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6] kernel.h: Retain constant expression output for
 max()/min()
Message-ID: <20180327054748.jx6mzywguuqfkqpv@gmail.com>
References: <20180326221554.GA45166@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326221554.GA45166@beast>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596040250176531135?=
X-GMAIL-MSGID: =?utf-8?q?1596068661448831228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Kees Cook <keescook@chromium.org> wrote:

> In the effort to remove all VLAs from the kernel[1], it is desirable to
> build with -Wvla. However, this warning is overly pessimistic, in that
> it is only happy with stack array sizes that are declared as constant
> expressions, and not constant values. One case of this is the evaluation
> of the max() macro which, due to its construction, ends up converting
> constant expression arguments into a constant value result.
> 
> All attempts to rewrite this macro with __builtin_constant_p() failed with
> older compilers (e.g. gcc 4.4)[2]. However, Martin Uecker constructed[3] a
> mind-shattering solution that works everywhere. Cthulhu fhtagn!
> 
> This patch updates the min()/max() macros to evaluate to a constant
> expression when called on constant expression arguments. This removes
> several false-positive stack VLA warnings from an x86 allmodconfig
> build when -Wvla is added:

Cool!

Acked-by: Ingo Molnar <mingo@kernel.org>

How many warnings are left in an allmodconfig build?

Thanks,

	Ingo
