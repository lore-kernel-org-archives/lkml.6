Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1905EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C556E20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dh4OaBqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C556E20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbeGLIO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:14:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51937 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeGLIO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:14:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so4747668wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cMdPa02co8Y5uRmZUOpdQaCAG9BrUlfiDv39xvrIRdo=;
        b=dh4OaBqDtAW1470b/0vq9aDflFBsk/2osZwH0UY25O4JqgnhTCgDgc8XOOhG6/84yi
         HoI6Uld7k/h9iuZZWOFoRIB1hea/C/X2Amn70tYWBnQKk/EOoiYvxQH1ZwEqXFtFyNB8
         NRvAAYNg5/oAEedhkeTgziKqSpnben+7DR/Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cMdPa02co8Y5uRmZUOpdQaCAG9BrUlfiDv39xvrIRdo=;
        b=TQbg+gUGND6pUZpDzMbzL/mIcKWytXQy9n7Yc+E4u0cNKIW0epjhTif4cBu6wBmFKv
         Sh7/b1txMiJpSlF25zvU+m2U8Xu9vv0bqsXTMgRjf0siJRAPjCm4s4863dukmrq2wzSE
         4dQrsB761a8UTv3+31OqLsZMpEqoCJ2f7KCIj9SS8iMDx8Dt0hxZnzCjOOM3LK3TpssY
         HAstLQMTap09MeFKC3Sf14FIEi0p0oRkjzNZI2Jc4jAO/BYwGXXY10HZiks/91ShIis3
         zuw/t/a+yRCUeRcGL6yuq7l9DC0efaDPJWxzbkigwyW966oRFUzbvEows4UbfMUPhcBM
         QWJA==
X-Gm-Message-State: AOUpUlF6iA2c+NO3gSylV+3oU0C7edWN7FQN8kp9boQg6+Ft7QbMzkJ4
        IfF26kuXLj/OQ5cJ462cY2sP4Q==
X-Google-Smtp-Source: AAOMgpd3F1YaJOCLuuK5IMVb7AC0fFel0GAWS3OpmI+nG16+ETm0OD11R97cSk+x9r/KwtZm02RgKg==
X-Received: by 2002:a1c:ea53:: with SMTP id i80-v6mr714881wmh.113.1531382789074;
        Thu, 12 Jul 2018 01:06:29 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([80.214.74.179])
        by smtp.gmail.com with ESMTPSA id x16-v6sm5351145wme.12.2018.07.12.01.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 01:06:28 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     gregkh@linuxfoundation.org, broonie@kernel.org, p.paillet@st.com,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] base: core: Remove WARN_ON from link dependencies check
Date:   Thu, 12 Jul 2018 10:06:23 +0200
Message-Id: <20180712080623.21203-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases the link between between customer and supplier
already exist. Do not warn about already existing dependencies
because device_link_add() take care of this case.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a44707a..fcdc17f0f349 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -105,7 +105,7 @@ static int device_is_dependent(struct device *dev, void *target)
 	struct device_link *link;
 	int ret;
 
-	if (WARN_ON(dev == target))
+	if (dev == target)
 		return 1;
 
 	ret = device_for_each_child(dev, target, device_is_dependent);
@@ -113,7 +113,7 @@ static int device_is_dependent(struct device *dev, void *target)
 		return ret;
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if (WARN_ON(link->consumer == target))
+		if (link->consumer == target)
 			return 1;
 
 		ret = device_is_dependent(link->consumer, target);
-- 
2.15.0

