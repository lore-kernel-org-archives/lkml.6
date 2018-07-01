Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE83C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EA825B75
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EA825B75
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbeGASti (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:49:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59680 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbeGAQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:11:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BCB26ACD;
        Sun,  1 Jul 2018 16:11:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Borislav Petkov <bp@suse.de>,
        David Ahern <dsahern@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Michal Marek <mmarek@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3.18 02/85] tools build: Fix Makefile(s) to properly invoke tools build
Date:   Sun,  1 Jul 2018 18:01:20 +0200
Message-Id: <20180701153122.463768891@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 16671c1e1cac2dbb995feb4bc55082fd939b5c2c upstream.

Several fixes were needed to allow following builds:
  $ make tools/tmon
  $ make -C <kernelsrc> tools/perf
  $ make -C <kernelsrc>/tools perf

 - some of the tools (perf) use same make variables as in
   kernel build, unsetting srctree and objtree
 - using original $(O) for O variable
 - perf build does not follow the descend function setup
   invoking it via it's own make rule

I tried the rest of the tools/Makefile targets and they
seem to work now.

Reported-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Michal Marek <mmarek@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild@vger.kernel.org
Link: http://lkml.kernel.org/r/1429389280-18720-3-git-send-email-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile       |    5 ++---
 tools/Makefile |   12 +++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -214,7 +214,6 @@ VPATH		:= $(srctree)$(if $(KBUILD_EXTMOD
 
 export srctree objtree VPATH
 
-
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
 # line overrides the setting of ARCH below.  If a native build is happening,
@@ -1505,11 +1504,11 @@ image_name:
 # Clear a bunch of variables before executing the submake
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter --j% -j,$(MAKEFLAGS))" O=$(objtree) subdir=tools -C $(src)/tools/
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter --j% -j,$(MAKEFLAGS))" O=$(O) subdir=tools -C $(src)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter --j% -j,$(MAKEFLAGS))" O=$(objtree) subdir=tools -C $(src)/tools/ $*
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter --j% -j,$(MAKEFLAGS))" O=$(O) subdir=tools -C $(src)/tools/ $*
 
 # Single targets
 # ---------------------------------------------------------------------------
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -1,3 +1,8 @@
+# Some of the tools (perf) use same make variables
+# as in kernel build.
+export srctree=
+export objtree=
+
 include scripts/Makefile.include
 
 help:
@@ -54,8 +59,13 @@ liblockdep: FORCE
 libapi: FORCE
 	$(call descend,lib/api)
 
+# The perf build does not follow the descend function setup,
+# invoking it via it's own make rule.
+PERF_O   = $(if $(O),$(O)/tools/perf,)
+
 perf: FORCE
-	$(call descend,$@)
+	$(Q)mkdir -p $(PERF_O) .
+	$(Q)$(MAKE) --no-print-directory -C perf O=$(PERF_O) subdir=
 
 selftests: FORCE
 	$(call descend,testing/$@)


