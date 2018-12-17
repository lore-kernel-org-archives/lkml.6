Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247DD20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/n7Z9xI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbeLQMZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:25:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeLQMZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C7Gu++e5gTHRsvHu5u3q/8Tf6m7Pip0LceAimKuJjco=; b=s/n7Z9xIgBfwNeyuZWjw0/sSw
        SiHQWQxIm2Gxm7Ko2Cb1pfzPCOnVabH4Kxol4m3yNOPvD+Ihz7cmfgG4M/x9rNIYOk01dWUkSvT+A
        AO3SNMpwo/pwIbIkpjyqY5M2tZ2HCLQRmR5WalAbPyHWkAZShKKf5yJ87NYQ2N7I5jMfwisuW4R8H
        EARARcEsjGtCnLBBp7QkNMoBMGD23IYmzm3NM/WLQ4vslcjCuv766aT0X4+xB6dk2kfCTuIEXmpcJ
        dpLdXusXU9K81W1MhifVnTzx0Ka1qMB+7BqTPJL1/W3PTefAb2APNEnUrh0yWDt+qU+GybjWnRO9M
        0zq9g3mXw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYrxy-0006fR-OF; Mon, 17 Dec 2018 12:25:46 +0000
Date:   Mon, 17 Dec 2018 04:25:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>, Hou Tao <houtao1@huawei.com>,
        phillip@squashfs.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang
 in mem alloc
Message-ID: <20181217122546.GL10600@bombadil.infradead.org>
References: <20181204020840.49576-1-houtao1@huawei.com>
 <20181215143824.GJ10600@bombadil.infradead.org>
 <69457a5a-79c9-4950-37ae-eff7fa4f949a@huawei.com>
 <20181217035157.GK10600@bombadil.infradead.org>
 <20181217093337.GC30879@dhcp22.suse.cz>
 <00ff5d2d-a50f-4730-db8a-cea3d7a3eef7@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ff5d2d-a50f-4730-db8a-cea3d7a3eef7@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 07:51:27PM +0900, Tetsuo Handa wrote:
> On 2018/12/17 18:33, Michal Hocko wrote:
> > On Sun 16-12-18 19:51:57, Matthew Wilcox wrote:
> > [...]
> >> Ah, yes, that makes perfect sense.  Thank you for the explanation.
> >>
> >> I wonder if the correct fix, however, is not to move the check for
> >> GFP_NOFS in out_of_memory() down to below the check whether to kill
> >> the current task.  That would solve your problem, and I don't _think_
> >> it would cause any new ones.  Michal, you touched this code last, what
> >> do you think?
> > 
> > What do you mean exactly? Whether we kill a current task or something
> > else doesn't change much on the fact that NOFS is a reclaim restricted
> > context and we might kill too early. If the fs can do GFP_FS then it is
> > obviously a better thing to do because FS metadata can be reclaimed as
> > well and therefore there is potentially less memory pressure on
> > application data.
> > 
> 
> I interpreted "to move the check for GFP_NOFS in out_of_memory() down to
> below the check whether to kill the current task" as

Too far; I meant one line earlier, before we try to select a different
process.

> @@ -1104,6 +1095,19 @@ bool out_of_memory(struct oom_control *oc)
>  	}
>  
>  	select_bad_process(oc);
> +
> +	/*
> +	 * The OOM killer does not compensate for IO-less reclaim.
> +	 * pagefault_out_of_memory lost its gfp context so we have to
> +	 * make sure exclude 0 mask - all other users should have at least
> +	 * ___GFP_DIRECT_RECLAIM to get here.
> +	 */
> +	if ((oc->gfp_mask && !(oc->gfp_mask & __GFP_FS)) && oc->chosen &&
> +	    oc->chosen != (void *)-1UL && oc->chosen != current) {
> +		put_task_struct(oc->chosen);
> +		return true;
> +	}
> +
>  	/* Found nothing?!?! */
>  	if (!oc->chosen) {
>  		dump_header(oc, NULL);
> 
> which is prefixed by "the correct fix is not".
> 
> Behaving like sysctl_oom_kill_allocating_task == 1 if __GFP_FS is not used
> will not be the correct fix. But ...
> 
> Hou Tao wrote:
> > There is no need to disable __GFP_FS in ->readpage:
> > * It's a read-only fs, so there will be no dirty/writeback page and
> >   there will be no deadlock against the caller's locked page
> 
> is read-only filesystem sufficient for safe to use __GFP_FS?
> 
> Isn't "whether it is safe to use __GFP_FS" depends on "whether fs locks
> are held or not" rather than "whether fs has dirty/writeback page or not" ?

It's worth noticing that squashfs _is_ in fact holding a page locked in
squashfs_copy_cache() when it calls grab_cache_page_nowait().  I'm not
sure if this will lead to trouble or not because I'm insufficiently
familiar with the reclaim path.
