Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7740AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBB820815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfACPB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:01:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:33138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730154AbfACPBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:01:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33A56AE11;
        Thu,  3 Jan 2019 15:01:13 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] epoll: unify awaking of wakeup source on ep_poll_callback() path
Date:   Thu,  3 Jan 2019 16:01:03 +0100
Message-Id: <20190103150104.17128-4-rpenyaev@suse.de>
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

Original comment "Activate ep->ws since epi->ws may get deactivated
at any time" indeed sounds loud, but it is incorrect, because the path
where we check epi->ws is a path where insert to ovflist happens, i.e.
ep_scan_ready_list() has taken ep->mtx and waits for this callback
to finish, thus ep_modify() (which unregisters wakeup source) waits
for ep_scan_ready_list().

Here in this patch I simply call ep_pm_stay_awake_rcu(), which is
a bit extra for this path (indirectly protected by main ep->mtx, so
even rcu is not needed), but I do not want to create another naked
__ep_pm_stay_awake() variant only for this particular case, so rcu
variant is just better for all the cases.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3c373a510f65..0122b9147542 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1167,14 +1167,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		if (epi->next == EP_UNACTIVE_PTR) {
 			epi->next = READ_ONCE(ep->ovflist);
 			WRITE_ONCE(ep->ovflist, epi);
-			if (epi->ws) {
-				/*
-				 * Activate ep->ws since epi->ws may get
-				 * deactivated at any time.
-				 */
-				__pm_stay_awake(ep->ws);
-			}
-
+			ep_pm_stay_awake_rcu(epi);
 		}
 		goto out_unlock;
 	}
-- 
2.19.1

