Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeC2AsS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 20:48:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43698 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeC2AsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 20:48:15 -0400
X-Google-Smtp-Source: AIpwx480IK0uirBmV/M3uQMu8cJ5NqcnCiTsl3OA0EqE1LKRnZOtYcSvG9IwHwPSj22t96XIsfiXog==
From: Laura Abbott <labbott@redhat.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 1/3] kbuild: Support HOSTLDFLAGS
Date: Wed, 28 Mar 2018 17:48:03 -0700
Message-Id: <20180329004805.7278-2-labbott@redhat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329004805.7278-1-labbott@redhat.com>
References: <20180329004805.7278-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In addition to HOSTCFLAGS, there's HOSTLDFLAGS. Ensure these get passed to
calls to build host binaries.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 scripts/Makefile.host      | 6 +++---
 tools/build/Makefile.build | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index e6dc6ae2d7c4..a3a0e2282a56 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -84,7 +84,7 @@ hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
 # Create executable from a single .c file
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	= HOSTCC  $@
-      cmd_host-csingle	= $(HOSTCC) $(hostc_flags) -o $@ $< \
+      cmd_host-csingle	= $(HOSTCC) $(HOSTLDFLAGS) $(hostc_flags) -o $@ $< \
 	  	$(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
 $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 	$(call if_changed_dep,host-csingle)
@@ -102,7 +102,7 @@ $(call multi_depend, $(host-cmulti), , -objs)
 # Create .o file from a single .c file
 # host-cobjs -> .o
 quiet_cmd_host-cobjs	= HOSTCC  $@
-      cmd_host-cobjs	= $(HOSTCC) $(hostc_flags) -c -o $@ $<
+      cmd_host-cobjs	= $(HOSTCC) $(HOSTLDFLAGS) $(hostc_flags) -c -o $@ $<
 $(host-cobjs): $(obj)/%.o: $(src)/%.c FORCE
 	$(call if_changed_dep,host-cobjs)
 
@@ -126,7 +126,7 @@ $(host-cxxobjs): $(obj)/%.o: $(src)/%.cc FORCE
 # Compile .c file, create position independent .o file
 # host-cshobjs -> .o
 quiet_cmd_host-cshobjs	= HOSTCC  -fPIC $@
-      cmd_host-cshobjs	= $(HOSTCC) $(hostc_flags) -fPIC -c -o $@ $<
+      cmd_host-cshobjs	= $(HOSTCC) $(HOSTLDFLAGS) $(hostc_flags) -fPIC -c -o $@ $<
 $(host-cshobjs): $(obj)/%.o: $(src)/%.c FORCE
 	$(call if_changed_dep,host-cshobjs)
 
diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index cd72016c3cfa..cab55f0d90e1 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -64,7 +64,7 @@ quiet_cmd_cc_o_c = CC       $@
       cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
 
 quiet_cmd_host_cc_o_c = HOSTCC   $@
-      cmd_host_cc_o_c = $(HOSTCC) $(host_c_flags) -c -o $@ $<
+      cmd_host_cc_o_c = $(HOSTCC) $(HOSTLDFLAGS) $(host_c_flags) -c -o $@ $<
 
 quiet_cmd_cxx_o_c = CXX      $@
       cmd_cxx_o_c = $(CXX) $(cxx_flags) -c -o $@ $<
-- 
2.16.2
