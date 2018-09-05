Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E72BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92BD2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WTGeZoKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92BD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIEX15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:27:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35742 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIEX14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eUlXs85ae9ElsPlYdSYa7Ouwvja3W9FuxWUf1gzGJ/0=; b=WTGeZoKmXrEV8C/IC2/txYpSe
        Tus3l88kdVrFjJVJzv7z5z0USbr2TZuvM+ST6YbeMCkPrdpKt5vpLvlsHXjF+jRGLo3x9+j9YwP6Q
        GNssX94idoMAkmsplGlQIUR+P02iTZemB/Iz1z5KMBBaxIU22Tm66fleBfqps0s+soq+Mg8/JLonp
        zdVVJl6NSKSO7eYetP+jj5ze6c6OcEeSvibCQ1Xydm1NBNpTaA9pNC0+aDzUnimyxhX/ZwfIQiEzZ
        1e1BEV6Gwz2pCETy8vC8l2j1ck0B9cMrnVwPmGEREJJKPFw5VAEaU+HqUJHPPozmFOEMswW6+IBO5
        2o5e8aMPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxcyR-0000ru-0R; Wed, 05 Sep 2018 18:56:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A692020210311; Wed,  5 Sep 2018 20:56:17 +0200 (CEST)
Date:   Wed, 5 Sep 2018 20:56:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180905185617.GC24082@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902173224.30606-1-namit@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 10:32:18AM -0700, Nadav Amit wrote:
> This patch-set addresses some issues that were raised in a recent
> correspondence and might affect the security and the correctness of code
> patching. (Note that patching performance is not addressed by this
> patch-set).
> 
> The main issue that the patches deal with is the fact that the fixmap
> PTEs that are used for patching are available for access from other
> cores and might be exploited. They are not even flushed from the TLB in
> remote cores, so the risk is even higher. Address this issue by
> introducing a temporary mm that is only used during patching.
> Unfortunately, due to init ordering, fixmap is still used during
> boot-time patching. Future patches can eliminate the need for it.
> 

Remind me; why are we doing it like this instead of fixing fixmap?
Because while this fixes the text_poke crud, it does leave fixmap
broken.
