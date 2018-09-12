Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11D1C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6521F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6521F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeILOfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:35:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727616AbeILOfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:35:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9770FAF3B;
        Wed, 12 Sep 2018 09:31:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E1B9B1E3613; Wed, 12 Sep 2018 11:31:40 +0200 (CEST)
Date:   Wed, 12 Sep 2018 11:31:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Toshi Kani <toshi.kani@hpe.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4, dax: set ext4_dax_aops for dax files
Message-ID: <20180912093140.GB7782@quack2.suse.cz>
References: <20180911154246.6844-1-toshi.kani@hpe.com>
 <20180911154246.6844-3-toshi.kani@hpe.com>
 <CAPcyv4iEZ7q0MV7n-_eovrJw_U9S3=pkY_nYwtw1jSBS7vPqCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iEZ7q0MV7n-_eovrJw_U9S3=pkY_nYwtw1jSBS7vPqCQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-09-18 11:15:18, Dan Williams wrote:
> On Tue, Sep 11, 2018 at 8:42 AM, Toshi Kani <toshi.kani@hpe.com> wrote:
> > Sync syscall to an existing DAX file needs to flush processor cache,
> > but it does not currently.  This is because 'ext4_da_aops' is set to
> > address_space_operations of existing DAX files, instead of 'ext4_dax_aops',
> > since S_DAX flag is set after ext4_set_aops() in the open path.
> >
> >   New file
> >   --------
> >   lookup_open
> >     ext4_create
> >       __ext4_new_inode
> >         ext4_set_inode_flags   // Set S_DAX flag
> >       ext4_set_aops            // Set aops to ext4_dax_aops
> >
> >   Existing file
> >   -------------
> >   lookup_open
> >     ext4_lookup
> >       ext4_iget
> >         ext4_set_aops          // Set aops to ext4_da_aops
> >         ext4_set_inode_flags   // Set S_DAX flag
> >
> > Change ext4_iget() to call ext4_set_inode_flags() before ext4_set_aops().
> >
> > Fixes: 5f0663bb4a64f588f0a2dd6d1be68d40f9af0086
> 
> Same format nit:
> 
> Fixes: 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")
> Cc: <stable@vger.kernel.org>
> 
> 
> > Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > ---
> >  fs/ext4/inode.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 775cd9b4af55..93cbbb859c40 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -4998,6 +4998,8 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
> >         if (ret)
> >                 goto bad_inode;
> >
> > +       ext4_set_inode_flags(inode);
> > +
> 
> Hmm, does this have unintended behavior changes?
> 
> I notice that there are some checks for flags "IS_APPEND(inode) ||
> IS_IMMUTABLE(inode)" *before* the call to ext4_set_inode_flags(). I
> didn't look too much deeper at whether those checks are bogus, but it
> would seem safer to do something like this for a lower risk fix.
> 
> Thoughts?

Well, safer but it would leave the landmine around for others to hit.
Toshi, please move the ext4_set_inode_flags() call to be just after the
assignment:

	ei->i_flags = le32_to_cpu(raw_inode->i_flags);

in ext4_iget(). That way people won't introduce checks for i_flags that can
never hit... And yes, it fixes also other bugs (mostly in sanity checks
AFAICS) than the DAX issue.

								Honza

> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d0dd585add6a..1e9ab445c777 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4999,7 +4999,6 @@ struct inode *ext4_iget(struct super_block *sb,
> unsigned long ino)
>         if (S_ISREG(inode->i_mode)) {
>                 inode->i_op = &ext4_file_inode_operations;
>                 inode->i_fop = &ext4_file_operations;
> -               ext4_set_aops(inode);
>         } else if (S_ISDIR(inode->i_mode)) {
>                 inode->i_op = &ext4_dir_inode_operations;
>                 inode->i_fop = &ext4_dir_operations;
> @@ -5042,6 +5041,12 @@ struct inode *ext4_iget(struct super_block *sb,
> unsigned long ino)
>         }
>         brelse(iloc.bh);
>         ext4_set_inode_flags(inode);
> +       /*
> +        * Now that we have determined whether DAX is enabled, set the
> +        * proper address spaces operations
> +        */
> +       if (S_ISREG(inode->i_mode))
> +               ext4_set_aops(inode);
> 
>         unlock_new_inode(inode);
>         return inode;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
