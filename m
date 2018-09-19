Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F13BECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45382150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45382150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbeISQjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:39:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:41214 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbeISQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:39:44 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8JB2IRM085764;
        Wed, 19 Sep 2018 20:02:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 19 Sep 2018 20:02:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8JB2Ccs085541
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 19 Sep 2018 20:02:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
 <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
Date:   Wed, 19 Sep 2018 20:02:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914122217.GA518@tigerII.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/14 21:22, Sergey Senozhatsky wrote:
> The "SMP-safe" comment becomes a bit tricky when pr_line is used with a
> static buffer. Either we need to require synchronization - umm... and
> document it - or to provide some means of synchronization in pr_line().
> Let's think what pr_line API should do about it.
> 
> Any thoughts?
> 

I'm inclined to propose a simple one shown below, similar to just having
several "struct cont" for concurrent printk() users.
What Linus has commented is that implicit context is bad, and below one
uses explicit context.
After almost all users are converted to use below one, we might be able
to get rid of KERN_CONT support.



From d5e0e422142ced2b7097040e96ba7c5528a460db Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 19 Sep 2018 14:39:07 +0900
Subject: [PATCH v2] printk: Add best-effort printk() buffering.

Sometimes we want to printk() a line without being disturbed by concurrent
printk() from interrupts and/or other threads. For example, mixed printk()
output of multiple thread's dump makes it hard to interpret.

Assuming that we will go to a direction that we add context identifier to
each line of printk() output (so that we can group multiple lines into one
block when parsing), this patch introduces functions for using fixed-sized
statically allocated buffers for line-buffering printk() output for best
effort basis (i.e. up to LOG_LINE_MAX bytes, up to 16 concurrent printk()
users).

If there happened to be more than 16 concurrent printk() users, existing
printk() will be used for users who failed to get buffers. Of course, if
there were more than 16 concurrent printk() users, the printk() output
would flood the console and the system would be already unusable (e.g.
RCU lockup or hung task watchdog would fire under such situation). Thus,
I think that 16 buffers should be sufficient.

Five functions (get_printk_buffer(), buffered_vprintk(), buffered_printk(),
flush_printk_buffer() and put_printk_buffer()) are provided for printk()
buffering.

  get_printk_buffer() tries to assign a "struct printk_buffer".

  buffered_vprintk()/buffered_printk() tries to use line-buffered printk()
  by holding incomplete line into "struct printk_buffer".

  flush_printk_buffer() flushes the "struct printk_buffer".

  put_printk_buffer() flushes and releases the "struct printk_buffer".

put_printk_buffer() must match corresponding get_printk_buffer() as with
rcu_read_unlock() must match corresponding rcu_read_lock().

These functions are safe to be called from any context, for these are
merely wrapping printk()/vprintk() calls in order to minimize possibility
of using "struct cont" by managing 16 buffers outside of the logbuf_lock
spinlock. Thus, any caller can be updated to use these functions.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/printk.h |  28 +++++++++
 kernel/printk/printk.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccf..889491b 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -157,6 +157,7 @@ static inline void printk_nmi_direct_enter(void) { }
 static inline void printk_nmi_direct_exit(void) { }
 #endif /* PRINTK_NMI */
 
