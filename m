Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD916C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F48220859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfAFT3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:29:17 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36057 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFT3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:29:17 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:143e:fcd5:beb7:2140])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id A213813F879;
        Sun,  6 Jan 2019 20:29:09 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 7/8] nvmem: core: Fix device reference leak
Date:   Sun,  6 Jan 2019 20:28:19 +0100
Message-Id: <20190106192820.12558-8-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190106192820.12558-1-albeu@free.fr>
References: <20190106192820.12558-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__nvmem_device_get() make use of bus_find_device() to get the relevant
device and this function increase the reference count of the device
found, however this is not accounted for anywhere. Fix
__nvmem_device_get() and __nvmem_device_put() to properly release this
reference count.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2fa97b373601..176fe72f4eb5 100644
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
2.19.1

