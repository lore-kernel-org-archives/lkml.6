Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DE8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACF520651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571145;
	bh=dU/0bNoLFCl/Pm3nYZfbgbWFS7t9nBYleLry7RwL7Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=scLPsTZShiBq8SrYxsOdXEipypOfsUytvaBlOCmLivOC2Q4J9h6QhvQ8b3X7sKcbK
	 Be2TaJFi6QtpAyAUg4DGCNQYAo9i9rvEls3Aln+Mqg7BaN6G5CVBcJbKCqWuedo5QZ
	 XWCrmHXOEBAFquwGV9R4weRY9I0sYPqEmfsrWAk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbfAOQoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387534AbfAOQo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F5F20657;
        Tue, 15 Jan 2019 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570668;
        bh=dU/0bNoLFCl/Pm3nYZfbgbWFS7t9nBYleLry7RwL7Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxO0LhCd1nc141tVSdT6yLMQwJ/sc+eJR0VH6m6IqWTzRLb+0MDY57TZoDd+Zqevf
         qqKMK3Zpf1fpwRVqHKjbrTqYStJtxvcF/H1IzXtDxSvy2YqRje+RaVcMLZx1QEaQ4u
         ycFeOfzTMMwFqL3cjkIunrlN/rpVA4jKdAHHPq5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 27/57] fork, memcg: fix cached_stacks case
Date:   Tue, 15 Jan 2019 17:36:08 +0100
Message-Id: <20190115154912.206139055@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shakeel Butt <shakeelb@google.com>

commit ba4a45746c362b665e245c50b870615f02f34781 upstream.

Commit 5eed6f1dff87 ("fork,memcg: fix crash in free_thread_stack on
memcg charge fail") fixes a crash caused due to failed memcg charge of
the kernel stack.  However the fix misses the cached_stacks case which
this patch fixes.  So, the same crash can happen if the memcg charge of
a cached stack is failed.

Link: http://lkml.kernel.org/r/20190102180145.57406-1-shakeelb@google.com
Fixes: 5eed6f1dff87 ("fork,memcg: fix crash in free_thread_stack on memcg charge fail")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/fork.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -221,6 +221,7 @@ static unsigned long *alloc_thread_stack
 		memset(s->addr, 0, THREAD_SIZE);
 
 		tsk->stack_vm_area = s;
+		tsk->stack = s->addr;
 		return s->addr;
 	}
 


