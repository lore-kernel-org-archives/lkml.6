Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237E4C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D244C20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131711;
	bh=F8kbbTYv/ENOPrtVxxxf/ZXpoyZI+cpMFOQ9deOBq2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zwemmdSvaqy0sEU+NFOdz9jj75QtSs9O3TZjYLtOtpZxGgkrwFUwyExbCp55dWfKo
	 aJt4mmZe4F9X6DvZ9OLhqKPsLpH5D0tAsrdqXogE0qG34PXxn3WQx7lgB4TSdaTI5h
	 2O6++33WY1Lx+WS58aDly7YnPsn7czPGjNkGfzFo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D244C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeLFV2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:28:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeLFV20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:28:26 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D28208E7;
        Thu,  6 Dec 2018 21:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131705;
        bh=F8kbbTYv/ENOPrtVxxxf/ZXpoyZI+cpMFOQ9deOBq2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dE0wqtxr5hb1ty0ay1UGTWp4560VwaiesbSY+rysDDvoArVrhY+eguGV0SYn0jJ7M
         /R01VFYNl0DpB18gY7NAnNii6vfwVq7DMQDXdbi3vYtw7NMhCu5WZOiC3dLatO7J77
         eaOURFCBADykIV5zR9/9b+ddqNdHYmi+wYeUiWXs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/75] tools lib traceevent: Added support for pkg-config
Date:   Thu,  6 Dec 2018 18:25:15 -0300
Message-Id: <20181206212602.20474-29-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch implements integration with pkg-config framework.  pkg-config
can be used by the library users to determine required CFLAGS and
LDFLAGS in order to use the library

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154647.022471992@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile                 | 26 ++++++++++++++++---
 .../lib/traceevent/libtraceevent.pc.template  | 10 +++++++
 2 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 tools/lib/traceevent/libtraceevent.pc.template

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 0b4e833088a4..adb16f845ab3 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -25,6 +25,7 @@ endef
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
 $(call allow-override,AR,$(CROSS_COMPILE)ar)
 $(call allow-override,NM,$(CROSS_COMPILE)nm)
+$(call allow-override,PKG_CONFIG,pkg-config)
 
 EXT = -std=gnu99
 INSTALL = install
@@ -47,6 +48,8 @@ prefix ?= /usr/local
 libdir = $(prefix)/$(libdir_relative)
 man_dir = $(prefix)/share/man
 man_dir_SQ = '$(subst ','\'',$(man_dir))'
+pkgconfig_dir ?= $(word 1,$(shell $(PKG_CONFIG) 		\
+			--variable pc_path pkg-config | tr ":" " "))
 
 export man_dir man_dir_SQ INSTALL
 export DESTDIR DESTDIR_SQ
@@ -270,7 +273,19 @@ define do_generate_dynamic_list_file
 	fi
 endef
 
-install_lib: all_cmd install_plugins
+PKG_CONFIG_FILE = libtraceevent.pc
+define do_install_pkgconfig_file
+	if [ -n "${pkgconfig_dir}" ]; then 					\
+		cp -f ${PKG_CONFIG_FILE}.template ${PKG_CONFIG_FILE}; 		\
+		sed -i "s|INSTALL_PREFIX|${1}|g" ${PKG_CONFIG_FILE}; 		\
+		sed -i "s|LIB_VERSION|${EVENT_PARSE_VERSION}|g" ${PKG_CONFIG_FILE}; \
+		$(call do_install,$(PKG_CONFIG_FILE),$(pkgconfig_dir),644); 	\
+	else 									\
+		(echo Failed to locate pkg-config directory) 1>&2;		\
+	fi
+endef
+
+install_lib: all_cmd install_plugins install_pkgconfig
 	$(call QUIET_INSTALL, $(LIB_TARGET)) \
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIB_INSTALL) $(DESTDIR)$(libdir_SQ)
@@ -279,6 +294,10 @@ install_plugins: $(PLUGINS)
 	$(call QUIET_INSTALL, trace_plugins) \
 		$(call do_install_plugins, $(PLUGINS))
 
+install_pkgconfig:
+	$(call QUIET_INSTALL, $(PKG_CONFIG_FILE)) \
+		$(call do_install_pkgconfig_file,$(prefix))
+
 install_headers:
 	$(call QUIET_INSTALL, headers) \
 		$(call do_install,event-parse.h,$(prefix)/include/traceevent,644); \
@@ -289,8 +308,9 @@ install: install_lib
 
 clean:
 	$(call QUIET_CLEAN, libtraceevent) \
-		$(RM) *.o *~ $(TARGETS) *.a *.so $(VERSION_FILES) .*.d .*.cmd \
-		$(RM) TRACEEVENT-CFLAGS tags TAGS
+		$(RM) *.o *~ $(TARGETS) *.a *.so $(VERSION_FILES) .*.d .*.cmd; \
+		$(RM) TRACEEVENT-CFLAGS tags TAGS; \
+		$(RM) $(PKG_CONFIG_FILE)
 
 PHONY += force plugins
 force:
diff --git a/tools/lib/traceevent/libtraceevent.pc.template b/tools/lib/traceevent/libtraceevent.pc.template
new file mode 100644
index 000000000000..42e4d6cb6b9e
--- /dev/null
+++ b/tools/lib/traceevent/libtraceevent.pc.template
@@ -0,0 +1,10 @@
+prefix=INSTALL_PREFIX
+libdir=${prefix}/lib64
+includedir=${prefix}/include/traceevent
+
+Name: libtraceevent
+URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+Description: Linux kernel trace event library
+Version: LIB_VERSION
+Cflags: -I${includedir}
+Libs: -L${libdir} -ltraceevent
-- 
2.19.2

