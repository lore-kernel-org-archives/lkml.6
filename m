Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8184CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367452082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dV+kAMJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367452082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeKCGD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:03:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39904 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeKCGD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:03:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id e5-v6so2831010eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WV5nMq0iwkWk9aO5gB+jpbcGedOnlttY/YYkFzipP0g=;
        b=dV+kAMJvOds2EkbPlLoAM3Rai77omm6yUSVRinxHTOl+ROtt0VA9DLbyKkugCcUeQn
         MXm7SIS17g9pNJDFwDe+0raTN53S9Pi9nGe7lxHDuWp6HKlgsiZOG6JYWs1fB8U3Q3o4
         pdouyby1cVK2GRg3AdxY+x61Tr/gWhyZGGzRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WV5nMq0iwkWk9aO5gB+jpbcGedOnlttY/YYkFzipP0g=;
        b=nMkFI62145QExSnCx4XBrcZRINu1MdMho+hwy35Vz+bNCZgJYEUoGtltZDRc93S9Ak
         RBix8yIVcjbjuL3nlmkuKNSdKWJfzwtGE01YnYmtoAOk3MRh2rVvAtsZNoI+71rfaHDx
         38BrzrQYdU+6BKUjZorv46G1mncFDPr1hoAuUjz35VtESbjAPyUUy4U0k7fiqHQypCRl
         cvDsmJSFzwdhe8g7zoZZpmQutmFkzDvjxtRZjMMcHOeNLsny9y5d9YKZ+0Yqag/ZuQgg
         wWGbC+oa6as9e0pHJct6YgBtFEEsWqJpXP6hLw3Ngo+ccIYC+iqsHZ2thswXlEBs2D50
         tKVg==
X-Gm-Message-State: AGRZ1gL1qF2UEEOjN4zdO3pPfQnB+KeVlZsYGAlr0QU4jmK5JY4df9Gp
        kSKhKJUijvHMvjcFKVS6F3oMSntY1zqVcg==
X-Google-Smtp-Source: AJdET5dji8NmUAkAcw5isHh9TP/N93N21PyMtXKexdcnEWKiiWqnCoSYpVsDaVqn0s8GSlnHB1BtDQ==
X-Received: by 2002:a17:906:8cb:: with SMTP id o11-v6mr7568128eje.16.1541192085948;
        Fri, 02 Nov 2018 13:54:45 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id g19-v6sm2697648eds.53.2018.11.02.13.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 13:54:45 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: eliminate const char[] auto variables
Date:   Fri,  2 Nov 2018 21:54:42 +0100
Message-Id: <20181102205442.7758-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Automatic const char[] variables cause unnecessary code
generation. For example, the this_mod variable leads to

    3f04:       48 b8 5f 5f 74 68 69 73 5f 6d   movabs $0x6d5f736968745f5f,%rax # __this_m
    3f0e:       4c 8d 44 24 02                  lea    0x2(%rsp),%r8
    3f13:       48 8d 7c 24 10                  lea    0x10(%rsp),%rdi
    3f18:       48 89 44 24 02                  mov    %rax,0x2(%rsp)
    3f1d:       4c 89 e9                        mov    %r13,%rcx
    3f20:       b8 65 00 00 00                  mov    $0x65,%eax # e
    3f25:       48 c7 c2 00 00 00 00            mov    $0x0,%rdx
                        3f28: R_X86_64_32S      .rodata.str1.1+0x18d
    3f2c:       be 48 00 00 00                  mov    $0x48,%esi
    3f31:       c7 44 24 0a 6f 64 75 6c         movl   $0x6c75646f,0xa(%rsp) # odul
    3f39:       66 89 44 24 0e                  mov    %ax,0xe(%rsp)

i.e., the string gets built on the stack at runtime. Similar code can be
found for the other instances I'm replacing here. Putting the string
in .rodata reduces the combined .text+.rodata size and saves time and
stack space at runtime.

The simplest fix, and what I've done for the this_mod case, is to just
make the variable static.

However, for the "<faulted>" case where the same string is used twice,
that prevents the linker from merging those two literals, so instead use
a macro - that's also slightly cleaner, since FAULTED_SIZE otherwise has
no direct relation to the faulted variable used in
tracing_mark_raw_write().

Finally, for the two runs of spaces, just use variables initialized with
string literals; the linker (at least for x86) will reuse the tail of
the longer for the shorter string.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/trace/ftrace.c |  2 +-
 kernel/trace/trace.c  | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f536f601bd46..4b79d4ae9635 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3862,7 +3862,7 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
 static bool module_exists(const char *module)
 {
 	/* All modules have the symbol __this_module */
-	const char this_mod[] = "__this_module";
+	static const char this_mod[] = "__this_module";
 	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
 	unsigned long val;
 	int n;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ff1c4b20cd0a..ffcceb33a9b2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3381,8 +3381,8 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
 				       unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
-	const char tgid_space[] = "          ";
-	const char space[] = "  ";
+	const char *tgid_space = "          ";
+	const char *space = "  ";
 
 	seq_printf(m, "#                          %s  _-----=> irqs-off\n",
 		   tgid ? tgid_space : space);
@@ -6089,13 +6089,13 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	struct ring_buffer *buffer;
 	struct print_entry *entry;
 	unsigned long irq_flags;
-	const char faulted[] = "<faulted>";
 	ssize_t written;
 	int size;
 	int len;
 
 /* Used in tracing_mark_raw_write() as well */
-#define FAULTED_SIZE (sizeof(faulted) - 1) /* '\0' is already accounted for */
+#define FAULTED_STR "<faulted>"
+#define FAULTED_SIZE (sizeof(FAULTED_STR) - 1) /* '\0' is already accounted for */
 
 	if (tracing_disabled)
 		return -EINVAL;
@@ -6127,7 +6127,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 
 	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
 	if (len) {
-		memcpy(&entry->buf, faulted, FAULTED_SIZE);
+		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		cnt = FAULTED_SIZE;
 		written = -EFAULT;
 	} else
@@ -6168,7 +6168,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	struct ring_buffer_event *event;
 	struct ring_buffer *buffer;
 	struct raw_data_entry *entry;
-	const char faulted[] = "<faulted>";
 	unsigned long irq_flags;
 	ssize_t written;
 	int size;
@@ -6208,7 +6207,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	len = __copy_from_user_inatomic(&entry->id, ubuf, cnt);
 	if (len) {
 		entry->id = -1;
-		memcpy(&entry->buf, faulted, FAULTED_SIZE);
+		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		written = -EFAULT;
 	} else
 		written = cnt;
-- 
2.19.1.6.gbde171bbf5

