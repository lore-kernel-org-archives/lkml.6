Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B857C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034AC20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDj6EdeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034AC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeK0Fgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeK0Fgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:36:53 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CBA20862;
        Mon, 26 Nov 2018 18:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543257714;
        bh=MK9NAaSBFuvSVHoE16CbMipp9ZlKcpWNEmGOqziKQe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDj6EdeLAtoWA6Xgmh+rqrAd58lZC68+jq+GfQym826bFoh0LBGycLsuRAoOEs78Y
         Lg6JbBCe7HpTTQlXgAxtrTHw/+9dxlypp/lH9Y+R6G8culgsWhp4wt9YGH0OUxogiB
         BYGjaCyoy47eBudk2KEApOWkejGfLzEfEQKI5LRY=
Date:   Mon, 26 Nov 2018 19:41:51 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 19/25] sched/vite: Handle nice updates under vtime
Message-ID: <20181126184150.GB18962@lerouge>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-20-git-send-email-frederic@kernel.org>
 <20181120141754.GW2131@hirez.programming.kicks-ass.net>
 <20181126155352.GA18962@lerouge>
 <20181126161103.GW2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126161103.GW2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:11:03PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 26, 2018 at 04:53:54PM +0100, Frederic Weisbecker wrote:
> > > > +	irq_work_queue_on(&per_cpu(vtime_set_nice_work, cpu), cpu);
> > > 
> > > What happens if you already had one pending? Do we loose updates?
> > 
> > No, if irq_work is already pending, it doesn't requeue iff the work hasn't
> > been executed yet and it's guaranteed it will see the freshest update.
> > (you should trust more the code you wrote ;-)
> 
> Yeah, I do remember hoq irq_work works. What I was asking was about how
> this specific handler deals with 'missing' updates.
> 
> Suppose we start with state A, set it to B and raise the IPI, then set
> it to C before the interrupt happens.
> 
> That means the irq_work handler will see C and never observe B.

Ah right, but that's ok, we can miss a few intermediate very short states. In this
case the most recent update is the relevant one.
