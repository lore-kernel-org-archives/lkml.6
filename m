Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DABCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F286720989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjDvN5g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfA1PzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40335 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbfA1PzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so18623901wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0Ha4ellaoNOp/hRaJJ64zG2xd/bafkpJFLNPc8fabM=;
        b=fjDvN5g9fjipqa2VAqDp3/6TPI+kGIIQBdBnots0pBJug2WXIXVM5VihE4JUIxDF5U
         mMBzLvPto83PARanyrApdIIFfNbAQxauJGfUn0j514Vpl8AF9ZlWsVHNh7l+WZc3zuVc
         xPxdsHguQYtEQcYx6fVlSrdUsPV2mrhtoX+Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0Ha4ellaoNOp/hRaJJ64zG2xd/bafkpJFLNPc8fabM=;
        b=Cd8Jba+WCWh+gkC4tWfq6WZQ01NTth/dSajy4zaSrqLW3PjNcMMdO1ZVQ/lik8vIyD
         xyI8DzfqQUPsNrVguWOa7moE1LmgOorFSb2EpJruU3vlRzwf5QdymvtXRBNsITwuKFnb
         UY5hs1v2XR7wtm3qB+7+ejKy9e3ZpXJa1w3vG8Drj159DFnHBscILqrA3tkHxCNs9UTK
         SvZpLcCW958PUawKnELXU17zIQ3eWRKXMV5eJ/X0mWKiH4GSjFf+6eEm32cO6SNmc4Kx
         PlPDqj2Phzg3Wp6KSy0/2x5CCKOihHWawiYDaYEqSIgot/8vxTGlXEB5qRFEIfQpKaAA
         /YXw==
X-Gm-Message-State: AJcUukfxJD0+ExvrGwziZq8AjRnO+v1cvLJD75mY9S7pQQNOeY5tsTvE
        2HTLZgcMyZOQ/35d7n/rkzXDpyVhHAU=
X-Google-Smtp-Source: ALg8bN7pVAHd9F0TreLg9Cc0Uj68w5uAduzUcUkvlnRY+tmZngsGq3ZgqIn+0L/+OdAUBYa1fIQuAw==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr22937298wru.177.1548690920879;
        Mon, 28 Jan 2019 07:55:20 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] nvmem: core: Always reference the device returned by nvmem_device_get()
Date:   Mon, 28 Jan 2019 15:55:04 +0000
Message-Id: <20190128155506.25566-12-srinivas.kandagatla@linaro.org>
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

In nvmem_device_get(), when the device lookup fails with DT it
currently fallback on nvmem_find() which is wrong for two reasons.
First nvmem_find() return NULL when nothing is found instead of an
ERR_PTR. But nvmem_find() also just lookup the device, it doesn't
reference the module and increment the reference count like it is done
in the DT path.

To fix this we replace the call to nvmem_find() with a call to
__nvmem_device_get() which does all the referencing and return a
proper ERR_PTR in case of error.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a749a5cb0a4e..1752768dd2d2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -874,7 +874,7 @@ struct nvmem_device *nvmem_device_get(struct device *dev, const char *dev_name)
 
 	}
 
-	return nvmem_find(dev_name);
+	return __nvmem_device_get(NULL, dev_name);
 }
 EXPORT_SYMBOL_GPL(nvmem_device_get);
 
-- 
2.20.1

