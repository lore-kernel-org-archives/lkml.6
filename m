Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5823FC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C9E2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C9E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeKHOoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:44:09 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:45309 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbeKHOoI (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 8 Nov 2018 09:44:08 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 07 Nov 2018 22:10:20 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk, dave@stgolabs.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 4/6] fs/epoll: robustify ep->mtx held checks
Date:   Wed,  7 Nov 2018 21:10:04 -0800
Message-Id: <20181108051006.18751-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181108051006.18751-1-dave@stgolabs.net>
References: <20181108051006.18751-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Insted of just commenting how important it is, lets make
it more robust and add a lockdep_assert_held() call.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 347da3f4f5d3..6a0c2591e57e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1637,6 +1637,8 @@ static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head
 	 * Items cannot vanish during the loop because ep_scan_ready_list() is
 	 * holding "mtx" during this call.
 	 */
+	lockdep_assert_held(&ep->mtx);
+
 	list_for_each_entry_safe(epi, tmp, head, rdllink) {
 		if (esed->res >= esed->maxevents)
 			break;
-- 
2.16.4

