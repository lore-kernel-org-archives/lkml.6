Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818E7C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CEB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CEB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJPW6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPW6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:58:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3F5F3B3C1;
        Tue, 16 Oct 2018 15:07:11 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFC795890E;
        Tue, 16 Oct 2018 15:06:52 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCH 04/10] tools cpupower: Override CFLAGS assignments
Date:   Tue, 16 Oct 2018 17:06:09 +0200
Message-Id: <20181016150614.21260-5-jolsa@kernel.org>
In-Reply-To: <20181016150614.21260-1-jolsa@kernel.org>
References: <20181016150614.21260-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 16 Oct 2018 15:07:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So user could specify outside CFLAGS values.

Cc: Thomas Renninger <trenn@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/power/cpupower/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 1dd5f4fcffd5..db66a952c173 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -129,7 +129,7 @@ WARNINGS += $(call cc-supports,-Wno-pointer-sign)
 WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
 WARNINGS += -Wshadow
 
-CFLAGS += -DVERSION=\"$(VERSION)\" -DPACKAGE=\"$(PACKAGE)\" \
+override CFLAGS += -DVERSION=\"$(VERSION)\" -DPACKAGE=\"$(PACKAGE)\" \
 		-DPACKAGE_BUGREPORT=\"$(PACKAGE_BUGREPORT)\" -D_GNU_SOURCE
 
 UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
@@ -156,12 +156,12 @@ LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c
 LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o
 LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
 
-CFLAGS +=	-pipe
+override CFLAGS +=	-pipe
 
 ifeq ($(strip $(NLS)),true)
 	INSTALL_NLS += install-gmo
 	COMPILE_NLS += create-gmo
-	CFLAGS += -DNLS
+	override CFLAGS += -DNLS
 endif
 
 ifeq ($(strip $(CPUFREQ_BENCH)),true)
@@ -175,7 +175,7 @@ ifeq ($(strip $(STATIC)),true)
         UTIL_SRC += $(LIB_SRC)
 endif
 
-CFLAGS += $(WARNINGS)
+override CFLAGS += $(WARNINGS)
 
 ifeq ($(strip $(V)),false)
 	QUIET=@
@@ -188,10 +188,10 @@ export QUIET ECHO
 
 # if DEBUG is enabled, then we do not strip or optimize
 ifeq ($(strip $(DEBUG)),true)
-	CFLAGS += -O1 -g -DDEBUG
+	override CFLAGS += -O1 -g -DDEBUG
 	STRIPCMD = /bin/true -Since_we_are_debugging
 else
-	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
+	override CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
 	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
 endif
 
-- 
2.17.2

