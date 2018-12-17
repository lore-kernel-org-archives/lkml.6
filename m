Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBCEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A2A204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G/iAKWlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeLQLhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:37:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52640 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbeLQLhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ypto5pGNyOfQlEOm+YoX2DZmroFPlTLVGI1R7JIUX/0=; b=G/iAKWlpOg1A87j0TS05WwRCM
        JQRP2MPW0FlGK5N4lJrudIH1rajpTK2YtwkuoW0B7OxfLHjui5eOkhwNZtCn4rRcJ2LIsuP6ZrSpw
        0NdLlXHtpRmjLaWBVdxjvjYb3ZUgBthYukDT4gJQarTJZX98X/6za8vQf1Smt/0SGQnizPhuwOg+n
        2/neZnzCVG8kbj4FApFbs+QH1dWaL7Qw8Uvgs7SIsr4icyw/do61uAo3Lnb7GxXU2+6Eonw5XDVy7
        EBod6cE8oQ3+RK1rMatNwk5hyF89smB9YvhpHzdaebxack0gEP9I/DLgvhvOX6ozhvs2pPBRra4Hm
        Uf2s8DKZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYrD9-0008Uo-81; Mon, 17 Dec 2018 11:37:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA9E7984437; Mon, 17 Dec 2018 12:37:18 +0100 (CET)
Date:   Mon, 17 Dec 2018 12:37:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yongji Xie <elohimes@gmail.com>
Cc:     dave@stgolabs.net, mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@baidu.com>,
        zhangyu31@baidu.com, liuqi16@baidu.com, yuanlinsi01@baidu.com,
        nixun@baidu.com, lilin24@baidu.com, longman@redhat.com,
        andrea.parri@amarulasolutions.com
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181217113718.GB4900@worktop.programming.kicks-ass.net>
References: <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
 <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:12:52PM +0800, Yongji Xie wrote:
> Hi Peter,
> 
> Please let me know If there is any progress on this issue. Thank you!

Right, sorry, my brain was filled with snot and didn't want to make
sense of things.

I've put some patches here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core

Could you have a look?
