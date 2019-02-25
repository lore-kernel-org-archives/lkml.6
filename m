Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D11C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6282146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551103568;
	bh=izGoo4mpmQ1NSvjx+x5em9fJLcDQJIMtSqZj8d05Pps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Onf/l2HJM79w9cij9+tZJfdJs/l59cC50CXFYPUZrKPTdZZvvJ5hTe6FDRyLTUupw
	 JxWToTm1YW6CVrR+rtaEsE+IAdW8OUY+XYEGFZHtxSSGDoeiBn1Vaa2WnLFWHr1lX2
	 hmSo29dQv+Sq7Y9Uqc3KRzS3p8QCnByKVdb3JlWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfBYOGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfBYOGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:06:06 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E950B20663;
        Mon, 25 Feb 2019 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551103564;
        bh=izGoo4mpmQ1NSvjx+x5em9fJLcDQJIMtSqZj8d05Pps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+xv6DNtuA1FBKuSGfA1Q+ShnpaeokS8Hx3nGAenvL+TxJ82mzA4S17fLzPgZ/QeI
         1aaJZFM+eypSWLzy6k7wljOkifjCYoqeWebv8f8Ra4wcG0T8hS3zF0IYom4p/wfiXx
         dUiLe+1gNNHQ5r2vWP5SIL1uLwjuHnEgDLGrYlJc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 2/4] uaccess: Add non-pagefault user-space read functions
