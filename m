Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8761FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE8B206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SzzWPBtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE8B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeIGCTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:19:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeIGCTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=meUx+c5OOhrm8NhHBdhijNt0QxOOddzH6wzatUXtTiE=; b=SzzWPBtQYSgLZaHm+RdkY0/DQe
        rwIiPTrRGPlwlJ9in/ZlYzr8DzWLWYMdhTYHLq9VwFNecf2Az4w/gKs8KUvWgMP/fs9OldKs6afWg
        sCdrLuVwxfqpNBEaWkB5ixUAXSe7+nvtgkfQZOI3OuS/hsdAWfX3/GIVP2cAfrDPPzoNWM6xaN+gg
        LnvM9sPKzU61Hc6KEgxz3oveZtYyS+LKUQs7iPXKgyI6azOlICe0Os8n6I+stGlW2/d8w4Js3OlEM
        5ExxZyPX8Ndw+19mUzwNQWVtOail1cFDrcTYUHHlWNSOl9HvYB+068SHEeC3WevgcD6S4Db94uT+p
        KXKn2eaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fy21l-00052v-8G; Thu, 06 Sep 2018 21:41:25 +0000
Received: by worktop (Postfix, from userid 1000)
        id 6B3B86E0AA9; Thu,  6 Sep 2018 23:41:22 +0200 (CEST)
Date:   Thu, 6 Sep 2018 23:41:22 +0200
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
Message-ID: <20180906214122.GG9358@worktop.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
 <20180906194003.GD4816@worktop.programming.kicks-ass.net>
 <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
 <20180906195351.GB9358@worktop.programming.kicks-ass.net>
 <D8CE0D88-9507-421C-9C97-ACAB05388F8D@vmware.com>
 <20180906202547.GC9358@worktop.programming.kicks-ass.net>
 <E8934715-B8B1-4E37-A37F-18D040885C4F@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E8934715-B8B1-4E37-A37F-18D040885C4F@vmware.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 08:57:38PM +0000, Nadav Amit wrote:
> at 1:25 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Sep 06, 2018 at 07:58:40PM +0000, Nadav Amit wrote:
> >>> With that CR3 trickery, we can rid ourselves of the text_mutex
> >>> requirement, since concurrent text_poke is 'safe'. That would clean up
> >>> the kgdb code quite a bit.
> >> 
> >> I don’t know. I’m somewhat worried with multiple mechanisms potentially
> >> changing the same code at the same time - and maybe ending up with some
> >> mess.
> > 
> > kgdb only pokes INT3, that should be pretty safe.
> 
> Maybe I misunderstand your point. If you want me to get rid of text_mutex
> completely,

No, just the ugly things kgdb does with it.
