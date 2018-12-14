Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3ADC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9042220892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9042220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeLNKwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:52:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbeLNKwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:52:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E80AE307EA84;
        Fri, 14 Dec 2018 10:52:21 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.32.181.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C08B26FA9;
        Fri, 14 Dec 2018 10:52:20 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org,
        Edward Cree <ecree@solarflare.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH net-next v3 1/4] indirect call wrappers: helpers to speed-up indirect calls of builtin
Date:   Fri, 14 Dec 2018 11:51:57 +0100
Message-Id: <645eb0fcfe12b7765d2a27025b1806247649f783.1544784419.git.pabeni@redhat.com>
In-Reply-To: <cover.1544784419.git.pabeni@redhat.com>
References: <cover.1544784419.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 14 Dec 2018 10:52:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header define a bunch of helpers that allow avoiding the
retpoline overhead when calling builtin functions via function pointers.
It boils down to explicitly comparing the function pointers to
known builtin functions and eventually invoke directly the latter.

The macros defined here implement the boilerplate for the above schema
and will be used by the next patches.

rfc -> v1:
 - use branch prediction hint, as suggested by Eric
v1  -> v2:
 - list explicitly the builtin function names in INDIRECT_CALL_*(),
   as suggested by Ed Cree

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/indirect_call_wrapper.h | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 include/linux/indirect_call_wrapper.h

diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
new file mode 100644
index 000000000000..7c8b7f4948af
--- /dev/null
+++ b/include/linux/indirect_call_wrapper.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_INDIRECT_CALL_WRAPPER_H
+#define _LINUX_INDIRECT_CALL_WRAPPER_H
+
+#ifdef CONFIG_RETPOLINE
+
+/*
+ * INDIRECT_CALL_$NR - wrapper for indirect calls with $NR known builtin
+ *  @f: function pointer
+ *  @f$NR: builtin functions names, up to $NR of them
+ *  @__VA_ARGS__: arguments for @f
+ *
+ * Avoid retpoline overhead for known builtin, checking @f vs each of them and
+ * eventually invoking directly the builtin function. The functions are check
+ * in the given order. Fallback to the indirect call.
+ */
+#define INDIRECT_CALL_1(f, f1, ...)					\
+	({								\
+		likely(f == f1) ? f1(__VA_ARGS__) : f(__VA_ARGS__);	\
+	})
+#define INDIRECT_CALL_2(f, f2, f1, ...)					\
+	({								\
+		likely(f == f2) ? f2(__VA_ARGS__) :			\
+				  INDIRECT_CALL_1(f, f1, __VA_ARGS__);	\
+	})
+
+#define INDIRECT_CALLABLE_DECLARE(f)	f
+#define INDIRECT_CALLABLE_SCOPE
+
+#else
+#define INDIRECT_CALL_1(f, name, ...) f(__VA_ARGS__)
+#define INDIRECT_CALL_2(f, name, ...) f(__VA_ARGS__)
+#define INDIRECT_CALLABLE_DECLARE(f)
+#define INDIRECT_CALLABLE_SCOPE		static
+#endif
+
+/*
+ * We can use INDIRECT_CALL_$NR for ipv6 related functions only if ipv6 is
+ * builtin, this macro simplify dealing with indirect calls with only ipv4/ipv6
+ * alternatives
+ */
+#if IS_BUILTIN(CONFIG_IPV6)
+#define INDIRECT_CALL_INET(f, f2, f1, ...) \
+	INDIRECT_CALL_2(f, f2, f1, __VA_ARGS__)
+#elif IS_ENABLED(CONFIG_INET)
+#define INDIRECT_CALL_INET(f, f2, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
+#else
+#define INDIRECT_CALL_INET(f, f2, f1, ...) f(__VA_ARGS__)
+#endif
+
+#endif
-- 
2.19.2

