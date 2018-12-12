Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D354EC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12FB2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12FB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeLLLEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:04:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:46018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbeLLLEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:04:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63E23AE8A;
        Wed, 12 Dec 2018 11:04:31 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] epoll: make sure all elements in ready list are in FIFO order
Date:   Wed, 12 Dec 2018 12:03:55 +0100
Message-Id: <20181212110357.25656-2-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212110357.25656-1-rpenyaev@suse.de>
References: <20181212110357.25656-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All coming events are stored in FIFO order and this is also should be
applicable to ->ovflist, which originally is stack, i.e. LIFO.

Thus to keep correct FIFO order ->ovflist should reversed by adding
elements to the head of the read list but not to the tail.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2329f96469e2..3627c2e07149 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -722,7 +722,11 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 		 * contain them, and the list_splice() below takes care of them.
 		 */
 		if (!ep_is_linked(epi)) {
-			list_add_tail(&epi->rdllink, &ep->rdllist);
+			/*
+			 * ->ovflist is LIFO, so we have to reverse it in order
+			 * to keep in FIFO.
+			 */
+			list_add(&epi->rdllink, &ep->rdllist);
 			ep_pm_stay_awake(epi);
 		}
 	}
-- 
2.19.1

