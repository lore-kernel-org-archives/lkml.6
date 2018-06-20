Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D592C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E1220846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPGIedkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E1220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932173AbeFTKLi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:11:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52272 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754251AbeFTKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z8R0jbBMxPDSfNWqMdLeGaCfGeLPHySLAViwTat5vk0=; b=gPGIedkmrrgwlS3l1MlwDqhef
        uZlpq06GVY22xlLn1E+oeEWut+PtE7QveN1lG+4o25KF7PToXX0j6khCvyC5uQMukI6W3xc2sd/Wi
        qPwjJTrq8D934XBop6GcvzSpdp5aiWM386T4Fxu+C9hQ6/iMVqz2jHXyOgYvUt5qtmB0V1m+s1oTT
        39sCjIZbSoSm+1kJk2g/lsYz43uUKBkmGMlyoacl7jnfjuJYqRErwkZb/XfD1a7bAyVPOi8fo2i9g
        3hssU7VUC1NYce8CNlNJuJAB4Qrav3lOHMrJhL1zghGe7Jb3oXczlQFtUP9S12RDbu7VcJCBtVihV
        ar8VIAprQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVa4u-0002TD-EE; Wed, 20 Jun 2018 10:11:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE2882029FA0A; Wed, 20 Jun 2018 12:11:01 +0200 (CEST)
Date:   Wed, 20 Jun 2018 12:11:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 0/9] x86: macrofying inline asm for better compilation
Message-ID: <20180620101101.GB2530@hirez.programming.kicks-ass.net>
References: <20180619194854.69486-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619194854.69486-1-namit@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:48:45PM -0700, Nadav Amit wrote:
> Nadav Amit (9):
>   Makefile: Prepare for using macros for inline asm
>   x86: objtool: use asm macro for better compiler decisions
>   x86: refcount: prevent gcc distortions
>   x86: alternatives: macrofy locks for better inlining
>   x86: bug: prevent gcc distortions
>   x86: prevent inline distortion by paravirt ops
>   x86: extable: use macros instead of inline assembly
>   x86: cpufeature: use macros instead of inline assembly
>   x86: jump-labels: use macros instead of inline assembly
> 
>  Makefile                               |  9 ++-
>  arch/x86/Makefile                      | 11 ++-
>  arch/x86/include/asm/alternative-asm.h | 20 ++++--
>  arch/x86/include/asm/alternative.h     | 11 +--
>  arch/x86/include/asm/asm.h             | 61 +++++++---------
>  arch/x86/include/asm/bug.h             | 98 +++++++++++++++-----------
>  arch/x86/include/asm/cpufeature.h      | 82 ++++++++++++---------
>  arch/x86/include/asm/jump_label.h      | 65 ++++++++++-------
>  arch/x86/include/asm/paravirt_types.h  | 56 +++++++--------
>  arch/x86/include/asm/refcount.h        | 74 +++++++++++--------
>  arch/x86/kernel/macros.S               | 16 +++++
>  include/asm-generic/bug.h              |  8 +--
>  include/linux/compiler.h               | 56 +++++++++++----
>  scripts/Kbuild.include                 |  4 +-
>  scripts/mod/Makefile                   |  2 +
>  15 files changed, 340 insertions(+), 233 deletions(-)
>  create mode 100644 arch/x86/kernel/macros.S

Aside from the one niggle:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
