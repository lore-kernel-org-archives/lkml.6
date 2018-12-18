Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C594EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B0F217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EjlMmDZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbeLRNOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:14:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLRNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8pbclwVz6ng5ILBCdUwjuWKJSypBC5BAU8/q2K3LI/k=; b=EjlMmDZOi1HYliw9GOEahJj0s
        SeHW1NMXEK9AjDrIo9N0+jOocWRBLdHzL99ZtNlnqdTTXTRX18hIok4CU8yB9wMSGmKtjHIvkelPL
        Eld8pwWsKXsiqYRUmJqx+ktii76szfAi+o6GZcwm/2XNbb4aP4i5AyyEMzps+2GSplmrPS74T6NKg
        f3hXRLICknBDwIrwKXYUy1NRjW9sZY17lzf/0w3Kt2f/8j7VxLQgXCMbvtygPZvEmp4Q9aTopRCfi
        7h3xqomAZfpDMHeezZbCw6fbg9yYohGYuBvL7OTmIm6rHwQ+Lne5hjnsHJqWdFkATo38TrZEM0ov6
        rwD1397GQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZFCX-0000p9-C2; Tue, 18 Dec 2018 13:14:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8CDF203895D5; Tue, 18 Dec 2018 14:14:19 +0100 (CET)
Date:   Tue, 18 Dec 2018 14:14:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@baidu.com>, zhangyu31@baidu.com,
        liuqi16@baidu.com, yuanlinsi01@baidu.com, nixun@baidu.com,
        lilin24@baidu.com, longman@redhat.com,
        andrea.parri@amarulasolutions.com
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181218131419.GD16284@hirez.programming.kicks-ass.net>
References: <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
 <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
 <20181217113718.GB4900@worktop.programming.kicks-ass.net>
 <20181217205310.pvwcryyaqlrzmaex@linux-r8p5>
 <20181218131031.GJ15430@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218131031.GJ15430@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:10:31PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 17, 2018 at 12:53:10PM -0800, Davidlohr Bueso wrote:

> > So how about the following to reduce some of the performance penalty (at
> > the cost of more complexity)?
> 
> I'd rather do it like so, except I'm still conflicted on the naming.

> +void wake_q_add(struct wake_q_head *head, struct task_struct *task)
> +{
> +	if (__wake_q_add(head, task))
> +		get_task_struct(task);
> +}
> +
> +void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task)
> +{
> +	if (!__wake_a_add(head, task))
> +		put_task_struct(task);
>  }

That is, in the one case it has internal reference counting, in the
other case it consumes the reference counting.
