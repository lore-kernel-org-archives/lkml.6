Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1794019-1519878105-2-17218581630673183480
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519878104; b=eikHJjaLWxCKSLppwLweIzCJIkdGDgbZt1SrzOO0wRE/Zdg
    hQetMhBrRmWZjCfYeIHqbRQo2moDmYcMtOBqpcYnQFv6gQiNben4vb1DIGA4F0NH
    1+p+dn82ga9FaImk6FyEp3CxNL9Y5RBu86GN6AgCmyJGP9tRAvU2YwfBtoydWpNG
    PgdNUIx0eTCjqmW4yWC3YpAIkD9BoAo9LnXaFZasHMpfJB+FhVGA1ICqIb+Ch+tL
    XXYCF4e/37YaARPkQ5EfpCqhzQ9sCXZNUgifyYuWZY2k9oIqlHWU5BFPx/+fA9OO
    1H3AcdLl//Bjy4xK2CxoMPmJVItqIVHHhCVhBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519878104; bh=tFLfoZYjHze0HRPzUjT0qDuhR0
    4AcA1Bcg/Qk5qmujk=; b=iYWEP3tNy6UjHSs/mDw6pAxVT+rzhyOq7Y8XanUmVL
    yVvLYY51Ms6TZ4LmVUy2YAa9dWuvl2dS3cIG76VXW7eG2RDLAVo8nXGQ/jNLSFjE
    h2lNY4GV7HTaRSN+q8oPE91umXWj0+Kamp5j9ro/MVZ8P9lKIgVwk9dRne3KI0vw
    hIyLWV3DgMbYxbSOXZg6f5nnOsuaQJou8kUummb5NIBtr6/Mn8+jx4/lKOUhSnJr
    9opfE+NevnvEY9yv5iE3Cjhd0fgfYzy2ybC1izbN7W6TBhI25c8qVz5cdc1ZPJQP
    AWcW2EXVIAl3TNI8VK7o2HNyof6aq7+1q/CKKOTeYQdA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965864AbeCAEUc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 23:20:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965860AbeCAET7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Feb 2018 23:19:59 -0500
Smtp-Origin-Hostprefix: devbig
From: Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig500.prn1.facebook.com
To: <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <torvalds@linux-foundation.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <rostedt@goodmis.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-api@vger.kernel.org>
Smtp-Origin-Cluster: prn1c29
Subject: [PATCH bpf-next 2/5] tracepoint: compute num_args at build time
Date: Wed, 28 Feb 2018 20:19:54 -0800
Message-ID: <20180301041957.399230-3-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180301041957.399230-1-ast@kernel.org>
References: <20180301041957.399230-1-ast@kernel.org>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

add fancy macro to compute number of arguments passed into tracepoint
at compile time and store it as part of 'struct tracepoint'.
The number is necessary to check safety of bpf program access that
is coming in subsequent patch.

for_each_tracepoint_range() api has no users inside the kernel.
Make it more useful with ability to stop for_each() loop depending
via callback return value.
In such form it's used in subsequent patch.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/tracepoint-defs.h |  1 +
 include/linux/tracepoint.h      | 32 +++++++++++++++++++++++---------
 include/trace/define_trace.h    | 14 +++++++-------
 kernel/tracepoint.c             | 27 ++++++++++++++++-----------
 4 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 64ed7064f1fa..39a283c61c51 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -33,6 +33,7 @@ struct tracepoint {
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
+	u32 num_args;
 };
 
 #endif
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index c94f466d57ef..b1676e53bb23 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -40,9 +40,19 @@ tracepoint_probe_register_prio(struct tracepoint *tp, void *probe, void *data,
 			       int prio);
 extern int
 tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data);
-extern void
-for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
-		void *priv);
+
+#ifdef CONFIG_TRACEPOINTS
+void *
+for_each_kernel_tracepoint(void *(*fct)(struct tracepoint *tp, void *priv),
+			   void *priv);
+#else
+static inline void *
+for_each_kernel_tracepoint(void *(*fct)(struct tracepoint *tp, void *priv),
+			   void *priv)
+{
+	return NULL;
+}
+#endif
 
 #ifdef CONFIG_MODULES
 struct tp_module {
@@ -225,23 +235,27 @@ extern void syscall_unregfunc(void);
 		return static_key_false(&__tracepoint_##name.key);	\
 	}
 
+#define ___FN_COUNT(fn,n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,n16,n,...) fn##n
+#define __FN_COUNT(fn,...) ___FN_COUNT(fn,##__VA_ARGS__,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0)
+#define __COUNT(...) __FN_COUNT(/**/,##__VA_ARGS__)
+
 /*
  * We have no guarantee that gcc and the linker won't up-align the tracepoint
  * structures, so we create an array of pointers that will be used for iteration
  * on the tracepoints.
  */
-#define DEFINE_TRACE_FN(name, reg, unreg)				 \
+#define DEFINE_TRACE_FN(name, reg, unreg, num_args)			 \
 	static const char __tpstrtab_##name[]				 \
 	__attribute__((section("__tracepoints_strings"))) = #name;	 \
 	struct tracepoint __tracepoint_##name				 \
 	__attribute__((section("__tracepoints"))) =			 \
-		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
+		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL, num_args };\
 	static struct tracepoint * const __tracepoint_ptr_##name __used	 \
 	__attribute__((section("__tracepoints_ptrs"))) =		 \
 		&__tracepoint_##name;
 
