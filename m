Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754908AbeBGUaQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754702AbeBGU2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3263F217C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202817.224736694@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:19 -0500
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
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 17/20 v2] tracing: Add indirect to indirect access for function based events
References: <20180207202402.253089656@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0017-tracing-Add-indirect-to-indirect-access-for-function.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Allow the function based events to retrieve not only the parameters offsets,
but also get data from a pointer within a parameter structure. Something
like:

 # echo 'ip_rcv(string skdev+16[0][0] | x8[6] skperm+16[0]+558)' > function_events

 # echo 1 > events/functions/ip_rcv/enable
 # cat trace
    <idle>-0     [003] ..s3   310.626391: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
    <idle>-0     [003] ..s3   310.626400: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
    <idle>-0     [003] ..s3   312.183775: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
    <idle>-0     [003] ..s3   312.184329: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
    <idle>-0     [003] ..s3   312.303895: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
    <idle>-0     [003] ..s3   312.304610: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
    <idle>-0     [003] ..s3   312.471980: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
    <idle>-0     [003] ..s3   312.472908: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)
    <idle>-0     [003] ..s3   313.135804: __netif_receive_skb_core->ip_rcv(skdev=em1, skperm=b4,b5,2f,ce,18,65)

That is, we retrieved the net_device of the sk_buff and displayed its name
and perm_addr info.

  sk->dev->name, sk->dev->perm_addr

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst |  40 +++++++++-
 kernel/trace/trace_event_ftrace.c             | 102 ++++++++++++++++++++++++--
 2 files changed, 136 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index b90b52b7061d..3b341992b93d 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -101,12 +101,15 @@ as follows:
          'char' | 'short' | 'int' | 'long' | 'size_t' |
 	 'symbol' | 'string'
 
- FIELD := <name> | <name> INDEX | <name> OFFSET | <name> OFFSET INDEX
+ FIELD := <name> | <name> INDEX | <name> OFFSET | <name> OFFSET INDEX |
+	 FIELD INDIRECT
 
  INDEX := '[' <number> ']'
 
  OFFSET := '+' <number>
 
+ INDIRECT := INDEX | OFFSET | INDIRECT INDIRECT | ''
+
  ADDR := A hexidecimal address starting with '0x'
 
  Where <name> is a unique string starting with an alphabetic character
@@ -385,3 +388,38 @@ based event.
 NULL can appear in any argument, to have them ignored. Note, skipping arguments
 does not give you access to later arguments if they are not supported by the
 architecture. The architecture only supplies the first set of arguments.
+
+
+The chain of indirects
+======================
+
+When a parameter is a structure, and that structure points to another structure,
+the data of that structure can still be found.
+
+ssize_t __vfs_read(struct file *file, char __user *buf, size_t count,
+		   loff_t *pos)
+
+has the following code.
+
+	if (file->f_op->read)
+		return file->f_op->read(file, buf, count, pos);
+
+To trace all the functions that are called by f_op->read(), that information
+can be obtained from the file pointer.
+
+Using gdb again:
+
+   (gdb) printf "%d\n", &((struct file *)0)->f_op
+40
+   (gdb) printf "%d\n", &((struct file_operations *)0)->read
+16
+
+    # echo '__vfs_read(symbol read+40[0]+16)' > function_events
+
+  # echo 1 > events/functions/__vfs_read/enable
+  # cat trace
+         sshd-1343  [005] ...2   199.734752: vfs_read->__vfs_read(read=tty_read+0x0/0xf0)
+         bash-1344  [003] ...2   199.734822: vfs_read->__vfs_read(read=tty_read+0x0/0xf0)
+         sshd-1343  [005] ...2   199.734835: vfs_read->__vfs_read(read=tty_read+0x0/0xf0)
+ avahi-daemon-910   [003] ...2   200.136740: vfs_read->__vfs_read(read=          (null))
+ avahi-daemon-910   [003] ...2   200.136750: vfs_read->__vfs_read(read=          (null))
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 673e2d963319..732ba570466b 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -14,8 +14,15 @@
 #define WRITE_BUFSIZE		4096
 #define INDIRECT_FLAG		0x10000000
 
+struct func_arg_redirect {
+	struct list_head		list;
+	long				index;
+	long				indirect;
+};
+
 struct func_arg {
 	struct list_head		list;
+	struct list_head		redirects;
 	char				*type;
 	char				*name;
 	long				indirect;
@@ -73,6 +80,8 @@ enum func_states {
 	FUNC_STATE_ARRAY,
 	FUNC_STATE_ARRAY_SIZE,
 	FUNC_STATE_ARRAY_END,
+	FUNC_STATE_REDIRECT_PLUS,
+	FUNC_STATE_REDIRECT_BRACKET,
 	FUNC_STATE_VAR,
 	FUNC_STATE_COMMA,
 	FUNC_STATE_NULL,
@@ -269,6 +278,8 @@ static int add_arg(struct func_event *fevent, int ftype, int unsign)
 	if (!arg)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&arg->redirects);
+
 	if (unsign)
 		arg->type = kasprintf(GFP_KERNEL, "unsigned %s",
 				      func_type->name);
@@ -331,6 +342,22 @@ static int update_arg_arg(struct func_event *fevent)
 	return 0;
 }
 
