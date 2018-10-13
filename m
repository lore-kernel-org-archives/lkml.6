Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC73C71123
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50D02075B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vf2+ez73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50D02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeJMIag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:30:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45100 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJMIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:30:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id y15-v6so6649631plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 17:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szr5KLhOEepnxhuji3Nc/YMARBLGRK4oTE2y29Q5DuI=;
        b=Vf2+ez732wRfmVM5sn8xhWJ3KJnSnR4AoDZzbC6Vwr6SxJ2oi+WphOdQ7d1JF1g/VW
         DsWjigQ6B3oVlmy6rHzucW3S3IsbNj9y9HiY5cQzFKImG/RuJJbnS1UakIeCGlD7ip45
         X+G/DJNufbQ4WVt1LKM36ZidXZOhb5pZ7DeB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szr5KLhOEepnxhuji3Nc/YMARBLGRK4oTE2y29Q5DuI=;
        b=OJQ0Zj5xEThYAkxov2SFswwqG3WmYBWBuhWAEqtme3Fuc6uu8NLBpiORlQFC+LYJV3
         YklyvrW77FMltcpUr2gOx+WNDlynvwrVGbkzV3RMglrPfK5POmBjrZiddxifmyluK21K
         VOAUrEMEOtpCFGcNx002/F6bfbm902S7bJCWCc1/r3EABevkX69saVgiHF3NEh2rH7FW
         AwrowLWYYOQcunLKxvivOAHQbCLCYcMBhtYRGwTmJWOuBUGD+uIc8cHl382jQYcxnJ6l
         6kzJuF/FrF25AgQXKon9tcG+Hzdsj7STCHpbvTiugTL8zvjWy3qhYIjofyST2lROm9Zp
         Jkrg==
X-Gm-Message-State: ABuFfojV3Oflkaprm2rZ31QlnidA9GFOgJSGSV+YCrNJk7rilDH1VF+Y
        H6mirc+oljYc4vx4o7GGoAPOt6i54qvDww==
X-Google-Smtp-Source: ACcGV61Zu1kR1AYSCorKL4Rnwd2Ixd4lQtWeU4CYJ3liGav4XVMNIc+mMIc1AgBkcymlOtFlH5hF9g==
X-Received: by 2002:a17:902:50e3:: with SMTP id c32-v6mr5923263plj.129.1539392134274;
        Fri, 12 Oct 2018 17:55:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id n7-v6sm2766183pgv.63.2018.10.12.17.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 17:55:33 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/4] ath10k: snoc: fix unbalanced clock error handling
Date:   Fri, 12 Oct 2018 17:55:04 -0700
Message-Id: <20181013005504.46399-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
In-Reply-To: <20181013005504.46399-1-briannorris@chromium.org>
References: <20181013005504.46399-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to regulator error handling, we should only start tearing down
the 'i - 1' clock when clock 'i' fails to enable. Otherwise, we might
end up with an unbalanced clock, where we never successfully enabled the
clock, but we try to disable it anyway.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 5a8e87339df2..a835599a8d55 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1470,7 +1470,7 @@ static int ath10k_snoc_clk_init(struct ath10k *ar)
 	return 0;
 
 err_clock_config:
-	for (; i >= 0; i--) {
+	for (i = i - 1; i >= 0; i--) {
 		clk_info = &ar_snoc->clk[i];
 
 		if (!clk_info->handle)
-- 
2.19.1.331.ge82ca0e54c-goog

