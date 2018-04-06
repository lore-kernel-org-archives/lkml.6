Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeDFGvY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 02:51:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50192 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeDFGvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 02:51:21 -0400
Date: Fri, 6 Apr 2018 07:51:18 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/20] afs: Implement @sys substitution handling
Message-ID: <20180406065118.GZ30522@ZenIV.linux.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
 <152296020457.31027.11109314533967989357.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152296020457.31027.11109314533967989357.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 09:30:04PM +0100, David Howells wrote:
> +static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
> +				       struct key *key)
> +{

> +		ret = lookup_one_len(buf, parent, len);

Er...  Parent is locked only shared here and lookup_one_len() seriously depends
upon exclusive lock.  As it is, race with lookup of the full name will mess the
things up very badly.
