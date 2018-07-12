Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE20C47F83
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28F92086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28F92086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbeGLRa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:30:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42102 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeGLRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:30:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fdfGS-0002Qc-Q9; Thu, 12 Jul 2018 17:20:24 +0000
Date:   Thu, 12 Jul 2018 18:20:24 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
Message-ID: <20180712172024.GZ30522@ZenIV.linux.org.uk>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <20180712171505.GA23780@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712171505.GA23780@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 07:15:05PM +0200, Greg KH wrote:
> On Tue, Jul 10, 2018 at 11:44:09PM +0100, David Howells wrote:
> > Provide an fsopen() system call that starts the process of preparing to
> > create a superblock that will then be mountable, using an fd as a context
> > handle.  fsopen() is given the name of the filesystem that will be used:
> > 
> > 	int mfd = fsopen(const char *fsname, unsigned int flags);
> > 
> > where flags can be 0 or FSOPEN_CLOEXEC.
> > 
> > For example:
> > 
> > 	sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> > 	write(sfd, "s /dev/sdb1"); // note I'm ignoring write's length arg
> > 	write(sfd, "o noatime");
> > 	write(sfd, "o acl");
> > 	write(sfd, "o user_attr");
> > 	write(sfd, "o iversion");
> > 	write(sfd, "o ");
> > 	write(sfd, "r /my/container"); // root inside the fs
> > 	write(sfd, "x create"); // create the superblock
> 
> Ugh, creating configfs again in a syscall form?  I know people love
> file descriptors, but can't you do this with a configfs entry instead if
> you really want to do this type of thing from userspace in this type of
> "style"?
> 
> Why reinvent the wheel again?

The damn thing REALLY, REALLY depends upon the fs type.  How would
you map it on configfs?
