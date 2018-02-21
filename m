Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeBUCsK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 21:48:10 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36671 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeBUCsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 21:48:07 -0500
X-Google-Smtp-Source: AH8x226cSTuMZM4j1ArxPzZiNiU2iXVJHoKSBYqf/rWq2mL+uCbE/03+JTsEzFOocF8vI4Gdj9HEAQ==
From: Tycho Andersen <tycho@tycho.ws>
To: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc: Tycho Andersen <tycho@tycho.ws>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 1/3] seccomp, ptrace: switch get_metadata types to arch independent
Date: Tue, 20 Feb 2018 19:47:45 -0700
Message-Id: <20180221024747.9659-2-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180221024747.9659-1-tycho@tycho.ws>
References: <20180221024747.9659-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 26500475ac1b ("ptrace, seccomp: add support for retrieving seccomp
metadata") introduced `struct seccomp_metadata`, which contained unsigned
longs that should be arch independent. The type of the flags member was
chosen to match the corresponding argument to seccomp(), and so we need
something at least as big as unsigned long. My understanding is that __u64
should fit the bill, so let's switch both types to that.

While this is userspace facing, it was only introduced in 4.16-rc2, and so
should be safe assuming it goes in before then.

Reported-by: "Dmitry V. Levin" <ldv@altlinux.org>
Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Oleg Nesterov <oleg@redhat.com>
---
 include/uapi/linux/ptrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index e46d82b91166..d5a1b8a492b9 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -69,8 +69,8 @@ struct ptrace_peeksiginfo_args {
 #define PTRACE_SECCOMP_GET_METADATA	0x420d
 
 struct seccomp_metadata {
-	unsigned long filter_off;	/* Input: which filter */
-	unsigned int flags;		/* Output: filter's flags */
+	__u64 filter_off;	/* Input: which filter */
+	__u64 flags;		/* Output: filter's flags */
 };
 
 /* Read signals from a shared (process wide) queue */
-- 
2.14.1
