Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49F0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4E22070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RSv2zYIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbfAHVgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:36:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfAHVgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2qghcKuc885VP1ZxaJJJf8/5ndhvsXiZ5M02SWOIP+Y=; b=RSv2zYIt7SicszoVfWUNOm2Vk
        OQixuUM4a1tBztumJQ2J60KOc0Lxt90dkIf5jFiEl6VxhKTeC2CfkAcw6sQhMtrBxISTHI1i+xRnY
        N838EmX5YB1+gZeVy3WoJzxxR5VJmphCn5q4G8azICZeqezC+B7cjJNlZ3ZV+5aT16TiXkr1MBeHV
        jT+I39lQ26FL7tD5+XhOyN/xcZuK9oLgwdABS7apNoaIu1u5nU/6CdrrAGjm0oi/al1Iv46xcqLPH
        5paA4Vu+NLvvS3+4n2kgsMAzh8er3Sb8VD8EIt6jR6/SQRkcwMrsb4N/mirrAndoTTRuoBhszyClz
        aeOVsLf4g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggz2r-0005Mi-I3; Tue, 08 Jan 2019 21:36:21 +0000
Date:   Tue, 8 Jan 2019 13:36:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove redundant test from find_get_pages_contig
Message-ID: <20190108213621.GH6310@bombadil.infradead.org>
References: <20190107200224.13260-1-willy@infradead.org>
 <20190107143319.c74593a70c86441b80e7cccc@linux-foundation.org>
 <20190107223935.GC6310@bombadil.infradead.org>
 <20190107150904.09e56f51acaf417ed21f13a3@linux-foundation.org>
 <20190108202635.GE6310@bombadil.infradead.org>
 <20190108132649.8f25386d966f04b0bccd6d77@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108132649.8f25386d966f04b0bccd6d77@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:26:49PM -0800, Andrew Morton wrote:
> On Tue, 8 Jan 2019 12:26:35 -0800 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > Would it be excessively cautious to put a WARN_ON_ONCE() in there for a
> > > while?
> > 
> > I think it would ... it'd get in the way of a subsequent patch to store
> > only head pages in the page cache.
> 
> OK, shall grab.  Perhaps the changelog could gain a few words
> explaining the history, etc.

Yeah, I suck at changelogs.  Particularly when I've encountered something
that's distracting me from the thing I was trying to do.  How about this:

mm: Remove redundant test from find_get_pages_contig

After we establish a reference on the page, we check the pointer
continues to be in the correct position in i_pages.  Checking page->index
afterwards is unnecessary; if it were to change, then the pointer to it
from the page cache would also move.  The check used to be done before
grabbing a reference on the page which was racy (see 9cbb4cb21b19f
("mm: find_get_pages_contig fixlet")), but nobody noticed that moving
the check after grabbing the reference was redundant.

Signed-off-by: Matthew Wilcox <willy@infradead.org>

