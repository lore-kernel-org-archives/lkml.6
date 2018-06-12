Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6EE4AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24725208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CUPR/XZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24725208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933472AbeFLMnL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:43:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932627AbeFLMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ognTD1ebtuEGuo59wdzAoDThx91WxYUUaI1ssdLEc2w=; b=CUPR/XZ3Qmfunncs7i/UowGW0
        pgcyvfVwxSD5PtqpibszBzakN5fMTFkSLRpcKJQotPdEcna9BF8RiurGh5JjsajrDoNYJgSyKCnjj
        Y9bTgHDQMq0FOWwPn9aqUQ5/UDz3WF70J/kUiYNKyT1quWOiHvssrvuTL1H2bj35uTtr0Vx1BNzz/
        gl4vJRDdFwFGvOIT8OLKRTXudgubvW413GE7T/z26tJCd07eREJ+yTcRUk/uUDXqPEnMC2yzJ+skx
        z8zL65MFlRluBU72jDo6Uf2Cg6h1It1zjheTCd2kHubmIV8+U9h50a9EX0u8u+b+WWjVO/XEIck9a
        jtFxFLK8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSidX-0007Tz-M6; Tue, 12 Jun 2018 12:42:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAA7D201EA7CB; Tue, 12 Jun 2018 14:42:57 +0200 (CEST)
Date:   Tue, 12 Jun 2018 14:42:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     mingo@kernel.org, gkohli@codeaurora.org, tglx@linutronix.de,
        mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 4/4] kthread: Simplify kthread_park() completion
Message-ID: <20180612124257.GS12198@hirez.programming.kicks-ass.net>
References: <20180607123310.866085998@infradead.org>
 <20180607124006.266038375@infradead.org>
 <20180608095220.GA18941@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608095220.GA18941@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 11:52:20AM +0200, Oleg Nesterov wrote:
> in smpboot_update_cpumask_percpu_thread() can hit a KTHREAD_SHOULD_PARK
> thread? Lets look into kernel test robot's .config:
> 
> 	CONFIG_NR_CPUS=1
> 
> Now look at NR_CPUS==1 version of for_each_cpu* helpers:
> 
> 	#define for_each_cpu(cpu, mask)			\
> 		for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)

Argh, that issue again.

> So even if the "tmp" cpumask is empty the code above always does
> 
> 		smpboot_park_thread(plug_thread, 0);
> 
> and hits the already parked kthread.

OK, I'll write a new Changelog.
