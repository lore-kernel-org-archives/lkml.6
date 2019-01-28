Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB06C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648E120663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693227;
	bh=65XBnOioQOiYBXQITEd7O1jICS+3yx3JiERN5k92ksk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JcsUGPwezO/6zG7b32c5UlYK8OOFNXztHTVEguAsinr0nqiNMEp1N5b7uptwY880v
	 GuFiTPrO0SLQtMbcGeW4CcWSHuGQbXydknhm8R4G9lymcxkhHYGPSjReMoMWTvjcyg
	 fU6Fa745AuOgg+V/Cd0i5Sz7+o0i8b29s+wvtKMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbfA1Qdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:33:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390171AbfA1Q0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:26:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E072084A;
        Mon, 28 Jan 2019 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692781;
        bh=65XBnOioQOiYBXQITEd7O1jICS+3yx3JiERN5k92ksk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kk827lReTdn/mVMx1t1WacwY1SJFhQ4scJMHaI6jw+gdYv6dLBqLMiBPVkCNAiQjw
         w6hYC4fwEAR4H9CoYLwXJOP5xUYG+zKRpFVk1/Qiz1FEXQlcbQTrU9/rwFBpkq1HM2
         us2+QDOsBJBT4tMETCgQJ5wMAiYWxBfuPMYLBZ5Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 79/80] fs/epoll: drop ovflist branch prediction
Date:   Mon, 28 Jan 2019 11:24:00 -0500
Message-Id: <20190128162401.58841-79-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

[ Upstream commit 76699a67f3041ff4c7af6d6ee9be2bfbf1ffb671 ]

The ep->ovflist is a secondary ready-list to temporarily store events
that might occur when doing sproc without holding the ep->wq.lock.  This
accounts for every time we check for ready events and also send events
back to userspace; both callbacks, particularly the latter because of
copy_to_user, can account for a non-trivial time.

As such, the unlikely() check to see if the pointer is being used, seems
both misleading and sub-optimal.  In fact, we go to an awful lot of
trouble to sync both lists, and populating the ovflist is far from an
uncommon scenario.

For example, profiling a concurrent epoll_wait(2) benchmark, with
CONFIG_PROFILE_ANNOTATED_BRANCHES shows that for a two threads a 33%
incorrect rate was seen; and when incrementally increasing the number of
epoll instances (which is used, for example for multiple queuing load
balancing models), up to a 90% incorrect rate was seen.

Similarly, by deleting the prediction, 3% throughput boost was seen
across incremental threads.

Link: http://lkml.kernel.org/r/20181108051006.18751-4-dave@stgolabs.net
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jason Baron <jbaron@akamai.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1b08556776ce..240d9ceb8d0c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1034,7 +1034,7 @@ static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync, void *k
 	 * semantics). All the events that happen during that period of time are
 	 * chained in ep->ovflist and requeued later on.
 	 */
-	if (unlikely(ep->ovflist != EP_UNACTIVE_PTR)) {
+	if (ep->ovflist != EP_UNACTIVE_PTR) {
 		if (epi->next == EP_UNACTIVE_PTR) {
 			epi->next = ep->ovflist;
 			ep->ovflist = epi;
-- 
2.19.1

