Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55236C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0AF2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0AF2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeK2HKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:10:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49838 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbeK2HKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:10:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACEBFA78;
        Wed, 28 Nov 2018 12:07:48 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C5F63F59C;
        Wed, 28 Nov 2018 12:07:48 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B4A6B1AE0A5A; Wed, 28 Nov 2018 20:08:06 +0000 (GMT)
Date:   Wed, 28 Nov 2018 20:08:06 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jan Glauber <Jan.Glauber@cavium.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, jslaby@suse.com
Subject: Re: dcache_readdir NULL inode oops
Message-ID: <20181128200806.GC32668@arm.com>
References: <20181109143744.GA12128@hc>
 <20181109155856.GC2091@brain-police>
 <20181110111656.GA16667@hc>
 <20181120182854.GC28838@arm.com>
 <20181120190317.GA29161@arm.com>
 <20181121131900.GA18931@hc>
 <20181123180525.GA21017@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123180525.GA21017@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I spent some more time looking at this today...

On Fri, Nov 23, 2018 at 06:05:25PM +0000, Will Deacon wrote:
> Doing some more debugging, it looks like the usual failure case is where
> one CPU clears the inode field in the dentry via:
> 
> 	devpts_pty_kill()
> 		-> d_delete()	// dentry->d_lockref.count == 1
> 			-> dentry_unlink_inode()
> 
> whilst another CPU gets a pointer to the dentry via:
> 
> 	sys_getdents64()
> 		-> iterate_dir()
> 			-> dcache_readdir()
> 				-> next_positive()
> 
> and explodes on the subsequent inode dereference when trying to pass the
> inode number to dir_emit():
> 
> 	if (!dir_emit(..., d_inode(next)->i_ino, ...))
> 
> Indeed, the hack below triggers a warning, indicating that the inode
> is being cleared concurrently.
> 
> I can't work out whether the getdents64() path should hold a refcount
> to stop d_delete() in its tracks, or whether devpts_pty_kill() shouldn't
> be calling d_delete() like this at all.

So the issue is that opening /dev/pts/ptmx creates a new pty in /dev/pts,
which disappears when you close /dev/pts/ptmx. Consequently, when we tear
down the dentry for the magic new file, we have to take the i_node rwsem of
the *parent* so that concurrent path walkers don't trip over it whilst its
being freed. I wrote a simple concurrent program to getdents(/dev/pts/) in
one thread, whilst another opens and closes /dev/pts/ptmx: it crashes the
kernel in seconds.

Patch below, but I'd still like somebody else to look at this, please.

Will

--->8

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index c53814539070..50ddb95ff84c 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -619,11 +619,17 @@ void *devpts_get_priv(struct dentry *dentry)
  */
 void devpts_pty_kill(struct dentry *dentry)
 {
-	WARN_ON_ONCE(dentry->d_sb->s_magic != DEVPTS_SUPER_MAGIC);
+	struct super_block *sb = dentry->d_sb;
+	struct dentry *parent = sb->s_root;
 
+	WARN_ON_ONCE(sb->s_magic != DEVPTS_SUPER_MAGIC);
+
+	inode_lock(parent->d_inode);
 	dentry->d_fsdata = NULL;
 	drop_nlink(dentry->d_inode);
 	d_delete(dentry);
+	inode_unlock(parent->d_inode);
+
 	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
 }
 
