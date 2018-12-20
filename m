Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB52C2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298145;
	bh=qEhMdPYe3Eq0pU2GFK4pl6VZXxarwEEKtSqa/oSQ6hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sXwUU9TJHrIT+LnzkfxSIecK9wMlw4jU+G3mtEfmpQ9lS1sVDOouPDTEzl0zgMgAC
	 WBsJAr1tt7gNFM9P9H1DAd95HPtFg9FWygSCNjyrELNqkO0RT9HFH6mdBd+it27jkK
	 DukzGG3NBXaso1ewtMIAreLbRqwedP3pTXGsUvpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbeLTJ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732614AbeLTJ3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B48021741;
        Thu, 20 Dec 2018 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298139;
        bh=qEhMdPYe3Eq0pU2GFK4pl6VZXxarwEEKtSqa/oSQ6hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKsdpLF5guXGuUG9Bj1I6/T/zANhnyH55VsCaDUZ7o5Zuif4YPbC2qi+dyrLJT7EJ
         6JhWszrgiOd8UiPUGE5h9yJJQZP692CtmDeYS287lPWCYbaZ26Kpda4CnQ+fmMeERJ
         haR8qMwKl+awelr8+PsEMlIoR6q8qVy2kxWnVp9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 14/67] drm/msm: Fix task dump in gpu recovery
Date:   Thu, 20 Dec 2018 10:18:26 +0100
Message-Id: <20181220085904.123798306@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

[ Upstream commit 482f96324a4e08818db7d75bb12beaaea6c9561d ]

The current recovery code gets a pointer to the task struct and does a
few things all within the rcu_read_lock. This puts constraints on the
types of gfp flags that can be used within the rcu lock. This patch
instead gets a reference to the task within the rcu lock and releases
the lock immediately, this way the task stays afloat until we need it and
we also get to use the desired gfp flags.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 46e6b82f7b66..52a2146dc1f2 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -425,10 +425,9 @@ static void recover_worker(struct work_struct *work)
 	if (submit) {
 		struct task_struct *task;
 
-		rcu_read_lock();
-		task = pid_task(submit->pid, PIDTYPE_PID);
+		task = get_pid_task(submit->pid, PIDTYPE_PID);
 		if (task) {
-			comm = kstrdup(task->comm, GFP_ATOMIC);
+			comm = kstrdup(task->comm, GFP_KERNEL);
 
 			/*
 			 * So slightly annoying, in other paths like
@@ -441,10 +440,10 @@ static void recover_worker(struct work_struct *work)
 			 * about the submit going away.
 			 */
 			mutex_unlock(&dev->struct_mutex);
-			cmd = kstrdup_quotable_cmdline(task, GFP_ATOMIC);
+			cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
+			put_task_struct(task);
 			mutex_lock(&dev->struct_mutex);
 		}
-		rcu_read_unlock();
 
 		if (comm && cmd) {
 			dev_err(dev->dev, "%s: offending task: %s (%s)\n",
-- 
2.19.1



