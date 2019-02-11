Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D63FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B4420855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896867;
	bh=LbojtIHMUt0Qg62Ud/bpEK3a7JDeRT+GhvpjzqGiiq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B1usg9dvtZHhoLMpMqGrBc2xO0A8VRT7xQEwnVfd8fMLT3+/evK8otU6l4greMZDo
	 74J5zu49PIxzjTZi9nBuYilK4EnymMzFOt2ZumZ5jOax3TfPBKjlU4s7mHJwxWKCfW
	 Ukc+o7Wkoxxcu7YIhxK7vIzvuirli6u0hiyb7oX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbfBKOy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388817AbfBKOyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:54:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA56B20855;
        Mon, 11 Feb 2019 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896862;
        bh=LbojtIHMUt0Qg62Ud/bpEK3a7JDeRT+GhvpjzqGiiq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BsbgexF1/ILGtee2EcVksh2aAQvosSCL2LcEiXUssE5N4baKiomJbMWE+PZtJvwp
         rd2w1wQOzsokg/MWfe5HNUY9kjL7+k/abGjwBMOmmJnwTk+ZQw+0E8oB/We34ZM3Ze
         +2i23JYBdhpuQUqciyVZaLBL1yJUMeHBGIFoTHkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 013/205] dlm: Dont swamp the CPU with callbacks queued during recovery
Date:   Mon, 11 Feb 2019 15:16:51 +0100
Message-Id: <20190211141828.012994081@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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



