Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33320C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030AC21917
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691423;
	bh=pewgAzwiChmQ6h5N8DxneNyd4MjiXIqmOpt4mZR7ODk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B+SvlBTEPEMv49RW36UsCwwESoXoPC5seXsaQ0cj0csXXq7Ik4GU4TBN1Wgo3aTgk
	 1+DcA97PCWeaMZK9bku30jlXuwT477LQmXeCKOLEuq3PoMAVx0C6g2K8oM2cfQjf7Y
	 QbzjJ+ZG3tyJa4HPVafftHXQUdrJaBJZkoM2Hifw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfA1QDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:03:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbfA1QDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5BFF2175B;
        Mon, 28 Jan 2019 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691411;
        bh=pewgAzwiChmQ6h5N8DxneNyd4MjiXIqmOpt4mZR7ODk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wN6fv0i2NqaeEoTyUuTix0rCkZjK6aSPqqNo3CldEIY3inwp9/uV6+5qSLsfL9RXs
         OsSYOLGbLjiND93B/0RoNgHvAIZPj/ja93NZgJSEITuX3uhoQI/r/JoAfVA4Y1xt1a
         mZrDBQqBgaeqhsxz1XOXBZZQevZ9DaXpHBOdNtvU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 087/258] thermal: Fix locking in cooling device sysfs update cur_state
Date:   Mon, 28 Jan 2019 10:56:33 -0500
Message-Id: <20190128155924.51521-87-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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

