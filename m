Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeBBXLA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:11:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751857AbeBBXKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:10:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B459A217C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180202231017.756258991@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 02 Feb 2018 18:05:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH 05/18] tracing: Add hex print for dynamic ftrace based events
References: <20180202230458.840252014@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0005-tracing-Add-hex-print-for-dynamic-ftrace-based-event.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add x64, x32, x16 and x8 to represent numbers of the same size in hex.
Similar to u64, u32, u16, and u8 but uses %x instead of %u.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst | 14 +++++++++-----
 kernel/trace/trace_event_ftrace.c             | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index 94c2c975295a..f27a0c4e829c 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -97,6 +97,7 @@ as follows:
 
  ATOM := 'u8' | 'u16' | 'u32' | 'u64' |
          's8' | 's16' | 's32' | 's64' |
+         'x8' | 'x16' | 'x32' | 'x64' |
          'char' | 'short' | 'int' | 'long' | 'size_t'
 
  FIELD := <name>
@@ -116,11 +117,14 @@ int ip_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt,
 
 If we are only interested in the first argument (skb):
 
- # echo 'ip_rcv(u64 skb, u64 dev)' > function_events
+ # echo 'ip_rcv(x64 skb, x86 dev)' > function_events
 
  # echo 1 > events/functions/ip_rcv/enable
  # cat trace
-     <idle>-0     [003] ..s3  2119.041935: __netif_receive_skb_core->ip_rcv(skb=18446612136982403072, dev=18446612136968273920)
-     <idle>-0     [003] ..s3  2119.041944: __netif_receive_skb_core->ip_rcv(skb=18446612136982403072, dev=18446612136968273920)
-     <idle>-0     [003] ..s3  2119.288337: __netif_receive_skb_core->ip_rcv(skb=18446612136982403072, dev=18446612136968273920)
-     <idle>-0     [003] ..s3  2119.288960: __netif_receive_skb_core->ip_rcv(skb=18446612136982403072, dev=18446612136968273920)
+     <idle>-0     [003] ..s3  5543.133460: __netif_receive_skb_core->ip_rcv(skb=ffff88007f960700, net=ffff880114250000)
+     <idle>-0     [003] ..s3  5543.133475: __netif_receive_skb_core->ip_rcv(skb=ffff88007f960700, net=ffff880114250000)
+     <idle>-0     [003] ..s3  5543.312592: __netif_receive_skb_core->ip_rcv(skb=ffff88007f960700, net=ffff880114250000)
+     <idle>-0     [003] ..s3  5543.313150: __netif_receive_skb_core->ip_rcv(skb=ffff88007f960700, net=ffff880114250000)
+
+We use "x64" in order to make sure that the data is displayed in hex.
+This is on a x86_64 machine, and we know the pointer sizes are 8 bytes.
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 66465be1e6d5..aa19c8af9d34 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -62,6 +62,11 @@ enum func_states {
 	FUNC_STATE_ERROR,
 };
 
+typedef u64 x64;
+typedef u32 x32;
+typedef u16 x16;
+typedef u8 x8;
+
 #define TYPE_TUPLE(type)			\
 	{ #type, sizeof(type), is_signed_type(type) }
 
@@ -77,12 +82,16 @@ static struct func_type {
 	TYPE_TUPLE(size_t),
 	TYPE_TUPLE(u64),
 	TYPE_TUPLE(s64),
+	TYPE_TUPLE(x64),
 	TYPE_TUPLE(u32),
 	TYPE_TUPLE(s32),
+	TYPE_TUPLE(x32),
 	TYPE_TUPLE(u16),
 	TYPE_TUPLE(s16),
+	TYPE_TUPLE(x16),
 	TYPE_TUPLE(u8),
 	TYPE_TUPLE(s8),
+	TYPE_TUPLE(x8),
 	{ NULL,		0,	0 }
 };
 
@@ -353,7 +362,9 @@ static void make_fmt(struct func_arg *arg, char *fmt)
 		fmt[c++] = 'l';
 	}
 
-	if (arg->sign)
+	if (arg->type[0] == 'x')
+		fmt[c++] = 'x';
+	else if (arg->sign)
 		fmt[c++] = 'd';
 	else
 		fmt[c++] = 'u';
-- 
2.15.1
