Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0364C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906BA20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Co3V1O2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfAaT27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37653 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbfAaT24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so1938510pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s01BexUIwWPAOZc8ULyS2OIx258H75BSpCIC9WlFXeA=;
        b=Co3V1O2wLJokDkFdLVsjREI0nao2Jg7jlHpj2lNY+2lrpHZRzNneoqScxkhcIpLze5
         8S7D+RePNeJ29sqQDnQbf7k4atEUy6m58s/U+MttCo8N5HwI4Wir5FMsTfYD8Q4YcON4
         JPocWAj6c1SizKDGsVfD4L5MMLc91rT/EnQkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s01BexUIwWPAOZc8ULyS2OIx258H75BSpCIC9WlFXeA=;
        b=LEoH4Mq/GnB40C+eLyFNao5gaukLI+jDKT0Rx1SIqryCD0wWI56JsGZv+pLPVz7PFv
         RAUdE/uvahH9A5WBxUirFlYhSDI/xjQAXKMFZ9hf2nGn5kWpyP9vVCt8T4h9CRRHNIVq
         Zv4LqkACKZG9CYB/nGtXnHLMjV+XtiTfDu5y/Rn+/yiiReEweOGHtdTASCVxw/r9EWNS
         dD4p9x2AN/E6UQPTPN270JUBgOcHG5NyQasJoQR1ur/SZhC4c+AQZrptNxGoUkdBnhbv
         awDPVirivvmZtwd6VYvM0nzo0SIxuqUyodVK3l+ZT0K23LrEFrS7ukOsxaBTa71WEdsX
         aTOA==
X-Gm-Message-State: AJcUukec+Ek9/4CKCcf73q9Hkem8VpfgwyTc2YWDvuDTu3J5G2x1Cmey
        iunz4PcJ3tPITC4gpSIYmVD5yQ==
X-Google-Smtp-Source: ALg8bN6cmIR/qbhV/Uq/U9H2S0j+DXRELuumBvMvyw891Bchw+ZY/JtGEi73minvNQOLad44JyJxUA==
X-Received: by 2002:a62:7042:: with SMTP id l63mr37555534pfc.89.1548962935607;
        Thu, 31 Jan 2019 11:28:55 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:55 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Garnier <thgarnie@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Michael Forney <forney@google.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 16/27] compiler: Option to add PROVIDE_HIDDEN replacement for weak symbols
Date:   Thu, 31 Jan 2019 11:24:23 -0800
Message-Id: <20190131192533.34130-17-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an option to have a PROVIDE_HIDDEN (linker script) entry for
each weak symbol. This option solves an error in x86_64 where the linker
optimizes PIE generated code to be non-PIE because --emit-relocs was used
instead of -pie (to reduce dynamic relocations).

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 init/Kconfig            |  7 +++++++
 scripts/link-vmlinux.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 116e0de4817f..2261c9891631 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2104,6 +2104,13 @@ config ASN1
 	  inform it as to what tags are to be expected in a stream and what
 	  functions to call on what tags.
 
+config WEAK_PROVIDE_HIDDEN
+	bool
+	help
+	  Generate linker script PROVIDE_HIDDEN entries for all weak symbols. It
+	  allows to prevent non-PIE code being replaced by the linker if the
+	  emit-relocs option is used instead of PIE (useful for x86_64 PIE).
+
 source "kernel/Kconfig.locks"
 
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index bc7f1fc1f55b..abf44a804c79 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -119,6 +119,17 @@ kallsyms()
 	${CC} ${aflags} -c -o ${2} ${afile}
 }
 
+gen_weak_provide_hidden()
+{
+        if [ -n "${CONFIG_WEAK_PROVIDE_HIDDEN}" ]; then
+                local pattern="s/^\s\+ w \(\w\+\)$/PROVIDE_HIDDEN(\1 = .);/gp"
+                echo -e "SECTIONS {\n. = _end;" > .tmp_vmlinux_hiddenld
+                ${NM} ${1} | sed -n "${pattern}" >> .tmp_vmlinux_hiddenld
+                echo "}" >> .tmp_vmlinux_hiddenld
+                LDFLAGS_vmlinux="${LDFLAGS_vmlinux} -T .tmp_vmlinux_hiddenld"
+        fi
+}
+
 # Create map file with all symbols from ${1}
 # See mksymap for additional details
 mksysmap()
@@ -200,6 +211,9 @@ modpost_link vmlinux.o
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
 
+# Generate weak linker script
+gen_weak_provide_hidden vmlinux.o
+
 kallsymso=""
 kallsyms_vmlinux=""
 if [ -n "${CONFIG_KALLSYMS}" ]; then
-- 
2.20.1.495.gaa96b0ce6b-goog

