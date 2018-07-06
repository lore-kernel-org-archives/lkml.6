Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A57C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D39823FCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YrZanQE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D39823FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbeGFNSO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:18:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932995AbeGFNSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FzaIFqmy9HyI6WVp/xxC/w9D+V3hk3YdSEmirsC+VUg=; b=YrZanQE3tYJ6vvFcfIK+6dVjl
        dZAR3+wC6rETnwe86VSxbQ+n01OinLrsw/GepZnuFeaDl/5JDUJB9m/QmooSKwtM5XYGqqygr6t9r
        2ZOKaJNd//fGGDk6ulRpODzzjOppWt+1sR12OSMyAiqwr95FUXffF648rd9GvEVr1v9F8s+s5BNLc
        NELL4SuCI4oE6zZKUpjU1YumuFwmnvxu7zFUnrHmqzNv4m1YIR+/QQJz6cmTjUVnqYYR42Wc4KlGC
        VmOnVROZMVX38ftGh7LDmwitPuK2Ays33dqhOc5oqIgjq2/DRnaN0fAM0jSnRT45vnmqUuLJ0Kywk
        SoWOlFsRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbQck-0004Xw-47; Fri, 06 Jul 2018 13:18:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60A7220298BAE; Fri,  6 Jul 2018 15:18:08 +0200 (CEST)
Date:   Fri, 6 Jul 2018 15:18:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/core: remove get_cpu() from sched_fork()
Message-ID: <20180706131808.GM2494@hirez.programming.kicks-ass.net>
References: <20180706130615.g2ex2kmfu5kcvlq6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706130615.g2ex2kmfu5kcvlq6@linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:06:15PM +0200, Sebastian Andrzej Siewior wrote:
> Based on this it is possible to remove get_cpu() and use
> smp_processor_id() for the `cpu' variable without breaking anything.

Almost.. I think, see init_task_preempt_count().
