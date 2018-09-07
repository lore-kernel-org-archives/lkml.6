Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472E2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007F720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HwrkU4cF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007F720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeIGRUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:20:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeIGRUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VUadmHrHGRRc/2eF2/zM4PQbkvulX5+g6rXh1CQlcvc=; b=HwrkU4cFE6aNQ2pWg/NbF+8Pu
        liYpxxvbtLDhssL0OOAEFmMVo4fGxEy2UjW8/iD6eEvsrVbS30nB8vNO7fk2w+SglpgpgncI5Z9bj
        FtZ3iYA6uJjUfLaEz6ctBOZNh5PFwh8Nfrs+1iRuKSwVER9CfhnaCWI4bsxPUTu8emNADvMy+M4e0
        fJ0qPTzo+4UHMo35Lh87n6utMtUdNCDPG5QjqyMemBGJgO2vg5DQwJ5t5vGC2xdd9cLYkVsrHfvxy
        jpgLMVKHoYBjKzkPNUYRulUd/FuGjG1WBXz/hgo+thynKvwHybJeHTyEZZVe+AWzCvt0z/5+kVb7e
        jn4KGL3vQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyG0L-0001yq-Uc; Fri, 07 Sep 2018 12:36:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27CC0201F9C52; Fri,  7 Sep 2018 14:36:51 +0200 (CEST)
Date:   Fri, 7 Sep 2018 14:36:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 3/3] x86/pti/64: Remove the SYSCALL64 entry trampoline
Message-ID: <20180907123651.GZ24106@hirez.programming.kicks-ass.net>
References: <cover.1536015544.git.luto@kernel.org>
 <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org>
 <20180904070455.GX24124@hirez.programming.kicks-ass.net>
 <CALCETrUZm3KsonYVd5sn=LhoGZ2ciO7xT_Fz=jD_HZ04tB9o=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUZm3KsonYVd5sn=LhoGZ2ciO7xT_Fz=jD_HZ04tB9o=Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:31:28PM -0700, Andy Lutomirski wrote:
> On Tue, Sep 4, 2018 at 12:04 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Sep 03, 2018 at 03:59:44PM -0700, Andy Lutomirski wrote:

> >> There is a possible alternative approach: we could instead move the
> >> trampoline within 2G of the entry text and make a separate copy for
> >> each CPU.  Then we could use a direct jump to rejoin the normal
> >> entry path.
> >
> > Can we have a few words on why this solution and not this alternative? I
> > mean, you raise the possibility, but then surely you chose not to
> > implement that. Might as well share that with us.
> 
> I can give some pros and cons.  With the other approach:
> 
>  - We avoid a pipeline stall.
>  - We execute from an extra page and read from another extra page
> during the syscall.  (The latter is because we need to use a relative
> addressing mode to find sp1 -- it's the same *cacheline* we'd use
> anyway, but we're accessing it using an alias, so it's an extra TLB
> entry.)
>  - We use more memory.  This would be one page per CPU for a simple
> implementation and 64-ish bytes per CPU or one page per node for a
> more complex implementation.
>  - More code complexity.
> 
> I'm not convinced this is a good tradeoff.

Fair enough, thanks!
