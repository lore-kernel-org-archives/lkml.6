Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9A2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E27208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E27208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbeG0OVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:21:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730971AbeG0OVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:21:39 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fj2LP-0007KR-NY; Fri, 27 Jul 2018 14:59:43 +0200
Date:   Fri, 27 Jul 2018 14:59:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        Peter Zilstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH RT] Revert "crypto: Convert crypto notifier chain to SRCU"
Message-ID: <20180727125943.zc5v5cmez7swonek@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit Revert "crypto: Convert crypto notifier chain to
SRCU".
This is not longer required because the rwsem is now multi reader
capable on RT.
The other concern was a deadlock because the rwsem is fifo writer fair
in regard to incoming reader. This is currently not an issue because we
have only one crypto_register_notifier() user, which is invoked before
the reader (blocking_notifier_call_chain()) are coming.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 crypto/algapi.c   | 4 ++--
 crypto/api.c      | 6 +++---
 crypto/internal.h | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 99ed1c74217f..395b082d03a9 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -726,13 +726,13 @@ EXPORT_SYMBOL_GPL(crypto_spawn_tfm2);
 
 int crypto_register_notifier(struct notifier_block *nb)
 {
-	return srcu_notifier_chain_register(&crypto_chain, nb);
+	return blocking_notifier_chain_register(&crypto_chain, nb);
 }
 EXPORT_SYMBOL_GPL(crypto_register_notifier);
 
 int crypto_unregister_notifier(struct notifier_block *nb)
 {
-	return srcu_notifier_chain_unregister(&crypto_chain, nb);
+	return blocking_notifier_chain_unregister(&crypto_chain, nb);
 }
 EXPORT_SYMBOL_GPL(crypto_unregister_notifier);
 
diff --git a/crypto/api.c b/crypto/api.c
index d4bbeba587f9..70a894e52ff3 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -32,7 +32,7 @@ EXPORT_SYMBOL_GPL(crypto_alg_list);
 DECLARE_RWSEM(crypto_alg_sem);
 EXPORT_SYMBOL_GPL(crypto_alg_sem);
 
-SRCU_NOTIFIER_HEAD(crypto_chain);
+BLOCKING_NOTIFIER_HEAD(crypto_chain);
 EXPORT_SYMBOL_GPL(crypto_chain);
 
 static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg);
@@ -237,10 +237,10 @@ int crypto_probing_notify(unsigned long val, void *v)
 {
 	int ok;
 
-	ok = srcu_notifier_call_chain(&crypto_chain, val, v);
+	ok = blocking_notifier_call_chain(&crypto_chain, val, v);
 	if (ok == NOTIFY_DONE) {
 		request_module("cryptomgr");
-		ok = srcu_notifier_call_chain(&crypto_chain, val, v);
+		ok = blocking_notifier_call_chain(&crypto_chain, val, v);
 	}
 
 	return ok;
diff --git a/crypto/internal.h b/crypto/internal.h
index 998a6af375d4..5ac27fba10e8 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -44,7 +44,7 @@ struct crypto_larval {
 
 extern struct list_head crypto_alg_list;
 extern struct rw_semaphore crypto_alg_sem;
-extern struct srcu_notifier_head crypto_chain;
+extern struct blocking_notifier_head crypto_chain;
 
 #ifdef CONFIG_PROC_FS
 void __init crypto_init_proc(void);
@@ -139,7 +139,7 @@ static inline int crypto_is_moribund(struct crypto_alg *alg)
 
 static inline void crypto_notify(unsigned long val, void *v)
 {
-	srcu_notifier_call_chain(&crypto_chain, val, v);
+	blocking_notifier_call_chain(&crypto_chain, val, v);
 }
 
 #endif	/* _CRYPTO_INTERNAL_H */
-- 
2.18.0

