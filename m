Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A86C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C441D20871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a2KWVgVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C441D20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeGJL26 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:28:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933268AbeGJL24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h8ZqV2uJGbuc0qyyqmwG5TXBt1c8QIqQUVGvJtuvZq4=; b=a2KWVgVFTsVU5H8ZMAOUEsxGX
        8p7XZEm4DpyU+6Rl1zlD+WhXmKCfScncLnMaAeTlSp0NjKQ+53OA7grcf1rAsk/bDtSaZCAiGiXBJ
        uFpf/OdvIi+GGuFGBxhAxtfHXek8EmldJbKd1IpIV35idctE5ruU5uxbhHaUZL/PoyprSaxmDGeaJ
        rLelYW3WohI7LqvUC4WPyj2XfeRx23TAMWPA077DuWh34Exkl721DMjGEHXmXgiXclk+zSfFdjJ3L
        X0xZ7RbgFdlDOlMlbCebn9oagUYQmCfWKC/w6yZEsOxCf+6pPis7XKrN6Y666QmrGXpAjAtnNf+og
        T7CPosCxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcqp9-0004aN-8x; Tue, 10 Jul 2018 11:28:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA753203E577F; Tue, 10 Jul 2018 13:28:49 +0200 (CEST)
Date:   Tue, 10 Jul 2018 13:28:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/lockdep: Dump state of percpu_rwsem upon hung up.
Message-ID: <20180710112849.GG2476@hirez.programming.kicks-ass.net>
References: <1530945060-7507-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <201807071750.mmO8ZiJo%fengguang.wu@intel.com>
 <201807100610.w6A6Apv4020906@www262.sakura.ne.jp>
 <20180710093046.GE2476@hirez.programming.kicks-ass.net>
 <bdecb526-9f61-bdb9-85f1-a6243b5fac7a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdecb526-9f61-bdb9-85f1-a6243b5fac7a@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 07:48:31PM +0900, Tetsuo Handa wrote:
> Should I update
> "[PATCH] locking/lockdep: Dump state of percpu_rwsem upon hung up." side
> to use "#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK" ?

Since it's a debug patch, who cares if there's a config for which it
doesn't build?
