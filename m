Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF7C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36F720BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iR4WTXxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36F720BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeGLMVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:21:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeGLMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dgHt3S1wvZn0APDqkvzdVp4+GOgkJxee5MQO4eFiUFM=; b=iR4WTXxhSD9gUmNnIaPcFdoo/
        cNimfnwVxHt19lwBU14SWfE/UMGzQthllqwyzTKHmkyP8rRDeqUl03AVKpEcb6SwBtXwLzcOtCmWN
        iYMZLHZOXV33jjxcDeBjvJrEo8X6VS/wJ9s6fUtpnm7A+dgW9kBOC5OHInpGTWqYo67aS9G6aBGbj
        ODxwrAWchwfiwAu9HwA6XEaN7Llkn0gCgRyxEBmv9S3vSgFCAQEiEhz3WbIJ+IdC+53Tkko3AICwV
        Is00U1btfpZrVKsKDfND7z99SvQpyGTDCFVDJPMi/b9B9ot8dswyVPmzrpcBaqWxteISBi1y6G+J0
        ftrYm7R7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdaRo-0005C0-LC; Thu, 12 Jul 2018 12:11:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FB9320291063; Thu, 12 Jul 2018 14:11:46 +0200 (CEST)
Date:   Thu, 12 Jul 2018 14:11:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712121146.GS2494@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
 <20180712074040.GA4920@worktop.programming.kicks-ass.net>
 <20180712115249.GA6201@andrea>
 <20180712120100.GA7404@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712120100.GA7404@andrea>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 02:01:00PM +0200, Andrea Parri wrote:
> > OTOH (as I pointed out earlier) the strengthening we're configuring
> > will prevent some arch. (riscv being just the example of today!) to
> > go "full RCsc", and this will inevitably "complicate" both the LKMM
> 
> "full RCpc"

That's a good thing :-)
