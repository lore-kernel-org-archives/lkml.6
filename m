Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF2620882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a7w9I5A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF2620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754528AbeGINCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:02:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeGINCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tktbsg7mmrj6LjPVW/4So8jLDi4Oz73rzyWCOvLN71M=; b=a7w9I5A92rJMf9mT2HphV7Dtf
        IHEjkFyqTqDF2b+vx9J+FNrESxARm649GhCSxreP/xFYQP36EaLICmKS0vxXCBbIpkBH1NDuUm2rf
        nTQ+0Jlac7NXwYygM7vXIGpRpnAt+8VsWdqKAilLKqfeMTiujz2LcGeo1RugeMuS/ziSS9c8AEaPH
        jxyEEsmsj97cT2lrjA4VHs0JbascCK2wdrTND3F/E2cc6WI7cGhX50t0o779cMa7POEewcgVWh+3o
        TYVPMCEFe3253zv2LKxBBEMI/EJAP+QWz+kTJogNLPSVD01NDweTNysccXiR6Jb7cECRfSDitIydl
        l4SpJrhgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcVoD-0006Hf-GI; Mon, 09 Jul 2018 13:02:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55DE420289331; Mon,  9 Jul 2018 15:02:27 +0200 (CEST)
Date:   Mon, 9 Jul 2018 15:02:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180709130227.GQ2512@hirez.programming.kicks-ass.net>
References: <bb77e730a5ada3689650b636e1dd03ac5cc87256.camel@infradead.org>
 <20180706162905.GZ2476@hirez.programming.kicks-ass.net>
 <20180706171150.GI3593@linux.vnet.ibm.com>
 <20180709085351.GC2476@hirez.programming.kicks-ass.net>
 <1531127935.18697.57.camel@infradead.org>
 <20180709104429.GI2476@hirez.programming.kicks-ass.net>
 <1531133801.18697.73.camel@infradead.org>
 <20180709110657.GL2476@hirez.programming.kicks-ass.net>
 <20180709123457.GM3593@linux.vnet.ibm.com>
 <20180709125516.GO2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709125516.GO2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:55:16PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 05:34:57AM -0700, Paul E. McKenney wrote:
> > But KVM defeats this by checking need_resched() before invoking
> > cond_resched().
> 
> That's not wrong or even uncommon I think.

In fact, I think we recently put that pattern in crypto code in order to
break up very long kernel_fpu sections.

Note that you also 'broke' cond_resched_lock() as that no longer matches
cond_resched().
