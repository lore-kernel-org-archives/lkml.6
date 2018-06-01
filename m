Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeFAIm5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:42:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48483 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751432AbeFAImm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:42:42 -0400
X-ME-Proxy: <xmx:AAcRW78IocMINQ1BPPUjwc5hLMtvKrJSC0TUd9w4I6uuVCMg0AN8aA>
X-ME-Proxy: <xmx:AAcRW7gnNfM-gzMeqgs6Zip1a2-D6haHRAQ9mYxtxG6zOarHRdG_Gw>
X-ME-Proxy: <xmx:AAcRWyGZPs9XYQQXfbIWdihRa7ObQaNQ3OLNjealqtYzUyVX3AdjFw>
X-ME-Proxy: <xmx:AAcRW680gbeoCi3Z4DmNis2jvO9vOd-88rO6wGHmVId5WOZcPCc0AA>
X-ME-Proxy: <xmx:AAcRW5yjFRnAG3p0X5DNh1VNNc9WMxVV8aqRMAb3tM4nqqKwUFXAmQ>
X-ME-Proxy: <xmx:AAcRW-8c-jgr03wBcKeU835bwAfkj8WqQOO4gj1rQz_2E3uRx0GKUQ>
X-ME-Sender: <xms:AAcRW20tGobYv48vrsxVgNkQ_vpR0fyXn__kdwCK1Ipu7jfJYpfk1g>
Message-ID: <1527842556.2706.37.camel@themaw.net>
Subject: Re: [PATCH] autofs: make autofs4 and autofs mutually exclusive
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 01 Jun 2018 16:42:36 +0800
In-Reply-To: <1527816954.2807.19.camel@themaw.net>
References: <20180529094702.4092022-1-arnd@arndb.de>
         <1527641284.2735.12.camel@themaw.net>
         <CAK8P3a3wMJoquq+3MN69Wd1EaDBgzPnzbD1a_e4cgLHq5j0b9g@mail.gmail.com>
         <1527671935.2939.15.camel@themaw.net>
         <20180531171335.6e8272916501f8b9505bc9f2@linux-foundation.org>
         <1527816954.2807.19.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-01 at 09:35 +0800, Ian Kent wrote:
> On Thu, 2018-05-31 at 17:13 -0700, Andrew Morton wrote:
> > On Wed, 30 May 2018 17:18:55 +0800 Ian Kent <raven@themaw.net> wrote:
> > 
> > > > I actually had an alternative approach that I tried out successfully
> > > > but discarded as being too different from the original code. Just for
> > > > reference, this one would work as well, and allow both to be
> > > > compiled together. The version you posted is probably better.
> > > 
> > > It's an attractive option but the problem is both implement the
> > > autofs file system.
> > > 
> > > I've always thought you can't register the same file system at the
> > > same time from two distinct sources.
> > > 
> > > If you're careful and compile each only as a module you could do it.
> > > 
> > > But many configurations have autofs compiled built-in because of the
> > > auto-loading problems that arose back when there was an autofs fs
> > > module as well as an autofs fs module present in the autofs4 directory.
> > > 
> > > Maybe it would actually work with one winning over the other but
> > > I'd prefer not to go that way.
> > > 
> > > It will be gone in two subsequent releases if it gets merged and no
> > > changes to the retained code will be needed with this approach.
> > 
> > I'm losing the plot here.  Can you please confirm that this is the
> > patch we want?
> 
> Understandable.
> 
> This wasn't quite what I did and at the risk of confusing matters
> further I'll try and explain what I did and why.
> 
> I folded the change into the patch which created fs/autofs/Kconfig
> (autofs-create-autofs-kconfig-and-makefile.patch).
> 
> However doing what you're doing here should have the same effect as
> long as Kbuild is smart enough to work out that
> "depends on AUTOFS_FS = n" doesn't apply when fs/autofs/Kconfig hasn't
> yet been created (by autofs-create-autofs-kconfig-and-makefile.patch).
> 
> The problem is that AUTOFS_FS=y might be still be present in .config
> (surviving after many years) causing the bisection problem.
> 
> That's why I thought it best to add the depends in fs/autofs4/Kconfig
> at the time fs/autofs/Kconfig is created rather than before that in
> autofs-update-fs-autofs4-makefile.patch, as is done here.
> 
> Let me check if Kbuild will do the right thing and get back to you.

It appears that folding the "depends" update into the earlier
patch will result in any CONFIG_AUTOFS* entries being silently
removed from .config until the later patch that creates the new
fs/autofs/Kconfig is applied.

Loosing the CONFIG_AUTOFS* settings could surprise someone doing
a bisect.

To try and clear up the confusion I've taken the series from
http://www.ozlabs.org/~akpm/mmotm/series

