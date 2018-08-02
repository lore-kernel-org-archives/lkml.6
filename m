Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B41C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D29214C5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D29214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbeHBKpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:45:10 -0400
Received: from verein.lst.de ([213.95.11.211]:38641 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeHBKpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:45:10 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5002668D64; Thu,  2 Aug 2018 10:59:38 +0200 (CEST)
Date:   Thu, 2 Aug 2018 10:59:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] aio: add a iocb refcount
Message-ID: <20180802085938.GA13473@lst.de>
References: <20180730071544.23998-1-hch@lst.de> <20180730071544.23998-3-hch@lst.de> <20180801231956.GS30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801231956.GS30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 12:19:56AM +0100, Al Viro wrote:
> On Mon, Jul 30, 2018 at 09:15:42AM +0200, Christoph Hellwig wrote:
> > This is needed to prevent races caused by the way the ->poll API works.
> > To avoid introducing overhead for other users of the iocbs we initialize
> > it to zero and only do refcount operations if it is non-zero in the
> > completion path.
> 
> refcount_t looks like a bad match - you, AFAICS, have count 0 for everything
> except poll, while for poll you start with 2.  That looks like
> 	if (iocb->shared && test_and_clear_bit(0, &iocb->shared))
> 		return;
> 	kill the sucker
> in your iocb_put() and initializing it to 1 in poll.  No?

For non-poll we don't need the recount, so we can ignore that.

For poll we have two reference - submitting and wakee context.  We
could replace the refcount_t with an atomic bitops - but it would

 a) make the code harder to read than plain old refcounting
 b) make the iocb bigger - at least for now as there is nothing
    else we can share that unsigned long with.

Your call - I can respin it either way.