+static int add_arg_redirect(struct func_arg *arg, long index, long indirect)
+{
+	struct func_arg_redirect *redirect;
+
+	redirect = kzalloc(sizeof(*redirect), GFP_KERNEL);
+	if (!redirect)
+		return -ENOMEM;
+
+	redirect->index = index;
+	redirect->indirect = indirect;
+
+	list_add_tail(&redirect->list, &arg->redirects);
+
+	return 0;
+}
+
 static enum func_states
 process_event(struct func_event *fevent, const char *token, enum func_states state)
 {
@@ -461,6 +488,10 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 			return FUNC_STATE_COMMA;
 		case '|':
 			return FUNC_STATE_PIPE;
+		case '+':
+			return FUNC_STATE_REDIRECT_PLUS;
+		case '[':
+			return FUNC_STATE_REDIRECT_BRACKET;
 		}
 		break;
 
@@ -484,6 +515,30 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 		}
 		break;
 
+	case FUNC_STATE_REDIRECT_PLUS:
+		if (WARN_ON(!fevent->last_arg))
+			break;
+		ret = kstrtoul(token, 0, &val);
+		if (ret)
+			break;
+		ret = add_arg_redirect(fevent->last_arg, val, 0);
+		if (ret)
+			break;
+		return FUNC_STATE_VAR;
+
+	case FUNC_STATE_REDIRECT_BRACKET:
+		if (WARN_ON(!fevent->last_arg))
+			break;
+		ret = kstrtoul(token, 0, &val);
+		if (ret)
+			break;
+		val *= fevent->last_arg->size;
+		val ^= INDIRECT_FLAG;
+		ret = add_arg_redirect(fevent->last_arg, 0, val);
+		if (ret)
+			break;
+		return FUNC_STATE_INDIRECT;
+
 	case FUNC_STATE_VAR:
 		if (token[0] == '=')
 			return FUNC_STATE_EQUAL;
@@ -543,20 +598,49 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
 	return FUNC_STATE_END;
 }
 
-static long long __get_arg(struct func_arg *arg, unsigned long val)
+static unsigned long process_redirects(struct func_arg *arg, unsigned long val,
+				       char *buf)
+{
+	struct func_arg_redirect *redirect;
+	int ret;
+
+	if (arg->indirect) {
+		ret = probe_kernel_read(buf, (void *)val, sizeof(long));
+		if (ret)
+			return 0;
+		val = *(unsigned long *)buf;
+	}
+
+	list_for_each_entry(redirect, &arg->redirects, list) {
+		val += redirect->index;
+		if (redirect->indirect) {
+			val += (redirect->indirect ^ INDIRECT_FLAG);
+			ret = probe_kernel_read(buf, (void *)val, sizeof(long));
+			if (ret)
+				return 0;
+		}
+	}
+	return val;
+}
+
+static long long __get_arg(struct func_arg *arg, unsigned long long val)
 {
 	char buf[8];
 	int ret;
 
 	val += arg->index;
 
-	if (!arg->indirect)
-		return val;
+	if (arg->indirect)
+		val += (arg->indirect ^ INDIRECT_FLAG);
+
+	if (!list_empty(&arg->redirects))
+		val = process_redirects(arg, val, buf);
 
-	val = val + (arg->indirect ^ INDIRECT_FLAG);
+	if (!val)
+		return 0;
 
 	/* Arrays and strings do their own indirect reads */
-	if (arg->array || arg->func_type == FUNC_TYPE_string)
+	if (!arg->indirect || arg->array || arg->func_type == FUNC_TYPE_string)
 		return val;
 
 	ret = probe_kernel_read(buf, (void *)val, arg->size);
@@ -1164,6 +1248,7 @@ static void func_event_seq_stop(struct seq_file *m, void *v)
 static int func_event_seq_show(struct seq_file *m, void *v)
 {
 	struct func_event *func_event = v;
+	struct func_arg_redirect *redirect;
 	struct func_arg *arg;
 	bool comma = false;
 	int last_arg = 0;
@@ -1192,6 +1277,13 @@ static int func_event_seq_show(struct seq_file *m, void *v)
 				seq_printf(m, "[%ld]",
 					   (arg->indirect ^ INDIRECT_FLAG) / arg->size);
 		}
+		list_for_each_entry(redirect, &arg->redirects, list) {
+			if (redirect->index)
+				seq_printf(m, "+%ld", redirect->index);
+			if (redirect->indirect)
+				seq_printf(m, "[%ld]",
+					   (redirect->indirect ^ INDIRECT_FLAG) / arg->size);
+		}
 	}
 	seq_puts(m, ")\n");
 
-- 
2.15.1
