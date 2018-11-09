Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD711C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D17520825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D17520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeKJBeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:34:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:38110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbeKJBeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:34:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB309AE6C;
        Fri,  9 Nov 2018 15:53:06 +0000 (UTC)
Date:   Fri, 9 Nov 2018 07:52:58 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 5/6] fs/epoll: reduce the scope of wq lock in epoll_wait()
Message-ID: <20181109155258.jxcr4t2pnz6zqct3@linux-r8p5>
References: <20181108051006.18751-1-dave@stgolabs.net>
 <20181108051006.18751-6-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181108051006.18751-6-dave@stgolabs.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I just realized I forgot these fixlets when sending the v1.

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ec14e5bcdaa9..c37729658c03 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -381,7 +381,7 @@ static void ep_nested_calls_init(struct nested_calls *ncalls)
  */
 static inline int ep_events_available(struct eventpoll *ep)
 {
-	return !list_empty(&ep->rdllist) ||
+	return !list_empty_careful(&ep->rdllist) ||
 		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
 }
 
@@ -1820,8 +1820,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			res = -EINTR;
 			break;
 		}
-		
-		if (ep_events_available(ep))
+
+		eavail = ep_events_available(ep);
+		if (eavail)
 			break;
 		if (signal_pending(current)) {
 			res = -EINTR;
