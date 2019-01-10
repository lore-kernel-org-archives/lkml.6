Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD90AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894A4208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GaCjm/pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfAJUZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:25:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51422 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfAJUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jog9ZwrILLUqYnYEM9yeKYKLdJpnoiz07dnT1UexYGE=; b=GaCjm/pWe5FgFqzGylW36JSuR
        w7j55huQNZGwupGWfX4BGLueRjgeK52utJbgYLT7kgUX5tp4N1JpdhF0GqHPpWmjWPk9fXyfms3ed
        y7YHRBCZmXsRv0Yo36PbZDpFr7iJ/brdxCOIp+Bl9fUKtqXhlWrknAO2HhpJKlW2na/liadrci1XX
        /0dR9U5gBh4dzywQ2pkKart0smy6VEFlyQcsMqMpU2rRVFQvx3OiDxD/buSI0WEGWqprnhdQ9TCZy
        oJAQEEIUGRJ45RyVTbac+XoBZ9mc7sJ2VVPos8cNFkoSH6KE1GPnLpMbaQ1FzkWklshY6NFgNypYa
        0apYNOGvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghgtU-00071q-1C; Thu, 10 Jan 2019 20:25:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 823F59844AF; Thu, 10 Jan 2019 21:25:33 +0100 (CET)
Date:   Thu, 10 Jan 2019 21:25:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Anatol Pomozov <anatol.pomozov@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, paulmck@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190110202533.GK2861@worktop.programming.kicks-ass.net>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc>
 <20190110124123.GA21224@hirez.programming.kicks-ass.net>
 <20190110144812.mkbokbj2iyryj6lv@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110144812.mkbokbj2iyryj6lv@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:48:12PM +0100, Florian Westphal wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> > Is performance a concern in this path? There is no comment justifying
> > this 'creative' stuff.
> 
> We have to wait until all cpus are done with current iptables ruleset.
> 
> Before this 'creative' change, this relied on get_counters
> synchronization.  And that caused wait times of 30 seconds or more on
> busy systems.
> 
> I have no objections swapping this with a synchronize_rcu() if that
> makes it easier.

Would using synchronize_rcu() not also mean you can get rid of that
xt_write_recseq*() stuff entirely?

Anyway, synchronize_rcu() can also take a little while, but I don't
think anywere near 30 seconds.

> (synchronize_rcu might be confusing though, as we don't use rcu
>  for table->private), and one 'has to know' that all the netfilter
>  hooks, including the iptables eval loop, run with rcu_read_lock
>  held).

A comment can help there, right?
