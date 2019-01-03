Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149EFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15BF20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfACPBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:01:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:33112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729306AbfACPBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:01:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87136ADBD;
        Thu,  3 Jan 2019 15:01:12 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] epoll: make sure all elements in ready list are in FIFO order
Date:   Thu,  3 Jan 2019 16:01:01 +0100
Message-Id: <20190103150104.17128-2-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103150104.17128-1-rpenyaev@suse.de>
References: <20190103150104.17128-1-rpenyaev@suse.de>
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
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
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

