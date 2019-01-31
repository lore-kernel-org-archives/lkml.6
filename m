Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794AC282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E174E218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IPmI1Jyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfAaJ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:56:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfAaJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KN65jVycwBIWs0n5vnAR5t/2bKTkjompeuCCWRbFckA=; b=IPmI1JyzbnKkgM7McXrYqBrrz
        FHSkE2SujZs2P1mG3fxLyarSMbT1ikrQ1/oSj9ptbDkfAkfPSeLH1ugHbHKjIH4vXBvVRfs5McXmh
        G0J2hadUwy6AsBgvrCjgEWA1mnir+bLWJ4niH5mXyhXeVm0fkKdbZsDkf1HwM+Kl8HhdyVGUg+6ZK
        lyZY7k5IZXEpCAWWFi816Cy8mvHWGeWPsf8EGpTk+nBOlJfoWbl8FSyC7ncDyw6igeaFRnp9KUqyR
        frxJb0AslimxFlTlEn0fRs7KaoxAhRYPG8mmlkKnHoKLguczt9jMJTIo8wTHQy2y4/hDhtoZkSSpI
        3Zzyq3OUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gp95M-0005cu-J7; Thu, 31 Jan 2019 09:56:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3164A20423039; Thu, 31 Jan 2019 10:56:38 +0100 (CET)
Date:   Thu, 31 Jan 2019 10:56:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH 0/3] Add NUMA-awareness to qspinlock
Message-ID: <20190131095638.GA31534@hirez.programming.kicks-ass.net>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131030136.56999-1-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:01:32PM -0500, Alex Kogan wrote:
> Lock throughput can be increased by handing a lock to a waiter on the
> same NUMA socket as the lock holder, provided care is taken to avoid
> starvation of waiters on other NUMA sockets. This patch introduces CNA
> (compact NUMA-aware lock) as the slow path for qspinlock.

Since you use NUMA, use the term node, not socket. The two are not
strictly related.

> CNA is a NUMA-aware version of the MCS spin-lock. Spinning threads are
> organized in two queues, a main queue for threads running on the same
> socket as the current lock holder, and a secondary queue for threads
> running on other sockets. Threads record the ID of the socket on which
> they are running in their queue nodes. At the unlock time, the lock
> holder scans the main queue looking for a thread running on the same
> socket. If found (call it thread T), all threads in the main queue
> between the current lock holder and T are moved to the end of the
> secondary queue, and the lock is passed to T. If such T is not found, the
> lock is passed to the first node in the secondary queue. Finally, if the
> secondary queue is empty, the lock is passed to the next thread in the
> main queue.
> 
> Full details are available at https://arxiv.org/abs/1810.05600.

Full details really should also be in the Changelog. You can skip much
of the academic bla-bla, but the Changelog should be self contained.

> We have done some performance evaluation with the locktorture module
> as well as with several benchmarks from the will-it-scale repo.
> The following locktorture results are from an Oracle X5-4 server
> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
> cores each). Each number represents an average (over 5 runs) of the
> total number of ops (x10^7) reported at the end of each run. The stock
> kernel is v4.20.0-rc4+ compiled in the default configuration.
> 
> #thr  stock  patched speedup (patched/stock)
>   1   2.710   2.715  1.002
>   2   3.108   3.001  0.966
>   4   4.194   3.919  0.934

So low contention is actually worse. Funnily low contention is the
majority of our locks and is _really_ important.

>   8   5.309   6.894  1.299
>  16   6.722   9.094  1.353
>  32   7.314   9.885  1.352
>  36   7.562   9.855  1.303
>  72   6.696  10.358  1.547
> 108   6.364  10.181  1.600
> 142   6.179  10.178  1.647
> 
> When the kernel is compiled with lockstat enabled, CNA 

I'll ignore that, lockstat/lockdep enabled runs are not what one would
call performance relevant.
