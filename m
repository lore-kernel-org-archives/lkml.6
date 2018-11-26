Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB108C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F32220865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Ap/Dkgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F32220865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeK0DGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:06:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0DGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yaNXNMQeJSdQ8xv7Pr6RUr5KTi+LQt8GMhtmVSjJPwI=; b=1Ap/Dkgfjatl/f37+3fQs6lDa
        OwEkHxKpknC4q0MKVk9nObjIVg5K7mPwR6A4bOSDDK0oGswxlJ0BHQgBvABMLrFaIpEyHSqzG87we
        A83Wf/xO5m+8xybksEOP589jtLh4IhZE6UYDok99xi3Njq+GVf3sDglllNX4UKvhNLPGe2uC1BZZg
        4uVE8e74RhCnMkzqE7RfMe9JAcWyy8rcsWl6SeuRFfdeNEag0YfXklYc/oNxrxUvMA3Ym8X6w/XNW
        7Mvd1NJpPkqHGKD/rcN06oIDqOQ3+oIUSBa+I86BiGgQiIPmdKerVB5SsXEFHZez6ukKooeAnjSkG
        V4zOZvOYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRJTV-0001ml-7r; Mon, 26 Nov 2018 16:11:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04FEF2029FD58; Mon, 26 Nov 2018 17:11:04 +0100 (CET)
Date:   Mon, 26 Nov 2018 17:11:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 19/25] sched/vite: Handle nice updates under vtime
Message-ID: <20181126161103.GW2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-20-git-send-email-frederic@kernel.org>
 <20181120141754.GW2131@hirez.programming.kicks-ass.net>
 <20181126155352.GA18962@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126155352.GA18962@lerouge>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:53:54PM +0100, Frederic Weisbecker wrote:
> > > +	irq_work_queue_on(&per_cpu(vtime_set_nice_work, cpu), cpu);
> > 
> > What happens if you already had one pending? Do we loose updates?
> 
> No, if irq_work is already pending, it doesn't requeue iff the work hasn't
> been executed yet and it's guaranteed it will see the freshest update.
> (you should trust more the code you wrote ;-)

Yeah, I do remember hoq irq_work works. What I was asking was about how
this specific handler deals with 'missing' updates.

Suppose we start with state A, set it to B and raise the IPI, then set
it to C before the interrupt happens.

That means the irq_work handler will see C and never observe B.