Date:   Mon, 25 Feb 2019 23:05:41 +0900
Message-Id: <155110354092.21156.13871336589042178985.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155110348217.21156.3874419272673328527.stgit@devbox>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add probe_user_read() and strncpy_from_unsafe_user() which
will not involves mm_sem so we can use it for accessing
user-space in irq-handler.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/uaccess.h |   13 +++++
 mm/maccess.c            |  134 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 131 insertions(+), 16 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 37b226e8df13..906573b8f02c 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -240,6 +240,17 @@ extern long probe_kernel_read(void *dst, const void *src, size_t size);
 extern long __probe_kernel_read(void *dst, const void *src, size_t size);
 
 /*
+ * probe_user_read(): safely attempt to read from a location in user space
+ * @dst: pointer to the buffer that shall take the data
+ * @src: address to read from
+ * @size: size of the data chunk
+ *
+ * Safely read from address @src to the buffer at @dst.  If a kernel fault
+ * happens, handle that and return -EFAULT.
+ */
+extern long probe_user_read(void *dst, const void __user *src, size_t size);
+
+/*
  * probe_kernel_write(): safely attempt to write to a location
  * @dst: address to write to
  * @src: pointer to the data that shall be written
@@ -252,6 +263,8 @@ extern long notrace probe_kernel_write(void *dst, const void *src, size_t size);
 extern long notrace __probe_kernel_write(void *dst, const void *src, size_t size);
 
 extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
+extern long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
+				     long count);
 
 /**
  * probe_kernel_address(): safely attempt to read from a location
diff --git a/mm/maccess.c b/mm/maccess.c
index 7a9752d59587..7d38d783e0b1 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -5,8 +5,20 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 
+static __always_inline long
+probe_read_common(void *dst, const void __user *src, size_t size)
+{
+	long ret;
+
+	pagefault_disable();
+	ret = __copy_from_user_inatomic(dst, src, size);
+	pagefault_enable();
+
+	return ret ? -EFAULT : 0;
+}
+
 /**
- * probe_kernel_read(): safely attempt to read from a location
+ * probe_kernel_read(): safely attempt to read from a kernel-space location
  * @dst: pointer to the buffer that shall take the data
  * @src: address to read from
  * @size: size of the data chunk
@@ -30,18 +42,53 @@ long __probe_kernel_read(void *dst, const void *src, size_t size)
 
 	set_fs(KERNEL_DS);
 	current->kernel_uaccess_faults_ok++;
-	pagefault_disable();
-	ret = __copy_from_user_inatomic(dst,
-			(__force const void __user *)src, size);
-	pagefault_enable();
+	ret = probe_read_common(dst, (__force const void __user *)src, size);
 	current->kernel_uaccess_faults_ok--;
 	set_fs(old_fs);
 
-	return ret ? -EFAULT : 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(probe_kernel_read);
 
 /**
+ * probe_user_read(): safely attempt to read from a user-space location
+ * @dst: pointer to the buffer that shall take the data
+ * @src: address to read from. This must be a user address.
+ * @size: size of the data chunk
+ *
+ * Safely read from user address @src to the buffer at @dst. If a kernel fault
+ * happens, handle that and return -EFAULT.
+ */
+
+long __weak probe_user_read(void *dst, const void __user *src, size_t size)
+    __attribute__((alias("__probe_user_read")));
+
+static long __normal_probe_user_read(void *dst, const void __user *src,
+				     size_t size)
+{
+	if (!access_ok(src, size))
+		return -EFAULT;
+
+	return probe_read_common(dst, src, size);
+}
+
+long __probe_user_read(void *dst, const void __user *src, size_t size)
+{
+	long ret;
+	mm_segment_t old_fs = get_fs();
+
+	if (segment_eq(old_fs, USER_DS)) {
+		ret = __normal_probe_user_read(dst, src, size);
+	} else {
+		set_fs(USER_DS);
+		ret = __normal_probe_user_read(dst, src, size);
+		set_fs(old_fs);
+	}
+	return ret ? -EFAULT : 0;
+}
+EXPORT_SYMBOL_GPL(probe_user_read);
+
+/**
  * probe_kernel_write(): safely attempt to write to a location
  * @dst: address to write to
  * @src: pointer to the data that shall be written
@@ -70,6 +117,22 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
 }
 EXPORT_SYMBOL_GPL(probe_kernel_write);
 
+
+static __always_inline long strncpy_from_unsafe_common(char *dst,
+				const char __user *unsafe_addr, long count)
+{
+	const char __user *src = unsafe_addr;
+	int ret;
+
+	pagefault_disable();
+	do {
+		ret = __get_user(*dst++, src++);
+	} while (dst[-1] && ret == 0 && src - unsafe_addr < count);
+	dst[-1] = '\0';
+	pagefault_enable();
+
+	return ret ? -EFAULT : src - unsafe_addr;
+}
 /**
  * strncpy_from_unsafe: - Copy a NUL terminated string from unsafe address.
  * @dst:   Destination address, in kernel space.  This buffer must be at
@@ -90,7 +153,6 @@ EXPORT_SYMBOL_GPL(probe_kernel_write);
 long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
 {
 	mm_segment_t old_fs = get_fs();
-	const void *src = unsafe_addr;
 	long ret;
 
 	if (unlikely(count <= 0))
@@ -98,16 +160,56 @@ long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
 
 	set_fs(KERNEL_DS);
 	current->kernel_uaccess_faults_ok++;
-	pagefault_disable();
-
-	do {
-		ret = __get_user(*dst++, (const char __user __force *)src++);
-	} while (dst[-1] && ret == 0 && src - unsafe_addr < count);
-
-	dst[-1] = '\0';
-	pagefault_enable();
+	ret = strncpy_from_unsafe_common(dst,
+			(const char __user __force *)unsafe_addr, count);
 	current->kernel_uaccess_faults_ok--;
 	set_fs(old_fs);
 
-	return ret ? -EFAULT : src - unsafe_addr;
+	return ret;
+}
+
+static __always_inline long __strncpy_from_unsafe_user(char *dst,
+			 const char __user *unsafe_addr, long count)
+{
+	if (!access_ok(unsafe_addr, count))
+		return -EFAULT;
+
+	return strncpy_from_unsafe_common(dst, unsafe_addr, count);
+}
+
+/**
+ * strncpy_from_unsafe_user: - Copy a NUL terminated string from unsafe user
+ *				address.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @unsafe_addr: Unsafe user address.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ *
+ * Copies a NUL-terminated string from unsafe user address to kernel buffer.
+ *
+ * On success, returns the length of the string INCLUDING the trailing NUL.
+ *
+ * If access fails, returns -EFAULT (some data may have been copied
+ * and the trailing NUL added).
+ *
+ * If @count is smaller than the length of the string, copies @count-1 bytes,
+ * sets the last byte of @dst buffer to NUL and returns @count.
+ */
+long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
+			      long count)
+{
+	mm_segment_t old_fs = get_fs();
+	long ret;
+
+	if (unlikely(count <= 0))
+		return 0;
+
+	if (segment_eq(old_fs, USER_DS)) {
+		ret = __strncpy_from_unsafe_user(dst, unsafe_addr, count);
+	} else {
+		set_fs(USER_DS);
+		ret = __strncpy_from_unsafe_user(dst, unsafe_addr, count);
+		set_fs(old_fs);
+	}
+	return ret;
 }

