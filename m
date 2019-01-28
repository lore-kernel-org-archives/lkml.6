Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99A8C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BAD2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BW6BxRUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfA1RgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:36:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34916 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfA1PzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so18659566wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SM1B9I6t8HFBSAnmnKVD5EISrf58W+phlPhNn1H5SHI=;
        b=BW6BxRUlOzvur7L2/Cfdyc8uYKO3JNnbliumNpAzwqMo59groRSPfT8lEzXEksR5KI
         e9+CqZ17J42SXVm8RRelyiG8IO1DVkLJbBSRMpfb/97XY/r/eFOrgEcI38tU0u2K6MWr
         PvMs8b+m4G+g+5KNKZJZB15zWWtZw2s4RKDK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SM1B9I6t8HFBSAnmnKVD5EISrf58W+phlPhNn1H5SHI=;
        b=gLW9XKeg5efjHdINYEBhDZ6Km/ASEy1vmhtndDDjOLpRZVU2z+dU2gLFxw03tynPa/
         PABiHlgPCvk3OfO8QnGUqIsBRCVLqU5S3ikz3XfNUO6rtdcqB8EyZVP3T0pPLyqbUa5j
         W3B0Bv2lWAHZq1yGqwrZM93KZtsTkKt2RBWZ0DsVEPRw2aWiSOHSa0Mlk+doo+PN/2GK
         ggT5SJOMdRS8+i24ETPeCRQJX+w4/GcJMTk0Qcsgr4ksmpOczvxple6M7CzmVku+4z+B
         NtknLgmt11zzfrjgcckUiVz09aakyzTK+YrOupItFUXqufHCKpjcDy4DsiRYBEqzyyK0
         A1TQ==
X-Gm-Message-State: AJcUukf22xd6mdN+6jfcig5Fx1g+7kOf38Xckeohsieg3Hqto75rYXM2
        9yBJKoMGEOrwSeWusbJeUMwiuHK9+yM=
X-Google-Smtp-Source: ALg8bN7UaLt/BCTA7a+u174yz70iCGs/aggVPlZ+lwye08TCuHP2XPcGz3ydfMyDPE4nm8v1tT9QaQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr21265063wrs.7.1548690917342;
        Mon, 28 Jan 2019 07:55:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] nvmem: core: Fix of_nvmem_cell_get() for optional cells
Date:   Mon, 28 Jan 2019 15:55:01 +0000
Message-Id: <20190128155506.25566-9-srinivas.kandagatla@linaro.org>
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

of_nvmem_cell_get() should return -ENOENT when a cell isn't defined,
otherwise callers can't distinguish between a missing cell and other
errors.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index cf2e1091fe89..f8c43da6f2ca 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1031,7 +1031,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 
 	cell_np = of_parse_phandle(np, "nvmem-cells", index);
 	if (!cell_np)
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-ENOENT);
 
 	nvmem_np = of_get_next_parent(cell_np);
 	if (!nvmem_np)
-- 
2.20.1

