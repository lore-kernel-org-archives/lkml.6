Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C983C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAD52147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H08UXXHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfA1Pz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40965 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbfA1PzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so18589966wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZsyg31nN3cTqKBQ+cnJv/eVAHpsVh0TDVW8eJ9YX1U=;
        b=H08UXXHZSo6EQbLRUZaDJa+u695P9tPKYYCyWyb1Sk5F35f1SNHRnD/TEMkd0ze3iB
         Q+/TtKyEyXXnUrRUF49uuQXdrphkZSAFqlv+xBzTC41xskHXGABFZ5woc2c03yrkoJkE
         PLgHsylS620TRUE1dUS7QjSyaMrNx2p9fltJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZsyg31nN3cTqKBQ+cnJv/eVAHpsVh0TDVW8eJ9YX1U=;
        b=PJ8YDATbTCDFrVQYrS1xGbY0PIZgx4gFVQozWsmeC2l7YFQBeTzwThi+injTdB9iBR
         xsOjZ6kNprqxjfQODCpFmEeoaqtq5OqQ08NsPHh+TV9IIe1oqvxMfyUmLnBqvnlrhglA
         Mc3rTcwkxeahNOJ+3ZqIhvMzaA+W1Zgfrv5stDMozfA2mGgYU04uliIoHq3u2cd30BHU
         236VWtzj9PulLViEAOEdYcUP/Xp1aQ5HPjHkC2OJsBqW1WOSoJYsO6pYAnB2vxkb+rjo
         9O+qJS/lTTlBddit3/vQ/2N6aQkL9384stzBpVtfqxAdcNj09xVnVX34A68AtFY+MnaF
         Lx/A==
X-Gm-Message-State: AJcUukexn1WXeX1QBLKjHeV2Px5SK1iJonlZZVUj3Ibu2cqfFOuFNlpI
        08THLzjZaAx4aTdicSacBsq/jT1WILE=
X-Google-Smtp-Source: ALg8bN6JANjddJespYCVP9WGYLzCi8HiKbRYL+/lxu3m0pyr87POj/IIXxQV0KWXwdssVGLqkLLRyA==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr23293116wrq.133.1548690921964;
        Mon, 28 Jan 2019 07:55:21 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:21 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] nvmem: core: Fix device reference leak
Date:   Mon, 28 Jan 2019 15:55:05 +0000
Message-Id: <20190128155506.25566-13-srinivas.kandagatla@linaro.org>
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

__nvmem_device_get() make use of bus_find_device() to get the relevant
device and this function increase the reference count of the device
found, however this is not accounted for anywhere. Fix
__nvmem_device_get() and __nvmem_device_put() to properly release this
reference count.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1752768dd2d2..5400017ef616 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -811,6 +811,7 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 			"could not increase module refcount for cell %s\n",
 			nvmem_dev_name(nvmem));
 
+		put_device(&nvmem->dev);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -821,6 +822,7 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 
 static void __nvmem_device_put(struct nvmem_device *nvmem)
 {
+	put_device(&nvmem->dev);
 	module_put(nvmem->owner);
 	kref_put(&nvmem->refcnt, nvmem_device_release);
 }
-- 
2.20.1

