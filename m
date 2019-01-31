Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA83FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DEC20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HQJftAgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfAaT3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:29:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38601 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfAaT32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:29:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so1925809plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03DhW08PwxDx+7CmSkXN5WrsmPi3V0p8jn7ZS9qbpus=;
        b=HQJftAgRaIad59USuyr99kBPfPoB5b/JxHSle6f3rJNLkUcnSjE/ZuAjyGJSaGcn3w
         V55k6m0AAvyzZIki/ywG+U5YQ5mJlGJGZK4gGuUKKsOVn8f+gwoBBNH7TC5lIJC7ENSQ
         ZNeBhS/Yc7ScR1O39zyJqIlRYi0HLUeToxxFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03DhW08PwxDx+7CmSkXN5WrsmPi3V0p8jn7ZS9qbpus=;
        b=cyPUaMcMimmneyLp/00kb+JiMTcV/vOuXHkEK/k4q546aGVDqZai/CA20L6VenSOla
         J7eYzXalyQyeF2M2wWej+kzbxiwPyt3ZiAGST8RnlwYwiLvrPkhy5XkXKi5ipYQYgu6g
         28IP73CPtxn2ujkiLYdL+7sXlRvlXB7BlVdPgqJCg/giLXAlbb3cYzzZY4cHwIr4PCSN
         l87RWi7sYSFqe1c83adMZ28h/d3dGEYPtx3N0YMgVok+OylHAQJYhutjKvUcVP3AUlcs
         ZPyXnAdk7SQA5C56W5TjqIxVUAXowwntL/bvlYhAFZi9d9dY4kOyKOJLwIna1ROvXIEn
         XL8A==
X-Gm-Message-State: AJcUukdgXF405i802yFgXRG+4KQhntTEapY1efO9Ao5SduNnQEoKmnUh
        cp6V2SyyJnNS8WIbRqXH9Lg4Yg==
X-Google-Smtp-Source: ALg8bN7Ztpo3TLep7OYRNosLM7wVxDj/Tp40mg/F+sUt1G+EPB0aZ3tpSUGCksvWzGcW1gHuy+Sc1A==
X-Received: by 2002:a17:902:8641:: with SMTP id y1mr36000898plt.159.1548962968064;
        Thu, 31 Jan 2019 11:29:28 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:29:27 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 24/27] x86/mm: Make the x86 GOT read-only
Date:   Thu, 31 Jan 2019 11:24:31 -0800
Message-Id: <20190131192533.34130-25-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GOT is changed during early boot when relocations are applied. Make
it read-only directly. This table exists only for PIE binary.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d7a6a9c2370..0a038594c878 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -323,6 +323,17 @@
 	__end_ro_after_init = .;
 #endif
 
+#ifdef CONFIG_X86_PIE
+#define RO_GOT_X86							\
+	.got        : AT(ADDR(.got) - LOAD_OFFSET) {			\
+		__start_got = .;					\
+		*(.got);						\
+		__end_got = .;						\
+	}
+#else
+#define RO_GOT_X86
+#endif
+
 /*
  * Read only Data
  */
@@ -379,6 +390,7 @@
 		__end_builtin_fw = .;					\
 	}								\
 									\
+	RO_GOT_X86							\
 	TRACEDATA							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
-- 
2.20.1.495.gaa96b0ce6b-goog

