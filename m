Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeFELsg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:48:36 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeFELsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:48:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: stub out ioprio_check_cap for !CONFIG_BLOCK
Date: Tue,  5 Jun 2018 13:47:41 +0200
Message-Id: <20180605114756.1517549-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Y6L/cJLYaX+ZjLDaxOizSH3E7uGVjAFTZ2UlDqkmZauEtPBmZig
 5ILglaIbLc65UDbAyFRETp00uxbh2CWQBsvCyAq4xFHRAJeqHPZ0ul0yDz8p2kf96pKEK0H
 NxEp+yLJAzRzxLVPhPAG9y/KxKEe5ayN586NzjYJctJz/0KgwieuNNf/9H1lQG5qqDMDjZc
 alc/lLG4lvnvMgX6KtHjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3YqM4I1y2Gw=:j5ajDEHEGqnkwxdVflfqcl
 qKHBxfBR+B//rWlCldTk7SubcDC5bzAhhqdqEld53bqFaiM1F3CWQECNZjxhX5FLFcw7fDJms
 FmuzDv9ObFCishWCjumbr909C8CAzVCvPcU9XM8BP7VnyL/zACD0a4t68nvioSl3Kjma0rT4b
 ok9CoaTNL4c73GcwCw+csg1faCA9nqnJzpSnotOTmu69+QcQIDC8WKf4ALG6SVsDscErFuvWC
 dmkoq9wi0oZDdipR/uKGhsVp/WlL+fOsRAUjVuu78x8vJh9K3Gphb3uMya24nPs/g37HS3nW1
 PYULwQyA+JNrJ+byy/Svhm3cyddWYn/PGQZzpSMLB1dfLPAKmqWl3OgoGsZPDDRdqG63/UMuJ
 jVMpGaq5fDi4Kj/WlPN8K1a1rqzJKMiqI7lDe43scLxV/vYEqVoKTwSmZLFXYhokqVflkFV3n
 +FC3juBOTMQGGGR4SSads7nG8OzMNzWbUNXyHolsoKnH6nOdDE3ohm+hXBpqxjTi922fsjgam
 cCVZmmw59dbIVBkSSamJduNHsIpf1wNNZqmiDyLOpN7sxHSiw6yZyRIIUs0yM0F9/f6U1jtwN
 4ebSnkhChA96Fk1qiQWqT/fGTNeJX4IsLsqOTuWzt1jk9f4cFMazY4wglzpIaBwrt3wcBXpP2
 v+M+GzjMeTt3J4gkkppBm9X66mcBuSsM/L4e7J3sr2fK7rEqxGppjbfU/8ArqjeEC3pw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BLOCK is disabled, we now run into a link error:

fs/aio.o: In function `aio_prep_rw':
aio.c:(.text+0xf68): undefined reference to `ioprio_check_cap'

Since the priorities are unused without block devices, this adds a stub
that always returns success.

Fixes: d9a08a9e616b ("fs: Add aio iopriority support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure if my assertion is correct, please check that returning zero
actually makes sense here.
---
 include/linux/ioprio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 4a28cec49ec3..ccc2a44483b6 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -77,6 +77,13 @@ extern int ioprio_best(unsigned short aprio, unsigned short bprio);
 
 extern int set_task_ioprio(struct task_struct *task, int ioprio);
 
+#ifdef CONFIG_BLOCK
 extern int ioprio_check_cap(int ioprio);
+#else
+static inline int ioprio_check_cap(int ioprio)
+{
+	return 0;
+}
+#endif
 
 #endif
-- 
2.9.0
