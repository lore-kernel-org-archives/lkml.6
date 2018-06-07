Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8eA/OQwoGVsKewAAmS7hNA
	; Thu, 07 Jun 2018 12:41:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D0D48608BA; Thu,  7 Jun 2018 12:41:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LhD67+E0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 429B0607DC;
	Thu,  7 Jun 2018 12:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 429B0607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbeFGMlo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:41:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49910 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeFGMll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YS1qMxUC8Zs8NRD6d41S1qG0bl2WzwPoHhsIXF/y3/s=; b=LhD67+E0BzK33pmCPDs2fSUeE
        5DytzUwu8mjI3EVlN6QcjFGKPBVim9+TwOLYReidSrXWriiwHZvDgKsiooIbBadIR5FA8NjLlo5M2
        HEAOGHOxYvH2tTEBIwszSUUj2sj/TbRA3+fRKVen6n4zImwPQZkfyb23oj/jwrrjZPFbc/+O5EAkS
        0+SO25ZBMKglT+IG1BsEJUHcBlzdDo2W7N4XzpJ2YpZ5p0ZasYqVbB5VsNz8XN20RgDo0Qq2FaxR2
        aMO+rxwJEBFR7lZ36TLbjCHeBgSO8ycTGACqau8mSe63eiE1UanLmINJl+FW3YDSy1qNiNi6nIm52
        hcHLRis4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQuEI-000647-4n; Thu, 07 Jun 2018 12:41:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 94FAB201EA7A3; Thu,  7 Jun 2018 14:41:18 +0200 (CEST)
Message-Id: <20180607123310.866085998@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 07 Jun 2018 14:33:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org
Cc: tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 0/4] kthread/smpboot: More fixes...
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches were tested with hotplug and /proc/sys/kernel/watchdog_cpumask
manipulations.

I used 'grep watchdog_fn /proc/timer_list | wc -l' to verify the expected
number of active timers.

Please have a look..

---
 include/linux/cpuhotplug.h |   1 +
 include/linux/kthread.h    |   1 -
 include/linux/nmi.h        |   5 ++
 include/linux/sched.h      |   2 +-
 include/linux/smpboot.h    |  15 +-----
 kernel/cpu.c               |   5 ++
 kernel/kthread.c           |  34 +++++++++---
 kernel/sched/core.c        |  31 ++++-------
 kernel/smpboot.c           |  54 ++-----------------
 kernel/watchdog.c          | 132 +++++++++++++++++++--------------------------
 10 files changed, 112 insertions(+), 168 deletions(-)
