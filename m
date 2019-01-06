Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65455C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4AB20859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfAFT3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:29:24 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36443 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFT3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:29:24 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:143e:fcd5:beb7:2140])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 4D1F213F879;
        Sun,  6 Jan 2019 20:29:16 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 8/8] nvmem: core: Avoid useless iterations in nvmem_cell_get_from_lookup()
Date:   Sun,  6 Jan 2019 20:28:20 +0100
Message-Id: <20190106192820.12558-9-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190106192820.12558-1-albeu@free.fr>
References: <20190106192820.12558-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the correct cell has been found there is no need to continue
iterating, just stop there. While at it replace the goto used to leave
the loop with simple break statements.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/nvmem/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 176fe72f4eb5..9334f074defb 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -977,7 +977,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 			if (IS_ERR(nvmem)) {
 				/* Provider may not be registered yet. */
 				cell = ERR_CAST(nvmem);
-				goto out;
+				break;
 			}
 
 			cell = nvmem_find_cell_by_name(nvmem,
@@ -985,12 +985,11 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 			if (!cell) {
 				__nvmem_device_put(nvmem);
 				cell = ERR_PTR(-ENOENT);
-				goto out;
 			}
+			break;
 		}
 	}
 
-out:
 	mutex_unlock(&nvmem_lookup_mutex);
 	return cell;
 }
-- 
2.19.1