+struct printk_buffer;
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(5, 0)
 int vprintk_emit(int facility, int level,
@@ -173,6 +174,13 @@ int printk_emit(int facility, int level,
 
 asmlinkage __printf(1, 2) __cold
 int printk(const char *fmt, ...);
+struct printk_buffer *get_printk_buffer(void);
+void flush_printk_buffer(struct printk_buffer *ptr);
+__printf(2, 3)
+int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...);
+asmlinkage __printf(2, 0)
+int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args);
+void put_printk_buffer(struct printk_buffer *ptr);
 
 /*
  * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
@@ -220,6 +228,26 @@ int printk(const char *s, ...)
 {
 	return 0;
 }
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
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9bf5404..c9e9f5d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1949,6 +1949,166 @@ asmlinkage int printk_emit(int facility, int level,
 }
 EXPORT_SYMBOL(printk_emit);
 
+struct printk_buffer {
+	unsigned short int used; /* Valid bytes in buf[]. */
+	char buf[LOG_LINE_MAX];
+	bool in_use;
+} __aligned(1024);
+#define MAX_PRINTK_BUFFERS 16
+static struct printk_buffer printk_buffers[MAX_PRINTK_BUFFERS];
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
+	unsigned short int i;
+
+	for (i = 0; i < MAX_PRINTK_BUFFERS; i++) {
+		struct printk_buffer *ptr = &printk_buffers[i];
+
+		if (ptr->in_use || cmpxchg(&ptr->in_use, false, true))
+			continue;
+		ptr->used = 0;
+		return ptr;
+	}
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
+	if (!ptr)
+		return;
+	if (ptr->used)
+		flush_printk_buffer(ptr);
+	xchg(&ptr->in_use, false);
+}
+EXPORT_SYMBOL(put_printk_buffer);
+
 int vprintk_default(const char *fmt, va_list args)
 {
 	int r;
-- 
1.8.3.1



An example user of these functions which would mitigate output like
https://syzkaller.appspot.com/text?tag=CrashReport&x=13368fda400000 is shown below.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 89d2a2a..44bbb96 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4689,10 +4689,10 @@ unsigned long nr_free_pagecache_pages(void)
 	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
 }
 
-static inline void show_node(struct zone *zone)
+static inline void show_node(struct printk_buffer *buf, struct zone *zone)
 {
 	if (IS_ENABLED(CONFIG_NUMA))
-		printk("Node %d ", zone_to_nid(zone));
+		buffered_printk(buf, "Node %d ", zone_to_nid(zone));
 }
 
 long si_mem_available(void)
@@ -4814,7 +4814,7 @@ static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
 
-static void show_migration_types(unsigned char type)
+static void show_migration_types(struct printk_buffer *buf, unsigned char type)
 {
 	static const char types[MIGRATE_TYPES] = {
 		[MIGRATE_UNMOVABLE]	= 'U',
@@ -4838,7 +4838,7 @@ static void show_migration_types(unsigned char type)
 	}
 
 	*p = '\0';
-	printk(KERN_CONT "(%s) ", tmp);
+	buffered_printk(buf, "(%s) ", tmp);
 }
 
 /*
@@ -4856,6 +4856,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 	int cpu;
 	struct zone *zone;
 	pg_data_t *pgdat;
+	struct printk_buffer *buf = get_printk_buffer();
 
 	for_each_populated_zone(zone) {
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
@@ -4950,8 +4951,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		for_each_online_cpu(cpu)
 			free_pcp += per_cpu_ptr(zone->pageset, cpu)->pcp.count;
 
-		show_node(zone);
-		printk(KERN_CONT
+		show_node(buf, zone);
+		buffered_printk(buf,
 			"%s"
 			" free:%lukB"
 			" min:%lukB"
@@ -4993,10 +4994,10 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(free_pcp),
 			K(this_cpu_read(zone->pageset->pcp.count)),
 			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
-		printk("lowmem_reserve[]:");
+		buffered_printk(buf, "lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
-			printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
-		printk(KERN_CONT "\n");
+			buffered_printk(buf, " %ld", zone->lowmem_reserve[i]);
+		buffered_printk(buf, "\n");
 	}
 
 	for_each_populated_zone(zone) {
@@ -5006,8 +5007,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
-		show_node(zone);
-		printk(KERN_CONT "%s: ", zone->name);
+		show_node(buf, zone);
+		buffered_printk(buf, "%s: ", zone->name);
 
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
@@ -5025,13 +5026,14 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
-			printk(KERN_CONT "%lu*%lukB ",
+			buffered_printk(buf, "%lu*%lukB ",
 			       nr[order], K(1UL) << order);
 			if (nr[order])
-				show_migration_types(types[order]);
+				show_migration_types(buf, types[order]);
 		}
-		printk(KERN_CONT "= %lukB\n", K(total));
+		buffered_printk(buf, "= %lukB\n", K(total));
 	}
+	put_printk_buffer(buf);
 
 	hugetlb_show_meminfo();
 
