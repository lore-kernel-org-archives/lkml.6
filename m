Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76BCC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B4C20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B4C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeJKVJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:09:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45091 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbeJKVJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:09:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so9738570wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 06:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lqcQ1ARpPEXiKceTyJRXakOv3x1Xh590zIIjgkAOgeA=;
        b=iqTPYudVVqRYlc8Wj0M2novpkAgv3Q5mhqQoWobrBlPRWNtHKlCSnpL3LvkVpbPYTV
         p0h4ZZ1kP7pLlELPZwHXejQwqk6B0OqV52MB0CLsg05TKoPPwCpMuoFX/miPvQLSsTJU
         o4GO9VAQ4pLv2qu578QxoN5KQsz5sVczCvm7H2jSA4KOhES6KUgLLYIksuCSF/pbXXjV
         LdxQ/csX2NLwzBAfZKsSc2+4OrQ0R2l1zg0gPVzVmo+1XCoNkBpO298NdqrrMUdBmM7c
         n0CE8Bnhv5x00NuK/elm7QXsHtviaFX8GlXN7zDBjm8L6wrUAz3o37xNXc7cIAllskTr
         nsvQ==
X-Gm-Message-State: ABuFfojWQwnZsaiK8PP5bCqkePJC05uzdcOyGK5iZWLCZLGwGMPr5lKj
        oGCuGNQrDtJYrke3x+U+oGGCOA==
X-Google-Smtp-Source: ACcGV63NROPto2Qjjpy6KwQWAvhffVn2soFgBb5OdkK6EJEDAZu68fdqZPZTw3IJHjIxhs0biM694g==
X-Received: by 2002:adf:b244:: with SMTP id y4-v6mr1657631wra.90.1539265348245;
        Thu, 11 Oct 2018 06:42:28 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id v16-v6sm20590749wru.31.2018.10.11.06.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 06:42:27 -0700 (PDT)
Date:   Thu, 11 Oct 2018 15:42:24 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     luca abeni <luca.abeni@santannapisa.it>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 5/8] sched: Add proxy execution
Message-ID: <20181011134224.GT9130@localhost.localdomain>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009092434.26221-6-juri.lelli@redhat.com>
 <20181010131048.54afd1b6@luca64>
 <20181011123448.GS9130@localhost.localdomain>
 <20181011125325.GA9867@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011125325.GA9867@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/18 14:53, Peter Zijlstra wrote:

[...]

> I think it was the safe and simple choice; note that we're not migrating
> just a single @p, but a whole chain of @p. rq->curr must not be any of the
> possible @p's. rq->idle, is per definition not one of the @p's.
> 
> Does that make sense?

It does, and I guess is most probably the safest choice indeed. But,
just to put together a proper comment for next version..

The chain we are migrating is composed of blocked_task(s), so tasks that
blocked on a mutex owned by @p. Now, if such a chain has been built, it
means that proxy() has been called "for" @p previously, and @p might be
curr while one of its waiters might be proxy. So, none of the blocked_
task(s) should be rq->curr (even if one of their scheduling context
might be in use)?
