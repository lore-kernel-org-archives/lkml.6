Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F61EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8262086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WlL6WKz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8262086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390475AbeIUTbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:31:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38640 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389870AbeIUT3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:37 -0400
Received: by mail-it1-f194.google.com with SMTP id p129-v6so1931820ite.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B8MUx6E9DqKVpcFO4+o4SdtmZtHPgBuDxKs+F+ULmhc=;
        b=WlL6WKz2mOgkorbaT1BwHyRjM1RjxiL+avqMGmExl+ycqFj3m9IaoHF4nPDOHc8Bf1
         0Xb7/iSzprTmjhP5IUnHmjse+ptxjk8SiK52VErC5PBcWC8zJDtRgvyXkqHYtz/L6Nb5
         PfG2UbRAEWpeL4HSmXQKyT4F/ZuJnxhb0iW4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B8MUx6E9DqKVpcFO4+o4SdtmZtHPgBuDxKs+F+ULmhc=;
        b=ufn6DiMeDeUfof1AxOLS3VFLO2H3EnHIo5kss5rdjnJTBEavntSIgGtBk1HT0C7EoA
         7c3ht8ViQDyFTgOo7Tu/Tuz/DcZLWn18IV3oOtiYkvNQxhFOI+mS5gVV8vtpfHy5p9E8
         B3XYJpmjDhUL68jXPB6F96BpiVZKEctLt3cXT+2vN5gGFr6fc9lOnMRMI6jzJVzr2yXt
         gnGqXZnrLSatoi+oTLoDKhFRvUWSzJFELI1YS+xGSIg3N4JLEwGsymqumZR/MNgc5zDC
         BWHNn61bUZHhLMdPYNenVbB1qhsnEQA7uVJT71qhUUpAP8x32XVQt4Gzolj9U7puyXuk
         L+eA==
X-Gm-Message-State: APzg51DIaqJ/zYJPUAMuqrGMwfNhlba5Ocxha7Yh9Kr3urgsGvhNjt58
        iQgKGAajS6lMhcel4lOYbxQdzw==
X-Google-Smtp-Source: ANB0VdaWjd4IC6EMIx8s8DGlq7EdGfpwutSe/VjuMu9YWKGzuoTGnu+FH9BEAOIM3pDScprTNqTKDQ==
X-Received: by 2002:a24:3d52:: with SMTP id n79-v6mr5756180itn.68.1537537242725;
        Fri, 21 Sep 2018 06:40:42 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:42 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/26] nvmem: check the return value of nvmem_add_cells()
Date:   Fri, 21 Sep 2018 06:40:07 -0700
Message-Id: <20180921134026.4596-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This function can fail so check its return value in nvmem_register()
and act accordingly.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1ced9caa811b..0ef84441ebe5 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -512,11 +512,17 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_device_del;
 	}
 
-	if (config->cells)
-		nvmem_add_cells(nvmem, config->cells, config->ncells);
+	if (config->cells) {
+		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
+		if (rval)
+			goto err_teardown_compat;
+	}
 
 	return nvmem;
 
+err_teardown_compat:
+	if (config->compat)
+		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 err_device_del:
 	device_del(&nvmem->dev);
 err_put_device:
-- 
2.19.0

