Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E39ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E4B20831
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E4B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeJaKGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:06:36 -0400
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:45716 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728819AbeJaKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:06:35 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl6.internode.on.net with ESMTP; 31 Oct 2018 11:35:59 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gHexJ-0006Yw-Dk; Wed, 31 Oct 2018 12:05:57 +1100
Date:   Wed, 31 Oct 2018 12:05:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: manual merge of the xfs tree with Linus' tree
Message-ID: <20181031010557.GU19305@dastard>
References: <20181031112244.71b62e67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031112244.71b62e67@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:22:44AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the xfs tree got a conflict in:
> 
>   Documentation/filesystems/porting
> 
> between commit:
> 
>   1a16dbaf798c ("Document d_splice_alias() calling conventions for ->lookup() users.")
> 
> from Linus' tree and commit:
> 
>   2e5dfc99f2e6 ("vfs: combine the clone and dedupe into a single remap_file_range")
> 
> from the xfs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/filesystems/porting
> index 321d74b73937,e6d4466268dd..000000000000
> --- a/Documentation/filesystems/porting
> +++ b/Documentation/filesystems/porting
> @@@ -623,13 -623,7 +623,18 @@@ in your dentry operations instead
>   	On success you get a new struct file sharing the mount/dentry with the
>   	original, on failure - ERR_PTR().
>   --
>  +[recommended]
>  +	->lookup() instances doing an equivalent of
>  +		if (IS_ERR(inode))
>  +			return ERR_CAST(inode);
>  +		return d_splice_alias(inode, dentry);
>  +	don't need to bother with the check - d_splice_alias() will do the
>  +	right thing when given ERR_PTR(...) as inode.  Moreover, passing NULL
>  +	inode to d_splice_alias() will also do the right thing (equivalent of
>  +	d_add(dentry, NULL); return NULL;), so that kind of special cases
>  +	also doesn't need a separate treatment.
> ++--
> + [mandatory]
> + 	->clone_file_range() and ->dedupe_file_range have been replaced with
> + 	->remap_file_range().  See Documentation/filesystems/vfs.txt for more
> + 	information.

Looks good - I knew about this one from merging back into a recent
Linus kernel.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
