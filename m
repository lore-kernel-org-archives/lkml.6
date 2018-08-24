Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69B82150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PbYxXT8v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HzZcUGwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69B82150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeHXXno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:43:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53162 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:43:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B2AD16055B; Fri, 24 Aug 2018 20:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141257;
        bh=S2+ZkwaMLf6Mce/14VsP2XJs7DgGYiunQ9xCIOk1LF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PbYxXT8vUk8LiZyG4qglMRVMmEvoBf/3xhfig6vd6EVeJHDddfdR2hFBzf9UniwRH
         PQlZM3fGCUBHmbXX5DHOeh22aLGiI8E8nhWWDwfWMXOQJ3/pUyJX1mMKyHb76K2RXm
         0/jm6r9B5wUtIy8JihlXJOy3oUhaqjbAuHY9zFhU=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BAFC607B5;
        Fri, 24 Aug 2018 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141254;
        bh=S2+ZkwaMLf6Mce/14VsP2XJs7DgGYiunQ9xCIOk1LF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzZcUGwRnpOGD+C/wmDYJwvG3jXr7XHRnfk4sd3ZZ/IgMODEcwDrCEhLTjt6IpyEH
         Ld791YFBo2GM4PFkWw8KMnFkkUWS89WrSe/PNGYT4y4OdA1xSmfSPKVtyX5mUwPoTO
         /GsORgBe2k/3ff8aGjmsQS360a4FVB+5iYkQYD38=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BAFC607B5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 6/6] drivers: soc: system_pm: Add suspend notifier
Date:   Sat, 25 Aug 2018 01:36:28 +0530
Message-Id: <1535141188-29731-7-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order of suspending different devices, which is part of device
suspend, during pm suspend can't be guaranteed. So once system PM device
flushes the cached sleep/wake requests, other client devices may send
new sleep or wake requests in their device suspend operations. The rpmh
controller needs to manage such new requests if any. A notification is
sent to controller to indicate the same.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/system_pm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/system_pm.c b/drivers/soc/qcom/system_pm.c
index 1451bf8..6524f7e 100644
--- a/drivers/soc/qcom/system_pm.c
+++ b/drivers/soc/qcom/system_pm.c
@@ -133,6 +133,7 @@ static int sys_pm_suspend(struct device *dev)
 		/* Flush the sleep/wake sets in RSC controller */
 		rpmh_flush(dev);
 		setup_pdc_wakeup_timer(true);
+		rpmh_notify_suspend(sys_pm_dev, true);
 	} else {
 		pr_err("%s:rpmh controller is busy\n", __func__);
 		return -EBUSY;
@@ -141,8 +142,14 @@ static int sys_pm_suspend(struct device *dev)
 	return 0;
 }
 
+static int sys_pm_resume(struct device *dev)
+{
+	rpmh_notify_suspend(sys_pm_dev, false);
+	return 0;
+}
+
 static const struct dev_pm_ops sys_pm_dev_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(sys_pm_suspend, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(sys_pm_suspend, sys_pm_resume)
 };
 
 static const struct of_device_id sys_pm_drv_match[] = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