#NEXT_PATCHES_START autofs
autofs4-merge-auto_fsh-and-auto_fs4h.patch
autofs4-use-autofs-instead-of-autofs4-everywhere.patch
autofs-copy-autofs4-to-autofs.patch
autofs-update-fs-autofs4-kconfig.patch
autofs-update-fs-autofs4-kconfig-fix.patch <--the update was folded into this
autofs-update-fs-autofs4-makefile.patch
autofs-delete-fs-autofs4-source-files.patch
autofs-create-autofs-kconfig-and-makefile.patch <-- when it should have been
                                                <-- folded into this one
autofs-rename-autofs-documentation-files.patch
autofs-use-autofs-instead-of-autofs4-in-documentation.patch
autofs-update-maintainers-entry-for-autofs.patch
#
autofs-comment-on-selinux-changes-needed-for-module-autoload.patch
#
autofs-clean-up-includes.patch
#NEXT_PATCHES_END

And the patches from http://www.ozlabs.org/~akpm/mmotm/broken-out/,
folded "autofs-update-fs-autofs4-kconfig-fix.patch" into
"autofs-create-autofs-kconfig-and-makefile.patch", and dropped the
former fix patch.

I've uploaded the resulting quilt series to
http://people.redhat.com/~ikent/akpm-autofs-rename-series/
so you can check.

The resulting "autofs-create-autofs-kconfig-and-makefile.patch" should
now look like (ha, of course that "Link:" is now wrong ...):

From: Ian Kent <raven@themaw.net>
Subject: autofs: create autofs Kconfig and Makefile

Create Makefile and Kconfig for autofs module.

Link: http://lkml.kernel.org/r/152626705591.28589.356365986974038383.stgit@pluto.themaw.net
Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/Kconfig         |    1 +
 fs/Makefile        |    1 +
 fs/autofs/Kconfig  |   20 ++++++++++++++++++++
 fs/autofs/Makefile |    7 +++++++
 4 files changed, 29 insertions(+)

--- /dev/null
+++ linux.git/fs/autofs/Kconfig
@@ -0,0 +1,20 @@
+config AUTOFS_FS
+	tristate "Kernel automounter support (supports v3, v4 and v5)"
+	default n
+	help
+	   The automounter is a tool to automatically mount remote file systems
+	   on demand. This implementation is partially kernel-based to reduce
+	   overhead in the already-mounted case; this is unlike the BSD
+	   automounter (amd), which is a pure user space daemon.
+
+	   To use the automounter you need the user-space tools from
+	   <https://www.kernel.org/pub/linux/daemons/autofs/>; you also want
+	   to answer Y to "NFS file system support", below.
+
+	   To compile this support as a module, choose M here: the module will be
+	   called autofs.
+
+	   If you are not a part of a fairly large, distributed network or
+	   don't have a laptop which needs to dynamically reconfigure to the
+	   local network, you probably do not need an automounter, and can say
+	   N here.
--- /dev/null
+++ linux.git/fs/autofs/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux autofs-filesystem routines.
+#
+
+obj-$(CONFIG_AUTOFS_FS) += autofs.o
+
+autofs-objs := init.o inode.o root.o symlink.o waitq.o expire.o dev-ioctl.o
--- linux.git.orig/fs/Kconfig
+++ linux.git/fs/Kconfig
@@ -108,6 +108,7 @@ source "fs/notify/Kconfig"
 
 source "fs/quota/Kconfig"
 
+source "fs/autofs/Kconfig"
 source "fs/autofs4/Kconfig"
 source "fs/fuse/Kconfig"
 source "fs/overlayfs/Kconfig"
--- linux.git.orig/fs/Makefile
+++ linux.git/fs/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_AFFS_FS)		+= affs/
 obj-$(CONFIG_ROMFS_FS)		+= romfs/
 obj-$(CONFIG_QNX4FS_FS)		+= qnx4/
 obj-$(CONFIG_QNX6FS_FS)		+= qnx6/
+obj-$(CONFIG_AUTOFS_FS)		+= autofs/
 obj-$(CONFIG_AUTOFS4_FS)	+= autofs4/
 obj-$(CONFIG_ADFS_FS)		+= adfs/
 obj-$(CONFIG_FUSE_FS)		+= fuse/
--- linux.git.orig/fs/autofs4/Kconfig
+++ linux.git/fs/autofs4/Kconfig
@@ -1,6 +1,7 @@
 config AUTOFS4_FS
 	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
 	default n
+	depends on AUTOFS_FS = n
 	help
 	  The automounter is a tool to automatically mount remote file systems
 	  on demand. This implementation is partially kernel-based to reduce
@@ -30,3 +31,10 @@ config AUTOFS4_FS
 	  - any "alias autofs autofs4" will need to be removed.
 
 	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
+
+	  NOTE: Since the modules autofs and autofs4 use the same file system
+		type name of "autofs" only one can be built. The "depends"
+		above will result in AUTOFS4_FS not appearing in .config for
+		any setting of AUTOFS_FS other than n and AUTOFS4_FS will
+		appear under the AUTOFS_FS entry otherwise which is intended
+		to draw attention to the module rename change.
