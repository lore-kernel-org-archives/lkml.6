Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6386C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD80218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfAYKn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:43:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38980 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAYKn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:43:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so6127259wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:43:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ysw7qcpcpXJqj/fVVnqWj+2HJIBnzUESfn/MhQ+DQc=;
        b=YR31d/E6vqeSZfAhwjEQu5nsnZ2NtUxEQkMfWE7glFAX6vsqNXCNoCSzLuwCge+wXT
         a4yjoftval7F8ryCBNwLnXkGk7+i821LTJ37YAa/3EEQgiZBAK2nfN98rmYG0AvNoC2x
         b2t2E1aMl0Nessq9CQh8i6XmYBIczZOf5HsQ4U+L/wCuPBzJoP/hj01p//quqqWf13hM
         vr4OVqWcEYv7gwZktzpUPdGubW6/T+joxryj9AH/wodzNqx1MoSmpbzrVxaUuJpatBT0
         e8VcOieQSJzpeVgxHz+ZcEZNKlo6CwXh/MAnMLxL+o0GmFjNeD+N89gi0kASnECOS1nE
         OFpg==
X-Gm-Message-State: AJcUukfpKc+czk9H9KnxAX9OyhJdwmqGqQUlJKKIosZZ7FZrzZgrtZyg
        xux0CQhH3yYgx9d6+ID9NuBKng==
X-Google-Smtp-Source: ALg8bN5dyN1Ey8S6ExLP7S5HXirj+S9AMn8Qo/aMTRrkVlDm6aRW55E5GxVts7p9OGWcI2iDWwG+xQ==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr6176873wme.119.1548413036727;
        Fri, 25 Jan 2019 02:43:56 -0800 (PST)
Received: from labbott-redhat.redhat.com (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id 127sm117953457wmm.45.2019.01.25.02.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 02:43:55 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Update -Wattribute-alias for gcc9
Date:   Fri, 25 Jan 2019 11:43:53 +0100
Message-Id: <20190125104353.2791-1-labbott@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bee20031772a ("disable -Wattribute-alias warning for
SYSCALL_DEFINEx()") disabled -Wattribute-alias with gcc8.
gcc9 changed the format of -Wattribute-alias to take a parameter.
This doesn't quite match with the existing disabling mechanism
so update for gcc9 to match with the default (-Wattribute-alias=1).

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
This is RFC because it feels ugly. I went ahead and did the obvious fixup
but it's worth discussing if we're going to end up with an explosion or
if there's a better way to handle this in one macro.
---
 include/linux/compat.h       | 2 ++
 include/linux/compiler-gcc.h | 7 ++++++-
 include/linux/syscalls.h     | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 056be0d03722..d5d7700f26a6 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -75,6 +75,8 @@
 	__diag_push();								\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
 		      "Type aliasing is used to sanitize syscall arguments");\
+	__diag_ignore(GCC, 9, "-Wattribute-alias=1",				\
+		      "Type aliasing is used to sanitize syscall arguments");\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e8579412ad21..75079668344c 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -165,8 +165,13 @@
 #define __diag_str(s)		__diag_str1(s)
 #define __diag(s)		_Pragma(__diag_str(GCC diagnostic s))
 
-#if GCC_VERSION >= 80000
+#if GCC_VERSION >= 90000
+#define __diag_GCC_8(s)
+#define __diag_GCC_9(s)		__diag(s)
+#elif GCC_VERSION >= 80000
 #define __diag_GCC_8(s)		__diag(s)
+#define __diag_GCC_9(s)
 #else
 #define __diag_GCC_8(s)
+#define __diag_GCC_9(s)
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 257cccba3062..a08059e1ccf4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -236,6 +236,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	__diag_push();							\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
 		      "Type aliasing is used to sanitize syscall arguments");\
+	__diag_ignore(GCC, 9, "-Wattribute-alias=1",			\
+		      "Type aliasing is used to sanitize syscall arguments");\
 	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_sys##name))));	\
 	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
-- 
2.20.1

