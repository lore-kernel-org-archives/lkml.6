Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D196CECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 02:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6059D20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 02:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="diSEKb0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6059D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJVLLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 07:11:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32858 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeJVLLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 07:11:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id z2-v6so1911082pgp.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 19:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qvvQuWaM77+h+B5Lh9KQjmG8HZmpb66a3ZGfQIMlXEw=;
        b=diSEKb0hhifWrMi4CU+slZuT7sRXokJZHd9tlouD4SU6oeK6k/B1GJUCyOyD6V8Xbv
         CLElmmZjkpTDp4aI1lc8Xime3zLdU1nwNrwHmaVXI+Q0RxyCNuHN68wanUO4mB212hSq
         a4hodd+xMNr9tqsUJMcarQC/zy2cSK/e+Quww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qvvQuWaM77+h+B5Lh9KQjmG8HZmpb66a3ZGfQIMlXEw=;
        b=G2mBLq1gbu6FZzpHN66D27VvVV7m5h6eP8iXvkug83k+kVs7f7NGk0FW0QQqc+qSZB
         IgGRiXclWfg+udMnEMInmGTHjGqC3o+ESFVZqXibCtZGmp0Z4ASHqPne8sVqFqaa9o3J
         x55nyugkLA0dN8+Yu1sgWF0IpsGHCb4UOQoHbi9jORT/8DL1hAmRMgBH7+3LAX/IlCwQ
         gJf3QGpAsMy7DTp4GPNhF7hCZiajah7P5rgi/faNYu4TgZ48gd8XWHOvwQugQrFOdmmi
         sOWW2r2KiRpIy/XNhMeTsAMk1xEdQ5rsArNFsPjfQ3AZIhs55tp66cRbki/6GWqykVax
         oIaw==
X-Gm-Message-State: ABuFfoig1Wmi0XNsO/Ma1DCTS3YF/BD3ie0NNrisRmoCv1t1aJUPFaYl
        f1wBwlcrAIA7z9yqd5vA7EY6b8lccm4mkw==
X-Google-Smtp-Source: ACcGV63GpG1FnJL8W5PugG2KA/X8LpinRmDB76F2qOGIaHPmjQS3a6BkM6BHfIhsJc4L/8Q8M6kTiA==
X-Received: by 2002:a63:e04d:: with SMTP id n13-v6mr22324061pgj.426.1540176919834;
        Sun, 21 Oct 2018 19:55:19 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id y144-v6sm44116622pfb.81.2018.10.21.19.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 19:55:18 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     "Lee Jones )" <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported
Date:   Mon, 22 Oct 2018 10:55:06 +0800
Message-Id: <20181022025505.27919-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the PMIC ID is unknown, the current code would call
irq_domain_remove and panic, as pmic->irq_domain is only
initialized by mt6397_irq_init.

Return immediately with an error, if the chip ID is unsupported.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/mfd/mt6397-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 77b64bd64df36a..ab24e176ef4487 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -329,8 +329,7 @@ static int mt6397_probe(struct platform_device *pdev)
 
 	default:
 		dev_err(&pdev->dev, "unsupported chip: %d\n", id);
-		ret = -ENODEV;
-		break;
+		return -ENODEV;
 	}
 
 	if (ret) {
-- 
2.19.1.568.g152ad8e336-goog

