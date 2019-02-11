Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A2B222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899503;
	bh=G/l0ESp0+YnkBU769hmDGBPaaaGM88sAyQO1uscnWCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E0Kmn9ztoPXtRTsjkEXw6d3B0r/Y7z7dDw2hPn3Jjk2cvWmxlQSbkT0loI+KFgU+l
	 hykKBH0xw55UCQdRoDE53xTPc9h519L9/D4z2eGzxrFB6NbkcUKfeeUliT2vnVfJbz
	 9X+Qj4iR3VpEePAG/kMA5aNW1zlLBuGdcYp2wfsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbfBKOuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388058AbfBKOuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E9820700;
        Mon, 11 Feb 2019 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896619;
        bh=G/l0ESp0+YnkBU769hmDGBPaaaGM88sAyQO1uscnWCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MX2rEAF4bUdbRDpRAgxNis1xTBR9xBdRN4J+dUrL6EHWOjQPjiKumJlZP14GRg5dV
         b2gNMHG+18cAdX52xOZ8riC++Dlehl4wJGEZMS1LM3FHYtzOqRdqxUkiHjA7SpAbdX
         1Iig4yzgSnsJzKbQfiHCFcVbJmo5Rf2vzxVOO9cA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 244/313] fs/epoll: drop ovflist branch prediction
Date:   Mon, 11 Feb 2019 15:18:44 +0100
Message-Id: <20190211141909.702760523@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 42bbe6824b4b..58f48ea0db23 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1154,7 +1154,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
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



