Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE725C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AC4218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XYB4w9HS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfB0IBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:01:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfB0IBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eOaSEjVF3dTmLFou+OG1uoIHG1sWUtxIukluUJvK3iM=; b=XYB4w9HSYY3bjQd1EdcQzIWJa
        KCn9U9BuJtQ7bytbJbdv3N8v27hlq4poDikC5kWzBuu1cWHbABYmb71EQn3YvZsC8XI7UuDHPmfeg
        emR8jaL64uXxto3sPW6UaDENBlTWvZNlJDWjd0L3D6mGg8+xx6Q3llbp63tLugNIMFVYzkefmfy22
        V38C+tft2xQ6p9C3MsXHxtYiUp20usZZeynCWcOGgmFy6JT9gU4WR5T9ty2ij2wPM4iGcsCwIvg0/
        seuYB1yIN7ekwRtitXWXTJpwYTPrFb6gIH8DTq66foxJaceXZLi3BZZPyMM4tt1owRZwgqvqFzpNH
        PY50iAqcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyu8r-0006FT-2k; Wed, 27 Feb 2019 08:00:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 747F023D03C7A; Wed, 27 Feb 2019 09:00:34 +0100 (CET)
Date:   Wed, 27 Feb 2019 09:00:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [RFC PATCH 0/4] tracing/probes: uaccess: Add support user-space
 access
Message-ID: <20190227080034.GJ32494@hirez.programming.kicks-ass.net>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
 <20190226213850.GA219025@google.com>
 <20190227164104.5f53f029a7fec898204e9b67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227164104.5f53f029a7fec898204e9b67@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 04:41:04PM +0900, Masami Hiramatsu wrote:
> 
> IMHO, checking in access_ok() inside it is reasonable, but as it
> commented, it is for "if pagefaults are enabled.". What we need another 
> access_ok() for the case when pagefaults are disabled, that is what PeterZ
> suggested in below mail.
> 
> https://lore.kernel.org/lkml/20190225150603.GE32494@hirez.programming.kicks-ass.net/T/#u

FWIW, feel free to carry that patch with your other changes that require
it.

You can add my SoB if you write the Changelog ;-)
