Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbeDPGl7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:41:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbeDPGl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:41:57 -0400
Date: Sun, 15 Apr 2018 23:41:33 -0700
From: tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-4d3b57da1593c66835d8e3a757e4751b35493fb8@git.kernel.org>
Cc: acme@redhat.com, lizhijian@cn.fujitsu.com, mingo@kernel.org,
        mark.rutland@arm.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, sandipan@linux.vnet.ibm.com
Reply-To: tglx@linutronix.de, mark.rutland@arm.com, lizhijian@cn.fujitsu.com,
        mingo@kernel.org, acme@redhat.com, sandipan@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20180404163445.16492-1-mark.rutland@arm.com>
References: <20180404163445.16492-1-mark.rutland@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers: Restore READ_ONCE() C++
 compatibility
Git-Commit-ID: 4d3b57da1593c66835d8e3a757e4751b35493fb8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4d3b57da1593c66835d8e3a757e4751b35493fb8
Gitweb:     https://git.kernel.org/tip/4d3b57da1593c66835d8e3a757e4751b35493fb8
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 4 Apr 2018 17:34:45 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 09:30:09 -0300

tools headers: Restore READ_ONCE() C++ compatibility

Our userspace <linux/compiler.h> defines READ_ONCE() in a way that clang
doesn't like, as we have an anonymous union in which neither field is
initialized.

WRITE_ONCE() is fine since it initializes the __val field. For
READ_ONCE() we can keep clang and GCC happy with a dummy initialization
of the __c field, so let's do that.

At the same time, let's split READ_ONCE() and WRITE_ONCE() over several
lines for legibility, as we do in the in-kernel <linux/compiler.h>.

Reported-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reported-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Tested-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 6aa7de059173a986 ("locking/atomics: COCCINELLE/treewide: Convert trivial ACCESS_ONCE() patterns to READ_ONCE()/WRITE_ONCE()")
Link: http://lkml.kernel.org/r/20180404163445.16492-1-mark.rutland@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/compiler.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 04e32f965ad7..1827c2f973f9 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -151,11 +151,21 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
  * required ordering.
  */
 
-#define READ_ONCE(x) \
-	({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
-
-#define WRITE_ONCE(x, val) \
-	({ union { typeof(x) __val; char __c[1]; } __u = { .__val = (val) }; __write_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
+#define READ_ONCE(x)					\
+({							\
+	union { typeof(x) __val; char __c[1]; } __u =	\
+		{ .__c = { 0 } };			\
+	__read_once_size(&(x), __u.__c, sizeof(x));	\
+	__u.__val;					\
+})
+
+#define WRITE_ONCE(x, val)				\
+({							\
+	union { typeof(x) __val; char __c[1]; } __u =	\
+		{ .__val = (val) }; 			\
+	__write_once_size(&(x), __u.__c, sizeof(x));	\
+	__u.__val;					\
+})
 
 
 #ifndef __fallthrough
