Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B5AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714E320645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ikr40iz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714E320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeICNN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:13:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeICNN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Zpx/cSPEiP3ssw0Vb2g9dyiMRBRZClIJ8aUw3VU/4I=; b=ikr40iz2RIbGO3HR4CVcaU/zk
        O+mqyJY+vQPF4IJGzbN79rcPBdEDdXdZZtUOEBYkM7FCx17xWZY4FxQWtPnRILK4H4xQn+UQtpe/m
        vRs6FaybUJk18OlOjFac7M7X5jRwLyl8lYUcPP3ylvNI8oRgH4pgV+TuhyhPLuBTov4quH+Q4spSI
        buLgLg0GPXxtn93hmwocVjhyUQs18OQAzD2lvsmqzPImJ5sBCmpfpuvg6/HocuZgGNYT4yFptMoAZ
        HHeG7P+TXvdu6Xbo8IZajttyccPxkd7vcMRkcEWqQvvW5/UDdxmjZI4xE1/4dJEVG99h3yBhElMn1
        ObnFQCiVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwkcq-0006hg-CR; Mon, 03 Sep 2018 08:54:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 293EF2024EB0A; Mon,  3 Sep 2018 10:54:23 +0200 (CEST)
Date:   Mon, 3 Sep 2018 10:54:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Shanahan <kevin@shanahan.id.au>,
        Siegfried Metz <frame@mailbox.org>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        len.brown@intel.com, rjw@rjwysocki.net, diego.viola@gmail.com,
        rui.zhang@intel.com, viktor_jaegerskuepper@freenet.de
Subject: Re: REGRESSION: boot stalls on several old dual core Intel CPUs
Message-ID: <20180903085423.GU24124@hirez.programming.kicks-ass.net>
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
 <20180830130439.GM24082@hirez.programming.kicks-ass.net>
 <20180901022125.GO4941@tuon.disenchant.local>
 <20180903072506.GS24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809030937230.1349@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809030937230.1349@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 09:38:15AM +0200, Thomas Gleixner wrote:
> On Mon, 3 Sep 2018, Peter Zijlstra wrote:
> > On Sat, Sep 01, 2018 at 11:51:26AM +0930, Kevin Shanahan wrote:
> > > commit 01548f4d3e8e94caf323a4f664eb347fd34a34ab
> > > Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > Date:   Tue Aug 18 17:09:42 2009 +0200
> > > 
> > >     clocksource: Avoid clocksource watchdog circular locking dependency
> > > 
> > >     stop_machine from a multithreaded workqueue is not allowed because
> > >     of a circular locking dependency between cpu_down and the workqueue
> > >     execution. Use a kernel thread to do the clocksource downgrade.
> > 
> > I cannot find stop_machine usage there; either it went away or I need to
> > like wake up.
> 
> timekeeping_notify() which is involved in switching clock source uses stomp
> machine.

ARGH... OK, lemme see if I can come up with something other than
endlessly spawning that kthread.

A special purpose kthread_worker would make more sense than that.
