Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CACC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE0C2184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z5RhYiau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfBACnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 21:43:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfBACnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 21:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q3gZsciv+RQVX9T/SHGocIS11HiPzVpAVPCjgkGweCI=; b=Z5RhYiaucaPZ6DFGE5zc0+p9a
        21KStfuDNUbEi/1XybZoaFCWXHEGsKNGFX/tBNtOwoTaGoEFT4gZjOUfTN9KPpOiV0cmaQIu0g4lj
        kq9PMnVhc+ukuv9XIlnVpZM4tEnjvaCWWwrxMFAA+STVCdDLrHQJsrOt+W6OrpYwCAM1/QO/amwAb
        2iP0gqMtMBYoRlRwr2kUBi6jAqQoHZ08AMulZszn5o1BxldtTQ6HtEGWWRLV6U+3/490n/C0GZMIu
        XbbFEibaQ+koimyuq/ABRazvuscyBtITQrK7XUJSJzfLDVkTp9bTVxn9AIZTh78rf4moT+Q1X70bo
        Lf3CZqpEg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpOnO-0000L9-FL; Fri, 01 Feb 2019 02:43:10 +0000
Date:   Thu, 31 Jan 2019 18:43:10 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
Message-ID: <20190201024310.GC26359@bombadil.infradead.org>
References: <20190201004242.7659-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201004242.7659-1-tobin@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:42:42AM +1100, Tobin C. Harding wrote:
> Currently when displaying /proc/slabinfo if any cache names are too long
> then the output columns are not aligned.  We could do something fancy to
> get the maximum length of any cache name in the system or we could just
> increase the hardcoded width.  Currently it is 17 characters.  Monitors
> are wide these days so lets just increase it to 30 characters.

I had a proposal some time ago to turn the slab name from being kmalloced
to being an inline 16 bytes (with some fun hacks for cgroups).  I think
that's a better approach than permitting such long names.  For example,
ext4_allocation_context could be shortened to ext4_alloc_ctx without
losing any expressivity.

Let me know if you can't find that and I'll try to dig it up.
