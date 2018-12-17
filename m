Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881FCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587502146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GCD1mTQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbeLQOlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:41:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeLQOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nZZ4uT7zaATupA8MtYGiN52I8EDHkuRogXWMUDrqNP8=; b=GCD1mTQf4iesza7o2dkc2JY2u
        /1sQKjL2HsK8PcKHTCneirvS5eCkh0QV4ljbr7hax77lC21b9q8HdtWO18LihRq8tskytX8ckursp
        72a3pyNBO3h3ZZAuEsGvf3xC6WkzCckcTftXWkLNrNAyLZUmXg50Q0MIXmRaI8fAeBMhYwvdo0AE4
        SoTCAREaPY/W/nqbCwJA7hAez49AscrYDIWnt2hqABJlAodZeOktDAfdkLPmY/3IUchX/jmOqWbbW
        IoiG7EZanbeojlGqGkgO1G6Ihx1sKD4o4WgtCsX2c74wu1pQkUXGhuxZ5tFOCA5KzuZAkb7oETFpx
        VlDhyEtig==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYu4r-0005Z5-Ud; Mon, 17 Dec 2018 14:41:01 +0000
Date:   Mon, 17 Dec 2018 06:41:01 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Hou Tao <houtao1@huawei.com>, phillip@squashfs.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang
 in mem alloc
Message-ID: <20181217144101.GN10600@bombadil.infradead.org>
References: <20181204020840.49576-1-houtao1@huawei.com>
 <20181215143824.GJ10600@bombadil.infradead.org>
 <69457a5a-79c9-4950-37ae-eff7fa4f949a@huawei.com>
 <20181217035157.GK10600@bombadil.infradead.org>
 <20181217093337.GC30879@dhcp22.suse.cz>
 <00ff5d2d-a50f-4730-db8a-cea3d7a3eef7@I-love.SAKURA.ne.jp>
 <20181217122546.GL10600@bombadil.infradead.org>
 <20181217141044.GP30879@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217141044.GP30879@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:10:44PM +0100, Michal Hocko wrote:
> On Mon 17-12-18 04:25:46, Matthew Wilcox wrote:
> > It's worth noticing that squashfs _is_ in fact holding a page locked in
> > squashfs_copy_cache() when it calls grab_cache_page_nowait().  I'm not
> > sure if this will lead to trouble or not because I'm insufficiently
> > familiar with the reclaim path.
> 
> Hmm, this is more interesting then. If there is any memcg accounted
> allocation down that path _and_ the squashfs writeout can lock more
> pages and mark them writeback before they are really sent to the storage
> then we have a problem. See [1]
> 
> [1] http://lkml.kernel.org/r/20181213092221.27270-1-mhocko@kernel.org

Squashfs is read only, so it'll never have dirty pages and never do
writeout.

But ... maybe the GFP flags being used for grab_cache_page_nowait() are
wrong.  It does, after all, say "nowait".  Perhaps it shouldn't be trying
direct reclaim at all, but rather fail earlier.  Like this:

+++ b/mm/filemap.c
@@ -1550,6 +1550,8 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
                        gfp_mask |= __GFP_WRITE;
                if (fgp_flags & FGP_NOFS)
                        gfp_mask &= ~__GFP_FS;
+               if (fgp_flags & FGP_NOWAIT)
+                       gfp_mask &= ~__GFP_DIRECT_RECLAIM;
 
                page = __page_cache_alloc(gfp_mask);
                if (!page)

