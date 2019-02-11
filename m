Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F1BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24539222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895951;
	bh=V64WkXL1SlJG1s6v8E4eiF8RE6eZ32QrOj5eacAlxhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BROD2Oaw4iWsRf5tz4STF0sew/fea6FDBD5OE0re4y8wc/gYw92t7B6eHNsQwN27G
	 9wfKw4mTp84JCEwk/zPRJzLG6Pky2Bn7PDOSktjngnnaSWpzPe89RUNS8VbELVYgwL
	 zG876L0ShKZiKGp7biTq53QVqDoQDOi5T3WyIO2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfBKOjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731348AbfBKOjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F94B2081B;
        Mon, 11 Feb 2019 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895943;
        bh=V64WkXL1SlJG1s6v8E4eiF8RE6eZ32QrOj5eacAlxhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/L2vTZ3n2OGnyngee8gRve0i3gw5B1QvvjxhvWoAuwHFXMoewVyNrPgWnEnqHXdS
         ywZjAB+N30UnUpTkpbF8it1hzTeBf4fQ44wTbtcR+9aq2FawJ8qGjRqMa3jxZ7QdPQ
         JemTXiyGqta4nzp9pHP+IvF/GgbFnXkxGPXw6wGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/313] dlm: Dont swamp the CPU with callbacks queued during recovery
Date:   Mon, 11 Feb 2019 15:15:01 +0100
Message-Id: <20190211141854.785707632@linuxfoundation.org>
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
index 562fa8c3edff..47ee66d70109 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -292,6 +292,8 @@ void dlm_callback_suspend(struct dlm_ls *ls)
 		flush_workqueue(ls->ls_callback_wq);
 }
 
+#define MAX_CB_QUEUE 25
+
 void dlm_callback_resume(struct dlm_ls *ls)
 {
 	struct dlm_lkb *lkb, *safe;
@@ -302,15 +304,23 @@ void dlm_callback_resume(struct dlm_ls *ls)
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



