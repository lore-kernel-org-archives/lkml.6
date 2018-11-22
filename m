Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D7920866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ggfGQ+b1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D7920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393846AbeKVUrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:47:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbeKVUrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9dCNxHqs5TlkEwajsCnPG0CfSw08S5QtKEYhjimDs00=; b=ggfGQ+b1Mq/5L2PmH/+4Ws9Pg
        mZOCUerw3fa9nnmnEo8NDMNKpu96yFssgjuM4s4sUvJqkgIUiETPzP4Aai82JdQdqLvUOLrnx+cuj
        uhuBixZ/XSYaZkPJ1Hrz/nklIsLYROKy1W76YlyOpWEcO6AU+bTiW/kELpXvXAQcA5Xmc068GsbUx
        11XqlZWi/BhNLKKe+cFaFtskTKjktYw03PiQXI2BXFQzFEUj4qy/Z7RMYvGSqAd14rrDDgiBtrEPu
        1/wRkiz/RzCEJwe28xN2x6w9hny4rsF9MYqWWI8BQYjvxp1cSTsjl4qtg0QZ/6WOrKfECav6msU8n
        BFSJjK9zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPluH-0000Iz-Ig; Thu, 22 Nov 2018 10:08:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B4A42029FD58; Thu, 22 Nov 2018 11:08:12 +0100 (CET)
Date:   Thu, 22 Nov 2018 11:08:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 00/14] function_graph: Rewrite to allow multiple
 users
Message-ID: <20181122100812.GO2131@hirez.programming.kicks-ass.net>
References: <20181122012708.491151844@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122012708.491151844@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 08:27:08PM -0500, Steven Rostedt wrote:
> Well the fuction graph tracer is arguably the strongest of the tracers.
> It shows both the entrance and exit of a function, can give the timings
> of a function, and shows the execution of the code quite nicely.
> 
> But it has one major flaw.
> 
> It can't let more than one user access it at a time.

The reason I 'never' use it is performance, it _sucks_.. I've never ran
into the multi-user issue.

So while I don't think the rewrite is bad, this argument here is.
