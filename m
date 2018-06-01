Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeFANXQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:23:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34211 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeFANXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:23:01 -0400
X-Google-Smtp-Source: ADUXVKKyUXLL92InfjACaQRDgPTnV0rlCqFTUyh/ButOeNP8pFjA77z835tvP5//ZDrzexE7SWDS3Q==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 10/17] signal: make has_pending_signals() return bool
Date: Fri,  1 Jun 2018 15:22:32 +0200
Message-Id: <20180601132239.4421-11-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

has_pending_signals() already behaves like a boolean function. Let's
actually declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e48675bd3be8..faf38b46d124 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -110,30 +110,33 @@ static bool sig_ignored(struct task_struct *t, int sig, bool force)
  * Re-calculate pending state from the set of locally pending
  * signals, globally pending signals, and blocked signals.
  */
-static inline int has_pending_signals(sigset_t *signal, sigset_t *blocked)
+static inline bool has_pending_signals(sigset_t *signal, sigset_t *blocked)
 {
 	unsigned long ready;
 	long i;
 
 	switch (_NSIG_WORDS) {
 	default:
-		for (i = _NSIG_WORDS, ready = 0; --i >= 0 ;)
-			ready |= signal->sig[i] &~ blocked->sig[i];
+		for (i = _NSIG_WORDS, ready = 0; --i >= 0;)
+			ready |= signal->sig[i] & ~blocked->sig[i];
 		break;
 
-	case 4: ready  = signal->sig[3] &~ blocked->sig[3];
-		ready |= signal->sig[2] &~ blocked->sig[2];
-		ready |= signal->sig[1] &~ blocked->sig[1];
-		ready |= signal->sig[0] &~ blocked->sig[0];
+	case 4:
+		ready = signal->sig[3] & ~blocked->sig[3];
+		ready |= signal->sig[2] & ~blocked->sig[2];
+		ready |= signal->sig[1] & ~blocked->sig[1];
+		ready |= signal->sig[0] & ~blocked->sig[0];
 		break;
 
-	case 2: ready  = signal->sig[1] &~ blocked->sig[1];
-		ready |= signal->sig[0] &~ blocked->sig[0];
+	case 2:
+		ready = signal->sig[1] & ~blocked->sig[1];
+		ready |= signal->sig[0] & ~blocked->sig[0];
 		break;
 
-	case 1: ready  = signal->sig[0] &~ blocked->sig[0];
+	case 1:
+		ready = signal->sig[0] & ~blocked->sig[0];
 	}
-	return ready !=	0;
+	return ready != 0;
 }
 
 #define PENDING(p,b) has_pending_signals(&(p)->signal, (b))
-- 
2.17.0
