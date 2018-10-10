Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BE7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F523214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F523214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeJJRgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:36:36 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64224 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeJJRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:36:35 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9AAF50e048466;
        Wed, 10 Oct 2018 19:15:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 10 Oct 2018 19:15:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9AAF0Pw048308
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 10 Oct 2018 19:15:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
 <20181001023721.GA6409@jagdpanzerIV>
 <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
 <20181002063851.GF598@jagdpanzerIV>
 <5a958a1b-a986-014a-5908-816e0a3ef4ff@i-love.sakura.ne.jp>
 <20181008160310.ldwryudzkvp5de3b@pathway.suse.cz>
 <3ce1695b-9c47-40cc-602b-7c5ffb593024@i-love.sakura.ne.jp>
 <20181009145229.3lv5vl2ypz5i45cq@pathway.suse.cz>
 <a4a2ecae-3c47-db1f-8124-4d2d0ab8b91c@i-love.sakura.ne.jp>
Message-ID: <d3e76073-c896-5807-1a2d-fe320643617d@i-love.sakura.ne.jp>
Date:   Wed, 10 Oct 2018 19:14:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a4a2ecae-3c47-db1f-8124-4d2d0ab8b91c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/10 6:19, Tetsuo Handa wrote:
> Do you think that adding cmpxchg() & retry logic to this API generates better
> result than simple fallback? buffered_printk() does not add a new locking dependency
> is a good point of this API. Showing the backtrace (by enabling a debug kernel config
> option for this API) will be sufficient.
> 

