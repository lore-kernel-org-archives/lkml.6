Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52005C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140E720839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PrlbzN+Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PrlbzN+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140E720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeLLNx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:53:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58830 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:53:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C3B1560208; Wed, 12 Dec 2018 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544622807;
        bh=4Ljmm43+EIbj0PFzXA1VtUmyW7AyAprFpeVOkY/z+O4=;
        h=From:To:Cc:Subject:Date:From;
        b=PrlbzN+YWUU22Mgz7TrltaqpoZObrjZOMjKyG/DWoAENnSoByeBdWGAu2Mt5Wa0/M
         BSonkP7CGFd3hLFccz89RxXezBCLCHHAWTWzawLenNzHpKU4A/knlwXi/oC2fgrpU9
         RxJHnTZaD76mxeoylPANVmhP/Z/MIkJVeOTsPPL0=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C45E6601D7;
        Wed, 12 Dec 2018 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544622807;
        bh=4Ljmm43+EIbj0PFzXA1VtUmyW7AyAprFpeVOkY/z+O4=;
        h=From:To:Cc:Subject:Date:From;
        b=PrlbzN+YWUU22Mgz7TrltaqpoZObrjZOMjKyG/DWoAENnSoByeBdWGAu2Mt5Wa0/M
         BSonkP7CGFd3hLFccz89RxXezBCLCHHAWTWzawLenNzHpKU4A/knlwXi/oC2fgrpU9
         RxJHnTZaD76mxeoylPANVmhP/Z/MIkJVeOTsPPL0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C45E6601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc:     cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        skannan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4] PM / devfreq: Restart previous governor if new governor fails to start
Date:   Wed, 12 Dec 2018 19:23:13 +0530
Message-Id: <20181212135313.30268-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <skannan@codeaurora.org>

If the new governor fails to start, switch back to old governor so that the
devfreq state is not left in some weird limbo.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---

V4:
* Removed prev_governor check.

V3:
* Fix NULL deref for real this time.
* Addressed some style preferences.

V2:
* Fixed typo in commit text
* Fixed potential NULL deref

 drivers/devfreq/devfreq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 141413067b5c..ba2875a0b90e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1024,7 +1024,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	int ret;
 	char str_governor[DEVFREQ_NAME_LEN + 1];
-	struct devfreq_governor *governor;
+	const struct devfreq_governor *governor, *prev_governor;
 
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
@@ -1053,12 +1053,19 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 			goto out;
 		}
 	}
+	prev_governor = df->governor;
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
 	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
-	if (ret)
+	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
 			 __func__, df->governor->name, ret);
+		df->governor = prev_governor;
+		strncpy(df->governor_name, prev_governor->name,
+			DEVFREQ_NAME_LEN);
+		df->governor->event_handler(df, DEVFREQ_GOV_START,
+					    NULL);
+	}
 out:
 	mutex_unlock(&devfreq_list_lock);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

