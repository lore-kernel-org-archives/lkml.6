Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07DFC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D8620685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TIWgxvOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D8620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeKTXmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:42:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeKTXmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bf5n/hjD4LuBtMg0vL7R93izlrTUbK1wdlLBwdCPRGs=; b=TIWgxvOvFxo9EkS83on2bxDT8
        Z6dNHzqjLx23BCOdxrIUqqFghr+G6c40gx4x9Pea0f+A6fS8X9fpHi2Qrc0cmi0e2aL6vBNQHoY+n
        wzekXfBc9rSrf0rUwssAtHAhoESAWLtWix8IA/Heu+NscKeifEGT7sePZ/xYd0ZSvDfr0S+WZHJ+D
        tKC+Xz+K9bbHKxDjFPbqRneq94pw19jfPskwDJmAWOn8xDZCwo6Fjse+okwAVAZh3N8MCQsDTvg5z
        CCE1NvozRB2km34cd+Zev2h0MyIwJMo8eSvBtbILsilFVFpKJdGV4HHSXrbILIMxn2U+nc1YqD3V8
        DUbpecEdA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP5pf-0003Db-Fr; Tue, 20 Nov 2018 13:12:47 +0000
Date:   Tue, 20 Nov 2018 05:12:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix swap offset when replacing shmem page
Message-ID: <20181120131247.GA3065@bombadil.infradead.org>
References: <20181119004719.156411-1-yuzhao@google.com>
 <20181119010924.177177-1-yuzhao@google.com>
 <alpine.LSU.2.11.1811191343280.17359@eggly.anvils>
 <20181120012950.GA94981@google.com>
 <alpine.LSU.2.11.1811192057490.2185@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1811192057490.2185@eggly.anvils>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:07:27PM -0800, Hugh Dickins wrote:
> I don't much like my original use of the name "swap_index", when it was
> not the index in a swapfile (though it was the index in the radix tree);
> but it will become a correct name with your patch.
> 
> Though Matthew Wilcox seems to want us to avoid saying "radix tree"...

Naming is hard ... but the Linux radix tree looks almost nothing like
a classic computer science radix tree.  If you try to reconcile our
implementation with the wikipedia article on radix trees, you'll get
very confused.

A lot of places where we were saying 'radix tree' in comments should
really have said 'page cache'.  So is this a swap cache index?  I'm
not really familiar enough with the swapping code to say.
