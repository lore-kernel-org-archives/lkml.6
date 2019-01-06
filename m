Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08E7C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E37A20859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfAFT25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:28:57 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:32302 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFT25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:28:57 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:143e:fcd5:beb7:2140])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 9E00F13F8C1;
        Sun,  6 Jan 2019 20:28:49 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 4/8] nvmem: core: Fix cell lookup when no cell is found
Date:   Sun,  6 Jan 2019 20:28:16 +0100
Message-Id: <20190106192820.12558-5-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190106192820.12558-1-albeu@free.fr>
References: <20190106192820.12558-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cell list is not empty and nvmem_find_cell_by_node/name() is
called for a cell that is not present in the list they will return an
invalid pointer instead of NULL. This happen because
list_for_each_entry() stop once it reach the list head again, but as
the list head is not contained in a struct nvmem_cell the iteration
variable then contains an invalid value.

This is easily solved by using a variable to iterate over the list and
one to return the cell found.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/nvmem/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 8e1b52559467..a7556b20cff4 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -525,12 +525,14 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
 static struct nvmem_cell *
 nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
 {
-	struct nvmem_cell *cell = NULL;
+	struct nvmem_cell *iter, *cell = NULL;
 
 	mutex_lock(&nvmem_mutex);
-	list_for_each_entry(cell, &nvmem->cells, node) {
-		if (strcmp(cell_id, cell->name) == 0)
+	list_for_each_entry(iter, &nvmem->cells, node) {
+		if (strcmp(cell_id, iter->name) == 0) {
+			cell = iter;
 			break;
+		}
 	}
 	mutex_unlock(&nvmem_mutex);
 
@@ -994,12 +996,14 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 static struct nvmem_cell *
 nvmem_find_cell_by_node(struct nvmem_device *nvmem, struct device_node *np)
 {
-	struct nvmem_cell *cell = NULL;
+	struct nvmem_cell *iter, *cell = NULL;
 
 	mutex_lock(&nvmem_mutex);
-	list_for_each_entry(cell, &nvmem->cells, node) {
-		if (np == cell->np)
+	list_for_each_entry(iter, &nvmem->cells, node) {
+		if (np == iter->np) {
+			cell = iter;
 			break;
+		}
 	}
 	mutex_unlock(&nvmem_mutex);
 
-- 
2.19.1

