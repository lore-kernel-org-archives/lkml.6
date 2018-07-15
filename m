Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626FDECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0720A2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JlTV6Q/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0720A2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeGOXZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:25:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeGOXZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r6rCNrofRGVM/QfpIZR+WrMt11dmQGwgoN0MBDmcZPo=; b=JlTV6Q/qGLBXQ6ImB7IZf6Kb4
        jM/NTydopnsVzCcSFapoAjkuvhq+BPVEHvVt0TqMOpp6wiv+Mst6fdDvDu1e1UDBSg+HNsanmkUr7
        EnKSFYSHb+lK4jCv1P0YCEBqxVkYkuZsCqOOJnS9ZTEJLE9uJif22sF9GMx+u5dxIhqv8ZVN8JJxN
        dJM6CCbgJwLwqkYrNio2B/cHh5RD7bxFfSgjUhmF4vmQbd8JRHFowNe0YUxugt4eAESYxPhZnYZ4C
        daJ8eaedfzO8ZXFqO7qbp77PfwJvrHrRLUWLdzyVDiRNBXbAONLPjuYAGrxDgaNHe7dbD8z7VQmNl
        LjR5/Dzmg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1feq0a-0007Ne-92; Sun, 15 Jul 2018 23:00:52 +0000
Date:   Sun, 15 Jul 2018 16:00:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/5] radix tree test suite: fix mapshift build target
Message-ID: <20180715230052.GA6486@bombadil.infradead.org>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180503192430.7582-2-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503192430.7582-2-ross.zwisler@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 01:24:26PM -0600, Ross Zwisler wrote:
> The following commit
> 
>   commit c6ce3e2fe3da ("radix tree test suite: Add config option for map
>   shift")
> 
> Introduced a phony makefile target called 'mapshift' that ends up
> generating the file generated/map-shift.h.  This phony target was then
> added as a dependency of the top level 'targets' build target, which is
> what is run when you go to tools/testing/radix-tree and just type 'make'.
> 
> Unfortunately, this phony target doesn't actually work as a dependency, so
> you end up getting:
> 
> $ make
> make: *** No rule to make target 'generated/map-shift.h', needed by 'main.o'.  Stop.
> make: *** Waiting for unfinished jobs....
> 
> Fix this by making the file generated/map-shift.h our real makefile target,
> and add this a dependency of the top level build target.

This commit breaks typing 'make SHIFT=6'.  It doesn't rebuild the
test suite any more.  If I revert this patch, it works.  Also, I can't
reproduce the problem you're reporting here.  So ... how do I reproduce
it?  Otherwise, I'm just going to revert this patch since it regresses
a feature I find useful.

> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> ---
>  tools/testing/radix-tree/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
> index fa7ee369b3c9..db66f8a0d4be 100644
> --- a/tools/testing/radix-tree/Makefile
> +++ b/tools/testing/radix-tree/Makefile
> @@ -17,7 +17,7 @@ ifeq ($(BUILD), 32)
>  	LDFLAGS += -m32
>  endif
>  
> -targets: mapshift $(TARGETS)
> +targets: generated/map-shift.h $(TARGETS)
>  
>  main:	$(OFILES)
>  
> @@ -42,9 +42,7 @@ radix-tree.c: ../../../lib/radix-tree.c
>  idr.c: ../../../lib/idr.c
>  	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
>  
> -.PHONY: mapshift
> -
> -mapshift:
> +generated/map-shift.h:
>  	@if ! grep -qws $(SHIFT) generated/map-shift.h; then		\
>  		echo "#define RADIX_TREE_MAP_SHIFT $(SHIFT)" >		\
>  				generated/map-shift.h;			\
> -- 
> 2.14.3
> 
