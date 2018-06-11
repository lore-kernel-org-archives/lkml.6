Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4EDB4C07D5B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5DB208B5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5DB208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933768AbeFKQn7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 12:43:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59220 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933508AbeFKQn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:43:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fSPv9-0000xY-MW; Mon, 11 Jun 2018 16:43:55 +0000
Date:   Mon, 11 Jun 2018 17:43:55 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] vfs: factor out inode_insert5()
Message-ID: <20180611164355.GV30522@ZenIV.linux.org.uk>
References: <20180529144143.16378-1-mszeredi@redhat.com>
 <20180529144143.16378-10-mszeredi@redhat.com>
 <20180610054902.GQ30522@ZenIV.linux.org.uk>
 <20180610060159.GS30522@ZenIV.linux.org.uk>
 <CAJfpegt5guR3zJeATw4-N41Ad2n9pcB5mQoLmSLOfocnEoodVg@mail.gmail.com>
 <20180611113230.GI23785@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611113230.GI23785@veci.piliscsaba.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 01:32:30PM +0200, Miklos Szeredi wrote:

> Incremental follows.  I think it's cleaner to initialize i_state and i_sb_list
> up front (hence the use of new_inode()), but could just as well add to sb list
> afterwards.

> ---
> diff --git a/fs/inode.c b/fs/inode.c
> index 0df41bb77e0f..03c0d7c1296f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1098,8 +1098,10 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
>  
>  		if (new) {
>  			inode = inode_insert5(new, hashval, test, set, data);
> -			if (unlikely(inode != new))
> -				iput(new);
> +			if (unlikely(inode != new)) {
> +				inode_sb_list_del(inode);
> +				destroy_inode(new);
> +			}

The thing is, until you put it into the list, it's invisible to everyone other
than iget5_locked() - no references in any shared data structures.  Which
outweighs the "it's somewhat irregular in not being on the list" considerably,
as far as the complexity of analysis goes, especially since there are inodes
that never get on that list and it's not something exotic - all sockets and
pipes are that way, for starters.  So IMO that should be dealt with in
inode_insert5().
