Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FCEC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663BA20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663BA20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeKHOoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:44:12 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:45488 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHOoJ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 8 Nov 2018 09:44:09 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 07 Nov 2018 22:10:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk, dave@stgolabs.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] fs/epoll: avoid barrier after an epoll_wait(2) timeout
Date:   Wed,  7 Nov 2018 21:10:06 -0800
Message-Id: <20181108051006.18751-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181108051006.18751-1-dave@stgolabs.net>
References: <20181108051006.18751-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon timeout, we can just exit out of the loop, without
the cost of the changing the task's state smp_store_mb
call. Just exit out of the loop and be done - setting
the task state afterwards will be, of course, redundant.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/eventpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f6c023f085f6..ec14e5bcdaa9 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1820,15 +1820,18 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			res = -EINTR;
 			break;
 		}
-		if (ep_events_available(ep) || timed_out)
+		
+		if (ep_events_available(ep))
 			break;
 		if (signal_pending(current)) {
 			res = -EINTR;
 			break;
 		}
 
-		if (!schedule_hrtimeout_range(to, slack, HRTIMER_MODE_ABS))
+		if (!schedule_hrtimeout_range(to, slack, HRTIMER_MODE_ABS)) {
 			timed_out = 1;
+			break;
+		}
 	}
 
 	__set_current_state(TASK_RUNNING);
-- 
2.16.4

