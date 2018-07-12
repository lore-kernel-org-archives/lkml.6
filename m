Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E058CEA96CF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71C4208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71C4208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeGLSNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:13:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeGLSNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:13:46 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C0B6CDA;
        Thu, 12 Jul 2018 18:03:06 +0000 (UTC)
Date:   Thu, 12 Jul 2018 20:03:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
Message-ID: <20180712180304.GA27758@kroah.com>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <20180712171505.GA23780@kroah.com>
 <20180712172024.GZ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172024.GZ30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:20:24PM +0100, Al Viro wrote:
> On Thu, Jul 12, 2018 at 07:15:05PM +0200, Greg KH wrote:
> > On Tue, Jul 10, 2018 at 11:44:09PM +0100, David Howells wrote:
> > > Provide an fsopen() system call that starts the process of preparing to
> > > create a superblock that will then be mountable, using an fd as a context
> > > handle.  fsopen() is given the name of the filesystem that will be used:
> > > 
> > > 	int mfd = fsopen(const char *fsname, unsigned int flags);
> > > 
> > > where flags can be 0 or FSOPEN_CLOEXEC.
> > > 
> > > For example:
> > > 
> > > 	sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> > > 	write(sfd, "s /dev/sdb1"); // note I'm ignoring write's length arg
> > > 	write(sfd, "o noatime");
> > > 	write(sfd, "o acl");
> > > 	write(sfd, "o user_attr");
> > > 	write(sfd, "o iversion");
> > > 	write(sfd, "o ");
> > > 	write(sfd, "r /my/container"); // root inside the fs
> > > 	write(sfd, "x create"); // create the superblock
> > 
> > Ugh, creating configfs again in a syscall form?  I know people love
> > file descriptors, but can't you do this with a configfs entry instead if
> > you really want to do this type of thing from userspace in this type of
> > "style"?
> > 
> > Why reinvent the wheel again?
> 
> The damn thing REALLY, REALLY depends upon the fs type.  How would
> you map it on configfs?

/sys/kernel/config/fs/ext4/ would work, right?  Each fs "type" would be
listed there.

Anyway, the whole "write a bunch of options and then do a 'create'" is
exactly the way configfs works.  Why not use that?

thanks,

greg k-h
