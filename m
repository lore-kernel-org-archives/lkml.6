Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEFCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C71920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C71920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbeKTHBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:01:15 -0500
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:39133 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728938AbeKTHBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:01:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 63601500F;
        Mon, 19 Nov 2018 20:35:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: act99_6d9b0cf864657
X-Filterd-Recvd-Size: 5573
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 19 Nov 2018 20:35:53 +0000 (UTC)
Message-ID: <322d852e776daacb811063031257124dd8949921.camel@perches.com>
Subject: [resend PATCH  for 3rd time] rxrpc: Neaten logging macros and add
 KERN_DEBUG logging level
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Nov 2018 12:35:52 -0800
In-Reply-To: <60269865c424b9fa853e22c68c0376a60bfbb171.camel@perches.com>
References: <35831b4769a0415ae7b975e88badb3033dbfe82d.1522176274.git.joe@perches.com>
         <60269865c424b9fa853e22c68c0376a60bfbb171.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabled, the current debug logging does not have a KERN_<LEVEL>.
Add KERN_DEBUG to the logging macros.

Miscellanea:
o Remove #define redundancy and neaten the macros a bit> 

Signed-off-by: Joe Perches <joe@perches.com>
---

v3: Remerge into -next, with new file/patch offsets

On Fri, 2018-05-11 at 09:29 -0700, Joe Perches wrote:
> ping?
> > Resend of patch: https://lkml.org/lkml/2017/11/30/573
> > No change in patch.
> > David Howells is now a listed maintainer for net/rxrpc/ so he should receive
> > this patch via get_maintainer

David, is there anything amiss with this patch?

 net/rxrpc/ar-internal.h | 75 ++++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index bc628acf4f4f..022cb15dfa00 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1140,66 +1140,47 @@ static inline bool after_eq(u32 seq1, u32 seq2)
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

