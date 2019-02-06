Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1830FC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD56F218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ErP5Hen9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfBFALf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36764 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfBFALe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:34 -0500
Received: by mail-ed1-f67.google.com with SMTP id d12so3445294edy.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6FQqHa1rlbDWsBMTo823W1nruhzQX7vLOJJT+3cw68=;
        b=ErP5Hen9uv1OAdWFBTRyNOmk9xRjmo9xQwvJ6VKb1rRJgz1xwkeDS7MSLs+2fQKiVU
         pC4fn7aNJ8WBMCSuIO4jHHXHMmAGlSqtH5pK651kcyI1NQmaBSYcX7Pr/17f+vPfsxr6
         Bf7bqULDg/nimG8jwpXkMnXFeykqbm08nbWEqCYUnEdkHcWqX1I9RgDC1ia+bIwwDMIB
         5KU1rYOmz7zKWYmrw/Ug37+VZxMPDcUuf7Yyazro8IDD4YLAbSjbnvvTplRcGzzSOtOd
         8j1EJChawpT0WulWgwZ6gFGAz5Zyl1fVjNNP3jRd5nYKdqR1EO+MTmCvz2oZSNtMwYz/
         OTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6FQqHa1rlbDWsBMTo823W1nruhzQX7vLOJJT+3cw68=;
        b=eGU7xUAcBAi/EAVP7ipshxGkj054v7qpdVehPROrtsI778BsD937BoenqCci1V1VyI
         U3tHoO+a2bW559fsBjEhAs4OLUEIQMNbslQIsmxKICZ5Flmbx5EAJTQ6hX9MAUaD8H+j
         kI3Wa27lGRmzz8vaKeDxTcOYOytqkosHqkpTjlEJ0VZj9gs7X2qkQhk2luPprfslYBsn
         sAUuXdNXUyGMj2kTYVtmefk7ueVXj/TXlJMy1pUPN1beDqh+yh8eSCfz3Yq0gqgeDktz
         KyZy5LSOtZamghjvc/Jsb/8ZH7envSA0hq8RkCH1MjsHeGYI9KwN8vxslMPW7hotSV34
         ly3w==
X-Gm-Message-State: AHQUAuaiFu6LCXoaZcyRchVIiLUXjkhqN3Dl6OxR+bYHbU7I3iga8S8Y
        ZCm6NqXy+izGKXY6sdgNZt7x2qh8CKA=
X-Google-Smtp-Source: AHgI3IZ1/ikPZs7NO6GoFnpodaqdvBVjS+afDXgEyQNQD+jMZgnndHBMpUEMX9ycnkjpEJrlxyOpyg==
X-Received: by 2002:a50:8d8c:: with SMTP id r12mr5897141edh.105.1549411891262;
        Tue, 05 Feb 2019 16:11:31 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:30 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 16/32] x86/vdso: Generate vdso{,32}-timens.lds
Date:   Wed,  6 Feb 2019 00:10:50 +0000
Message-Id: <20190206001107.16488-17-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.
It will add a penalty for everybody as branch predictor may mispredict
the jump. Also there are instruction cache lines wasted on cmp/jmp.

Those effects of introducing time namespace are very much unwanted
having in mind how much work have been spent on micro-optimisation
vdso code.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

Unfortunately, to allow changing VDSO VMA on a running process,
the entry points to VDSO should have the same offsets (addresses).
That's needed as i.e. application that calls setns() may have already
resolved VDSO symbols in GOT/PLT.

Provide two linker scripts:
- *-timens.lds for building VDSO for processes inside time namespace
  (it has bigger functions and needs to build firstly)
- *.lds for host processes VDSO
  (it has smaller functions and entry addresses should be adjusted
  with the linker script magic to fit with entries from timens)

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/.gitignore                 |  1 +
 arch/x86/entry/vdso/Makefile                   | 18 ++++++++++++++----
 arch/x86/entry/vdso/vdso-timens.lds.S          |  7 +++++++
 arch/x86/entry/vdso/vdso32/.gitignore          |  1 +
 arch/x86/entry/vdso/vdso32/vdso32-timens.lds.S |  8 ++++++++
 5 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vdso-timens.lds.S
 create mode 100644 arch/x86/entry/vdso/vdso32/vdso32-timens.lds.S

diff --git a/arch/x86/entry/vdso/.gitignore b/arch/x86/entry/vdso/.gitignore
index 9ab4fa4c7e7b..aaddf8f2171c 100644
--- a/arch/x86/entry/vdso/.gitignore
+++ b/arch/x86/entry/vdso/.gitignore
@@ -1,4 +1,5 @@
 vdso.lds
