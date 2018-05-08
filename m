Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeEHQV4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:21:56 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:56397 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755528AbeEHQVy (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 8 May 2018 12:21:54 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 4/6] net: Update netstamp_needed static key to modern api
Date: Tue,  8 May 2018 09:07:01 -0700
Message-Id: <20180508160703.8125-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180508160703.8125-1-dave@stgolabs.net>
References: <20180508160703.8125-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in refcount semantics -- key init is false; replace

static_key_slow_inc|dec   with   static_branch_inc|dec
static_key_false          with   static_branch_unlikely

Added a '_key' suffix to netstamp_needed, for better self
documentation.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 net/core/dev.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 64483afb7b90..668be88b5308 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1786,7 +1786,7 @@ void net_dec_egress_queue(void)
 EXPORT_SYMBOL_GPL(net_dec_egress_queue);
 #endif
 
-static struct static_key netstamp_needed __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
 #ifdef HAVE_JUMP_LABEL
 static atomic_t netstamp_needed_deferred;
 static atomic_t netstamp_wanted;
@@ -1797,9 +1797,9 @@ static void netstamp_clear(struct work_struct *work)
 
 	wanted = atomic_add_return(deferred, &netstamp_wanted);
 	if (wanted > 0)
-		static_key_enable(&netstamp_needed);
+		static_branch_enable(&netstamp_needed_key);
 	else
-		static_key_disable(&netstamp_needed);
+		static_branch_disable(&netstamp_needed_key);
 }
 static DECLARE_WORK(netstamp_work, netstamp_clear);
 #endif
@@ -1819,7 +1819,7 @@ void net_enable_timestamp(void)
 	atomic_inc(&netstamp_needed_deferred);
 	schedule_work(&netstamp_work);
 #else
-	static_key_slow_inc(&netstamp_needed);
+	static_branch_inc(&netstamp_needed_key);
 #endif
 }
 EXPORT_SYMBOL(net_enable_timestamp);
@@ -1839,7 +1839,7 @@ void net_disable_timestamp(void)
 	atomic_dec(&netstamp_needed_deferred);
 	schedule_work(&netstamp_work);
 #else
-	static_key_slow_dec(&netstamp_needed);
+	static_branch_dec(&netstamp_needed_key);
 #endif
 }
 EXPORT_SYMBOL(net_disable_timestamp);
@@ -1847,15 +1847,15 @@ EXPORT_SYMBOL(net_disable_timestamp);
 static inline void net_timestamp_set(struct sk_buff *skb)
 {
 	skb->tstamp = 0;
-	if (static_key_false(&netstamp_needed))
+	if (static_branch_unlikely(&netstamp_needed_key))
 		__net_timestamp(skb);
 }
 
-#define net_timestamp_check(COND, SKB)			\
-	if (static_key_false(&netstamp_needed)) {		\
-		if ((COND) && !(SKB)->tstamp)	\
-			__net_timestamp(SKB);		\
-	}						\
+#define net_timestamp_check(COND, SKB)				\
+	if (static_branch_unlikely(&netstamp_needed_key)) {	\
+		if ((COND) && !(SKB)->tstamp)			\
+			__net_timestamp(SKB);			\
+	}							\
 
 bool is_skb_forwardable(const struct net_device *dev, const struct sk_buff *skb)
 {
-- 
2.13.6
