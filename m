Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DA5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B99520661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pkDasp/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B99520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeHaMjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:39:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeHaMjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1g0OpraIOMN55pmYzjFbW3UFbF9IY5hiEyyg8BYasa4=; b=pkDasp/k1VWnAAne1thM/HslyO
        gxxSS4Z07HRzXzadcaeyovvPzLcfkVZhO+yGLmwYILXAWj0hOD2V5jEK3WX8CnWCx7oJtpDurVl7L
        1AtlJymcs8zpNUt26KanCYesDuYjSfToC8WHyH02/rYi38kxMp7zLaAavo/jpUzF2ggWJEFKdYECH
        vX6+OGfm/nDJvoOjHS9E2Sc1OV+zNwoPRY532LydXM+TmbA8yd+9YBtolk3VP2wfukerwbF+JwcDh
        GAqgPIS8g7+d+ZSt8lhCGk66yvrXWhSvtlCeJkSfnErtLFvPAU5y2JyLz6w0MJ6hgzv/ApbxaTDlL
        4FRsRWiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fverm-0005Jq-E6; Fri, 31 Aug 2018 08:33:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F5AC2024D73F; Fri, 31 Aug 2018 10:33:16 +0200 (CEST)
Date:   Fri, 31 Aug 2018 10:33:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mojha@codeaurora.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:smp/urgent] cpu/hotplug: Remove skip_onerr field from
 cpuhp_step structure
Message-ID: <20180831083316.GR24082@hirez.programming.kicks-ass.net>
References: <1535439294-31426-1-git-send-email-mojha@codeaurora.org>
 <tip-935aad3015fb4afc0b7ef6e6c18175b95461de47@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tip-935aad3015fb4afc0b7ef6e6c18175b95461de47@git.kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 04:03:58AM -0700, tip-bot for Mukesh Ojha wrote:
> Commit-ID:  935aad3015fb4afc0b7ef6e6c18175b95461de47
> Gitweb:     https://git.kernel.org/tip/935aad3015fb4afc0b7ef6e6c18175b95461de47
> Author:     Mukesh Ojha <mojha@codeaurora.org>
> AuthorDate: Tue, 28 Aug 2018 12:24:54 +0530
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Thu, 30 Aug 2018 12:59:30 +0200

> @@ -644,12 +637,6 @@ static void cpuhp_thread_fun(unsigned int cpu)
>  
>  	WARN_ON_ONCE(!cpuhp_is_ap_state(state));
>  
> -	if (st->rollback) {
> -		struct cpuhp_step *step = cpuhp_get_step(state);
> -		if (step->skip_onerr)
> -			goto next;
> -	}
> -
>  	if (cpuhp_is_atomic_state(state)) {
>  		local_irq_disable();
>  		st->result = cpuhp_invoke_callback(cpu, state, bringup, st->node, &st->last);


Can you fold this in?

../kernel/cpu.c: In function ‘cpuhp_thread_fun’:
../kernel/cpu.c:663:1: warning: label ‘next’ defined but not used [-Wunused-label]

---
 kernel/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c544baf75e77..aa7fe85ad62e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -660,7 +660,6 @@ static void cpuhp_thread_fun(unsigned int cpu)
 		st->should_run = false;
 	}
 
-next:
 	cpuhp_lock_release(bringup);
 
 	if (!st->should_run)