-#define DEFINE_TRACE(name)						\
-	DEFINE_TRACE_FN(name, NULL, NULL);
+#define DEFINE_TRACE(name, num_args)					\
+	DEFINE_TRACE_FN(name, NULL, NULL, num_args);
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
 	EXPORT_SYMBOL_GPL(__tracepoint_##name)
@@ -275,8 +289,8 @@ extern void syscall_unregfunc(void);
 		return false;						\
 	}
 
-#define DEFINE_TRACE_FN(name, reg, unreg)
-#define DEFINE_TRACE(name)
+#define DEFINE_TRACE_FN(name, reg, unreg, num_args)
+#define DEFINE_TRACE(name, num_args)
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)
 
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index d9e3d4aa3f6e..c040eda95d41 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -25,7 +25,7 @@
 
 #undef TRACE_EVENT
 #define TRACE_EVENT(name, proto, args, tstruct, assign, print)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, __COUNT(args))
 
 #undef TRACE_EVENT_CONDITION
 #define TRACE_EVENT_CONDITION(name, proto, args, cond, tstruct, assign, print) \
@@ -39,24 +39,24 @@
 #undef TRACE_EVENT_FN
 #define TRACE_EVENT_FN(name, proto, args, tstruct,		\
 		assign, print, reg, unreg)			\
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, __COUNT(args))
 
 #undef TRACE_EVENT_FN_COND
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,		\
 		assign, print, reg, unreg)			\
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, __COUNT(args))
 
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args) \
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, __COUNT(args))
 
 #undef DEFINE_EVENT_FN
 #define DEFINE_EVENT_FN(template, name, proto, args, reg, unreg) \
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, __COUNT(args))
 
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, __COUNT(args))
 
 #undef DEFINE_EVENT_CONDITION
 #define DEFINE_EVENT_CONDITION(template, name, proto, args, cond) \
@@ -64,7 +64,7 @@
 
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(name, proto, args)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, __COUNT(args))
 
 #undef TRACE_INCLUDE
 #undef __TRACE_INCLUDE
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 671b13457387..3f2dc5738c2b 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -502,17 +502,22 @@ static __init int init_tracepoints(void)
 __initcall(init_tracepoints);
 #endif /* CONFIG_MODULES */
 
-static void for_each_tracepoint_range(struct tracepoint * const *begin,
-		struct tracepoint * const *end,
-		void (*fct)(struct tracepoint *tp, void *priv),
-		void *priv)
+static void *for_each_tracepoint_range(struct tracepoint * const *begin,
+				       struct tracepoint * const *end,
+				       void *(*fct)(struct tracepoint *tp, void *priv),
+				       void *priv)
 {
 	struct tracepoint * const *iter;
+	void *ret;
 
 	if (!begin)
-		return;
-	for (iter = begin; iter < end; iter++)
-		fct(*iter, priv);
+		return NULL;
+	for (iter = begin; iter < end; iter++) {
+		ret = fct(*iter, priv);
+		if (ret)
+			return ret;
+	}
+	return NULL;
 }
 
 /**
@@ -520,11 +525,11 @@ static void for_each_tracepoint_range(struct tracepoint * const *begin,
  * @fct: callback
  * @priv: private data
  */
-void for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
-		void *priv)
+void *for_each_kernel_tracepoint(void *(*fct)(struct tracepoint *tp, void *priv),
+				 void *priv)
 {
-	for_each_tracepoint_range(__start___tracepoints_ptrs,
-		__stop___tracepoints_ptrs, fct, priv);
+	return for_each_tracepoint_range(__start___tracepoints_ptrs,
+					 __stop___tracepoints_ptrs, fct, priv);
 }
 EXPORT_SYMBOL_GPL(for_each_kernel_tracepoint);
 
-- 
2.9.5

