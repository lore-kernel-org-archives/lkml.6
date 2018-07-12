Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B80C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88AB20842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88AB20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbeGLRZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:25:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35302 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeGLRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:25:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D44D8D85;
        Thu, 12 Jul 2018 17:15:07 +0000 (UTC)
Date:   Thu, 12 Jul 2018 19:15:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
Message-ID: <20180712171505.GA23780@kroah.com>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 11:44:09PM +0100, David Howells wrote:
> Provide an fsopen() system call that starts the process of preparing to
> create a superblock that will then be mountable, using an fd as a context
> handle.  fsopen() is given the name of the filesystem that will be used:
> 
> 	int mfd = fsopen(const char *fsname, unsigned int flags);
> 
> where flags can be 0 or FSOPEN_CLOEXEC.
> 
> For example:
> 
> 	sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> 	write(sfd, "s /dev/sdb1"); // note I'm ignoring write's length arg
> 	write(sfd, "o noatime");
> 	write(sfd, "o acl");
> 	write(sfd, "o user_attr");
> 	write(sfd, "o iversion");
> 	write(sfd, "o ");
> 	write(sfd, "r /my/container"); // root inside the fs
> 	write(sfd, "x create"); // create the superblock

Ugh, creating configfs again in a syscall form?  I know people love
file descriptors, but can't you do this with a configfs entry instead if
you really want to do this type of thing from userspace in this type of
"style"?

Why reinvent the wheel again?

thanks,

greg k-h
