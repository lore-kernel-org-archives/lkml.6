Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887DBC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FB32084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VwcrKzr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FB32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeLLWhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:37:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38375 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLWhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:37:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so27842pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFd3YwLBcxp6yAJtaHUNNfNu3+WWgtg3kk2/4oOmH+A=;
        b=VwcrKzr+NN1op4Hpo0jqWBNkVB/J747Aftu0QtxghTC3DHZcYIP+PWd+aOGxkdlb6M
         isX82CLttb7zTTlRuC9PIDyVvF177pQZVPwT3RZDeaqhxxalKJCJCFjhtEUsrm9Rcfsu
         tJ0ihbpNh44b90EqWBGkFwBPz7YV/fzhDZP14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFd3YwLBcxp6yAJtaHUNNfNu3+WWgtg3kk2/4oOmH+A=;
        b=NSnMyk0iJkoO6bfzCbcNNWqACRfFQj0mSbGp0pV/OIEe7IDN4zqNKO1D2CDnLXnomX
         /Wfj4NNTW1Ai7/wIZ2qoRmR43jadKNr+MnB0AIi7dRyKovjWrwJLMCsEMJdg5IxoGv4w
         ovsBh55bS9uL9yeBMm6VJayeY8n1RN2LsSloMjp9DlXMsz8kV3Z+F8Qa9Qhkcfng5pMu
         7/yh24x2s+heAlNEeixRG3MPEO4LBO7zoqqbiP7vIcM92OF+3JMB/GvNe3Uz2KdYcEHs
         rdMQpbp53rlbRogqJlgZP0kR5rgV/Uw2f+pW1wlQCAnsXPTjRUhrm+ZC6XLNl55CHF+6
         5SUg==
X-Gm-Message-State: AA+aEWaPCFIQdzRgcrW/b37c5qmflK0es6iE+GkVfq0EMLgaLiFuyzC1
        1huVmNJXm9YttBwc225DDYaLimPerbk=
X-Google-Smtp-Source: AFSGD/WwURh0hcAiQhwxElH0uTn1OtPDmZiHDK6e2iX3KEAdS2hVgd8uUBw8dZFDKYmMInsDANslSg==
X-Received: by 2002:aa7:8045:: with SMTP id y5mr21730423pfm.62.1544654240212;
        Wed, 12 Dec 2018 14:37:20 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id g15sm45153pfj.131.2018.12.12.14.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 14:37:19 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC] rcu: add sparse check to rcu_assign_pointer
Date:   Wed, 12 Dec 2018 14:37:10 -0800
Message-Id: <20181212223710.215094-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_assign_pointer currently doesn't do any sparse checking on a pointer
assigned. So its possible that a pointer that is not __rcu annotated is
assigned with rcu_assign_pointer without sparse complainting.
rcu_dereference already does such checking so lets also make
rcu_assign_pointer to do the same. The extra error could be helpful in
cases where an RCU pointer is assigned with rcu_assign_pointer but not
annotated with __rcu.

This doesn't generate any code in the normal case because __CHECKER__ is
defined only in the context of sparse.

Also we rename rcu_dereference_sparse to rcu_check_parse since the
checking now happens not only during derereferencing but also during
assignment.

Test: Introduced an rcu_assign_pointer in code and checked the output of
sparse with and without this change. The change correctly causes sparse
to throw an error.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 4db8bcacc51a..9e6f10da7f26 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -309,16 +309,16 @@ static inline void rcu_preempt_sleep_check(void) { }
  */
 
 #ifdef __CHECKER__
-#define rcu_dereference_sparse(p, space) \
+#define rcu_check_sparse(p, space) \
 	((void)(((typeof(*p) space *)p) == p))
 #else /* #ifdef __CHECKER__ */
-#define rcu_dereference_sparse(p, space)
+#define rcu_check_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
 
 #define __rcu_access_pointer(p, space) \
 ({ \
 	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
-	rcu_dereference_sparse(p, space); \
+	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(_________p1)); \
 })
 #define __rcu_dereference_check(p, c, space) \
@@ -326,13 +326,13 @@ static inline void rcu_preempt_sleep_check(void) { }
 	/* Dependency order vs. p above. */ \
 	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
-	rcu_dereference_sparse(p, space); \
+	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(________p1)); \
 })
 #define __rcu_dereference_protected(p, c, space) \
 ({ \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
-	rcu_dereference_sparse(p, space); \
+	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(p)); \
 })
 #define rcu_dereference_raw(p) \
@@ -382,6 +382,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_assign_pointer(p, v)					      \
 ({									      \
 	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
+	rcu_check_sparse(p, __rcu);				      \
 									      \
 	if (__builtin_constant_p(v) && (_r_a_p__v) == (uintptr_t)NULL)	      \
 		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
@@ -785,7 +786,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  */
 #define RCU_INIT_POINTER(p, v) \
 	do { \
-		rcu_dereference_sparse(p, __rcu); \
+		rcu_check_sparse(p, __rcu); \
 		WRITE_ONCE(p, RCU_INITIALIZER(v)); \
 	} while (0)
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

