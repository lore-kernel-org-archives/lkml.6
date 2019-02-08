Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EBBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9365D20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FEfpVoMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfBHUag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:30:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38923 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfBHUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:30:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so3899263edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 12:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UFznljXd4IyrVSxwbopYcGR+HEQgH4TTL29XSymlWw=;
        b=FEfpVoMjhsBIu9wGzcoHFMKCMQ2hdNr32nIKe1eEz7PmVsCpXelZQe05zRXiqbE60Q
         7ojUBd3WsN7HmVl9x3q823CtYheh9y0op3XOz8RWW82esxnGLCtRKBG1TwhXAyYaR4i7
         Q2+eReUPrEcfWripeN1VM3dvwgRvX2CFTvzts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UFznljXd4IyrVSxwbopYcGR+HEQgH4TTL29XSymlWw=;
        b=bsVV7P9xyC/VgV4+YcHNfUCxwhp6hVRG46cv8TDCMhkYbx/Cc6DaV0SifuuooWSz6e
         Kh6A55rrR8oo1N4+z4CpWrfKldcAkj9xTvJb4w7vs8tJYAqLGSua3ULPM38FEM71i3fT
         89s44pRycw1SPrzJe0lg1QA0HtYuSwm6IDMdQWC0nJ2fEQlV3UL9B7iKLHG6CB+DaRVn
         fJSW4VUe8hH8wg+fXMbz4WtHJKbqiu5bcZVZMgepjMcWTRbhSfjKWfOMWboh/FNpBM4u
         jAi0UW4h3wwEAdARFWL5sA/jPod4d3wjydeB4r2uXdzZ29R8b9H8+q9E9FFPJ5Q98AAA
         PCRg==
X-Gm-Message-State: AHQUAuYm2aicfgPOB5EYfF8DJvpJpSHA33qzcyzMHnmKL1gowN8Wyu7V
        x2DlBEhB/1a37nhgtIluLa3LhQ==
X-Google-Smtp-Source: AHgI3IbnG/Av76F9Z7DV+2hqkZ/aYUyXJLI8VO9jcR5YhMkUiV69dr+vCbcV2mt9lso7nGWsigBgCw==
X-Received: by 2002:a17:906:5053:: with SMTP id e19mr17478286ejk.9.1549657823568;
        Fri, 08 Feb 2019 12:30:23 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id p7sm680095ejb.15.2019.02.08.12.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 12:30:23 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 3/3] linux/fs.h: move member alignment check next to definition of struct filename
Date:   Fri,  8 Feb 2019 21:30:15 +0100
Message-Id: <20190208203015.29702-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208203015.29702-1-linux@rasmusvillemoes.dk>
References: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
 <20190208203015.29702-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of doing this compile-time check in some slightly arbitrary
user of struct filename, put it next to the definition.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v2: added, mostly as an example of use of static_assert(), to check
that the compiler actually groks it. Feel free to NAK it as useless
churn.

 fs/namei.c         | 2 --
 include/linux/fs.h | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 914178cdbe94..d604f6b3bcc3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -39,7 +39,6 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
-#include <linux/build_bug.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -131,7 +130,6 @@ getname_flags(const char __user *filename, int flags, int *empty)
 	struct filename *result;
 	char *kname;
 	int len;
-	BUILD_BUG_ON(offsetof(struct filename, iname) % sizeof(long) != 0);
 
 	result = audit_reusename(filename);
 	if (result)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 29d8e2cfed0e..8dce6932e620 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -37,6 +37,8 @@
 #include <linux/uuid.h>
 #include <linux/errseq.h>
 #include <linux/ioprio.h>
+#include <linux/build_bug.h>
+#include <linux/stddef.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -2487,6 +2489,7 @@ struct filename {
 	struct audit_names	*aname;
 	const char		iname[];
 };
+static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);
 
 extern long vfs_truncate(const struct path *, loff_t);
 extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs,
-- 
2.20.1

