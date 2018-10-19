Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A2CECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A1E21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jagnw5Ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A1E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJSTEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:04:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeJSTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L2HhGR0Jvs5NQOqmSuWE7snZ2hvk4LUH6PSmxPO6MfY=; b=Jagnw5Ye34yPxo+qne0ftlsRN
        Mys2xteLfLLwEkoYzu72fgpj3i4+yvylciN17Zc7gLkGBOfwScQgtLlZb2qXvzKXn/jOfdc+GtjnW
        vG3dYHyIz+75e79Uoc3pW5wmlh2575CHQa9K2E/157KfawvLLXuh5FZnzxkm/QA9k3mDXZNMG/kci
        9N0sKPgi2PZ1NU3B5N4apORPgRRrO6TPyHt1SlCne5VIeuRA4EMm293sEN9kfuoZjPBqJlSLMxCtz
        KJQrBDXoHx0pCtMqKnMmtYaC3xFIlJmRjXckiHH/fXLcOeyOnw3jG3TfJU4JiTSrMs/oj2mXsB+eR
        nR6m9FtFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDSUX-0005JY-SH; Fri, 19 Oct 2018 10:58:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8268020297B7B; Fri, 19 Oct 2018 12:58:51 +0200 (CEST)
Date:   Fri, 19 Oct 2018 12:58:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/kasan: make quarantine_lock a raw_spinlock_t
Message-ID: <20181019105851.GG3121@hirez.programming.kicks-ass.net>
References: <20181009142742.ikh7xv2dn5skjjbe@linutronix.de>
 <CACT4Y+ZB38pKvT8+BAjDZ1t4ZjXQQKoya+ytXT+ASQxHUkWwnA@mail.gmail.com>
 <20181010092929.a5gd3fkkw6swco4c@linutronix.de>
 <CACT4Y+agGPSTZ-8A8r8haSeRM8UpRYMAF8BC4A87yeM9nvpP6w@mail.gmail.com>
 <20181010095343.6qxved3owi6yokoa@linutronix.de>
 <CACT4Y+ZpMjYBPS0GHP0AsEJZZmDjwV9DJBiVUzYKBnD+r9W4+A@mail.gmail.com>
 <20181010214945.5owshc3mlrh74z4b@linutronix.de>
 <20181012165655.f067886428a394dc7fbae7af@linux-foundation.org>
 <20181013135058.GC4931@worktop.programming.kicks-ass.net>
 <20181015163529.30ed9b0ac18e20dd975f4253@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015163529.30ed9b0ac18e20dd975f4253@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:35:29PM -0700, Andrew Morton wrote:
> On Sat, 13 Oct 2018 15:50:58 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > The whole raw_spinlock_t is for RT, no other reason.
> 
> Oh.  I never realised that.
> 
> Is this documented anywhere?  Do there exist guidelines which tell
> non-rt developers and reviewers when it should be used?

I'm afraid not; I'll put it on the todo list ... I've also been working
on some lockdep validation for the lock order stuff.
