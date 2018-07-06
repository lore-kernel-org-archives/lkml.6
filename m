Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC99C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0E422401
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0E422401
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933754AbeGFRfn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:35:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47684 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933090AbeGFRfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:35:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fbUdw-0002Qr-Kk; Fri, 06 Jul 2018 17:35:40 +0000
Date:   Fri, 6 Jul 2018 18:35:40 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH (v4.18 regression fix)] vfs: don't evict uninitialized
 inode
Message-ID: <20180706173540.GD30522@ZenIV.linux.org.uk>
References: <20180706153548.23287-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706153548.23287-1-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 05:35:48PM +0200, Miklos Szeredi wrote:
> iput() ends up calling ->evict() on new inode, which is not yet initialized
> by owning fs.  So use destroy_inode() instead.
> 
> Add to sb->s_inodes list only after the inode has been inserted into the
> hash.  The exact point at which the inode is added onto the sb list
> shouldn't matter as long as it is done while the inode is in the I_NEW
> state.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Fixes: 80ea09a002bf ("vfs: factor out inode_insert5()")

Check 22dc9a168272 (new primitive: discard_new_inode()) in vfs.git; IMO yours
should go on top of that and I would seriously consider going for just
alloc_inode() - to hell with new_inode_pseudo().  I_CREATING gives an easy
way for insert_inode5() to decide whether we need to move into ->i_sb_list...
