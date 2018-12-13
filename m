Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E4EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C5F20672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675427;
	bh=jx+lTGg8tQMGi/YNxffzC0BV8DzRsRJokZoCJqztydU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vDZ5oCZcL2UhFctIU2jkrVb5SIPVUG+oipQYsSOJHoQDHcIr0wgcWpGjeib6ypXx+
	 mND6wfHUrilItX3NXnWFzYRmyd62oE4ClguI9stKZRY4K/5tnX+2uY2Dphw1TNnaJY
	 Het0QUtxcGNdZ4oL+VVu8z7ZIBwqYMOjKmgtDkSg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C5F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeLMEaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeLMEaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C205208E7;
        Thu, 13 Dec 2018 04:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675420;
        bh=jx+lTGg8tQMGi/YNxffzC0BV8DzRsRJokZoCJqztydU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+v7hhIwPzi4gSqdNAecYWGuAIJ1NHPlLwzxPOujRTNUMFPVONDc0Q6F+p+ydeIli
         OlDk6uNyWqxzqfRN23D6vyofx0ewMKCG1i/Gj5Yj3T8slrylXHmEFDkGcyyQ/t17W6
         AvCGLvdQmC3lsDoYaqlA69M2uuk+OD48uDfBxFa8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 55/73] thermal: armada: fix legacy validity test sense
Date:   Wed, 12 Dec 2018 23:28:20 -0500
Message-Id: <20181213042838.75160-55-sashal@kernel.org>
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

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 70bb27b79adf63ea39e37371d09c823c7a8f93ce ]

Commit 8c0e64ac4075 ("thermal: armada: get rid of the ->is_valid()
pointer") removed the unnecessary indirection through a function
pointer, but in doing so, also removed the negation operator too:

-       if (priv->data->is_valid && !priv->data->is_valid(priv)) {
+       if (armada_is_valid(priv)) {

which results in:

armada_thermal f06f808c.thermal: Temperature sensor reading not valid
armada_thermal f2400078.thermal: Temperature sensor reading not valid
armada_thermal f4400078.thermal: Temperature sensor reading not valid

at boot, or whenever the "temp" sysfs file is read.  Replace the
negation operator.

Fixes: 8c0e64ac4075 ("thermal: armada: get rid of the ->is_valid() pointer")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/armada_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 2c2f6d93034e..e16b3cb1808c 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -357,7 +357,7 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
 	int ret;
 
 	/* Valid check */
-	if (armada_is_valid(priv)) {
+	if (!armada_is_valid(priv)) {
 		dev_err(priv->dev,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
-- 
2.19.1

