Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE975C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEDC208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="k7uJwKfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfBSLEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:04:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38928 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfBSLEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:04:12 -0500
Received: from zn.tnic (p200300EC2BCDC800496980E891B65FF8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:c800:4969:80e8:91b6:5ff8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C41881EC03D8;
        Tue, 19 Feb 2019 12:04:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550574250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rtGjmKlG9FpDsdh9ZJ8Y8iEVJxSkU5/owmFsijqBtGY=;
        b=k7uJwKfS/qVBAXcPfEGBLgv3A66WzfEHKr0s2lHZEeBVWUwoKU8BAMyhWTzqnbNC1YFHzV
        N8q2OYSmYK8mq72Sub7kdxg8x5iSKQ0zqEaG4Gtr/AAeBuKp7+PfA35pk2ektNQWGwfWNi
        3piWSP/0DRhK4Xj7VnSJBRznABaS+sU=
Date:   Tue, 19 Feb 2019 12:04:00 +0100
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 14/20] mm: Make hibernate handle unmapped pages
Message-ID: <20190219110400.GA19514@zn.tnic>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-15-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129003422.9328-15-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:34:16PM -0800, Rick Edgecombe wrote:
> For architectures with CONFIG_ARCH_HAS_SET_ALIAS, pages can be unmapped
> briefly on the directmap, even when CONFIG_DEBUG_PAGEALLOC is not
> configured. So this changes kernel_map_pages and kernel_page_present to be

s/this changes/change/

From Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Also, please end function names with parentheses.

> defined when CONFIG_ARCH_HAS_SET_ALIAS is defined as well. It also changes
> places (page_alloc.c) where those functions are assumed to only be
> implemented when CONFIG_DEBUG_PAGEALLOC is defined.

The commit message doesn't need to say "what" you're doing - that should
be obvious from the diff below. It should rather say "why" you're doing
it.

> So now when CONFIG_ARCH_HAS_SET_ALIAS=y, hibernate will handle not present
> page when saving. Previously this was already done when

pages

> CONFIG_DEBUG_PAGEALLOC was configured. It does not appear to have a big
> hibernating performance impact.

Comment over safe_copy_page() needs updating I guess.

> Before:
> [    4.670938] PM: Wrote 171996 kbytes in 0.21 seconds (819.02 MB/s)
> 
> After:
> [    4.504714] PM: Wrote 178932 kbytes in 0.22 seconds (813.32 MB/s)

IINM, that's like 1734 pages more. How am I to understand this number?

Code has called set_alias_nv_noflush() on them and safe_copy_page() now
maps them one by one to copy them to the hibernation image?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
