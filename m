Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2F1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF19217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oLa+cprQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF19217A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeHDBBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 21:01:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbeHDBBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 21:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A3Sq2P1dgJ2d0V5Jf01zrClW2UbD6WrD1qyZvW8TQDc=; b=oLa+cprQ3S/jz0LmyiTEBtx4f
        tG9NioMVRwp76jBwQb+9y349OLPq+lN+xhrvPT9P3Eb6wMD/t0Ae3wnrzuMkvmmbPjNNlBTUQeQqD
        XuWsvVOt/5VO3rquNTQGcBYDbT9EMRVpJoSXjr22xDWsdgDjHLMWszTfOYI0gs8xcv0uLjk+3U2VV
        FQ0xAUhh5GbfA4lTGHd8+Wv+P+A7mAb4yJ+5J8qOU1iJhKnOkyjH8HyK8DNf36I4NzfhS+Lq9mEEN
        AQC0i6E1CVGfQFJ3Ezykj3/4BsBFVOrcD/rl6lBj5XC7M6KlpKc79XFn9QMerbwMe8bGa9MKkw6TR
        zFGPBxFFA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flj6M-000062-Nc; Fri, 03 Aug 2018 23:03:18 +0000
Date:   Fri, 3 Aug 2018 16:03:18 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, vdavydov.dev@gmail.com,
        mhocko@suse.com, aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp, shakeelb@google.com,
        jbacik@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Use special value SHRINKER_REGISTERING instead
 list_empty() check
Message-ID: <20180803230318.GB23284@bombadil.infradead.org>
References: <153331055842.22632.9290331685041037871.stgit@localhost.localdomain>
 <20180803155120.0d65511b46c100565b4f8a2c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803155120.0d65511b46c100565b4f8a2c@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 03:51:20PM -0700, Andrew Morton wrote:
> On Fri, 03 Aug 2018 18:36:14 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > The patch introduces a special value SHRINKER_REGISTERING to use instead
> > of list_empty() to detect a semi-registered shrinker.
> 
> All this isn't terribly nice.  Why can't we avoid installing the
> shrinker into the idr until it is fully initialized?

I haven't reviewed the current state of the code in question, but the
IDR allows you to store a NULL in order to allocate an ID.  One should
then either call idr_remove() in order to release the ID or idr_replace()
once the object has been fully initialised.

Another way to potentially accomplish the same thing is to use
idr_alloc_u32 which will assign the ID immediately before inserting
the pointer into the IDR.  This only works if the caller can initialise
everything but the ID, and can handle an ENOMEM.

