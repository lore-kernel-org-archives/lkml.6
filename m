Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE39ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF02B21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF02B21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbeIUWmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:42:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390076AbeIUWmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:42:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C97931E308;
        Fri, 21 Sep 2018 16:52:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 923B887E23;
        Fri, 21 Sep 2018 16:52:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180921155455.flkf5vdrm3vgn6do@brauner.io>
References: <20180921155455.flkf5vdrm3vgn6do@brauner.io> <20180920151214.15484-6-mszeredi@redhat.com> <20180920151214.15484-1-mszeredi@redhat.com> <17157.1537542475@warthog.procyon.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20310.1537548756.1@warthog.procyon.org.uk>
Date:   Fri, 21 Sep 2018 17:52:36 +0100
Message-ID: <20311.1537548756@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 21 Sep 2018 16:52:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> So from reading the patch I got the impression that superblock mount
> options passed via fsconfig() are passed as strings like "ro" and are
> translated into approriate objects (e.g. flags etc.) by the kernel.

I'm having second throughts about that - at least for "ro": that one is
particularly problematic as it governs how source devices are opened.  I'm
kind of tempted to pass that as a flag to fsopen().

What I'd like to do in btrfs, ext4, etc. is open blockdevs as I get the
parameters that enumerate them - but I have to hold the looked-up paths till
the validate/get_tree stage so that I know the final ro/rw state before I can
do the opening.

> That seems like a future proof mechanism to extend mount options for
> userspace without having to worry about exceeding any integer types in the
> future. Maybe this would make sense for non-superblock options as well? I
> can see that this is less performant that checking flags and string parsing
> is a thing that is not particularly nice but it would be one option to solve
> the running out of flags problem.

Al disliked the idea of setting up a separate context to define the mount
options.

> > 	mount_setattr(int dfd, const char *path, unsigned int atflags,
> > 		      unsigned int attr_values,
> > 		      unsigned int attr_mask);
> 
> If we go with the flag arguments wouldn't it make sense to use a larger
> integer type?

You can't - at least not directly through syscall args.  They are 32-bit on a
32-bit system.

> > where atflags can potentially include AT_RECURSIVE.
> 
> Very much in favor of having this operate recursively!

It gets complicated with propagation.

David
