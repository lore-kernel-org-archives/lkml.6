Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCE7C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816AA21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107271;
	bh=6p0QmFNwZe5fL6bkN6eZXHMnwiDCCe2DPCTzrZ5EjsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HSBUC11/fsOuBCBfsyMUJLE3EJ7uLV8LApspSk6CGHxIFLOyL0Kl4yrTu6Gv+cl+u
	 H1OEuJ1tISDoyVuL3be1SORGO8g0ceEkba5Pfwp6x8JsEejfLO0GzS/SnkNU13qh4d
	 7IOdoXs5Oe8i7VLLb7O9/HkjxlQB4vu5mbV/tJ5s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816AA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbeLFOlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728695AbeLFOlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2898820892;
        Thu,  6 Dec 2018 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107267;
        bh=6p0QmFNwZe5fL6bkN6eZXHMnwiDCCe2DPCTzrZ5EjsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbjN1k/bbImw4WYohAxMvXV2yNhGH21Doc0ZvddylLtZn0Mb+P8vLE5EV3c/7ke0n
         JSnVMdxOp673lfIHizlSb/KYMkVfP11w9sGjWmLwQM7nhzLRy+3IAdD6Ub32RZWfjh
         xHHFeH9I3Mt3r0K4pf+TFL4YxdSeL7vomgT9tOfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        linux-trace-devel@vger.kernel.org,
        Zenghui Yu <yuzenghui@huawei.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 09/41] tracepoint: Use __idx instead of idx in DO_TRACE macro to make it unique
Date:   Thu,  6 Dec 2018 15:38:49 +0100
Message-Id: <20181206142950.461941444@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zenghui Yu <yuzenghui@huawei.com>

commit 0c7a52e4d4b5c4d35b31f3c3ad32af814f1bf491 upstream.

After enabling KVM event tracing, almost all of trace_kvm_exit()'s
printk shows

	"kvm_exit: IRQ: ..."

even if the actual exception_type is NOT IRQ.  More specifically,
trace_kvm_exit() is defined in virt/kvm/arm/trace.h by TRACE_EVENT.

This slight problem may have existed after commit e6753f23d961
("tracepoint: Make rcuidle tracepoint callers use SRCU"). There are
two variables in trace_kvm_exit() and __DO_TRACE() which have the
same name, *idx*. Thus the actual value of *idx* will be overwritten
when tracing. Fix it by adding a simple prefix.

Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Wang Haibin <wanghaibin.wang@huawei.com>
Cc: linux-trace-devel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/tracepoint.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -166,7 +166,7 @@ static inline struct tracepoint *tracepo
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
 		void *__data;						\
-		int __maybe_unused idx = 0;				\
+		int __maybe_unused __idx = 0;				\
 									\
 		if (!(cond))						\
 			return;						\
@@ -182,7 +182,7 @@ static inline struct tracepoint *tracepo
 		 * doesn't work from the idle path.			\
 		 */							\
 		if (rcuidle) {						\
-			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
+			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
 			rcu_irq_enter_irqson();				\
 		}							\
 									\
@@ -198,7 +198,7 @@ static inline struct tracepoint *tracepo
 									\
 		if (rcuidle) {						\
 			rcu_irq_exit_irqson();				\
-			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
+			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
 		}							\
 									\
 		preempt_enable_notrace();				\


