Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF80DECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C8521476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C8521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJRHPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:15:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38322 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:15:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCv3s-0001o1-Gv; Wed, 17 Oct 2018 23:17:08 +0000
Date:   Thu, 18 Oct 2018 00:17:08 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin King <colin.king@canonical.com>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        "Ernesto A. Fernndez" <ernesto.mnd.fernandez@gmail.com>
Subject: Re: [PATCH] hfs: fix array out of bounds read of array extent
Message-ID: <20181017231708.GB32577@ZenIV.linux.org.uk>
References: <20180831140538.31566-1-colin.king@canonical.com>
 <20181017150117.fef4f8d8e814aa2d25adba5e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017150117.fef4f8d8e814aa2d25adba5e@linux-foundation.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 03:01:17PM -0700, Andrew Morton wrote:
> On Fri, 31 Aug 2018 15:05:38 +0100 Colin King <colin.king@canonical.com> wrote:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently extent and index i are both being incremented causing
> > an array out of bounds read on extent[i]. Fix this by removing
> > the extraneous increment of extent.
> > 
> > Detected by CoverityScan, CID#711541 ("Out of bounds read")
> > 
> > Fixes: d1081202f1d0 ("HFS rewrite")
> 
> No such commit here.  I assume this is 7cb74be6fd827e314f8.
> 
> > --- a/fs/hfs/extent.c
> > +++ b/fs/hfs/extent.c
> > @@ -300,7 +300,7 @@ int hfs_free_fork(struct super_block *sb, struct hfs_cat_file *file, int type)
> >  		return 0;
> >  
> >  	blocks = 0;
> > -	for (i = 0; i < 3; extent++, i++)
> > +	for (i = 0; i < 3; i++)
> >  		blocks += be16_to_cpu(extent[i].count);
> >  
> >  	res = hfs_free_extents(sb, extent, blocks, blocks);
> 
> Well, that's quite the bug.  Question is, why didn't anyone notice it. 
> What are the runtime effects?  A disk space leak, perhaps?
> 
> I worry a bit that, given the fs was evidently working "ok", perhaps
> this error was corrected elsewhere in the code and that "fixing" this
> site will have unexpected and undesirable runtime effects.  Can someone
> help me out here?

hfs_free_extents() seems to expect the 'offset' argument to be the
sum of ->count of 1--3 starting elements of extent array.  In case of
mismatch, it returns -EIO and that's it - hfs_free_fork() will bugger
off with -EIO at that point.  If it does match, block_nr is supposed
to be in range 0..offset and blocks offset - block_nr .. offset - 1
are freed.

So at a guess, that sucker mostly ends up leaking blocks.  Said that,
it means that the rest of hfs_free_fork() has never been tested.

I'd suggest somebody to turn that
        /* panic? */
        return -EIO;
in hfs_free_extents() into
	printk(KERN_ERR "hfs_free_extents is fucked");
	return -EIO;
and see if it's triggerable.  Then check if there's a block leak in
the reproducer, whatever it is.
