Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeFDRQf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:16:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeFDRQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:16:33 -0400
Date: Mon, 4 Jun 2018 10:16:30 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH][RFC] open_tree(2) (was Re: [PATCH 30/32] vfs: Allow
 cloning of a mount tree with open(O_PATH|O_CLONE_MOUNT) [ver #8])
Message-ID: <20180604171630.GA29059@bombadil.infradead.org>
References: <20180601063928.GS30522@ZenIV.linux.org.uk>
 <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720691829.9073.10564431140980997005.stgit@warthog.procyon.org.uk>
 <20180601062654.GA32397@infradead.org>
 <7067.1527841663@warthog.procyon.org.uk>
 <20180602030913.GU30522@ZenIV.linux.org.uk>
 <20180602034255.GV30522@ZenIV.linux.org.uk>
 <21804.1527954321@warthog.procyon.org.uk>
 <20180602174957.GX30522@ZenIV.linux.org.uk>
 <20180603005532.GZ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603005532.GZ30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2018 at 01:55:37AM +0100, Al Viro wrote:
> +SYSCALL_DEFINE3(open_tree, int, dfd, const char *, filename, unsigned, flags)
> +{
> +	struct file *file;
> +	struct path path;
> +	int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
> +	bool detached = flags & OPEN_TREE_CLONE;
> +	int error;
> +	int fd;
> +
> +	BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);

Why do we need OPEN_TREE_CLOEXEC?  Wouldn't we be better off just making
the fd returned by open_tree implicitly close-on-exec?  I can think of
no good reason for these file descriptors to be inherited across exec()
and if someone comes up with such a reason, fcntl(F_SETFD) is not an
expensive call to make.
