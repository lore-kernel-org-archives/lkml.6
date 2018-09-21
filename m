Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC70CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4992154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrVkCcR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4992154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390286AbeIUT3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39505 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUT3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:45 -0400
Received: by mail-io1-f65.google.com with SMTP id l7-v6so12226907iok.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ubyyzpqjZo5EwJuJjP578r7LdpokWJHLiT1J1QDuKOM=;
        b=UrVkCcR1izauToD6NsmJi2a9cfwTwb8CC8uvNHaIEcDaomsuSLIFdLd29wv7TYIFzp
         CQHITuJBM+dCUNAXiwCAookZz3zlu8JpIzdmPg6uaLDsNnqgb//UjAiyu8TCiaU1nnlA
         dDTeL1r1K4jHEfDxVBoAcRO64bxXrFhpk95tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ubyyzpqjZo5EwJuJjP578r7LdpokWJHLiT1J1QDuKOM=;
        b=OvF5g6nsjakjiAVkBVk/8+b4NBM1Se2jg2tG5aiRXnLwNlkTtkeglK2DS9zXg0fmKE
         r/Eg7nK8QECQg2lSn8QnI/917rlBF/+MTMMrgsP1wsEWVKCtDCPl0pYEmffFoYG7Gd87
         qu9NAnPui0Pc+lvumXas2VVUd6Z2rEJEmJAphzRg739y0ldGGwm0p9/m0jvNXRD0kola
         iFN1fZjOvxbCHtloZDGoWfTV2f5VfVlYrOC+X8B9Ng1zXhlN1k85u8m4CP+CHPmtkwrj
         xtkSwJ8vhK68ECzy1ZRIqtQCp4gPCesgo4IR/AwR4O5am2Er+2QOW5g0sfhyO0b2r1Ps
         jVGg==
X-Gm-Message-State: APzg51DBysh+rx4sED+NEvtLYtlxanJI20sWRsxGqERbJVKQNVMbxHR2
        JOR0jUWZJQKJABoVW79uWnGH3A==
X-Google-Smtp-Source: ANB0VdZGuPdw6DylpgVpK7U7949rbgmVO7WE26uAv5aHz3xCLR+7lqYa/VRPlrHK5Q+YWk4Og7aLsg==
X-Received: by 2002:a02:9936:: with SMTP id r51-v6mr40293149jaj.46.1537537250319;
        Fri, 21 Sep 2018 06:40:50 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:49 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 14/26] nvmem: remove the global cell list
Date:   Fri, 21 Sep 2018 06:40:14 -0700
Message-Id: <20180921134026.4596-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Nvmem subsystem keeps a global list of cells that, for non-DT systems,
can only be referenced by cell name, which makes it impossible to have
more than one nvmem device with cells named the same.

This patch makes every nvmem device the owner of the list of its cells.
This effectively removes the support for non-DT systems, but it will
be reintroduced following a different approach in subsequent patches.

This isn't a problem as support for board files in nvmem is currently
broken anyway: any user that would try to get an nvmem cell from the
global cell list would remove the cell after the calling
nvmem_cell_put(). This can cause anything from a subsequent user not
being able to get the cell to double free errors if more users hold
reference to the same cell at the same time.

Fortunately there are no such users which allows us to rework this part.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 64 +++++++++++---------------------------------
 1 file changed, 15 insertions(+), 49 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bd14d04782cd..ee794613024c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -38,6 +38,7 @@ struct nvmem_device {
 	int			flags;
 	struct bin_attribute	eeprom;
 	struct device		*base_dev;
+	struct list_head	cells;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	void *priv;
@@ -58,9 +59,6 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
-static LIST_HEAD(nvmem_cells);
-static DEFINE_MUTEX(nvmem_cells_mutex);
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -282,28 +280,11 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 	return to_nvmem_device(d);
 }
 
-static struct nvmem_cell *nvmem_find_cell(const char *cell_id)
-{
-	struct nvmem_cell *p;
-
-	mutex_lock(&nvmem_cells_mutex);
-
-	list_for_each_entry(p, &nvmem_cells, node)
-		if (!strcmp(p->name, cell_id)) {
-			mutex_unlock(&nvmem_cells_mutex);
-			return p;
-		}
-
-	mutex_unlock(&nvmem_cells_mutex);
-
-	return NULL;
-}
-
 static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
-	mutex_lock(&nvmem_cells_mutex);
+	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
-	mutex_unlock(&nvmem_cells_mutex);
+	mutex_unlock(&nvmem_mutex);
 	kfree(cell);
 }
 
@@ -311,16 +292,15 @@ static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 {
 	struct nvmem_cell *cell, *p;
 
-	list_for_each_entry_safe(cell, p, &nvmem_cells, node)
-		if (cell->nvmem == nvmem)
-			nvmem_cell_drop(cell);
+	list_for_each_entry_safe(cell, p, &nvmem->cells, node)
+		nvmem_cell_drop(cell);
 }
 
 static void nvmem_cell_add(struct nvmem_cell *cell)
 {
-	mutex_lock(&nvmem_cells_mutex);
-	list_add_tail(&cell->node, &nvmem_cells);
-	mutex_unlock(&nvmem_cells_mutex);
+	mutex_lock(&nvmem_mutex);
+	list_add_tail(&cell->node, &cell->nvmem->cells);
+	mutex_unlock(&nvmem_mutex);
 }
 
 static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
@@ -465,6 +445,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	}
 
 	kref_init(&nvmem->refcnt);
+	INIT_LIST_HEAD(&nvmem->cells);
 
 	nvmem->id = rval;
 	nvmem->owner = config->owner;
@@ -626,29 +607,14 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 {
 	struct nvmem_device *nvmem = NULL;
 
-	mutex_lock(&nvmem_mutex);
-
-	if (np) {
-		nvmem = of_nvmem_find(np);
-		if (!nvmem) {
-			mutex_unlock(&nvmem_mutex);
-			return ERR_PTR(-EPROBE_DEFER);
-		}
-	} else {
-		struct nvmem_cell *cell = nvmem_find_cell(cell_id);
-
-		if (cell) {
-			nvmem = cell->nvmem;
-			*cellp = cell;
-		}
-
-		if (!nvmem) {
-			mutex_unlock(&nvmem_mutex);
-			return ERR_PTR(-ENOENT);
-		}
-	}
+	if (!np)
+		return ERR_PTR(-ENOENT);
 
+	mutex_lock(&nvmem_mutex);
+	nvmem = of_nvmem_find(np);
 	mutex_unlock(&nvmem_mutex);
+	if (!nvmem)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
-- 
2.19.0

