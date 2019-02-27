Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD71C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A626C2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfB0KoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:44:16 -0500
Received: from mother.openwall.net ([195.42.179.200]:39049 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725881AbfB0KoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:44:15 -0500
Received: (qmail 16154 invoked from network); 27 Feb 2019 10:44:13 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 27 Feb 2019 10:44:13 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id EA567AA7D0; Wed, 27 Feb 2019 11:44:07 +0100 (CET)
Date:   Wed, 27 Feb 2019 11:44:07 +0100
From:   Solar Designer <solar@openwall.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/asm: Pin sensitive CR0 bits
Message-ID: <20190227104407.GA18804@openwall.com>
References: <20190226233647.28547-1-keescook@chromium.org> <20190226233647.28547-2-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226233647.28547-2-keescook@chromium.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:36:45PM -0800, Kees Cook wrote:
>  static inline void native_write_cr0(unsigned long val)
>  {
> -	asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
> +	bool warn = false;
> +
> +again:
> +	val |= X86_CR0_WP;
> +	/*
> +	 * In order to have the compiler not optimize away the check
> +	 * in the WARN_ONCE(), mark "val" as being also an output ("+r")

This comment is now slightly out of date: the check is no longer "in the
WARN_ONCE()".  Ditto about the comment for CR4.

> +	 * by this asm() block so it will perform an explicit check, as
> +	 * if it were "volatile".
> +	 */
> +	asm volatile("mov %0,%%cr0": "+r" (val) : "m" (__force_order) : );
> +	/*
> +	 * If the MOV above was used directly as a ROP gadget we can
> +	 * notice the lack of pinned bits in "val" and start the function
> +	 * from the beginning to gain the WP bit for sure. And do it
> +	 * without first taking the exception for a WARN().
> +	 */
> +	if ((val & X86_CR0_WP) != X86_CR0_WP) {
> +		warn = true;
> +		goto again;
> +	}
> +	WARN_ONCE(warn, "Attempt to unpin X86_CR0_WP, cr0 bypass attack?!\n");
>  }

Alexander
