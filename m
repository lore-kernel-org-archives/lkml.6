Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CB1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A2A21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695273;
	bh=x9MCPZinfKCrChz8taD08x69kAT4WLxm8ocJ7HUuj2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n/5sTuVa2hwIMIHZt/Q1D9v1hGh9/jHzMmh+iqP2kdhHKMLsgC/35XUbEFHYV3TGn
	 /ZleuI6jHrX0aBCpMj4CD8VB34YAtGiLRI1kngjDfpAB8TFSRvoEZdERohS3/QE5qw
	 L/ifkKiUU0uCaJ/B5gPmCsulcXhH7eYbsJ6mFtXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfA1RHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732529AbfA1QMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:12:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32E82177E;
        Mon, 28 Jan 2019 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691954;
        bh=x9MCPZinfKCrChz8taD08x69kAT4WLxm8ocJ7HUuj2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQshiuGk+1d01qKmGHqgFfMYwHU3M6tVttA1Ocm1uAVwuz9svUrdI6VGEX2REf0eM
         ntcQlKMc7Awmokb5lClRFsObTr7FeIS0zVgtnUxemVi6RVNgm9tV5xOVgKc/4K/daS
         hSUbOjD2lbWjC76HXsnJGX9YJoPihyvv4HcK6g5k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.14 014/170] dlm: Don't swamp the CPU with callbacks queued during recovery
Date:   Mon, 28 Jan 2019 11:09:24 -0500
Message-Id: <20190128161200.55107-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit 216f0efd19b9cc32207934fd1b87a45f2c4c593e ]

Before this patch, recovery would cause all callbacks to be delayed,
put on a queue, and afterward they were all queued to the callback
work queue. This patch does the same thing, but occasionally takes
a break after 25 of them so it won't swamp the CPU at the expense
of other RT processes like corosync.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/ast.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 07fed838d8fd..15fa4239ae9f 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -290,6 +290,8 @@ void dlm_callback_suspend(struct dlm_ls *ls)
 		flush_workqueue(ls->ls_callback_wq);
 }
 
+#define MAX_CB_QUEUE 25
+
 void dlm_callback_resume(struct dlm_ls *ls)
 {
 	struct dlm_lkb *lkb, *safe;
@@ -300,15 +302,23 @@ void dlm_callback_resume(struct dlm_ls *ls)
 	if (!ls->ls_callback_wq)
 		return;
 
+more:
 	mutex_lock(&ls->ls_cb_mutex);
 	list_for_each_entry_safe(lkb, safe, &ls->ls_cb_delay, lkb_cb_list) {
 		list_del_init(&lkb->lkb_cb_list);
 		queue_work(ls->ls_callback_wq, &lkb->lkb_cb_work);
 		count++;
+		if (count == MAX_CB_QUEUE)
+			break;
 	}
 	mutex_unlock(&ls->ls_cb_mutex);
 
 	if (count)
 		log_rinfo(ls, "dlm_callback_resume %d", count);
+	if (count == MAX_CB_QUEUE) {
+		count = 0;
+		cond_resched();
+		goto more;
+	}
 }
 
-- 
2.19.1

