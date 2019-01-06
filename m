Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B505C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB06820859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfAFT2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:28:37 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:30987 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFT2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:28:37 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:143e:fcd5:beb7:2140])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id ADD7F13F8C9;
        Sun,  6 Jan 2019 20:28:29 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 1/8] nvmem: core: Set the provider read-only when no write callback is given
Date:   Sun,  6 Jan 2019 20:28:13 +0100
Message-Id: <20190106192820.12558-2-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190106192820.12558-1-albeu@free.fr>
References: <20190106192820.12558-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no write callback is given the device should be marked as read-only.
While at it also move from a bit or to a logical or as that is a logical
expression.

Signed-off-by: Alban Bedel <albeu@free.fr>
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
2.19.1

