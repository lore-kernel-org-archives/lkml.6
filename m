Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05953C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5C921855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900014;
	bh=cGCGHv9dbd+lcwuDi1w+9hYwTdgJ20KfnBJ2i6Dy52E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TUlkSXbrSBtHXbVXUMGM76DNWKsMXqWfE+tyoGFGVMwgd1juct5iVVgl28ZRW/zMY
	 yI8pIT1+69FVOhUs2QDskMIbYxeCWVU0041R3PVCExmJJ1kENLVsNYJiguOZ1+CqAi
	 t233QntqOIRsDemNk/MKTHjHkrGsc/4N+ZrYvBRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbfBKPqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732362AbfBKOmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:42:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ECCD20700;
        Mon, 11 Feb 2019 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896127;
        bh=cGCGHv9dbd+lcwuDi1w+9hYwTdgJ20KfnBJ2i6Dy52E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQBfzsHezoeQ79VUcMCp3PmZNkaVyXlZuxqpEaUdO4TRILCzdhjzbKtguBm4GKOU1
         DTlh670t7Rl2CpMSpxtarM4T6+sMQitzFlz4GWw7zsqEsc/TjaxNm66bLaaQ8nqccF
         RA0dQe+wwP0mIcHoWYdvU7qhArEiY2PJwM9ZZP7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/313] thermal: Fix locking in cooling device sysfs update cur_state
Date:   Mon, 11 Feb 2019 15:16:01 +0100
Message-Id: <20190211141859.275905054@linuxfoundation.org>
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



