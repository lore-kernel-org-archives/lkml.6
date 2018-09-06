Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA2AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E49E2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SoT+nvOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E49E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeIGAbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:31:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbeIGAbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hdLNGESV/Zmlv9YBKz/S6B+1oEbN9RnAUFg0BowPAsU=; b=SoT+nvOOr2ASbDRd2dQIn8Hs4t
        QH9q/EhEJyyXuRKGRj/+9NV1rtvhtXcI+kmP8GhirhbnRUTdVHdMKEIznY+gDySAP949LCqkMvBsb
        Dg3oAQKmlXVbD9FKeoycBi2KWXnBgIpsT3/2QHXltz9n7BJ7LULplA2Ovt3kaQesln43hLtAetEzf
        Cm/7MOj/y0/kk0qYr2F3yXYM/rdDTMzXI8z5R1yQdKI/PU8hnRUJSWfIeEHWThSnjzXERIdb4Zd/0
        TStQtaiX3XKpNJbzMXYE918J13uEiCCbmRo7Ca3jQvcedkrX17yK+OWlN1ZVrg5U6qtUrrczNGw+f
        Pc3+GNgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fy0Lo-0005Yy-2i; Thu, 06 Sep 2018 19:54:00 +0000
Received: by worktop (Postfix, from userid 1000)
        id D36D66E0AA9; Thu,  6 Sep 2018 21:53:51 +0200 (CEST)
Date:   Thu, 6 Sep 2018 21:53:51 +0200
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
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Message-ID: <20180906195351.GB9358@worktop.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
 <20180906194003.GD4816@worktop.programming.kicks-ass.net>
 <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 07:42:14PM +0000, Nadav Amit wrote:
> at 12:40 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sun, Sep 02, 2018 at 10:32:19AM -0700, Nadav Amit wrote:
> >> text_mutex is expected to be held before text_poke() is called, but we
> >> cannot add a lockdep assertion since kgdb does not take it, and instead
> >> *supposedly* ensures the lock is not taken and will not be acquired by
> >> any other core while text_poke() is running.
> >> 
> >> The reason for the "supposedly" comment is that it is not entirely clear
> >> that this would be the case if gdb_do_roundup is zero.
> > 
> > Argh, that's pretty shit code...
> > 
> > Not only is that text_mutex abuse ugly, so too is the fixmap usage from
> > IRQ context. I suppose this really does require your alternative mm
> > patches for text_poke().
> 
> Right, I forgot about that…

With that CR3 trickery, we can rid ourselves of the text_mutex
requirement, since concurrent text_poke is 'safe'. That would clean up
the kgdb code quite a bit.
