Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C95206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jxjCCFIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfAJPpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:45:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbfAJPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TrbfF/5QQ3K6gZkS1CcwjoCV4ZQwn+wW8N7biJnD3pA=; b=jxjCCFIClMFnxsMmW4805UBwR
        HfXyJijgpVv06X1tX5TeoylhCLggwxnkWH+V+KlvQUVwtGxxiHggN8epu8bTVFPBXtOrdlmUwLWRS
        S7vXUjvZbiQ5DmvYnlDzO3ljlZr/4SAQuue7kSHN4pgS/PWpYMCCuQ08iJEi8TgQjI1bgh25tVcgI
        0o7FeXDA9fVjNyUR9WprdJPoR79kywJ14Ac9YDBzpdEziMqMz9diDsVLbSrIwtAG2+gFUD2PieHWD
        mcpi4XFuua/4Rr+1xe7Xmu5D85xSw0ByD2IkDxBzj0XEUqIpgI9sDU1N76B2Z8z1J3sk82/lgLX9o
        26pvT4/Lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghcWD-00062e-UQ; Thu, 10 Jan 2019 15:45:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2604E20297683; Thu, 10 Jan 2019 16:45:14 +0100 (CET)
Date:   Thu, 10 Jan 2019 16:45:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
Message-ID: <20190110154514.GA13869@hirez.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
 <20181217213002.73776-8-bvanassche@acm.org>
 <20190110152035.GF30894@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110152035.GF30894@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:20:35PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 17, 2018 at 01:29:54PM -0800, Bart Van Assche wrote:

> > +	/*
> > +	 * Leak *chain because it is not safe to reinsert it before an RCU
> > +	 * grace period has expired.
> > +	 */
> > +	new_chain = lock_chains + nr_lock_chains++;
> > +	*new_chain = *chain;
> > +	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
> > +#endif
> > +}
> 
> Leaking a chain_hlocks[] and lock_chains[] entry is pretty gross, but
> yes that should work.

/me finds patch 10 and goes.. ooh shiny ;-)
