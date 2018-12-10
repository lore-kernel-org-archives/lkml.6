Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83118C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543FB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543FB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeLJJrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:47:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:36304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726136AbeLJJrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:47:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A19FEAD6F;
        Mon, 10 Dec 2018 09:47:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2562D1E13F8; Mon, 10 Dec 2018 10:47:22 +0100 (CET)
Date:   Mon, 10 Dec 2018 10:47:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Subject: Re: [PATCH] Fix sync. in blkdev_write_iter() acessing i_flags
Message-ID: <20181210094722.GB29289@quack2.suse.cz>
References: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
 <20181207175811.GZ2217@ZenIV.linux.org.uk>
 <5c86e85f-0ad4-935a-3021-7046551f361f@tu-dortmund.de>
 <20181208004944.GA2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208004944.GA2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 08-12-18 00:49:44, Al Viro wrote:
> On Fri, Dec 07, 2018 at 08:49:16PM +0100, Alexander Lochmann wrote:
> 
> > > _What_ SUID bit?  We are talking about a write to block device, for fsck sake...
> > > 
> > That's the way I understood Jan's explanation:
> > "
> > Thinking more about this I'm not sure if this is actually the right
> > solution. Because for example the write(2) can set S_NOSEC flag wrongly
> > when it would race with chmod adding SUID bit. So probably we rather need
> > to acquire i_rwsem in blkdev_write_iter() if file does not have S_NOSEC set
> > (we don't want to acquire it unconditionally as that would heavily impact
> > scalability of block device writes).
> 
> 	IDGI.  We are talking about a block device here.  What business could
> file_remove_privs() have doing _anything_ to it?  should_remove_suid() returns
> to return 0 for those; what case do you have in mind?  Somebody setting
> security.capabilities on a block device inode?
> 
> 	IMO the bug here is file_remove_privs() not buggering off immediately
> after having observed that we are dealing with a block device.  It really
> has nothing useful to do.

I didn't notice that S_ISREG() check in should_remove_suid(). My bad. And I
wasn't quite sure whether some security module does not rely on
inode_need_killpriv security hook. But now when I grep I see that
cap_inode_need_killpriv() is really the only user and security.capabilities
probably don't make sense for it since block devices cannot be executed
anyway.

So yes, the easiest fix is to just bail from file_remove_privs(). Probably
for anything that is not a regular file, right? Directories cannot be
written anyway and for pipes and character devices same logic applies as
for block devices.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
