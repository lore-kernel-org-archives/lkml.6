Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524593298; cv=none;
        d=google.com; s=arc-20160816;
        b=cbwuRam05Uh8KGZYjKrzClyj49rWe5TY/aqf9cmeI9HzxNC/uO2keAt6bu1FhIR0p0
         BACYhadtOm8u78Y6NPHuA+m7MOa/rXOkZaa4lCx0qWHu3Bb4CfGbz2wk9nDrZ7h1Rsf0
         9U9GSo2opzSVSBUNQQxtVlg+XXTpkJblAmkNvmbusRqaa3hnpmUD4Q3Jdb8A9XXpQ/im
         cQZsow+o5pm04JOZ8+U/HRzAcXs0BaIa+zkJ2d624pnsTWmshYVQHf/clvjWi3P01nA5
         Eue0GLozHCVgSHAG93SivTBfhJM3zDdAbOQI/LqdARcLm7pS6vihI4ziwWaiZDhcT0yV
         efHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=T1UekXwdlgK45FRXnyXI2UUf8CYIZDJO2HVUO0XJo3g=;
        b=HSOINY3nDjFH9qf2Xdwkt1dAHhne/wvmjPUNhdYFxMeI+F7zIYDNxAgBg70TSzMtf+
         n6ie6VjcHvJNcxxYyOnUIFii0jaaDnm9/bDV3e3OGzrW8U4k0VYVUtZmJ+ws/NiM3sWV
         jZt7aGlk+AyEsYTjF6U5GLXP2pqcz+Jo2v++eurNNVQ2tNeXoUVcuDdB+yLFj7OdZxOX
         pAvCu/kyr2njFn3it9d3rTnzpkhsId4dMBxl9gmG9yY8ZikijJYgAyg8AyLF9yfd0RBN
         2jNKWjF40LCPojThY/GyEZ40SYFMqTgNtvJqH/jKEpKljlVTxbpQ0oemRm/FVgs9FIvZ
         /NbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gewlHgyj;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gewlHgyj;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49yS+FfL4t9dE4k1WZEfWt3GgakBEdLzTrF3636jYKTgpEJ0fr3JKnKELyrORR7EObTiuvJ5g==
From: Wei Wang <wvw@google.com>
X-Google-Original-From: Wei Wang < wvw@google.com >
To: 
Cc: gregkh@linuxfoundation.org,
	wei.vince.wang@gmail.com,
	Wei Wang <wvw@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Crt Mori <cmo@melexis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] do not call trace_printk on non-debug build
Date: Tue, 24 Apr 2018 11:08:10 -0700
Message-Id: <20180424180812.215900-1-wvw@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598651942651560845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Wang <wvw@google.com>

trace_printk will cause trace_printk_init_buffers executed in kernel
start, which will increase memory and also show bad warnings in
production kernel.

Signed-off-by: Wei Wang <wvw@google.com>
---
 include/linux/kernel.h       | 17 +++++++++++++++++
 include/linux/trace_events.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 6a1eb0b0aad96..f1a003e5986a9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -677,6 +677,7 @@ do {									\
  * let gcc optimize the rest.
  */
 
+#if defined(DEBUG)
 #define trace_printk(fmt, ...)				\
 do {							\
 	char _______STR[] = __stringify((__VA_ARGS__));	\
@@ -685,7 +686,11 @@ do {							\
 	else						\
 		trace_puts(fmt);			\
 } while (0)
+#else
+#define trace_printk(fmt, ...)
+#endif
 
+#if defined(DEBUG)
 #define do_trace_printk(fmt, args...)					\
 do {									\
 	static const char *trace_printk_fmt __used			\
@@ -699,6 +704,9 @@ do {									\
 	else								\
 		__trace_printk(_THIS_IP_, fmt, ##args);			\
 } while (0)
+#else
+#define do_trace_printk(fmt, args...)
+#endif
 
 extern __printf(2, 3)
 int __trace_bprintk(unsigned long ip, const char *fmt, ...);
@@ -731,6 +739,7 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
  *  (1 when __trace_bputs is used, strlen(str) when __trace_puts is used)
  */
 
+#if defined(DEBUG)
 #define trace_puts(str) ({						\
 	static const char *trace_printk_fmt __used			\
 		__attribute__((section("__trace_printk_fmt"))) =	\
@@ -741,6 +750,10 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
 	else								\
 		__trace_puts(_THIS_IP_, str, strlen(str));		\
 })
+#else
+#define trace_puts(str)
+#endif
+
 extern int __trace_bputs(unsigned long ip, const char *str);
 extern int __trace_puts(unsigned long ip, const char *str, int size);
 
@@ -751,6 +764,7 @@ extern void trace_dump_stack(int skip);
  * if we try to allocate the static variable to fmt if it is not a
  * constant. Even with the outer if statement.
  */
+#if defined(DEBUG)
 #define ftrace_vprintk(fmt, vargs)					\
 do {									\
 	if (__builtin_constant_p(fmt)) {				\
@@ -762,6 +776,9 @@ do {									\
 	} else								\
 		__ftrace_vprintk(_THIS_IP_, fmt, vargs);		\
 } while (0)
+#else
+#define ftrace_vprintk(fmt, vargs)
+#endif
 
 extern __printf(2, 0) int
 __ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap);
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 2bde3eff564cd..433208a1c6009 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -533,6 +533,7 @@ int trace_set_clr_event(const char *system, const char *event, int set);
  * if we try to allocate the static variable to fmt if it is not a
  * constant. Even with the outer if statement optimizing out.
  */
+#if defined(DEBUG)
 #define event_trace_printk(ip, fmt, args...)				\
 do {									\
 	__trace_printk_check_format(fmt, ##args);			\
@@ -546,6 +547,9 @@ do {									\
 	} else								\
 		__trace_printk(ip, fmt, ##args);			\
 } while (0)
+#else
+#define event_trace_printk(ip, fmt, args...)
+#endif
 
 #ifdef CONFIG_PERF_EVENTS
 struct perf_event;
-- 
2.17.0.484.g0c8726318c-goog
