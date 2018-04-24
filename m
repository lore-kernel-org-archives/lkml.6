Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933854AbeDXOLk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:11:40 -0400
Received: from verein.lst.de ([213.95.11.211]:59465 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933448AbeDXOLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:11:19 -0400
Date: Tue, 24 Apr 2018 16:12:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 20/39] afs: simplify procfs code
Message-ID: <20180424141248.GA26136@lst.de>
References: <22411.1524142823@warthog.procyon.org.uk> <20180419124140.9309-21-hch@lst.de> <20180419124140.9309-1-hch@lst.de> <22726.1524227374@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22726.1524227374@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 01:29:34PM +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > > Use remove_proc_subtree to remove the whole subtree on cleanup, and
> > > unwind the registration loop into individual calls.  Switch to use
> > > proc_create_seq where applicable.
> > 
> > Note that this is likely going to clash with my patch to net-namespace all of
> > the afs proc files:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-context&id=f60c26c827c073583107ebf19d87bc5c0e71c3d2
> > 
> > If it helps, I should be able to disentangle this from the mount-api changes
> > since the subsequent patch connects the dots to propagate the network
> > namespace over automount using the new fs_context to do it.
> 
> Okay, I'll follow up this mail with a pair of patches to just use network
> namespacing in AFS.  The first exports a function from core code only; the
> second is the actual modifications to AFS.

I don't think you should need any of these.  seq_file_net or
seq_file_single_net will return you the net_ns based on a struct
seq_file.  And even from your write routines you can reach the
seq_file in file->private pretty easily.
