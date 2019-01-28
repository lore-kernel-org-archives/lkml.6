Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACBEC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DE62147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0jFbjCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfA1PzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39805 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbfA1PzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so18614858wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EzzauLuRu7S4DI8YrZtbq8X+zovdFXkJQc9myBytVls=;
        b=f0jFbjCA+wizq41/gotVHqLqwPq00jSl0pprOR48HBDrBkyrWDohdYSA8yFonqdbZc
         5k3Wtpvi7daPEezkDYb242jq4esQiXyoxXKD/sFT5xCGs0ZAiS/l6Wb37bDMsuBlI7Ui
         CIb1CIqmh5QYqFrkPXW1RqHtdz7V2Ccenz1Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EzzauLuRu7S4DI8YrZtbq8X+zovdFXkJQc9myBytVls=;
        b=rwO0ggMlcHxRiSZlzkfUHWbFHfwFEYTfd7eGlTIZNIu2QG8jwa4yDzqV+GJuCTMAE3
         bBheEaTDj/YvtL+WQFIzIFE9krnuqRUB7AqOcvdvFqpoEkcklXoo134TaOpW2CEaCjN6
         FsGtOiAp7Hqko65msLxdjygxkdm/z8i8lgWukIzFZ1Q6tHMoHGxaqwx0BQHgjMYw2JTX
         rOZ+2OmVeko2dFGpp/GEWD3aRgG0xKTGQxaO2Lkb6O5x9TK7t0E+Ls5rXUHljYBY+WeE
         1Sh/PARCn+NiySMRE0isqWrXRaTXTlg5LqMZbYWenQgeU0mQLHWcD8cpsNuM1Qm3wmvR
         fdQw==
X-Gm-Message-State: AJcUukfkHH5fFutD9HOxvdULQC87ZwoNIlO87MO0+/HS4CkRRZ4gIdPE
        NO4EgYdXJRb9MnQRTAuN+zylUA==
X-Google-Smtp-Source: ALg8bN50loEwF+Dlemb6cPfdegGkMdsmokl2U7cca/aA6XuhnbAnRfhZiyrf/x24IMacbufmk8BIfA==
X-Received: by 2002:adf:ff09:: with SMTP id k9mr21346704wrr.97.1548690916153;
        Mon, 28 Jan 2019 07:55:16 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] nvmem: core: Set the provider read-only when no write callback is given
Date:   Mon, 28 Jan 2019 15:55:00 +0000
Message-Id: <20190128155506.25566-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
References: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Bedel <albeu@free.fr>

If no write callback is given the device should be marked as read-only.
While at it also move from a bit or to a logical or as that is a logical
expression.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f7301bb4ef3b..cf2e1091fe89 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -646,8 +646,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			     config->name ? config->id : nvmem->id);
 	}
 
-	nvmem->read_only = device_property_present(config->dev, "read-only") |
-			   config->read_only;
+	nvmem->read_only = device_property_present(config->dev, "read-only") ||
+			   config->read_only || !nvmem->reg_write;
 
 	if (config->root_only)
 		nvmem->dev.groups = nvmem->read_only ?
-- 
2.20.1