+vdso-timens.lds
 vdsox32.lds
 vdso32-syscall-syms.lds
 vdso32-sysenter-syms.lds
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index ccb572831ea1..4e1659619e7e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -44,11 +44,14 @@ vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
 vobjs-timens := $(foreach F,$(vobjs-timens-y),$(obj)/$F)
 vobjs32-timens := $(foreach F,$(vobjs32-timens-y),$(obj)/$F)
+dep-vdso.lds-$(CONFIG_TIME_NS) += $(obj)/vdso-image-64-timens.c
+dep-vdso32.lds-$(CONFIG_TIME_NS) += $(obj)/vdso-image-32-timens.c
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.lds $(vobjs-y) $(vobjs-timens-y) vdso64.entries
 targets += vdso32/vdso32.lds $(vobjs32-y) $(vobjs32-timens-y) vdso32.entries
+targets += vdso-timens.lds vdso32/vdso32-timens.lds
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
@@ -59,11 +62,13 @@ targets += $(vdso_img_cfiles)
 targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
 CPPFLAGS_vdso.lds += -P -C
+CPPFLAGS_vdso-timens.lds := $(CPPFLAGS_vdso.lds)
 
 VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
 			-z max-page-size=4096
+VDSO_LDFLAGS_vdso-timens.lds := $(VDSO_LDFLAGS_vdso.lds)
 
-$(obj)/vdso64-timens.so.dbg: $(obj)/vdso.lds $(vobjs-timens) FORCE
+$(obj)/vdso64-timens.so.dbg: $(obj)/vdso-timens.lds $(vobjs-timens) FORCE
 	$(call if_changed,vdso)
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
@@ -79,6 +84,9 @@ quiet_cmd_vdso2c = VDSO2C  $@
 $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 	$(call if_changed,vdso2c)
 
+$(obj)/vdso.lds: $(dep-vdso.lds-y) $(obj)/vdso2c FORCE
+$(obj)/vdso32/vdso32.lds: $(dep-vdso32.lds-y) $(obj)/vdso2c FORCE
+
 #
 # Don't omit frame pointers for ease of userspace debugging, but do
 # optimize sibling calls.
@@ -142,8 +150,10 @@ $(obj)/%.so: $(obj)/%.so.dbg
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
 
-CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
+CPPFLAGS_vdso32.lds := $(CPPFLAGS_vdso.lds)
+CPPFLAGS_vdso32-timens.lds := $(CPPFLAGS_vdso32.lds)
+VDSO_LDFLAGS_vdso32.lds := -m elf_i386 -soname linux-gate.so.1
+VDSO_LDFLAGS_vdso32-timens.lds := $(VDSO_LDFLAGS_vdso32.lds)
 
 KBUILD_AFLAGS_32 := $(filter-out -m64,$(KBUILD_AFLAGS)) -DBUILD_VDSO
 $(obj)/vdso32.so.dbg: KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
@@ -172,7 +182,7 @@ endif
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 $(obj)/vdso32-timens.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
-$(obj)/vdso32-timens.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32-timens) FORCE
+$(obj)/vdso32-timens.so.dbg: $(obj)/vdso32/vdso32-timens.lds $(vobjs32-timens) FORCE
 	$(call if_changed,vdso)
 
 $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
diff --git a/arch/x86/entry/vdso/vdso-timens.lds.S b/arch/x86/entry/vdso/vdso-timens.lds.S
new file mode 100644
index 000000000000..687aba3bc5f0
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso-timens.lds.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linker script for 64-bit timens vDSO.
+ */
+
+#define UNALIGNED_ENTRIES
+#include "vdso.lds.S"
diff --git a/arch/x86/entry/vdso/vdso32/.gitignore b/arch/x86/entry/vdso/vdso32/.gitignore
index e45fba9d0ced..ce4afb6ffb62 100644
--- a/arch/x86/entry/vdso/vdso32/.gitignore
+++ b/arch/x86/entry/vdso/vdso32/.gitignore
@@ -1 +1,2 @@
 vdso32.lds
+vdso32-timens.lds
diff --git a/arch/x86/entry/vdso/vdso32/vdso32-timens.lds.S b/arch/x86/entry/vdso/vdso32/vdso32-timens.lds.S
new file mode 100644
index 000000000000..1a3b3b1f0517
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso32/vdso32-timens.lds.S
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linker script for 32-bit timens vDSO.
+ */
+
+#define UNALIGNED_ENTRIES
+
+#include "vdso32.lds.S"
-- 
2.20.1

