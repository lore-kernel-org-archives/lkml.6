Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A67C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B4423EAE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IOK7jFrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B4423EAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeFVII6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:08:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeFVIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6lpv1DR9EJb2W+A0NEZo0plEU+zEWD0pngecRP1iWYA=; b=IOK7jFrYmnPymFgTsUFU9aLwY
        pMj4xijNm6EYJtTHF/TGYgocii6TtDfH26VM65lrRS+fIoVwCNnhHmB29IrQuRbyDsJfve2CmQIY7
        s0Wmn6i8zNkxsKl7TP5Zsl41uLdJuCYDTCk/7FyJM7VRS4xzchRciUvG/8IC9Tt+jcdsKlZ94IXff
        +FykqQgRTTmYMoj5YwX0a4M8IDTToKAHQUyBCvZIWrpmo0GhxjvnMRpgUpTPQe+hyDLfCiza9n4YM
        KQiZHmcjnAD+1vWc7pvQm91FocVHdjfWHYYwz24acFnTAoolzvVEnaRZoU6TPtk//yfRt64qiAPnv
        PNsMtsVjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWH7c-0006Et-Lo; Fri, 22 Jun 2018 08:08:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69E7E2029F1D5; Fri, 22 Jun 2018 10:08:42 +0200 (CEST)
Date:   Fri, 22 Jun 2018 10:08:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180622080842.GF2494@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
 <20180621180422.GF3452@worktop.programming.kicks-ass.net>
 <20180622033440.GM3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622033440.GM3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 08:34:40PM -0700, Paul E. McKenney wrote:
> (Peter, if you meant to ack both, please let me know.)

I sadly have not had the time to go through all that fancy cat language
stuff, so while I can read and mostly understand the Changelog, I don't
feel qualified to actually say anything much about that first patch ;-)

At some distant point in the past I mostly grokked the cat stuffs, but
then things happened and I've not looked at it in more than a year and
the brain just doesn't want to remember... :/ Some day..
