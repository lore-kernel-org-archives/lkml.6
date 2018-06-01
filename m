Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeFAANi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 20:13:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFAANh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 20:13:37 -0400
Date: Thu, 31 May 2018 17:13:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ian Kent <raven@themaw.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] autofs: make autofs4 and autofs mutually exclusive
Message-Id: <20180531171335.6e8272916501f8b9505bc9f2@linux-foundation.org>
In-Reply-To: <1527671935.2939.15.camel@themaw.net>
References: <20180529094702.4092022-1-arnd@arndb.de>
        <1527641284.2735.12.camel@themaw.net>
        <CAK8P3a3wMJoquq+3MN69Wd1EaDBgzPnzbD1a_e4cgLHq5j0b9g@mail.gmail.com>
        <1527671935.2939.15.camel@themaw.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018 17:18:55 +0800 Ian Kent <raven@themaw.net> wrote:

> > I actually had an alternative approach that I tried out successfully
> > but discarded as being too different from the original code. Just for
> > reference, this one would work as well, and allow both to be
> > compiled together. The version you posted is probably better.
> 
> It's an attractive option but the problem is both implement the
> autofs file system.
> 
> I've always thought you can't register the same file system at the
> same time from two distinct sources.
> 
> If you're careful and compile each only as a module you could do it.
> 
> But many configurations have autofs compiled built-in because of the
> auto-loading problems that arose back when there was an autofs fs
> module as well as an autofs fs module present in the autofs4 directory.
> 
> Maybe it would actually work with one winning over the other but
> I'd prefer not to go that way.
> 
> It will be gone in two subsequent releases if it gets merged and no
> changes to the retained code will be needed with this approach.

I'm losing the plot here.  Can you please confirm that this is the
patch we want?


From: Ian Kent <raven@themaw.net>
Subject: autofs: update fs/autofs4/Kconfig

Update Kconfig and add a depricated warning.

[raven@themaw.net: make autofs4 Kconfig depend on AUTOFS_FS]
  Link: http://lkml.kernel.org/r/152687649097.8263.7046086367407522029.stgit@pluto.themaw.net
Link: http://lkml.kernel.org/r/152626706133.28589.11994171621899212952.stgit@pluto.themaw.net
Signed-off-by: Ian Kent <raven@themaw.net>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/autofs4/Kconfig |   42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff -puN fs/autofs4/Kconfig~autofs-update-fs-autofs4-kconfig fs/autofs4/Kconfig
--- a/fs/autofs4/Kconfig~autofs-update-fs-autofs4-kconfig
+++ a/fs/autofs4/Kconfig
@@ -1,5 +1,7 @@
 config AUTOFS4_FS
-	tristate "Kernel automounter version 4 support (also supports v3)"
+	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
+	default n
+	depends on AUTOFS_FS = n
 	help
 	  The automounter is a tool to automatically mount remote file systems
 	  on demand. This implementation is partially kernel-based to reduce
@@ -7,14 +9,32 @@ config AUTOFS4_FS
 	  automounter (amd), which is a pure user space daemon.
 
 	  To use the automounter you need the user-space tools from
-	  <https://www.kernel.org/pub/linux/daemons/autofs/v4/>; you also
-	  want to answer Y to "NFS file system support", below.
+	  <https://www.kernel.org/pub/linux/daemons/autofs/>; you also want
+	  to answer Y to "NFS file system support", below.
 
-	  To compile this support as a module, choose M here: the module will be
-	  called autofs4.  You will need to add "alias autofs autofs4" to your
-	  modules configuration file.
-
-	  If you are not a part of a fairly large, distributed network or
-	  don't have a laptop which needs to dynamically reconfigure to the
-	  local network, you probably do not need an automounter, and can say
-	  N here.
+	  This module is in the process of being renamed from autofs4 to
+	  autofs. Since autofs is now the only module that provides the
+	  autofs file system the module is not version 4 specific.
+
+	  The autofs4 module is now built from the source located in
+	  fs/autofs. The autofs4 directory and its configuration entry
+	  will be removed two kernel versions from the inclusion of this
+	  change.
+
+	  Changes that will need to be made should be limited to:
+	  - source include statments should be changed from autofs_fs4.h to
+	    autofs_fs.h since these two header files have been merged.
+	  - user space scripts that manually load autofs4.ko should be
+	    changed to load autofs.ko. But since the module directory name
+	    and the module name are the same as the file system name there
+	    is no need to manually load module.
+	  - any "alias autofs autofs4" will need to be removed.
+
+	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
+
+	  NOTE: Since the modules autofs and autofs4 use the same file system
+		type name of "autofs" only one can be built. The "depends"
+		above will result in AUTOFS4_FS not appearing in .config for
+		any setting of AUTOFS_FS other than n and AUTOFS4_FS will
+		appear under the AUTOFS_FS entry otherwise which is intended
+		to draw attention to the module rename change.
_
