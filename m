Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EF7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2216223C8
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH2GgPXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2216223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404677AbeKLIYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:24:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404612AbeKLIYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:24:05 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B1B21780;
        Sun, 11 Nov 2018 22:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975647;
        bh=TaLNkvJvBCiFcpLMo3EU1tVQlxjimFeWC1Y448Eoo5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iH2GgPXIf7qETa5OXi5+sqt5jIhInMLxTmIbrWSeBV4XMYXAgXhY0z8FAjQOEyAsq
         bM0j2NXUdzJ00l4xavbSzJ5qpaTg1bFEwCBPIfsh7fmUzPeR5q+7cMLwC0QY/mGXyb
         em2Yq9cSG3OSOq1m60ZHBhTDzi686Yp0m1wWVlHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Muchun <smuchun@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 021/141] sched/fair: Fix the min_vruntime update logic in dequeue_entity()
Date:   Sun, 11 Nov 2018 14:24:40 -0800
Message-Id: <20181111221630.654232583@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Muchun <smuchun@gmail.com>

[ Upstream commit 9845c49cc9bbb317a0bc9e9cf78d8e09d54c9af0 ]

The comment and the code around the update_min_vruntime() call in
dequeue_entity() are not in agreement.

>From commit:

  b60205c7c558 ("sched/fair: Fix min_vruntime tracking")

I think that we want to update min_vruntime when a task is sleeping/migrating.
So, the check is inverted there - fix it.

Signed-off-by: Song Muchun <smuchun@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b60205c7c558 ("sched/fair: Fix min_vruntime tracking")
Link: http://lkml.kernel.org/r/20181014112612.2614-1-smuchun@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/fair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3502,7 +3502,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 	 * put back on, and if we advance min_vruntime, we'll be placed back
 	 * further than we started -- ie. we'll be penalized.
 	 */
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
+	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
 }
 


