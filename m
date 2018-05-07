Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeEGN56 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:57:58 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:45492 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752082AbeEGN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:57:50 -0400
From: Julia Cartwright <julia@ni.com>
To: <bigeasy@linutronix.de>, <tglx@linutronix.de>
CC: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Phillip Lougher" <phillip@squashfs.org.uk>,
        Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH RT 1/2] locallock: provide {get,put}_locked_ptr() variants
Date: Mon, 7 May 2018 08:58:56 -0500
Message-ID: <20180507135857.7565-1-julia@ni.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <4064553.Shs7ScuBS6@ws-stein>
References: <4064553.Shs7ScuBS6@ws-stein>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a set of locallocked accessors for pointers to per-CPU data;
this is useful for dynamically-allocated per-CPU regions, for example.

These are symmetric with the {get,put}_cpu_ptr() per-CPU accessor
variants.

Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/locallock.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index d658c2552601..921eab83cd34 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -222,6 +222,14 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 #define put_locked_var(lvar, var)	local_unlock(lvar);
 
+#define get_locked_ptr(lvar, var)					\
+	({								\
+		local_lock(lvar);					\
+		this_cpu_ptr(var);					\
+	})
+
+#define put_locked_ptr(lvar, var)	local_unlock(lvar);
+
 #define local_lock_cpu(lvar)						\
 	({								\
 		local_lock(lvar);					\
@@ -262,6 +270,8 @@ static inline void local_irq_lock_init(int lvar) { }
 
 #define get_locked_var(lvar, var)		get_cpu_var(var)
 #define put_locked_var(lvar, var)		put_cpu_var(var)
+#define get_locked_ptr(lvar, var)		get_cpu_ptr(var)
+#define put_locked_ptr(lvar, var)		put_cpu_ptr(var)
 
 #define local_lock_cpu(lvar)			get_cpu()
 #define local_unlock_cpu(lvar)			put_cpu()
-- 
2.17.0
