Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7ECC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F22420859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfAFT3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:29:04 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:34719 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFT3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:29:04 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:143e:fcd5:beb7:2140])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 48DF713F8C1;
        Sun,  6 Jan 2019 20:28:56 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 5/8] nvmem: core: Properly handle connection ID in of_nvmem_device_get()
Date:   Sun,  6 Jan 2019 20:28:17 +0100
Message-Id: <20190106192820.12558-6-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190106192820.12558-1-albeu@free.fr>
References: <20190106192820.12558-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_nvmem_device_get() would crash if NULL was passed as a connection
ID. Rework this to use the usual sementic of assuming the first
connection when no connection ID is given.

Furthermore of_nvmem_device_get() would return -EINVAL when it failed
to resolve the connection, making it impossible to properly implement
an optional connection. Return -ENOENT instead to let the caller know
that the connection doesn't exists.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/nvmem/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a7556b20cff4..28e01a9876c6 100644
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
2.19.1

