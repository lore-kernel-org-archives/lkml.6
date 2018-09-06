Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA818C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581072077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="suDNZVtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581072077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeIFMra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:47:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41296 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeIFMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EL9JG27UJcViQr2Ylr8SzYbhcRVeRIco2rUJptg+Hk0=; b=suDNZVtLtDN+Y1oQKHWSiIISh
        q5XPLdrks+6L5K/ivFXSKefU/SePw1k6Y8Kgsc5Z0/NBPmCWtyXbaReGM8PB1W4W6Nv3+fWlpHWlV
        la3Ax5NuQe/bJW/ZAvD0NqDHp+yAq9r1G0p1KSUjWQb+15RbG2kihPfUQgAmIDf9JVxjbBsgP9ia1
        wNhHDHM569awb8Dy1DcFtewKVkIqrqLJ1OfoWsItgkelLpdvyKNRmaOp6++DReFrMqG28iwDUARSV
        48psn9dN+CSoGD+AZDu2W0yCqi4FjlmkKQgyeYSslF+LKWDpvHi96xYu8RvOOXg2z7A5W/KSFVH6Q
        SNgQsKtdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxpPT-0000g6-HZ; Thu, 06 Sep 2018 08:13:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21B732024EB09; Thu,  6 Sep 2018 10:13:00 +0200 (CEST)
Date:   Thu, 6 Sep 2018 10:13:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180906081300.GF24082@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 07:10:46PM +0000, Nadav Amit wrote:
> at 12:02 PM, Nadav Amit <namit@vmware.com> wrote:
> 
> > at 11:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> >> On Sun, Sep 02, 2018 at 10:32:18AM -0700, Nadav Amit wrote:
> >>> This patch-set addresses some issues that were raised in a recent
> >>> correspondence and might affect the security and the correctness of code
> >>> patching. (Note that patching performance is not addressed by this
> >>> patch-set).
> >>> 
> >>> The main issue that the patches deal with is the fact that the fixmap
> >>> PTEs that are used for patching are available for access from other
> >>> cores and might be exploited. They are not even flushed from the TLB in
> >>> remote cores, so the risk is even higher. Address this issue by
> >>> introducing a temporary mm that is only used during patching.
> >>> Unfortunately, due to init ordering, fixmap is still used during
> >>> boot-time patching. Future patches can eliminate the need for it.
> >> 
> >> Remind me; why are we doing it like this instead of fixing fixmap?
> >> Because while this fixes the text_poke crud, it does leave fixmap
> >> broken.
> > 
> > Do you have other fixmap mappings in mind that are modified after boot?
> 
> Oh.. I misunderstood you. You mean: why not to make the fixmap mappings that
> are used for text_poke() as private ones.

No, you got it the first time. There are in fact more fixmap abusers;
see drivers/acpi/apei/ghes.c.  Also, as long as set_fixmap() allows
overwriting a _PAGE_PRESENT pte and has that dodgy
__flush_tlb_one_kernel() in it, the broken remains (and can return).

So we need to fix fixmap, to either disallow overwriting a _PAGE_PRESENT
pte, or to issue a full TLB invalidate.

Either fix will terminally break GHES, but that's OK, they've known
about this issue since 2015 and haven't cared, so I can't be bothered
about them.

