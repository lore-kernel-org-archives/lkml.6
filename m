Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64128C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC10920858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC10920858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJHRnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:43:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61903 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJHRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:43:04 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w98AVxDU008880;
        Mon, 8 Oct 2018 19:31:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Mon, 08 Oct 2018 19:31:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w98AVwG4008876
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 8 Oct 2018 19:31:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
 <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
 <20181001023721.GA6409@jagdpanzerIV>
 <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
 <20181002063851.GF598@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5a958a1b-a986-014a-5908-816e0a3ef4ff@i-love.sakura.ne.jp>
Date:   Mon, 8 Oct 2018 19:31:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002063851.GF598@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/02 15:38, Sergey Senozhatsky wrote:
> I have sketched a very silly, quick-and-dirty implementation using
> struct cont. It derives all the good features of the existing pr_cont.
> I didn't spend enough time on this. It's just a sketch... which compiles
> and that's it.

Sergey and I had off-list discussion about an implementation above. But
I concluded that I should update my version than updating Sergey's sketch.

The origin ( https://groups.google.com/forum/#!topic/syzkaller/ttZehjXiHTU ) is
how to prefix caller information to each line of printk() messages so that syzbot
can group messages from each context and do the better processing.

We know that Linus has refused injecting extra data into message body
( https://lkml.kernel.org/r/CA+55aFynkjSL1NNZbx6m1iE2HjZagGK09rAr5-HaZ4Ep2eWKOg@mail.gmail.com )

  On 2017/09/18 0:35, Linus Torvalds wrote:
  > On Sat, Sep 16, 2017 at 11:26 PM, Sergey Senozhatsky
  > <sergey.senozhatsky@gmail.com> wrote:
  >>
  >> so... I think we don't have to update 'struct printk_log'. we can store
  >> that "extended data" at the beginning of every message, right after the
  >> prefix.
  > 
  > No, we really can't. That just means that all the tools would have to
  > be changed to get the normal messages without the extra crud. And
  > since it will have lost the difference, that's not even easy to do.
  > 
  > So this is exactly the wrong way around.
  > 
  > If people want to see the extra data, it really should be extra data
  > that you can get with a new interface from the kernel logs. Not a
  > "let's just a add it to all lines and make every line uglier and
  > harder to read.
  > 
  >               Linus

but we also know that syzbot cannot count on a new interface
( https://lkml.kernel.org/r/CACT4Y+aFO+yZ7ovkxJOJfz=JgsE3yr+ywLQ9kVUrOHYMBgfWdg@mail.gmail.com )

  On 2018/05/18 22:08, Dmitry Vyukov wrote:
  > On Fri, May 18, 2018 at 2:54 PM, Petr Mladek <pmladek@suse.com> wrote:
  >> On Fri 2018-05-18 14:25:57, Dmitry Vyukov wrote:
  >>>> On Thu 2018-05-17 20:21:35, Sergey Senozhatsky wrote:
  >>>>> Dunno...
  >>>>> For instance, can we store context tracking info as a extended record
  >>>>> data? We have that dict/dict_len thing. So may we can store tracking
  >>>>> info there? Extended records will appear on the serial console /* if
  >>>>> console supports extended data */ or can be read in via devkmsg_read().
  >>>
  >>> What consoles do support it?
  >>> We are interested at least in qemu console, GCE console and Android
  >>> phone consoles. But it would be pity if this can't be used on various
  >>> development boards too.
  >>
  >> Only the netconsole is able to show the extended (dict)
  >> information at the moment. Search for CON_EXTENDED flag.
  > 
  > Then we won't be able to use it. And we can't pipe from devkmsg_read
  > in user-space, because we need this to work when kernel is broken in
  > various ways...

and we have to allow normal consoles to inject caller information into message
body. Since syzbot can modify kernel configurations and kernel boot command
line options, if Linus permits, we can enable injecting caller information to
only syzbot environments.

Regarding a concern Linus mentioned
( https://lkml.kernel.org/r/CA+55aFwmwdY_mMqdEyFPpRhCKRyeqj=+aCqe5nN108v8ELFvPw@mail.gmail.com ),
we would be able to convert

     printk("Testing feature XYZ..");
     this_may_blow_up_because_of_hw_bugs();
     printk(KERN_CONT " ... ok\n");

to

     printk("Testing feature XYZ..\n");
     this_may_blow_up_because_of_hw_bugs();
     printk("... feature XYZ ok\n");

and eventually remove pr_cont/printk(KERN_CONT) support (i.e. printk() will always
emit '\n').



From df59a431b18888af3bdc9a90d03f1a9d63a12c3e Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sun, 7 Oct 2018 10:20:38 +0900
Subject: [PATCH v3] printk: Add line-buffered printk() API.

Sometimes we want to print a whole line without being disturbed by
concurrent printk() from interrupts and/or other threads, for printk()
which does not end with '\n' can be disturbed.

Mixed printk() output makes it hard to interpret. Assuming that we will go
to a direction that we allow prefixing context identifier to each line of
printk() output (so that we can group multiple lines into one block when
parsing), this patch introduces API for line-buffered printk() output
(so that we can make sure that printk() ends with '\n').

Since functions introduced by this patch are merely wrapping
printk()/vprintk() calls in order to minimize possibility of using
"struct cont", it is safe to replace printk()/vprintk() with this API.

Details:

  A structure named "struct printk_buffer" is introduced for buffering
  up to LOG_LINE_MAX bytes of printk() output which did not end with '\n'.

  A caller is allowed to allocate/free "struct printk_buffer" using
  kzalloc()/kfree() if that caller is in a location where it is possible
  to do so.

  A macro named "DEFINE_PRINTK_BUFFER()" is defined for allocating
  "struct printk_buffer" from the stack memory or in the .bss section.

  But since sizeof("struct printk_buffer") is nearly 1KB, it might not be
  preferable to allocate "struct printk_buffer" from the stack memory.
  In that case, a caller can use best-effort buffering mode. Two functions
  get_printk_buffer() and put_printk_buffer() are provided for that mode.

  get_printk_buffer() tries to assign a "struct printk_buffer" from
  statically preallocated array. It returns NULL if all static
  "struct printk_buffer" are in use.

  put_printk_buffer() flushes and releases the "struct printk_buffer".
  put_printk_buffer() must match corresponding get_printk_buffer() as with
  rcu_read_unlock() must match corresponding rcu_read_lock().

  Three functions buffered_vprintk(), buffered_printk() and
  flush_printk_buffer() are provided for using "struct printk_buffer".
  These are like vfprintf(), fprintf(), fflush() except that these receive
  "struct printk_buffer *" for the first argument.

  buffered_vprintk() and buffered_printk() behave like vprintk() and
  printk() respectively if "struct printk_buffer *" argument is NULL.
  flush_printk_buffer() and put_printk_buffer() become no-op if
  "struct printk_buffer *" argument is NULL. Therefore, the caller of
  get_printk_buffer() does not need to check for NULL.

How to use:

  (1) Allocate "struct printk_buffer" and zero-clear it.
      You can use one of kzalloc() or DEFINE_PRINTK_BUFFER() or
      get_printk_buffer().

  (2) Rewrite printk() calls in the following way. The "ptr" is
      "struct printk_buffer *" allocated in step (1).

      printk(fmt, ...)     => buffered_printk(ptr, fmt, ...)
      vprintk(fmt, args)   => buffered_vprintk(ptr, fmt, args)
      pr_emerg(fmt, ...)   => bpr_emerg(ptr, fmt, ...)
      pr_alert(fmt, ...)   => bpr_alert(ptr, fmt, ...)
      pr_crit(fmt, ...)    => bpr_crit(ptr, fmt, ...)
      pr_err(fmt, ...)     => bpr_err(ptr, fmt, ...)
      pr_warning(fmt, ...) => bpr_warning(ptr, fmt, ...)
      pr_warn(fmt, ...)    => bpr_warn(ptr, fmt, ...)
      pr_notice(fmt, ...)  => bpr_notice(ptr, fmt, ...)
      pr_info(fmt, ...)    => bpr_info(ptr, fmt, ...)
      pr_cont(fmt, ...)    => bpr_cont(ptr, fmt, ...)

  (3) Release "struct printk_buffer" by calling put_printk_buffer()
      only if it was allocated by get_printk_buffer().
      Release "struct printk_buffer" by calling kfree()
      only if it was allocated by kzalloc().

Note that since "struct printk_buffer" buffers only up to one line, there
is no need to rewrite if it is known that the "struct printk_buffer" is
empty and printk() ends with '\n'.

  Good example:

    printk("Hello ");    =>  DEFINE_PRINTK_BUFFER(buf);
    pr_cont("world.\n");     buffered_printk(&buf, "Hello ");
                             buffered_printk(&buf, "world.\n");

  Pointless example:

    printk("Hello\n");   => DEFINE_PRINTK_BUFFER(buf);
    printk("World.\n");     buffered_printk(&buf, "Hello\n");
                            buffered_printk(&buf, "World.\n");

Note that bpr_devel() and bpr_debug() are not defined. This is
because pr_devel()/pr_debug() should not be followed by pr_cont()
because pr_devel()/pr_debug() are conditionally enabled; output from
pr_devel()/pr_debug() should always end with '\n'.

The statically preallocated buffer has 16 "struct printk_buffer".
If there happened to be out of statically preallocated buffer, existing
printk() will be used for users who failed to get "struct printk_buffer".
Of course, under such situation, the printk() output would flood the
console and the system would be already unusable (e.g. RCU lockup or
hung task watchdog would fire) even if "struct printk_buffer" is
dynamically allocated. Thus, I think that 16 should be sufficient.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/printk.h |  72 ++++++++++++++++++++++
 kernel/printk/printk.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 230 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccf..912b770 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -173,6 +173,37 @@ int printk_emit(int facility, int level,
 
 asmlinkage __printf(1, 2) __cold
 int printk(const char *fmt, ...);
+/*
+ * A structure for line-buffering printk() output.
+ */
+struct printk_buffer {
+	unsigned short int used; /* Valid bytes in buf[]. */
+	char buf[1024 - 32]; /* This is LOG_LINE_MAX bytes. */
+	bool in_use; /* Unused if defined using DEFINE_PRINTK_BUFFER(). */
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
@@ -220,6 +251,30 @@ int printk(const char *s, ...)
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
@@ -300,19 +355,34 @@ static inline void printk_safe_flush_on_panic(void)
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
@@ -320,6 +390,8 @@ static inline void printk_safe_flush_on_panic(void)
  */
 #define pr_cont(fmt, ...) \
 	printk(KERN_CONT fmt, ##__VA_ARGS__)
+#define bpr_cont(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_CONT fmt, ##__VA_ARGS__)
 
 /* pr_devel() should produce zero code unless DEBUG is defined */
 #ifdef DEBUG
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9bf5404..6f564e6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1949,6 +1949,164 @@ asmlinkage int printk_emit(int facility, int level,
 }
 EXPORT_SYMBOL(printk_emit);
 
+#define MAX_PRINTK_BUFFERS 16
+static struct printk_buffer printk_buffers[MAX_PRINTK_BUFFERS] __aligned(1024);
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
+	if (!ptr)
+		return;
+	if (ptr->used)
+		flush_printk_buffer(ptr);
+	/* Make sure ptr->in_use is cleared after setting ptr->used = 0.*/
+	wmb();
+	ptr->in_use = false;
+}
+EXPORT_SYMBOL(put_printk_buffer);
+
 int vprintk_default(const char *fmt, va_list args)
 {
 	int r;
-- 
1.8.3.1

