Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07431C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AED20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AED20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeILV0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:26:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726854AbeILV0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:26:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 739E6AF87;
        Wed, 12 Sep 2018 16:20:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B1DB61E3613; Wed, 12 Sep 2018 18:20:46 +0200 (CEST)
Date:   Wed, 12 Sep 2018 18:20:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "jack@suse.cz" <jack@suse.cz>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4, dax: update dax check to skip journal inode
Message-ID: <20180912162046.GA23522@quack2.suse.cz>
References: <20180911154246.6844-1-toshi.kani@hpe.com>
 <20180911154246.6844-2-toshi.kani@hpe.com>
 <20180912092422.GA7782@quack2.suse.cz>
 <92faf51ac89e62dcd67e39cc66eef60966d1263c.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92faf51ac89e62dcd67e39cc66eef60966d1263c.camel@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-09-18 15:47:12, Kani, Toshi wrote:
> On Wed, 2018-09-12 at 11:24 +0200, Jan Kara wrote:
> > On Tue 11-09-18 09:42:45, Toshi Kani wrote:
> > > Ext4 mount path calls ext4_iget() to obtain the journal inode.  This
> > > inode does not support DAX, and 'ext4_da_aops' needs to be set.  It
> > > currently works for the DAX mount case because ext4_iget() always set
> > > 'ext4_da_aops' to any regular files.
> > > 
> > >   ext4_fill_super
> > >     ext4_load_journal
> > >       ext4_get_journal_inode
> > >         ext4_iget
> > > 
> > > In preparation to fix ext4_iget() to set 'ext4_dax_aops' for DAX files,
> > > update ext4_should_use_dax() to return false for the journal inode.
> > > 
> > > Fixes: 5f0663bb4a64f588f0a2dd6d1be68d40f9af0086
> > > Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > 
> > The journal inode is similar to any other 'system' inode we have in ext4.
> > We don't really expect any of the address space operations to be called for
> > it because we don't use page cache with these inodes. Very similar
> > situation is with e.g. quota files. So to me it seems this patch is not
> > really necessary. Or did you observe any bad effects without this patch?
> 
> Yes, without this change, mount fails with the error below.  I believe
> .bmap operation in ext4_da_aops is necessary for this case.
> 
>   jbd2_journal_init_inode: Cannot locate journal superblock
>   EXT4-fs
> (pmem1): Could not load journal inode

Ah, OK, forgot about this. Then how about adding:
	.bmap                   = ext4_bmap,

to ext4_dax_aops? .bmap is completely fine for DAX inodes and there's no
reason to disallow it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
