Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeEQGnI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:43:08 -0400
Received: from verein.lst.de ([213.95.11.211]:51576 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752230AbeEQGnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:43:05 -0400
Date: Thu, 17 May 2018 08:47:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Novakovic <chris@chrisn.me.uk>
Subject: Re: linux-next: manual merge of the net-next tree with the vfs tree
Message-ID: <20180517064737.GA24336@lst.de>
References: <20180517113450.182c8259@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517113450.182c8259@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + /* Create a new file under /proc/net/ipconfig */
> + static int ipconfig_proc_net_create(const char *name,
> + 				    const struct file_operations *fops)
> + {
> + 	char *pname;
> + 	struct proc_dir_entry *p;
> + 
> + 	if (!ipconfig_dir)
> + 		return -ENOMEM;
> + 
> + 	pname = kasprintf(GFP_KERNEL, "%s%s", "ipconfig/", name);
> + 	if (!pname)
> + 		return -ENOMEM;
> + 
> + 	p = proc_create(pname, 0444, init_net.proc_net, fops);
> + 	kfree(pname);
> + 	if (!p)
> + 		return -ENOMEM;
> + 
> + 	return 0;

This code doesn't exist in the above mentioned commit.  But event
without knowing the details of the /proc/net code this looks somewhat
bogus.  For one I thought all the /proc/net files should be per-net
namespace.  Second the ntp file really should be using proc_create_net,
to handle all that under the hood - with the merge of the VFS
tree it will take a seq_ops, which is what this code really wants
anyway.
