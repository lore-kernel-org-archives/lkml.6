Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFB8C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B057206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VElQUT/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B057206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeKUA2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:28:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58024 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKUA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p2mMJxt5nVwgw+Rc6YtScLfjQihbZoOEL4varJT6LZY=; b=VElQUT/H28EjlzribKEGgWoJH
        eSzGrwPGRhlT5kA+sca1vzu0nAg0DBg5aOO1FxfNTp1uwFkezAL2T64alEudrknkDW3zgamp5pP5e
        hdz1vNbmpoAS1t5J6H5L5fDrW3CT4KDfxa9aB2gyCBz/J5biC+3VFB6EeSvRe44gdI+tQHyImz94O
        bV7MnfRExXrfYqFVG27V9dk+TJGA1vDCPTsfMKSoaaMh1ZyL3mrI6Bt7NRF4c3k8jN+amb+1N0yED
        hARSM+d5bO9zm907yUfW5vF8K2MvOdRZZ3j6lNZQAZAaljqFCBBW1ns4k4s0zGa+Z96kU45gMt6Am
        KyGsehlnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP6YF-0008J4-8U; Tue, 20 Nov 2018 13:58:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E51622029F87F; Tue, 20 Nov 2018 14:58:49 +0100 (CET)
Date:   Tue, 20 Nov 2018 14:58:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 09/25] kcpustat: Track running task following vtime
 sequences
Message-ID: <20181120135849.GS2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-10-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542163569-20047-10-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:45:53AM +0100, Frederic Weisbecker wrote:
> In order to make kcpustat vtime aware (ie: work on nohz_full without
> freezing), we need to track the task running on the CPU in order to
> fetch its vtime delta and add it to the relevant kcpustat field.
> 
> The most efficient way to track this task is to use RCU. The task is
> assigned on context switch right after we flush the vtime of the previous
> task and the next task has been set on vtime.
> 
> Things are then prepared to be ordered that way:
> 
>              WRITER (ctx switch)                READER
>              ------------------            -----------------------
>         vtime_seqcount_write_lock(prev)     rcu_read_lock()
>         //flush prev vtime                  curr = rcu_dereference(kcpustat->curr)
>         vtime_seqcount_write_unlock(prev)   vtime_seqcount_read_start(curr)
>                                             //fetch curr vtime
>         vtime_seqcount_lock(next)           vtime_seqcount_read_end(curr)
>         //Init vtime                        rcu_read_unlock()
>         vtime_seqcount_unlock(next)
> 
>         rcu_assign_pointer(kcpustat->curr, next)
> 
> With this ordering layout, we are sure that we get a sequence with a
> coherent couple (task cputime, kcpustat).

I'm confused; earlier you added a ->cpu member; but I don't see that
used.

Also, I'm confuddled on the purpose of rcu_assign_pointer(), what does
the store_release therein ensure?

Also, I'm pretty sure the below is terminally broken; task_struct is not
rcu-freed, and therefore the above scenario is just broken. Nothing
stops the task from going away right after rcu_dereference().
