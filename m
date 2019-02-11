Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46B9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8B720821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895110;
	bh=RqXEecHFDKiNEipWvm3W0Z9ee7U90ah7LNRDdk1sa70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RQsGAYoM0IDSqQZsCcTE9eEgiK3BAtBjoM20KvFPC0t6zvgx8+zCfSVJfrSgb6dS9
	 b3XXvxunnHU1H1j/nReMqhblqBh9a1wit/FyA8RNOu3QbAJa2o+6U/pdXr7DKhcvqg
	 d+tZZ7IRTkYpRp0K4pF2XvQPU5ujzF1GHaxz00Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfBKOZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbfBKOZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:25:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A491420821;
        Mon, 11 Feb 2019 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895105;
        bh=RqXEecHFDKiNEipWvm3W0Z9ee7U90ah7LNRDdk1sa70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxvWU8d4PZ93BxjT4dKbJEWp6fo2AMAuxodK5pd6sdgipfj0xMohUt1WEsAfX9Roj
         CKZysntmKnrAHHXM1QfmlTo3ME/WrzohqIfAm8JN6rIUTtUhmo3+7C+Ux+cfzJQ5AT
         d5We9gKQc5GHuCzYvJebjngCxeYEziWt65RiZqUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 094/352] thermal: Fix locking in cooling device sysfs update cur_state
Date:   Mon, 11 Feb 2019 15:15:21 +0100
Message-Id: <20190211141851.856039832@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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



