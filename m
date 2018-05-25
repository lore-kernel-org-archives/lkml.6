Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967627AbeEYRWE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:22:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39047 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967595AbeEYRV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:21:28 -0400
X-Google-Smtp-Source: AB8JxZrWLPpHy6ArAulKgNALwWbIej1CZbxkjhsfiuGM4htKA2cPxuSLOdhOSxZxVMdS8vws4FCybA==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v3 5/6] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date: Fri, 25 May 2018 19:21:15 +0200
Message-Id: <011bbed9ae9404e2f8939e2bcda459387038089f.1527268727.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <cover.1527268727.git.andreyknvl@google.com>
References: <cover.1527268727.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 2 ++
 lib/strnlen_user.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index b53e1b5d80f4..97467cd2bc59 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -106,6 +106,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	src = untagged_addr(src);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 60d0bbda8f5e..8b5f56466e00 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,6 +108,8 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	str = untagged_addr(str);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
-- 
2.17.0.921.gf22659ad46-goog
