Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634BFC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30228218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bUbrur6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfAYJbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:31:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfAYJbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:31:00 -0500
Received: from zn.tnic (p200300EC2BCAC5008171EC5460E7CDAE.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:c500:8171:ec54:60e7:cdae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D3D11EC0229;
        Fri, 25 Jan 2019 10:30:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548408658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l8/CFgutwOvxgqngQLTy4YuEb5ebbbFztEea0Avs9q0=;
        b=bUbrur6puTnchZI+GtOUgt9AOVvc+Ae5pp2AbXn3zl56ko7TQeiAMvMt82l/uiNKrzFkWU
        xE+Lgre99tNAQPN+kju5rRJhk7+gwDA1BVSo2SOpdZc5BqECsohuDcMTrvfJV+xcR6Z0Dt
        NtKvCITWDx8Hug0dQ4Tj6P0pQgnMd4Q=
Date:   Fri, 25 Jan 2019 10:30:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 01/17] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Message-ID: <20190125093052.GA27998@zn.tnic>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117003259.23141-2-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:32:43PM -0800, Rick Edgecombe wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> text_mutex is currently expected to be held before text_poke() is
> called, but we kgdb does not take the mutex, and instead *supposedly*
> ensures the lock is not taken and will not be acquired by any other core
> while text_poke() is running.
> 
> The reason for the "supposedly" comment is that it is not entirely clear
> that this would be the case if gdb_do_roundup is zero.

I guess that variable name is "kgdb_do_roundup" ?

> This patch creates two wrapper functions, text_poke() and

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> text_poke_kgdb() which do or do not run the lockdep assertion
> respectively.
> 
> While we are at it, change the return code of text_poke() to something
> meaningful. One day, callers might actually respect it and the existing
> BUG_ON() when patching fails could be removed. For kgdb, the return
> value can actually be used.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Fixes: 9222f606506c ("x86/alternatives: Lockdep-enforce text_mutex in text_poke*()")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/include/asm/text-patching.h |  1 +
>  arch/x86/kernel/alternative.c        | 52 ++++++++++++++++++++--------
>  arch/x86/kernel/kgdb.c               | 11 +++---
>  3 files changed, 45 insertions(+), 19 deletions(-)

...

> +/**
> + * text_poke_kgdb - Update instructions on a live kernel by kgdb
> + * @addr: address to modify
> + * @opcode: source of the copy
> + * @len: length to copy
> + *
> + * Only atomic text poke/set should be allowed when not doing early patching.
> + * It means the size must be writable atomically and the address must be aligned
> + * in a way that permits an atomic write. It also makes sure we fit on a single
> + * page.
> + *
> + * Context: should only be used by kgdb, which ensures no other core is running,
> + *	    despite the fact it does not hold the text_mutex.
> + */
> +void *text_poke_kgdb(void *addr, const void *opcode, size_t len)

text_poke_unlocked() I guess. I don't think kgdb is that special that it
needs its own function flavor.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
