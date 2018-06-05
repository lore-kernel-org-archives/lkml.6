Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeFEQHJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:07:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751745AbeFEQHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:07:07 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/5] afs: Handle CONFIG_PROC_FS=n
From: David Howells <dhowells@redhat.com>
To: viro@ZenIV.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Jun 2018 17:07:05 +0100
Message-ID: <152821482528.16494.1230190248948500113.stgit@warthog.procyon.org.uk>
In-Reply-To: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
References: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AFS filesystem depends at the moment on /proc for configuration and
also presents information that way - however, this causes a compilation
failure if procfs is disabled.

Fix it so that the procfs bits aren't compiled in if procfs is disabled.

This means that you can't configure the AFS filesystem directly, but it is
still usable provided that an up-to-date keyutils is installed to look up
cells by SRV or AFSDB DNS records.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/Makefile   |    4 ++--
 fs/afs/internal.h |    8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index 532acae25453..546874057bd3 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -5,7 +5,7 @@
 
 afs-cache-$(CONFIG_AFS_FSCACHE) := cache.o
 
-kafs-objs := \
+kafs-y := \
 	$(afs-cache-y) \
 	addr_list.o \
 	callback.o \
@@ -21,7 +21,6 @@ kafs-objs := \
 	main.o \
 	misc.o \
 	mntpt.o \
-	proc.o \
 	rotate.o \
 	rxrpc.o \
 	security.o \
@@ -34,4 +33,5 @@ kafs-objs := \
 	write.o \
 	xattr.o
 
+kafs-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_AFS_FS)  := kafs.o
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b51fb8587166..bc3d8c87a938 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -870,11 +870,19 @@ extern int afs_get_ipv4_interfaces(struct afs_net *, struct afs_interface *,
 /*
  * proc.c
  */
+#ifdef CONFIG_PROC_FS
 extern int __net_init afs_proc_init(struct afs_net *);
 extern void __net_exit afs_proc_cleanup(struct afs_net *);
 extern int afs_proc_cell_setup(struct afs_cell *);
 extern void afs_proc_cell_remove(struct afs_cell *);
 extern void afs_put_sysnames(struct afs_sysnames *);
+#else
+static inline int afs_proc_init(struct afs_net *net) { return 0; }
+static inline void afs_proc_cleanup(struct afs_net *net) {}
+static inline int afs_proc_cell_setup(struct afs_cell *cell) { return 0; }
+static inline void afs_proc_cell_remove(struct afs_cell *cell) {}
+static inline void afs_put_sysnames(struct afs_sysnames *sysnames) {}
+#endif
 
 /*
  * rotate.c
