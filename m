Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BA5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4F921537
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4F921537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeHOX2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:28:46 -0400
Received: from fieldses.org ([173.255.197.46]:60954 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeHOX2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:28:46 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A8A4E1CE7; Wed, 15 Aug 2018 16:35:03 -0400 (EDT)
Date:   Wed, 15 Aug 2018 16:35:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        syzbot <syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com>,
        jlayton@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: general protection fault in send_sigurg_to_task
Message-ID: <20180815203503.GB30591@fieldses.org>
References: <0000000000007f59610573509684@google.com>
 <000000000000f4136d0573512103@google.com>
 <20180814191129.GN7906@fieldses.org>
 <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 01:50:20PM -0700, Dmitry Vyukov wrote:
> On Tue, Aug 14, 2018 at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > On Mon, Aug 13, 2018 at 06:33:02AM -0700, syzbot wrote:
> >> syzbot has found a reproducer for the following crash on:
> >>
> >> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
> >> git tree:       linux-next
> >
> > I fetched linux-next but don't have 5ed5da74de9e.
> 
> Hi Bruce,
> 
> +Stephen for the disappeared linux-next commit.
> 
> On the dashboard link you can see that it also happened on a more
> recent commit 4e8b38549b50459a22573d756dd1f4e1963c2a8d that I do see
> now in linux-next.
> 
> > I'm also not sure why I'm on the cc for this.
> 
> You've been pointed to by "./scripts/get_maintainer.pl -f fs/fcntl.c"
> as maintainer of the file, which is the file where the crash happened.

We should probably fix that.  There's a tiny bit of lock-related code in
that file but it's not at all interesting compared, say, to the code
that this bug is hitting....

(Which I have no clue about.  send_sigurg_to_task() is getting a bad
task?  Help.)

--b.

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..a5dca2be8513 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5541,9 +5541,6 @@ M:	Jeff Layton <jlayton@kernel.org>
 M:	"J. Bruce Fields" <bfields@fieldses.org>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-F:	include/linux/fcntl.h
-F:	include/uapi/linux/fcntl.h
-F:	fs/fcntl.c
 F:	fs/locks.c
 
 FILESYSTEMS (VFS and infrastructure)
