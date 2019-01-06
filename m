Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE7FC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B7120859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfAFT3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:29:11 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:35588 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFT3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:29:10 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:143e:fcd5:beb7:2140])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 054DF13F7E7;
        Sun,  6 Jan 2019 20:29:02 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 6/8] nvmem: core: Always reference the device returned by nvmem_device_get()
Date:   Sun,  6 Jan 2019 20:28:18 +0100
Message-Id: <20190106192820.12558-7-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190106192820.12558-1-albeu@free.fr>
References: <20190106192820.12558-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 28e01a9876c6..2fa97b373601 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -874,7 +874,7 @@ struct nvmem_device *nvmem_device_get(struct device *dev, const char *dev_name)
 
 	}
 
-	return nvmem_find(dev_name);
+	return __nvmem_device_get(NULL, dev_name);
 }
 EXPORT_SYMBOL_GPL(nvmem_device_get);
 
-- 
2.19.1

