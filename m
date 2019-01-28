Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4FCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CD92147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690477;
	bh=pewgAzwiChmQ6h5N8DxneNyd4MjiXIqmOpt4mZR7ODk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YOB5mCxq7JpYFYgKnQ5xWEotB7GYEZFt8umVAgek8Pkf8h4l+f+k99fYN+HfpXUPS
	 k/ojKyPTNNHmgETL3nymSDW8Jtq70ihxf+le8iJzI+vkNzXIkrDlXK1IK1+jy4Vnq/
	 ka5rn+IOQcSMKyvFqFcMxv/Pgsn3j8BoJZczc35Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfA1Pr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbfA1Pry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:47:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D06122177E;
        Mon, 28 Jan 2019 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690473;
        bh=pewgAzwiChmQ6h5N8DxneNyd4MjiXIqmOpt4mZR7ODk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FsJfyDERUxRgPEIZ7s2xQI8i4bp09PWQizjJersntpqsxtlXMkL/8Zg9rrDXBZoL4
         q/1WXAeoXNHhwfQfm+oeppAzq8HqCW863Y/GbPO9z9TW14G8LW8PMp038AteIrCGsn
         c4xH6bWyoGBa0TuZGFxnyYb4dzqRqK/Qjvjsbwq0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 101/304] thermal: Fix locking in cooling device sysfs update cur_state
Date:   Mon, 28 Jan 2019 10:40:18 -0500
Message-Id: <20190128154341.47195-101-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

[ Upstream commit 68000a0d983f539c95ebe5dccd4f29535c7ac0af ]

Sysfs interface to update cooling device cur_state does not
currently holding cooling device lock sometimes leading to
stale values in cur_state if getting updated simultanelously
from user space and thermal framework. Adding the proper locking
code fixes this issue.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_sysfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2241ceae7d7f..aa99edb4dff7 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -712,11 +712,14 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	if ((long)state < 0)
 		return -EINVAL;
 
+	mutex_lock(&cdev->lock);
+
 	result = cdev->ops->set_cur_state(cdev, state);
-	if (result)
-		return result;
-	thermal_cooling_device_stats_update(cdev, state);
-	return count;
+	if (!result)
+		thermal_cooling_device_stats_update(cdev, state);
+
+	mutex_unlock(&cdev->lock);
+	return result ? result : count;
 }
 
 static struct device_attribute
-- 
2.19.1

