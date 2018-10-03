Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4822FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E990213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWmp24UV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E990213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeJDAHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:17 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:34515 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:17 -0400
Received: by mail-vs1-f73.google.com with SMTP id b199so2118512vsd.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H8gBokA4otWleiKrJnBhbRyUjo005vND9wgkjdd5xVo=;
        b=mWmp24UVCs+wbUstMxy/XrwS2hDG5n/XzzxT/LqLj/DvWG56Ww7VRWdYWbRFJ3gqBE
         pDJ8q3iwMMB8CEPe1BWNsPL4Hu5oC6agxmlMOBe6UMVOqAwsbvmX/JYlkiXSbM3nYY4e
         kDdooVmXMJayeMHcbCj/TVMZf6fCwax6Qkz+QBR+xw1DMOQZAh7qwMb39P76nOH8U4HH
         fupUjXo0ZFpwcFSQY4LQOKv0/emdBlYvzHVH/xX8hRuITCfHPVW+GtgbRrQxbr+U1BDc
         CWVA5bKfzcSg8Sv0pt5PuchSaLUkMYpmYOm1aZ0medtWae+BK+6b1j6unHr14/Ttq0rT
         ZZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H8gBokA4otWleiKrJnBhbRyUjo005vND9wgkjdd5xVo=;
        b=DDpWu6qrOHzuXC91xgwm4OZkrAYk8GXq7x24P67HFySQy0sCUgswoXf437RMVgV98S
         ml08/Sq9Qo7V1wzkgnPsQNj4OHd21jrOwfZqzgOpux2uFPr/pIIyurYsIXcxXo1py9pP
         qUmtqVkwUpwi9soI501laP4hj5pwbXcAtrIwjtfLdv465FS/ijqDdeyWIXAgFcHmDrFB
         GWQCmwByqn6wSupX3c2dcwRiCSNPn+AlC+EZ1y7zauuItX49JB+3RIwbgAEK4fdpeLry
         zTB8nDZpUmOWuM0LpSrW4TOqQ1Ohx3A/PQOJ6SVlY8NckqhhUym8qmpu7Bnw+titj1Dd
         kbeQ==
X-Gm-Message-State: ABuFfojD/a2VAAMBceAQgP7T0zxAkmd/Oi0LnIuEv+vULFOWtNcpoJF2
        /xXNMqJSkczPlSfzT9898APUWJ9S
X-Google-Smtp-Source: ACcGV63srqOx9solSx+dWzrztYL95Pw9opczHRTKTZJWM7QOKFSwCNLtHvmqeXlTGjxNAlAvEH/+CaNS
X-Received: by 2002:a67:9898:: with SMTP id g24mr2232052vsh.4.1538587079278;
 Wed, 03 Oct 2018 10:17:59 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:10 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-5-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 05/15] platform: goldfish: pipe: Remove redundant casting
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

This casting is not required.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/goldfish_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index c386aaf40034..bc431f04c4cf 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -925,7 +925,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	 *  reading device version back: this allows the host implementation to
 	 *  detect the old driver (if there was no version write before read).
 	 */
-	writel((u32)PIPE_DRIVER_VERSION, dev->base + PIPE_REG_VERSION);
+	writel(PIPE_DRIVER_VERSION, dev->base + PIPE_REG_VERSION);
 	dev->version = readl(dev->base + PIPE_REG_VERSION);
 	if (WARN_ON(dev->version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
-- 
2.19.0.605.g01d371f741-goog

