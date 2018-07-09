Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912EDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C0F20842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii+r7xya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C0F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeGIUnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754520AbeGIUnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:43:07 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4CD62083C;
        Mon,  9 Jul 2018 20:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531168986;
        bh=pzoHWjhzl+Xx0ygDEaVpJP1yT02OnjtjUYRiHlMgZRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ii+r7xyal996M5tnOAxk3uE65BxQ2zosGsWe20rx/GX4E+urMnaPLM8MqWhpCdedu
         ceqJ0mnTXIhyAlaK4Vbuemv8J5T8sQHdJkvrelZPxRAHRmanzVFm91wYejQDRm/8Rb
         7TQ1MfsWC+WQ69EnSbkkk8z2HXPG3Os/BJ8ITx6Q=
Date:   Mon, 9 Jul 2018 13:43:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: flush journal nat entries for
 nat_bits during unmount
Message-ID: <20180709204306.GD24534@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <ee638123-4114-badc-7d82-989e480ed45e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee638123-4114-badc-7d82-989e480ed45e@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09, Chao Yu wrote:
> On 2018/7/7 5:09, Jaegeuk Kim wrote:
> > Let's flush journal nat entries for speed up in the next run.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/node.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 29237aeca041..0f076fb0d828 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -2613,6 +2613,13 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  	nid_t set_idx = 0;
> >  	LIST_HEAD(sets);
> >  
> > +	/* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
> > +	if (enabled_nat_bits(sbi, cpc)) {
> > +		down_write(&nm_i->nat_tree_lock);
> > +		remove_nats_in_journal(sbi);
> > +		up_write(&nm_i->nat_tree_lock);
> > +	}
> 
> The case will cover that nm_i->dirty_nat_cnt is zero and there is cached nats in
> journal?

Yes.

> 
> So enabled_nat_bits() below should be removed?

It's out of lock, nm_i->nat_tree_lock, logically..

> 
> 	if (enabled_nat_bits(sbi, cpc) ||
> 		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
> 		remove_nats_in_journal(sbi);
> 
> Thanks,
> 
> > +
> >  	if (!nm_i->dirty_nat_cnt)
> >  		return;
> >  
> > 
