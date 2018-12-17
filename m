Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7067EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EF82084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lWkkV92m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbeLQDwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 22:52:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLQDwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 22:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wyLf1tbBJbdMB6b84iajO+S/cGTmskKQw3TuYFmg2MI=; b=lWkkV92mlYkwRLkqmKq/g+BaT
        pYH+8lg+bjZEDJIIZMi7TDWj5nnyXCD4alCzx6qPyRSaOn/4W9n61MwS2Un2VO5EwR57TwkYSGmS9
        /EXuwZTKOZTe/DAmCKB9rjoQMj4nuHJVsFxQBHbA0McXtnFMCOxe0Ujlkz2+nSYBB7GOghVHdtwVN
        PbqmKi+J1OUaLDOnriVw4HaBJhO/ib0JvfCO8r0Pkd69PG3VE98LTPIe4w4CJHWFfjq4WVytICfyJ
        1kWFJGHRK86r6hT7OE70ZFkMD5fVhEBzhuM/VCshn0nJz+8iv5TzK8NWhLS6I3tB++Pzh+TcYgIHP
        ei13htQxA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYjwj-0003vu-Vl; Mon, 17 Dec 2018 03:51:57 +0000
Date:   Sun, 16 Dec 2018 19:51:57 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     phillip@squashfs.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang
 in mem alloc
Message-ID: <20181217035157.GK10600@bombadil.infradead.org>
References: <20181204020840.49576-1-houtao1@huawei.com>
 <20181215143824.GJ10600@bombadil.infradead.org>
 <69457a5a-79c9-4950-37ae-eff7fa4f949a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69457a5a-79c9-4950-37ae-eff7fa4f949a@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 05:38:13PM +0800, Hou Tao wrote:
> Hi,
> 
> On 2018/12/15 22:38, Matthew Wilcox wrote:
> > On Tue, Dec 04, 2018 at 10:08:40AM +0800, Hou Tao wrote:
> >> There is no need to disable __GFP_FS in ->readpage:
> >> * It's a read-only fs, so there will be no dirty/writeback page and
> >>   there will be no deadlock against the caller's locked page
> >> * It just allocates one page, so compaction will not be invoked
> >> * It doesn't take any inode lock, so the reclamation of inode will be fine
> >>
> >> And no __GFP_FS may lead to hang in __alloc_pages_slowpath() if a
> >> squashfs page fault occurs in the context of a memory hogger, because
> >> the hogger will not be killed due to the logic in __alloc_pages_may_oom().
> > 
> > I don't understand your argument here.  There's a comment in
> > __alloc_pages_may_oom() saying that we _should_ treat GFP_NOFS
> > specially, but we currently don't.
> I am trying to say that if __GFP_FS is used in pagecache_get_page() when it tries
> to allocate a new page for squashfs, that will be no possibility of dead-lock for
> squashfs.
> 
> We do treat GFP_NOFS specially in out_of_memory():
> 
>     /*
>      * The OOM killer does not compensate for IO-less reclaim.
>      * pagefault_out_of_memory lost its gfp context so we have to
>      * make sure exclude 0 mask - all other users should have at least
>      * ___GFP_DIRECT_RECLAIM to get here.
>      */
>     if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS))
>         return true;
> 
> So if GFP_FS is used, no task will be killed because we will return from
> out_of_memory() prematurely. And that will lead to an infinite loop in
> __alloc_pages_slowpath() as we have observed:
> 
> * a squashfs page fault occurred in the context of a memory hogger
> * the page used for page fault allocated successfully
> * in squashfs_readpage() squashfs will try to allocate other pages
>   in the same 128KB block, and __GFP_NOFS is used (actually GFP_HIGHUSER_MOVABLE & ~__GFP_FS)
> * in __alloc_pages_slowpath() we can not get any pages through reclamation
>   (because most of memory is used by the current task) and we also can not kill
>   the current task (due to __GFP_NOFS), and it will loop forever until it's killed.

Ah, yes, that makes perfect sense.  Thank you for the explanation.

I wonder if the correct fix, however, is not to move the check for
GFP_NOFS in out_of_memory() down to below the check whether to kill
the current task.  That would solve your problem, and I don't _think_
it would cause any new ones.  Michal, you touched this code last, what
do you think?
