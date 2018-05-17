Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEQNzW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:55:22 -0400
Received: from cli-5b7ef064.bcn.adamo.es ([91.126.240.100]:59819 "HELO
        mail.sysvalve.es" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with SMTP id S1751788AbeEQNzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:55:21 -0400
From: =?UTF-8?q?L=2E=20Alberto=20Gim=C3=A9nez?= <agimenez@sysvalve.es>
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org
Subject: [PATCH] build: Exclude cscope and tags files from packaging
Date: Thu, 17 May 2018 15:48:37 +0200
Message-Id: <20180517134838.8403-1-agimenez@sysvalve.es>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building a Debian package, cscope and tags generated files are
accounted in the Debian packaging process, even causing some errors
under some circumstances (generating diff between "pristine" tar and
"patched sources").

Ignore these generated files for packaging related purposes.

Signed-off-by: L. Alberto Giménez <agimenez@sysvalve.es>
---
 Makefile                 | 5 ++++-
 scripts/package/Makefile | 4 ++--
 scripts/package/mkspec   | 6 +++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index ba3106b36597..0b862a544a6a 100644
--- a/Makefile
+++ b/Makefile
@@ -453,11 +453,14 @@ export MODVERDIR := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_ve
 # Files to ignore in find ... statements
 
 export RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o    \
-			  -name CVS -o -name .pc -o -name .hg -o -name .git \) \
+			  -name CVS -o -name .pc -o -name .hg -o -name .git -o \
+			  -name tags -o -name 'cscope*' \) \
 			  -prune -o
 export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn \
 			 --exclude CVS --exclude .pc --exclude .hg --exclude .git
 
+export TAR_EXTRA_IGNORE := --exclude tags --exclude 'cscope*'
+
 # ===========================================================================
 # Rules shared between *config targets and build targets
 
diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 73503ebce632..520532b3bcb2 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -44,7 +44,7 @@ if test "$(objtree)" != "$(srctree)"; then \
 	false; \
 fi ; \
 $(srctree)/scripts/setlocalversion --save-scmversion; \
-tar -cz $(RCS_TAR_IGNORE) -f $(2).tar.gz \
+tar -cz $(RCS_TAR_IGNORE) $(TAR_EXTRA_IGNORE) -f $(2).tar.gz \
 	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
 rm -f $(objtree)/.scmversion
 
@@ -73,7 +73,7 @@ deb-pkg: FORCE
 	$(call cmd,src_tar,$(KDEB_SOURCENAME))
 	origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
 		mv $(KDEB_SOURCENAME).tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) -i.git -us -uc
+	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) -i'(.git|cscope.*)' -us -uc
 
 bindeb-pkg: FORCE
 	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index e05646dc24dc..e966a87c0011 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -28,9 +28,9 @@ fi
 
 PROVIDES="$PROVIDES kernel-$KERNELRELEASE"
 __KERNELRELEASE=$(echo $KERNELRELEASE | sed -e "s/-/_/g")
-EXCLUDES="$RCS_TAR_IGNORE --exclude=.tmp_versions --exclude=*vmlinux* \
---exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
---exclude=.config.old --exclude=.missing-syscalls.d"
+EXCLUDES="$RCS_TAR_IGNORE $TAR_EXTRA_IGNORE --exclude=.tmp_versions \
+--exclude=*vmlinux* --exclude=*.o --exclude=*.ko --exclude=*.cmd \
+--exclude=Documentation --exclude=.config.old --exclude=.missing-syscalls.d"
 
 # We can label the here-doc lines for conditional output to the spec file
 #
-- 
2.17.0
