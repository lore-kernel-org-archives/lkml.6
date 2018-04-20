Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754808AbeDTMbd convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:31:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754591AbeDTMbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:31:32 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <22726.1524227374@warthog.procyon.org.uk>
References: <22726.1524227374@warthog.procyon.org.uk> <22411.1524142823@warthog.procyon.org.uk> <20180419124140.9309-21-hch@lst.de> <20180419124140.9309-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 01/02] net: Export get_proc_net()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22802.1524227488.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Fri, 20 Apr 2018 13:31:28 +0100
Message-ID: <22803.1524227488@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export get_proc_net() so that write() routines attached to net-namespaced
proc files can find the network namespace that they're in.  Currently, this
is only accessible via seqfile routines.
    
This will permit AFS to have a separate cell database per-network namespace
and to manage each one independently of the others.
    
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/proc/proc_net.c      |    3 ++-
 include/linux/proc_fs.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 1763f370489d..23d56146e38f 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -33,10 +33,11 @@ static inline struct net *PDE_NET(struct proc_dir_entry *pde)
 	return pde->parent->data;
 }
 
-static struct net *get_proc_net(const struct inode *inode)
+struct net *get_proc_net(const struct inode *inode)
 {
 	return maybe_get_net(PDE_NET(PDE(inode)));
 }
+EXPORT_SYMBOL_GPL(get_proc_net);
 
 int seq_open_net(struct inode *ino, struct file *f,
 		 const struct seq_operations *ops, int size)
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 928ef9e4d912..47a87121d30c 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -79,6 +79,8 @@ static inline struct proc_dir_entry *proc_net_mkdir(
 	return proc_mkdir_data(name, 0, parent, net);
 }
 
+extern struct net *get_proc_net(const struct inode *inode);
+
 struct ns_common;
 int open_related_ns(struct ns_common *ns,
 		   struct ns_common *(*get_ns)(struct ns_common *ns));
