Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DEBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BA02147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XX45LbDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfA1Rfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:35:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40961 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfA1PzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so18589832wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0/pWPJ9dN7bFakh4TwkUfEapIBrvkN+RgDjhJ97VaY=;
        b=XX45LbDLTNBdDRPJ8E3DbnJM9ifQQ5fhMisTGa7brzYR2ZY6kjoahFlFgXDb8eu/ZB
         54Y26gr9wTWC4yGD0D/r9gbXz/TqZ2vtpXB+hMe+KUeAXKNdHCeCTtFP1w7yqad5VMDQ
         54aJVzPR0imzId/4a1WRzUIJyEhmdKTogSVS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0/pWPJ9dN7bFakh4TwkUfEapIBrvkN+RgDjhJ97VaY=;
        b=cNDHo117eD8lLKSrDkDkk+5bSN16v+b8k5ibZ5azDKLpk1T49nYfZiKG+aK8fOg/jQ
         IlRXOErTcL69PhVw6HWwqzuq9+CGhE8keKrPwNAXECUh3TQlKDmJT2PnpTGqfL0Wmswd
         p4GXmSSgjTO5S4FyWWwIFrX6y+xQ9ZnQG1O6hqBJxDt9wFkBEjLDpbY8LxmUxN1P2RYu
         WNGsmgGZxsZJRAyGE0Q2PSFkshFH06qOOTOfJyD38JZ9ddnuwalLogDf66NNUUfI/slN
         ENCAmgqs1OvGNenZtketAt2Wd1BPhjXRSd12p1lbCIbrznHAbyJmIOKv2ka4C3Le/MdB
         KoJA==
X-Gm-Message-State: AHQUAuZGTd8Cjk57ZZfQBmpeujkEC+ZJoewNbTf8Myb0250+ddYZZvUV
        CXihm/q4Cxk1R0oOYSrecN47+utvpUo=
X-Google-Smtp-Source: AHgI3IYsYuaIKsi7bzRFWL4UmMTu/4e8bXmZF5wNchbXo1o4FHsnXU4qIaRPs/FOGIDY7Fo9LvhbkQ==
X-Received: by 2002:adf:ef88:: with SMTP id d8mr1130981wro.163.1548690919658;
        Mon, 28 Jan 2019 07:55:19 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] nvmem: core: Properly handle connection ID in of_nvmem_device_get()
Date:   Mon, 28 Jan 2019 15:55:03 +0000
Message-Id: <20190128155506.25566-11-srinivas.kandagatla@linaro.org>
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

of_nvmem_device_get() would crash if NULL was passed as a connection
ID. Rework this to use the usual sementic of assuming the first
connection when no connection ID is given.

Furthermore of_nvmem_device_get() would return -EINVAL when it failed
to resolve the connection, making it impossible to properly implement
an optional connection. Return -ENOENT instead to let the caller know
that the connection doesn't exists.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a2ad44104aa2..a749a5cb0a4e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -839,13 +839,14 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 {
 
 	struct device_node *nvmem_np;
-	int index;
+	int index = 0;
 
-	index = of_property_match_string(np, "nvmem-names", id);
+	if (id)
+		index = of_property_match_string(np, "nvmem-names", id);
 
 	nvmem_np = of_parse_phandle(np, "nvmem", index);
 	if (!nvmem_np)
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-ENOENT);
 
 	return __nvmem_device_get(nvmem_np, NULL);
 }
-- 
2.20.1

