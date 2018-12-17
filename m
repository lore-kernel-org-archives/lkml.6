Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4184FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6C72133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545058153;
	bh=TUaH+jb/o3KpAYoxtRRzjueo2P22RXq8n/bgDIeuaNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K0N4q5BKs5qpgXy3BbRJhyLt9J+aysbEYQj11t/CakiDyIrHYtdcN+r+6fD/FPfgT
	 nudDa1yp7ckF+C8EsZDrpdGV/kOjsJWs1vlYRLDxs6lpBysMLQmK1oYHcxIdTtvFzS
	 N4I81/VN5pzhM5W+sD4tOennDwlUEdcdX82gbJn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbeLQOtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:49:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:54086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732489AbeLQOtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:49:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF0EAAC90;
        Mon, 17 Dec 2018 14:49:08 +0000 (UTC)
Date:   Mon, 17 Dec 2018 15:49:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Hou Tao <houtao1@huawei.com>, phillip@squashfs.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang
 in mem alloc
Message-ID: <20181217144908.GQ30879@dhcp22.suse.cz>
References: <20181204020840.49576-1-houtao1@huawei.com>
 <20181215143824.GJ10600@bombadil.infradead.org>
 <69457a5a-79c9-4950-37ae-eff7fa4f949a@huawei.com>
 <20181217035157.GK10600@bombadil.infradead.org>
 <20181217093337.GC30879@dhcp22.suse.cz>
 <00ff5d2d-a50f-4730-db8a-cea3d7a3eef7@I-love.SAKURA.ne.jp>
 <20181217122546.GL10600@bombadil.infradead.org>
 <20181217141044.GP30879@dhcp22.suse.cz>
 <20181217144101.GN10600@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217144101.GN10600@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-12-18 06:41:01, Matthew Wilcox wrote:
> On Mon, Dec 17, 2018 at 03:10:44PM +0100, Michal Hocko wrote:
> > On Mon 17-12-18 04:25:46, Matthew Wilcox wrote:
> > > It's worth noticing that squashfs _is_ in fact holding a page locked in
> > > squashfs_copy_cache() when it calls grab_cache_page_nowait().  I'm not
> > > sure if this will lead to trouble or not because I'm insufficiently
> > > familiar with the reclaim path.
> > 
> > Hmm, this is more interesting then. If there is any memcg accounted
> > allocation down that path _and_ the squashfs writeout can lock more
> > pages and mark them writeback before they are really sent to the storage
> > then we have a problem. See [1]
> > 
> > [1] http://lkml.kernel.org/r/20181213092221.27270-1-mhocko@kernel.org
> 
> Squashfs is read only, so it'll never have dirty pages and never do
> writeout.
> 
> But ... maybe the GFP flags being used for grab_cache_page_nowait() are
> wrong.  It does, after all, say "nowait".  Perhaps it shouldn't be trying
> direct reclaim at all, but rather fail earlier.  Like this:
> 
> +++ b/mm/filemap.c
> @@ -1550,6 +1550,8 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
>                         gfp_mask |= __GFP_WRITE;
>                 if (fgp_flags & FGP_NOFS)
>                         gfp_mask &= ~__GFP_FS;
> +               if (fgp_flags & FGP_NOWAIT)
> +                       gfp_mask &= ~__GFP_DIRECT_RECLAIM;
>  
>                 page = __page_cache_alloc(gfp_mask);
>                 if (!page)

Isn't FGP_NOWAIT about page lock rather than the allocation context?

-- 
Michal Hocko
SUSE Labs
