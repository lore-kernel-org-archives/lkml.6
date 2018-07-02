Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A90C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7781C241AE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7781C241AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753515AbeGBVbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:31:40 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:54719 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753384AbeGBVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:31:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6A43040E0;
        Mon,  2 Jul 2018 21:31:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ants08_df54f728134c
X-Filterd-Recvd-Size: 3570
Received: from XPS-9350 (unknown [172.58.94.179])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Jul 2018 21:31:35 +0000 (UTC)
Message-ID: <d729f7dc451cf26f5fdb63e44930c8fb67da41d3.camel@perches.com>
Subject: Re: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
From:   Joe Perches <joe@perches.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, peter.enderborg@sony.com,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Date:   Mon, 02 Jul 2018 14:31:32 -0700
In-Reply-To: <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
References: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
         <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 16:51 -0400, Paul Moore wrote:
> On Wed, Jun 20, 2018 at 2:39 AM Joe Perches <joe@perches.com> wrote:
> > pr_fmt can be used with the pr_<level> macros to prefix
> > arbitrary content to logging messages.
> > 
> > So add '#define pr_fmt(fmt) "SELinux: " fmt' to selinux files
> > that use pr_<level> and remove embedded "SELinux: " prefixes
> > from the format strings.

[]
> > @@ -1644,13 +1640,12 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
> > 
> >                                 if (rc == -EINVAL) {
> >                                         if (printk_ratelimit())
> > -                                               pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
> > -                                                       "context=%s.  This indicates you may need to relabel the inode or the "
> > -                                                       "filesystem in question.\n", ino, dev, context);
> > +                                               pr_notice("inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
> > +                                                         ino, dev, context);
> 
> Please split up lines like this.  I realize that there isn't much room
> left, but this message wraps a silly amount in my 80-char terminal; if
> you need to wrap, please limit it to a word or two.
> 
> To stop the argument before it starts, I don't care what checkpatch.pl
> says about splitting printk format strings like this.

I do, so does Linus.  It's also specified in CodingStyle.

2) Breaking long lines and strings
----------------------------------
[]
never break user-visible strings such as
printk messages, because that breaks the ability to grep for them.
----------------------------------

Likely this would also use pr_notice_ratelimited(etc...)
to reduce indentation a bit too.

Probably these should be output on 2 lines as the output
dmesg line length is extremely long.

> What tree did you base your patch on?

next-20180619 on the day it was sent. 

> Please base SELinux patches
> either on the SELinux tree or Linus' tree.  The SELinux tree can be
> found at the links below:
> 
> * git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

It's almost always better to use selinux/next.
Why should this patch be different?

cheers, Joe