This is an idea for reporting out of buffers event. I would add a kernel config
option for whether to report that event. Maybe I should offload the reporting
to a workqueue context, for reporting from get_printk_context() requires that
get_printk_context() callers have to be printk()-safe, and
get_printk_context() callers might be already in vprintk_safe()/vprintk_nmi()
context even if it is possible to call printk().

 include/linux/printk.h |  71 +++++++++++++++++
 kernel/printk/printk.c | 201 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 272 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccf..bcccf1f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -173,6 +173,36 @@ int printk_emit(int facility, int level,
 
 asmlinkage __printf(1, 2) __cold
 int printk(const char *fmt, ...);
+/*
+ * A structure for line-buffering printk() output.
+ */
+struct printk_buffer {
+	unsigned short int used; /* Valid bytes in buf[]. */
+	char buf[1024 - 32]; /* This is LOG_LINE_MAX bytes. */
+};
+/*
+ * A macro for allowing "struct printk_buffer" on stack or in .bss section.
+ *
+ * You can use this macro for allocation on stack only when you are sure that
+ * that location is never tight about stack usage, for e.g. interrupt might
+ * consume some stack from that location. You can use this macro for allocation
+ * in .bss section only when you are sure that access to this variable is
+ * appropriately serialized, for concurrent access to this variable can lead to
+ * memory corruption.
+ *
+ * If you are not sure, you should use get_printk_buffer()/put_printk_buffer()
+ * instead. You don't need to check for get_printk_buffer() == NULL, for
+ * buffered_printk()/buffered_vprintk() will fallback to printk()/vprintk()
+ * in that case.
+ */
+#define DEFINE_PRINTK_BUFFER(name) struct printk_buffer name = { }
+struct printk_buffer *get_printk_buffer(void);
+void flush_printk_buffer(struct printk_buffer *ptr);
+__printf(2, 3)
+int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...);
+__printf(2, 0)
+int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args);
+void put_printk_buffer(struct printk_buffer *ptr);
 
 /*
  * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
@@ -220,6 +250,30 @@ int printk(const char *s, ...)
 {
 	return 0;
 }
+struct printk_buffer {
+	char dummy; /* Not used. */
+};
+#define DEFINE_PRINTK_BUFFER(name) struct printk_buffer name
+static inline struct printk_buffer *get_printk_buffer(void)
+{
+	return NULL;
+}
+static inline __printf(2, 3)
+int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...)
+{
+	return 0;
+}
+static inline __printf(2, 0)
+int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args)
+{
+	return 0;
+}
+static inline void flush_printk_buffer(struct printk_buffer *ptr)
+{
+}
+static inline void put_printk_buffer(struct printk_buffer *ptr)
+{
+}
 static inline __printf(1, 2) __cold
 int printk_deferred(const char *s, ...)
 {
@@ -300,19 +354,34 @@ static inline void printk_safe_flush_on_panic(void)
  */
 #define pr_emerg(fmt, ...) \
 	printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_emerg(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_alert(fmt, ...) \
 	printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_alert(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_crit(fmt, ...) \
 	printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_crit(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_err(fmt, ...) \
 	printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_err(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_warning(fmt, ...) \
 	printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_warning(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_warn pr_warning
+#define bpr_warn bpr_warning
 #define pr_notice(fmt, ...) \
 	printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_notice(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_info(fmt, ...) \
 	printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_info(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
 /*
  * Like KERN_CONT, pr_cont() should only be used when continuing
  * a line with no newline ('\n') enclosed. Otherwise it defaults
@@ -320,6 +389,8 @@ static inline void printk_safe_flush_on_panic(void)
  */
 #define pr_cont(fmt, ...) \
 	printk(KERN_CONT fmt, ##__VA_ARGS__)
+#define bpr_cont(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_CONT fmt, ##__VA_ARGS__)
 
 /* pr_devel() should produce zero code unless DEBUG is defined */
 #ifdef DEBUG
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9bf5404..453db95 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1949,6 +1949,207 @@ asmlinkage int printk_emit(int facility, int level,
 }
 EXPORT_SYMBOL(printk_emit);
 
+#define MAX_PRINTK_BUFFERS 16
+static struct printk_buffer printk_buffers[MAX_PRINTK_BUFFERS];
+static DECLARE_BITMAP(printk_buffers_in_use, MAX_PRINTK_BUFFERS);
+
+/**
+ * get_printk_buffer - Try to get printk_buffer.
+ *
+ * Returns pointer to "struct printk_buffer" on success, NULL otherwise.
+ *
+ * If this function returned "struct printk_buffer", the caller is responsible
+ * for passing it to put_printk_buffer() so that "struct printk_buffer" can be
+ * reused in the future.
+ *
+ * Even if this function returned NULL, the caller does not need to check for
+ * NULL, for passing NULL to buffered_printk() simply acts like normal printk()
+ * and passing NULL to flush_printk_buffer()/put_printk_buffer() is a no-op.
+ */
+struct printk_buffer *get_printk_buffer(void)
+{
+#ifdef CONFIG_STACKTRACE
+	static unsigned long trace_entries[MAX_PRINTK_BUFFERS][20];
+	static struct stack_trace trace[MAX_PRINTK_BUFFERS];
+	static unsigned long stamp[MAX_PRINTK_BUFFERS];
+	static int reported;
+#endif
+	long i;
+
+	for (i = 0; i < MAX_PRINTK_BUFFERS; i++) {
+		if (test_bit(i, printk_buffers_in_use) ||
+		    test_and_set_bit(i, printk_buffers_in_use))
+			continue;
+		printk_buffers[i].used = 0;
+#ifdef CONFIG_STACKTRACE
+		if (!reported) {
+			stamp[i] = jiffies;
+			trace[i].nr_entries = 0;
+			trace[i].entries = trace_entries[i];
+			trace[i].max_entries = 20;
+			trace[i].skip = 0;
+			save_stack_trace(&trace[i]);
+		}
+#endif
+		return &printk_buffers[i];
+	}
+#ifdef CONFIG_STACKTRACE
+	if (!cmpxchg(&reported, 0, 1)) {
+		/*
+		 * Report who is reserving the buffers, for it might be due to
+		 * missing put_printk_buffer() calls.
+		 *
+		 * Note that this report is racy.
+		 * Someone might be about to call put_printk_buffer().
+		 * Someone might be about to set stamp[i] to jiffies.
+		 * Someone might have just set trace[i].nr_entries to 0.
+		 * But it does not worth introducing a lock dependency.
+		 */
+		pr_info("printk: All buffers are in use. Falling back to unbuffered mode.\n");
+		for (i = 0; i < MAX_PRINTK_BUFFERS; i++) {
+			unsigned int j;
+
+			if (!test_bit(i, printk_buffers_in_use))
+				continue;
+			pr_info("buffer[%lu] was reserved %lu jiffies ago by\n",
+				i, jiffies - stamp[i]);
+			for (j = 0; j < trace[i].nr_entries; j++)
+				pr_info("  %pS\n", (void *)trace[i].entries[j]);
+		}
+	}
+#endif
+	return NULL;
+}
+EXPORT_SYMBOL(get_printk_buffer);
+
+/**
+ * buffered_vprintk - Try to vprintk() in line buffered mode.
+ *
+ * @ptr:  Pointer to "struct printk_buffer". It can be NULL.
+ * @fmt:  printk() format string.
+ * @args: va_list structure.
+ *
+ * Returns the return value of vprintk().
+ *
+ * Try to store to @ptr first. If it fails, flush @ptr and then try to store to
+ * @ptr again. If it still fails, use unbuffered printing.
+ */
+int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args)
+{
+	va_list tmp_args;
+	unsigned short int i;
+	int r;
+
+	BUILD_BUG_ON(sizeof(ptr->buf) != LOG_LINE_MAX);
+	if (!ptr)
+		goto unbuffered;
+	for (i = 0; i < 2; i++) {
+		unsigned int pos = ptr->used;
+		char *text = ptr->buf + pos;
+
+		va_copy(tmp_args, args);
+		r = vsnprintf(text, sizeof(ptr->buf) - pos, fmt, tmp_args);
+		va_end(tmp_args);
+		if (r + pos < sizeof(ptr->buf)) {
+			/*
+			 * Eliminate KERN_CONT at this point because we can
+			 * concatenate incomplete lines inside printk_buffer.
+			 */
+			if (r >= 2 && printk_get_level(text) == 'c') {
+				memmove(text, text + 2, r - 2);
+				ptr->used += r - 2;
+			} else {
+				ptr->used += r;
+			}
+			/* Flush already completed lines if any. */
+			while (1) {
+				char *cp = memchr(ptr->buf, '\n', ptr->used);
+
+				if (!cp)
+					break;
+				*cp = '\0';
+				printk("%s\n", ptr->buf);
+				i = cp - ptr->buf + 1;
+				ptr->used -= i;
+				memmove(ptr->buf, ptr->buf + i, ptr->used);
+			}
+			return r;
+		}
+		if (i)
+			break;
+		flush_printk_buffer(ptr);
+	}
+ unbuffered:
+	return vprintk(fmt, args);
+}
+
+/**
+ * buffered_printk - Try to printk() in line buffered mode.
+ *
+ * @ptr:  Pointer to "struct printk_buffer". It can be NULL.
+ * @fmt:  printk() format string, followed by arguments.
+ *
+ * Returns the return value of printk().
+ *
+ * Try to store to @ptr first. If it fails, flush @ptr and then try to store to
+ * @ptr again. If it still fails, use unbuffered printing.
+ */
+int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r = buffered_vprintk(ptr, fmt, args);
+	va_end(args);
+	return r;
+}
+EXPORT_SYMBOL(buffered_printk);
+
+/**
+ * flush_printk_buffer - Flush incomplete line in printk_buffer.
+ *
+ * @ptr: Pointer to "struct printk_buffer". It can be NULL.
+ *
+ * Returns nothing.
+ *
+ * Flush if @ptr contains partial data. But usually there is no need to call
+ * this function because @ptr is flushed by put_printk_buffer().
+ */
+void flush_printk_buffer(struct printk_buffer *ptr)
+{
+	if (!ptr || !ptr->used)
+		return;
+	/* buffered_vprintk() keeps 0 <= ptr->used < sizeof(ptr->buf) true. */
+	ptr->buf[ptr->used] = '\0';
+	printk("%s", ptr->buf);
+	ptr->used = 0;
+}
+EXPORT_SYMBOL(flush_printk_buffer);
+
+/**
+ * put_printk_buffer - Release printk_buffer.
+ *
+ * @ptr: Pointer to "struct printk_buffer". It can be NULL.
+ *
+ * Returns nothing.
+ *
+ * Flush and release @ptr.
+ */
+void put_printk_buffer(struct printk_buffer *ptr)
+{
+	long i = ptr - printk_buffers;
+
+	if (!ptr || i < 0 || i >= MAX_PRINTK_BUFFERS)
+		return;
+	if (ptr->used)
+		flush_printk_buffer(ptr);
+	/* Make sure in_use flag is cleared after setting ptr->used = 0. */
+	wmb();
+	clear_bit(i, printk_buffers_in_use);
+}
+EXPORT_SYMBOL(put_printk_buffer);
+
 int vprintk_default(const char *fmt, va_list args)
 {
 	int r;
-- 
1.8.3.1

