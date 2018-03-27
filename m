Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeC0SwM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 14:52:12 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:37879 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751355AbeC0SwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 14:52:10 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:69:355:379:541:800:960:967:968:973:988:989:1260:1345:1437:1535:1544:1711:1730:1747:1777:1792:2194:2199:2393:2525:2559:2563:2682:2685:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6261:7903:9025:9592:10004:10848:11026:11232:11473:11658:11914:12043:12296:12438:12555:12679:12683:12740:12895:12986:14096:14181:14721:21080:21220:21451:21611:21627:30054:30056:30070,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: dime42_6a20a16dbed38
X-Filterd-Recvd-Size: 5079
From: Joe Perches <joe@perches.com>
To: David Howells <dhowells@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [resend PATCH] rxrpc: Neaten logging macros and add KERN_DEBUG logging level
Date: Tue, 27 Mar 2018 11:52:05 -0700
Message-Id: <35831b4769a0415ae7b975e88badb3033dbfe82d.1522176274.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabled, the current debug logging does not have a KERN_<LEVEL>.
Add KERN_DEBUG to the logging macros.

Miscellanea:

o Remove #define redundancy and neaten the macros a bit

Signed-off-by: Joe Perches <joe@perches.com>
---

Resend of patch: https://lkml.org/lkml/2017/11/30/573

No change in patch.

David Howells is now a listed maintainer for net/rxrpc/ so he should receive
this patch via get_maintainer

 net/rxrpc/ar-internal.h | 75 ++++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 416688381eb7..d4b53b2339b3 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1147,66 +1147,47 @@ static inline bool after_eq(u32 seq1, u32 seq2)
  */
 extern unsigned int rxrpc_debug;
 
-#define dbgprintk(FMT,...) \
-	printk("[%-6.6s] "FMT"\n", current->comm ,##__VA_ARGS__)
+#if defined(__KDEBUG) || defined(CONFIG_AF_RXRPC_DEBUG)
+#define dbgprintk(fmt, ...)						\
+	printk(KERN_DEBUG "[%-6.6s] " fmt "\n", current->comm, ##__VA_ARGS__)
+#else
+#define dbgprintk(fmt, ...)						\
+	no_printk(KERN_DEBUG "[%-6.6s] " fmt "\n", current->comm, ##__VA_ARGS__)
+#endif
 
-#define kenter(FMT,...)	dbgprintk("==> %s("FMT")",__func__ ,##__VA_ARGS__)
-#define kleave(FMT,...)	dbgprintk("<== %s()"FMT"",__func__ ,##__VA_ARGS__)
-#define kdebug(FMT,...)	dbgprintk("    "FMT ,##__VA_ARGS__)
-#define kproto(FMT,...)	dbgprintk("### "FMT ,##__VA_ARGS__)
-#define knet(FMT,...)	dbgprintk("@@@ "FMT ,##__VA_ARGS__)
+#define kenter(fmt, ...)	dbgprintk("==> %s(" fmt ")", __func__, ##__VA_ARGS__)
+#define kleave(fmt, ...)	dbgprintk("<== %s()" fmt "", __func__, ##__VA_ARGS__)
+#define kdebug(fmt, ...)	dbgprintk("    " fmt, ##__VA_ARGS__)
+#define kproto(fmt, ...)	dbgprintk("### " fmt, ##__VA_ARGS__)
+#define knet(fmt, ...)		dbgprintk("@@@ " fmt, ##__VA_ARGS__)
 
+#if defined(__KDEBUG) || !defined(CONFIG_AF_RXRPC_DEBUG)
+#define _enter(fmt, ...)	kenter(fmt, ##__VA_ARGS__)
+#define _leave(fmt, ...)	kleave(fmt, ##__VA_ARGS__)
+#define _debug(fmt, ...)	kdebug(fmt, ##__VA_ARGS__)
+#define _proto(fmt, ...)	kproto(fmt, ##__VA_ARGS__)
+#define _net(fmt, ...)		knet(fmt, ##__VA_ARGS__)
 
-#if defined(__KDEBUG)
-#define _enter(FMT,...)	kenter(FMT,##__VA_ARGS__)
-#define _leave(FMT,...)	kleave(FMT,##__VA_ARGS__)
-#define _debug(FMT,...)	kdebug(FMT,##__VA_ARGS__)
-#define _proto(FMT,...)	kproto(FMT,##__VA_ARGS__)
-#define _net(FMT,...)	knet(FMT,##__VA_ARGS__)
+#else
 
-#elif defined(CONFIG_AF_RXRPC_DEBUG)
 #define RXRPC_DEBUG_KENTER	0x01
 #define RXRPC_DEBUG_KLEAVE	0x02
 #define RXRPC_DEBUG_KDEBUG	0x04
 #define RXRPC_DEBUG_KPROTO	0x08
 #define RXRPC_DEBUG_KNET	0x10
 
-#define _enter(FMT,...)					\
-do {							\
-	if (unlikely(rxrpc_debug & RXRPC_DEBUG_KENTER))	\
-		kenter(FMT,##__VA_ARGS__);		\
-} while (0)
-
-#define _leave(FMT,...)					\
-do {							\
-	if (unlikely(rxrpc_debug & RXRPC_DEBUG_KLEAVE))	\
-		kleave(FMT,##__VA_ARGS__);		\
-} while (0)
-
-#define _debug(FMT,...)					\
-do {							\
-	if (unlikely(rxrpc_debug & RXRPC_DEBUG_KDEBUG))	\
-		kdebug(FMT,##__VA_ARGS__);		\
-} while (0)
-
-#define _proto(FMT,...)					\
-do {							\
-	if (unlikely(rxrpc_debug & RXRPC_DEBUG_KPROTO))	\
-		kproto(FMT,##__VA_ARGS__);		\
+#define RXRPC_DEBUG(TYPE, type, fmt, ...)				\
+do {									\
+	if (unlikely(rxrpc_debug & RXRPC_DEBUG_##TYPE))			\
+		type(fmt, ##__VA_ARGS__);				\
 } while (0)
 
-#define _net(FMT,...)					\
-do {							\
-	if (unlikely(rxrpc_debug & RXRPC_DEBUG_KNET))	\
-		knet(FMT,##__VA_ARGS__);		\
-} while (0)
+#define _enter(fmt, ...)	RXRPC_DEBUG(KENTER, kenter, fmt, ##__VA_ARGS__)
+#define _leave(fmt, ...)	RXRPC_DEBUG(KLEAVE, kleave, fmt, ##__VA_ARGS__)
+#define _debug(fmt, ...)	RXRPC_DEBUG(KDEBUG, kdebug, fmt, ##__VA_ARGS__)
+#define _proto(fmt, ...)	RXRPC_DEBUG(KPROTO, kproto, fmt, ##__VA_ARGS__)
+#define _net(fmt, ...)		RXRPC_DEBUG(KNET, knet, fmt, ##__VA_ARGS__)
 
-#else
-#define _enter(FMT,...)	no_printk("==> %s("FMT")",__func__ ,##__VA_ARGS__)
-#define _leave(FMT,...)	no_printk("<== %s()"FMT"",__func__ ,##__VA_ARGS__)
-#define _debug(FMT,...)	no_printk("    "FMT ,##__VA_ARGS__)
-#define _proto(FMT,...)	no_printk("### "FMT ,##__VA_ARGS__)
-#define _net(FMT,...)	no_printk("@@@ "FMT ,##__VA_ARGS__)
 #endif
 
 /*
-- 
2.15.0
