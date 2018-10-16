Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A4FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84B321470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="km5Tj8ZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84B321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJQA27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJQA26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:28:58 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C9C2089E;
        Tue, 16 Oct 2018 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539707865;
        bh=ah9I7lvdVs0nXsWMnOBQpHbSTrh7clPZYFCNymiGTzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=km5Tj8ZLE8kaanhtPSlRrkxUHivRlws1YxM0fcMjamSKbwUeES9it+1QhUJPXCfjA
         DnIcZDnnLWwK8DhROEXe0x6OBtSqbl12LnZaJzrtwm0NxS2bWzoZu72aTUP88a3a/z
         YOQTHUBwthGoDYCnrCp5abx5omTO0q9+Sl/IY9v0=
Date:   Tue, 16 Oct 2018 09:37:44 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Rosenberg <drosen@google.com>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20181016163744.GA29774@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181003103222.6e1655cd@canb.auug.org.au>
 <20181016111712.33f9dc2e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016111712.33f9dc2e@canb.auug.org.au>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 3 Oct 2018 10:32:22 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the vfs tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > /home/sfr/next/next/fs/f2fs/super.c: In function 'f2fs_remount':
> > /home/sfr/next/next/fs/f2fs/super.c:1589:16: error: 'MS_RDONLY' undeclared (first use in this function); did you mean 'IS_RDONLY'?
> >   if ((*flags & MS_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
> >                 ^~~~~~~~~
> >                 IS_RDONLY
> > 
> > Caused by commit
> > 
> >   dcf8001d292b ("vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled")
> > 
> > interacting with commit
> > 
> >   f80f781514ef ("f2fs: checkpoint disabling")
> > 
> > from the f2fs tree.
> > 
> > I have added the following merge fix patch for today.  If it is correct,
> > I assume that it could be applied to f2fs tree as the the other uses of
> > MS_RDONLY have already been changed to SB_RDONLY.  (There is another
> > use of MS_READONLY in this function that is already cleaned up in the
> > vfs tree commit.)
> 
> Can this be applied to the f2fs tree?

Hi Stephen,

I've modified this patch in f2fs tree to use SB_RDONLY.

Thanks,

> 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Wed, 3 Oct 2018 10:27:04 +1000
> > Subject: [PATCH] f2fs: update for MS_* flags mostly going away
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  fs/f2fs/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 6ed77589ff2b..b612a9e4a35e 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1586,7 +1586,7 @@ static int f2fs_remount(struct super_block *sb, int *flags,
> >  		goto restore_opts;
> >  	}
> >  
> > -	if ((*flags & MS_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
> > +	if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
> >  		err = -EINVAL;
> >  		f2fs_msg(sbi->sb, KERN_WARNING,
> >  			"disabling checkpoint not compatible with read-only");
> > -- 
> > 2.18.0
> 
> -- 
> Cheers,
> Stephen Rothwell


