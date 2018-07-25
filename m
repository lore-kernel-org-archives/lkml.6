Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8065C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C2D204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C2D204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbeGYUJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:09:30 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:50946 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeGYUJa (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 25 Jul 2018 16:09:30 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 25 Jul 2018 12:56:27 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -next] fs/epoll: simply CONFIG_NET_RX_BUSY_POLL ifdefery
Date:   Wed, 25 Jul 2018 11:56:20 -0700
Message-Id: <20180725185620.11020-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... 'tis easier on the eye.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1b1abc461fc0..0ab82d0d4e02 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -391,7 +391,6 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
 
 	return ep_events_available(ep) || busy_loop_timeout(start_time);
 }
-#endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
  * Busy poll if globally on and supporting sockets found && no events,
@@ -401,20 +400,16 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
  */
 static void ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
-#ifdef CONFIG_NET_RX_BUSY_POLL
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 
 	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on())
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep);
-#endif
 }
 
 static inline void ep_reset_busy_poll_napi_id(struct eventpoll *ep)
 {
-#ifdef CONFIG_NET_RX_BUSY_POLL
 	if (ep->napi_id)
 		ep->napi_id = 0;
-#endif
 }
 
 /*
@@ -422,7 +417,6 @@ static inline void ep_reset_busy_poll_napi_id(struct eventpoll *ep)
  */
 static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 {
-#ifdef CONFIG_NET_RX_BUSY_POLL
 	struct eventpoll *ep;
 	unsigned int napi_id;
 	struct socket *sock;
@@ -452,9 +446,15 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 
 	/* record NAPI ID for use in next busy poll */
 	ep->napi_id = napi_id;
-#endif
 }
 
+#else
+#define ep_busy_loop(ep, nonblock)		do { } while (0)
+#define ep_reset_busy_poll_napi_id(ep)		do { } while (0)
+#define ep_set_busy_poll_napi_id(epi)		do { } while (0)
+
+#endif /* CONFIG_NET_RX_BUSY_POLL */
+
 /**
  * ep_call_nested - Perform a bound (possibly) nested call, by checking
  *                  that the recursion limit is not exceeded, and that
-- 
2.16.4

