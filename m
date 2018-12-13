Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59474C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C56120870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676692;
	bh=N8AfGWv1BymxIbK9rX5NHROOq0ClCwsRM2lj4GdEsZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G4bmgXhSaPcD+UXLddu7tsmZlz9puWWOu3U4vrBHWQZErVJnpPvfZi4oSK2rAq/s9
	 TSQh6xAb/KG5cCsiJh6KZuy0warNHtFFz0C9r44mp61AwuCiUwdhUFtwR+XYAIco8L
	 sPMI9Cq7M3FQwWkzTJ3OuxLkDzhH1uhoM/DqAzgk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C56120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeLME3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbeLME25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:28:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C042220849;
        Thu, 13 Dec 2018 04:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675336;
        bh=N8AfGWv1BymxIbK9rX5NHROOq0ClCwsRM2lj4GdEsZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfTUsg9I9YCcUht0QnGb3/DKbiFxMlbE+OwUqvrvv/hsoHbNFm6O92Q7OnbO5JPIr
         x87tYKlKXWK+ewZ/TV5IAYVtigXTG0w9qtUo77+VDai72An5PcybO/HcmBFz4wqiBs
         PPG3x0RlfcJLvBRmeZ7wsV0VWOmrt4pS6s4nemcI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 12/73] drm/msm: Fix task dump in gpu recovery
Date:   Wed, 12 Dec 2018 23:27:37 -0500
Message-Id: <20181213042838.75160-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sharat Masetty <smasetty@codeaurora.org>

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

