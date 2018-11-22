Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4925C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884022081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JJW9LXKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884022081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437015AbeKWAXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:23:35 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36510 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeKWAXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:23:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so7778837edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kn1GMJ6nAhu22j3QnZFy6TU+VvMnQSDGmLq0CAIJ7Bc=;
        b=JJW9LXKBk5IdFjwtML39qLQ6pGwihIL7pWXxJQKqqE0cepaMNlb17RkPOYq3DVmNsc
         YFuN4PdkEF/VVkE/jpddpityYj6PxS1Ybnb0zOAUYoQzFGd6mUybMr/yMuxLR44i4t4J
         Fx27S/ubqfo2Kut0ZQCxFSGE6E5vskowN/YTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kn1GMJ6nAhu22j3QnZFy6TU+VvMnQSDGmLq0CAIJ7Bc=;
        b=IYQaXgVRhZ5/BhAmHByOXi39+5TtC9RkcbE1vEIET93w4A7AwVzvvQV4jO1Gvm86Yd
         hqTvgWVHfaO6pveqAWgNLsLVjIeb+VOTE/Y7sycteMSqoQLtILrn/VjnFo0Bh/lkMGq8
         LizY5p3D6AQM7XEF8mM4ztjAZluTiUeealKKOj5KxCHS7sfYgKOKXr8oi2IcgJoLEDhK
         vGbVsJLVpXgA3t/2H5QxJSnnqCh0lFErif3HG1tjbl86+JmfvnZg3q8tdKm/BP9lcBCB
         CGdspsnNZPvZd2YAKjWivVIS5/OvQynIRNP57pcaG/A1lfL/iP6ce4WeI57dnTImnDFG
         hfYA==
X-Gm-Message-State: AGRZ1gJvoJYrx9nHxlUWShmgnzroUInuWN/cww91comZuhZJRynkcvKK
        1dVoZ5RyG0JrVvONC2WqwUHiGA==
X-Google-Smtp-Source: AJdET5ci2qBvalKPmReguVfGmHP52Nf5UMkLqKwl3Oh0ykqlJR3RcPuuxATsMJ8x7lobxN97FqNMVw==
X-Received: by 2002:a17:906:7253:: with SMTP id n19-v6mr8050284ejk.192.1542894248335;
        Thu, 22 Nov 2018 05:44:08 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id r18-v6sm5787258ejz.22.2018.11.22.05.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 05:44:07 -0800 (PST)
Date:   Thu, 22 Nov 2018 14:44:00 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Question] smp_wmb() in prepare_uprobe()
Message-ID: <20181122134400.GA10327@andrea>
References: <20181121224124.GB4016@andrea>
 <20181122123655.GD28270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122123655.GD28270@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 01:36:56PM +0100, Oleg Nesterov wrote:
> Hi,
> 
> On 11/21, Andrea Parri wrote:
> >
> > The comment for the smp_wmb() in prepare_uprobe() says:
> >
> >   "pairs with rmb() in find_active_uprobe()"
> 
> it seems that this comment was wrong from the very beginning,
> 
> 
> > but I see no (smp_)rmb() in find_active_uprobe(); I see the smp_rmb() in
> > handle_swbp(): is this the intended pairing barrier?
> 
> Yes, and the comment near this rmb() says "pairs with wmb() in install_breakpoint()",
> today this is not right too.

Thanks for the confirmation.  So, this is the easy part ;-), maybe
something like:

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 96d4bee83489b..2d29977522017 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -829,7 +829,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	BUG_ON((uprobe->offset & ~PAGE_MASK) +
 			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
 
-	smp_wmb(); /* pairs with rmb() in find_active_uprobe() */
+	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
  out:
@@ -2178,7 +2178,7 @@ static void handle_swbp(struct pt_regs *regs)
 	 * After we hit the bp, _unregister + _register can install the
 	 * new and not-yet-analyzed uprobe at the same address, restart.
 	 */
-	smp_rmb(); /* pairs with wmb() in install_breakpoint() */
+	smp_rmb(); /* pairs with the smp_wmb() in prepare_uprobe() */
 	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
 		goto out;
 

> 
> > Which memory accesses do you want to "order" with this pairing?
> 
> See 142b18ddc81439acda4bc4231b291e99fe67d507 ("uprobes: Fix handle_swbp()
> vs unregister() + register() race") and the comment above this rmb().

Mmh..., at first glance, this suggests me that the above set_bit() and
test_bit() to/from uprobe->flags are among these memory accesses.  But
this doesn't make sense to me: these accesses do not "alternate" (i.e.,
they both appear after the corresponding barrier..); instead I'd expect
something like (on top of the above diff):

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2d29977522017..a75b9a08dee54 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2178,10 +2178,18 @@ static void handle_swbp(struct pt_regs *regs)
 	 * After we hit the bp, _unregister + _register can install the
 	 * new and not-yet-analyzed uprobe at the same address, restart.
 	 */
-	smp_rmb(); /* pairs with the smp_wmb() in prepare_uprobe() */
 	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
 		goto out;
 
+	/*
+	 * Pairs with the smp_wmb() in prepare_uprobe().
+	 *
+	 * Guarantees that if we see the UPROBE_COPY_INSN bit set, then
+	 * we must (can) also see the stores to &uprobe->arch performed
+	 * by prepare_uprobe() (say).
+	 */
+	smp_rmb();
+
 	/* Tracing handlers use ->utask to communicate with fetch methods */
 	if (!get_utask())
 		goto out;

Thoughts?

  Andrea


> 
> Oleg.
> 
