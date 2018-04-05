Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeDEPTF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:19:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751638AbeDEPRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:17:02 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4/9] kbuild: Add filechk2 function
Date: Thu,  5 Apr 2018 17:16:40 +0200
Message-Id: <20180405151645.19130-5-jolsa@kernel.org>
In-Reply-To: <20180405151645.19130-1-jolsa@kernel.org>
References: <20180405151645.19130-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding filechk2 function  that has the same semantics
as filechk, but it takes the target file from the 2nd
argument instead of from the '$@' as in the filechk
function.

This function is needed when we can't have separate
target for the file, like in the following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 scripts/Kbuild.include | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 065324a8046f..9775ce2771d4 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -67,6 +67,30 @@ define filechk
 	fi
 endef
 
+# filechk2 is used to check if the content of a generated file is updated.
+# It follows the same logic as the filechk except instead of the $@ target
+# variable, the checked file is passed in 2nd argument.
+#
+# Sample usage:
+# define filechk_sample
+#	echo $KERNELRELEASE
+# endef
+# version.h : Makefile
+#	$(call filechk2,sample,version.h)
+# endef
+define filechk2
+	$(Q)set -e;					\
+	$(kecho) '  CHK     $(2)';			\
+	mkdir -p $(dir $(2));				\
+	$(filechk_$(1)) < $< > $(2).tmp;		\
+	if [ -r $(2) ] && cmp -s $(2) $(2).tmp; then	\
+		rm -f $(2).tmp;				\
+	else						\
+		$(kecho) '  UPD     $(2)';		\
+		mv -f $(2).tmp $(2);			\
+	fi
+endef
+
 ######
 # gcc support functions
 # See documentation in Documentation/kbuild/makefiles.txt
-- 
2.13.6
