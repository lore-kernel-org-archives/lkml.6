Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F92C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFDB20849
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KVD1XSYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFDB20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbeGIOnz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:43:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbeGIOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aTrt4W8JyGAAEcenTVkjc3cnT5TtknK/DlTOtOV03PM=; b=KVD1XSYIHlLVpM70nfRf7Ix+1
        fP9n4t/ISgv73c6iIV/AE1uxkapaey5lJJ8LFINQ1dyvTBs57ylvktHrHGtUmQoy/3+N+Pr09lytA
        rY1P5a69oOkQddvI+LIAdI7246dDLY7Z0H2aCFIuLrYyGmpeClXFpUg9DdhLhwL7/AnKO6xijyaYT
        YwnU49qXGGcpGXijqSqdxQz2CiC54mKYuIZM0F7/4rxgQ3fKBmHmUa7LJOe5GxhT3Y/ghRVwCBfaf
        /ePATGWfFDVMuU9qGgLHISB4k46O8rpNkbBlh8+5pxKSphEtO6XkZybGlhJIJMLQwcBIG95yB9o55
        KagJQG/Bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcXO8-0003l9-Dm; Mon, 09 Jul 2018 14:43:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DDA220297EAB; Mon,  9 Jul 2018 16:43:38 +0200 (CEST)
Date:   Mon, 9 Jul 2018 16:43:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180709144338.GS2476@hirez.programming.kicks-ass.net>
References: <20180706171150.GI3593@linux.vnet.ibm.com>
 <20180709085351.GC2476@hirez.programming.kicks-ass.net>
 <1531127935.18697.57.camel@infradead.org>
 <20180709104429.GI2476@hirez.programming.kicks-ass.net>
 <1531133801.18697.73.camel@infradead.org>
 <20180709110657.GL2476@hirez.programming.kicks-ass.net>
 <20180709123457.GM3593@linux.vnet.ibm.com>
 <20180709125516.GO2476@hirez.programming.kicks-ass.net>
 <20180709130227.GQ2512@hirez.programming.kicks-ass.net>
 <20180709142932.GO3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709142932.GO3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 07:29:32AM -0700, Paul E. McKenney wrote:

> OK, so here are our options:
> 
> 1.	Add the RCU conditional to need_resched(), as David suggests.
> 	Peter has concerns about overhead.

Not only overhead, its plain broken, because:

 1) we keep preemption state in other places too
 2) we check need_resched() in asm

