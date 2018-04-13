Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754489AbeDMNw7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:52:59 -0400
Received: from foss.arm.com ([217.140.101.70]:42684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754450AbeDMNw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:52:56 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Jiri Olsa <jolsa@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] tools build: Use -Xpreprocessor instead of -Wp and leave pathnames intact
Date: Fri, 13 Apr 2018 14:53:10 +0100
Message-Id: <1523627590-27612-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build.include invokes the pre-processor via GCC in order to generate a
dependency list for the input file. Since these options are passed using
'-Wp,-M...,$(depfile)' it is important that $(depfile) does not contain
any commas, so these are substituted with underscores. This substitution
will break the build if the directory name of the output directory happens
to include a comma, e.g. when using "aiaiai" for bisection testing:

  | cc1: fatal error: x86/tools/objtool/fixdep.o: No such file or directory
  | compilation terminated.
  | cat: /tmp/aiaiai-test-patchset.qroS/before/obj.defconfig_x86/tools/objtool/.fixdep.o.d: No such file or directory
  | make[5]: *** [tools/objtool/fixdep.o] Error 1

We can address this by using -Xpreprocessor instead of -Wp, which allows
us to pass down an unmodified pathname.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

As an aside, the way we currently pass the depfile to -MD appears to be
in direct contradiction with the preprocessor documentation, although it
does work with the cc1 implementation.

 tools/build/Build.include | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/build/Build.include b/tools/build/Build.include
index 418871d02ebf..e1914f8e2328 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -22,9 +22,7 @@ dot-target = $(dir $@).$(notdir $@)
 basetarget = $(basename $(notdir $@))
 
 ###
-# The temporary file to save gcc -MD generated dependencies must not
-# contain a comma
-depfile = $(subst $(comma),_,$(dot-target).d)
+depfile = $(dot-target).d
 
 ###
 # Check if both arguments has same arguments. Result is empty string if equal.
@@ -89,12 +87,12 @@ if_changed = $(if $(strip $(any-prereq) $(arg-check)),                   \
 # - per target C flags
 # - per object C flags
 # - BUILD_STR macro to allow '-D"$(variable)"' constructs
-c_flags_1 = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CFLAGS) -D"BUILD_STR(s)=\#s" $(CFLAGS_$(basetarget).o) $(CFLAGS_$(obj))
+c_flags_1 = -Xpreprocessor -MD -Xpreprocessor $(depfile) -Xpreprocessor -MT -Xpreprocessor $@ $(CFLAGS) -D"BUILD_STR(s)=\#s" $(CFLAGS_$(basetarget).o) $(CFLAGS_$(obj))
 c_flags_2 = $(filter-out $(CFLAGS_REMOVE_$(basetarget).o), $(c_flags_1))
 c_flags   = $(filter-out $(CFLAGS_REMOVE_$(obj)), $(c_flags_2))
-cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXXFLAGS_$(basetarget).o) $(CXXFLAGS_$(obj))
+cxx_flags = -Xpreprocessor -MD -Xpreprocessor $(depfile) -Xpreprocessor -MT -Xpreprocessor $@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXXFLAGS_$(basetarget).o) $(CXXFLAGS_$(obj))
 
 ###
 ## HOSTCC C flags
 
-host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CHOSTFLAGS) -D"BUILD_STR(s)=\#s" $(CHOSTFLAGS_$(basetarget).o) $(CHOSTFLAGS_$(obj))
+host_c_flags = -Xpreprocessor -MD -Xpreprocessor $(depfile) -Xpreprocessor -MT -Xpreprocessor $@ $(CHOSTFLAGS) -D"BUILD_STR(s)=\#s" $(CHOSTFLAGS_$(basetarget).o) $(CHOSTFLAGS_$(obj))
-- 
2.1.4
