Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71356C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F19A20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GFcnzSj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F19A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502391AbeKWSZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:25:58 -0500
Received: from m12-13.163.com ([220.181.12.13]:48886 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390041AbeKWSZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=l7HrF
        AUGrX/AbS0daXYfYodInwELvxOeILo2B59k4VE=; b=GFcnzSj1j2mu3yFSednpH
        +GC/pwKCgqrzkREQeViqs1ogibrBvrSAV/pfHwl1la86H5BJqbjQNgfORadkeIGI
        tmATt8z4oSTNIRRUASdktXXFS5QkA/T+DIdbSgBELEYVQrk15sLcnjYd12LtFsiH
        YyVxvjSGezdzO6yWb7qBWs=
Received: from bp (unknown [106.120.213.96])
        by smtp9 (Coremail) with SMTP id DcCowAA3JS4Pr_db3bKfBQ--.42338S2;
        Fri, 23 Nov 2018 15:41:05 +0800 (CST)
Date:   Fri, 23 Nov 2018 15:41:06 +0800
From:   PanBian <bianpan2016@163.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] exportfs: do not read dentry after free
Message-ID: <20181123074106.GA102096@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1542942953-93562-1-git-send-email-bianpan2016@163.com>
 <CAOQ4uxj74Xh6ZbJp7zPZOxOY-gkrm5K1yU31+DW1YMYzOWtKgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj74Xh6ZbJp7zPZOxOY-gkrm5K1yU31+DW1YMYzOWtKgA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: DcCowAA3JS4Pr_db3bKfBQ--.42338S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1kAFykXw15Zr1fJry5Jwb_yoW8Aw1kpa
        n3Gr4FkFWvqFsxCr4xuF15X3409w1IqF15JFyUWr18Xr9xXF1F9r129w1q9Fy09rs5CFWD
        XF4DKw1fWF45ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bUSoXUUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUREIclaD0R7dzQAAsw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 07:58:15AM +0200, Amir Goldstein wrote:
> On Fri, Nov 23, 2018 at 5:16 AM Pan Bian <bianpan2016@163.com> wrote:
> >
> > The function dentry_connected calls dput(dentry) to drop the previously
> > acquired reference to dentry. In this case, dentry can be released.
> > After that, IS_ROOT(dentry) checks the condition
> > (dentry == dentry->d_parent), which may result in a use-after-free bug.
> > This patch directly compares dentry with its parent obtained before
> > dropping the reference.
> >
> > Fixes: a056cc8934c("exportfs: stop retrying once we race with
> > rename/remove")
> >
> 
> CC Fixes patch author/reviewers
> 
> How did you find this? by code review or did this actually happen?
> 
> Normally a IS_ROOT dentry would be either DCACHE_DISCONNECTED or
> pinned to some super block, but I guess there may be corner cases?

I found this by code review, and I have not yet observed crash.

> 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > ---
> >  fs/exportfs/expfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> > index 645158d..a69aaf5 100644
> > --- a/fs/exportfs/expfs.c
> > +++ b/fs/exportfs/expfs.c
> > @@ -77,7 +77,7 @@ static bool dentry_connected(struct dentry *dentry)
> >                 struct dentry *parent = dget_parent(dentry);
> >
> >                 dput(dentry);
> > -               if (IS_ROOT(dentry)) {
> > +               if (dentry == parent) { /* is root entry */
> >                         dput(parent);
> >                         return false;
> >                 }
> 
> The change itself looks right, but the name IS_ROOT is confusing
> enough as it is. The explicit comment is just plain wrong.
> If it was really a root dentry, it wouldn't have been DCACHE_DISCONNECTED
> (unless it is a filesystem bug).

I will remove the comment and resubmit the patch.

Thanks a lot,
Pan

> 
> Thanks,
> Amir.

