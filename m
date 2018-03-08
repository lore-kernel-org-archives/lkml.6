Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeCHU6x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:58:53 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33746 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeCHU6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:58:51 -0500
X-Google-Smtp-Source: AG47ELuwUTYDokC5hGyI4eTvYIWJh4ViRLxzQibwTovXeIWRSNWXyYdEZsECKiGv9vAUV0jOivNNUg==
From: Mathieu Malaterre <malat@debian.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Malaterre <malat@debian.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] trace: Use __printf markup to silence compiler
Date: Thu,  8 Mar 2018 21:58:43 +0100
Message-Id: <20180308205843.27447-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence warnings (triggered at W=1) by adding relevant __printf attributes.

  CC      kernel/trace/trace.o
kernel/trace/trace.c: In function ‘__trace_array_vprintk’:
kernel/trace/trace.c:2979:2: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  len = vscnprintf(tbuffer, TRACE_BUF_SIZE, fmt, args);
  ^~~
  AR      kernel/trace/built-in.o

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/trace/trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 926718fa846d..117e246d0a49 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2949,6 +2949,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 }
 EXPORT_SYMBOL_GPL(trace_vbprintk);
 
+__printf(3, 0)
 static int
 __trace_array_vprintk(struct ring_buffer *buffer,
 		      unsigned long ip, const char *fmt, va_list args)
@@ -3003,12 +3004,14 @@ __trace_array_vprintk(struct ring_buffer *buffer,
 	return len;
 }
 
+__printf(3, 0)
 int trace_array_vprintk(struct trace_array *tr,
 			unsigned long ip, const char *fmt, va_list args)
 {
 	return __trace_array_vprintk(tr->trace_buffer.buffer, ip, fmt, args);
 }
 
+__printf(3, 0)
 int trace_array_printk(struct trace_array *tr,
 		       unsigned long ip, const char *fmt, ...)
 {
@@ -3024,6 +3027,7 @@ int trace_array_printk(struct trace_array *tr,
 	return ret;
 }
 
+__printf(3, 4)
 int trace_array_printk_buf(struct ring_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...)
 {
@@ -3039,6 +3043,7 @@ int trace_array_printk_buf(struct ring_buffer *buffer,
 	return ret;
 }
 
+__printf(2, 0)
 int trace_vprintk(unsigned long ip, const char *fmt, va_list args)
 {
 	return trace_array_vprintk(&global_trace, ip, fmt, args);
-- 
2.11.0
