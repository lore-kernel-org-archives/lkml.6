Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EF6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55B52245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55B52245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeKOEaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:30:01 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:40724 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOEaB (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 14 Nov 2018 23:30:01 -0500
Received: from localhost.localdomain (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 14 Nov 2018 11:25:42 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] fs/epoll: rename check_events label to send_events
Date:   Wed, 14 Nov 2018 10:25:31 -0800
Message-Id: <20181114182532.27981-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is currently called check_events because it, well, did
exactly that. However, since the lockless ep_events_available()
call, the label no longer checks, but just sends the events.
Rename as such.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---

Both patch 1 and 2 apply on top of the mmots.

 fs/eventpoll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ec14e5bcdaa9..7e2b5f3d6b3e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1774,7 +1774,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		eavail = ep_events_available(ep);
 		spin_unlock_irq(&ep->wq.lock);
 
-		goto check_events;
+		goto send_events;
 	}
 
 fetch_events:
@@ -1784,7 +1784,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 	eavail = ep_events_available(ep);
 	if (eavail)
-		goto check_events;
+		goto send_events;
 
 	/*
 	 * Busy poll timed out.  Drop NAPI ID for now, we can add
@@ -1840,7 +1840,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	__remove_wait_queue(&ep->wq, &wait);
 	spin_unlock_irq(&ep->wq.lock);
 
-check_events:
+send_events:
 	/*
 	 * Try to transfer events to user space. In case we get 0 events and
 	 * there's still timeout left over, we go trying again in search of
-- 
2.16.4

