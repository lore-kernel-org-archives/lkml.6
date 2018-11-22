Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67B4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877C6205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877C6205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391026AbeKVW6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:58:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729105AbeKVW6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:58:30 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BEB3F16A7E52A;
        Thu, 22 Nov 2018 20:19:18 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Thu, 22 Nov 2018 20:19:11 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [RFC] tracepoint: fix bad trace value in trace_kvm_exit()
Date:   Thu, 22 Nov 2018 12:17:30 +0000
Message-ID: <1542889050-23144-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enabling KVM event tracing, almost all of trace_kvm_exit()'s
printk shows
	"kvm_exit: IRQ: ..."
even if the actual exception_type is NOT IRQ.

This slight problem may have existed after commit e6753f2. There are
two variables in trace_kvm_exit() and __DO_TRACE() which have the
same name, *idx*. Thus the actual value of *idx* will be overwritten
when tracing.

So, what about this stupid patch?

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Wang Haibin <wanghaibin.wang@huawei.com>
---
 include/linux/tracepoint.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 538ba1a..e9de8ad 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -166,7 +166,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
 		void *__data;						\
-		int __maybe_unused idx = 0;				\
+		int __maybe_unused __idx = 0;				\
 									\
 		if (!(cond))						\
 			return;						\
@@ -182,7 +182,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		 * doesn't work from the idle path.			\
 		 */							\
 		if (rcuidle) {						\
-			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
+			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
 			rcu_irq_enter_irqson();				\
 		}							\
 									\
@@ -198,7 +198,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 									\
 		if (rcuidle) {						\
 			rcu_irq_exit_irqson();				\
-			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
+			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
 		}							\
 									\
 		preempt_enable_notrace();				\
-- 
1.8.3.1


