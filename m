Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F96C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B6C2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAJPA0PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfA1Rfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:35:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbfA1PzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so18578830wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y61FLzvMGwuY8EhkE3hjek/pc/s87AiM7Lg6ZKyxvx4=;
        b=PAJPA0PEon0lTUGPXRPrGfxDPtCfSY3yMfUz5KR6fsjS6OccHlcjx2Up2RA7cX+3Iv
         4SwIz4Xvs7Dig4ulvTR/hKXAiebOu4POKXv8sbcp/FEbrT9OXCyWCDYTxyHqIjrpNRXE
         lNjDPjhgsSkP+A40JmE7Bqdh5O1w5pPHujeog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y61FLzvMGwuY8EhkE3hjek/pc/s87AiM7Lg6ZKyxvx4=;
        b=A/tqGzAV6ORuZ8AR4iDut1muRhkkY58NelQbOA3Xez797hZD3axA1nFh3xPB0KsRjJ
         bRqnb6r5mg4nAoEPDmQZRXkEewAVojECYJmoVZh4ZtzHrEWtJ5gJxUSdwTkMxeam3R9i
         bdoPFK5es3gKvEhujvD8z7UZ6PjbEchmjHZvITtvKq9Tv+BELDbDogzB9M0uhn+v8uT6
         DpCLQgfd19QYFyF4GRKnW0/y7DXpvN2cXcP5pZnyp+rEuMGEiBEpDSXybkQ9WGAgw6gT
         RVk4CBsdkPzs4ComHYmsLVbNx1XBowaYFR2Je4ddOxKrTO9SEcsORphJiDb8RsBZ8ijE
         K0aQ==
X-Gm-Message-State: AJcUukd4Ek0etLspRIW1scCotN9ne2pvvzYtP+YU51rWura9d6xanoHJ
        jFwnXwYSoR1/pzgfuE56jVPERp2qT3c=
X-Google-Smtp-Source: ALg8bN5YUpgipDadDlC8mGIgq0hJzl5kKTvEkp8usRIiqetiYcA/Rr7uhuvCYWGSPyaqMTyFMJ/l+g==
X-Received: by 2002:a5d:5208:: with SMTP id j8mr23115456wrv.188.1548690918427;
        Mon, 28 Jan 2019 07:55:18 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] nvmem: core: Fix cell lookup when no cell is found
Date:   Mon, 28 Jan 2019 15:55:02 +0000
Message-Id: <20190128155506.25566-10-srinivas.kandagatla@linaro.org>
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

If the cell list is not empty and nvmem_find_cell_by_node/name() is
called for a cell that is not present in the list they will return an
invalid pointer instead of NULL. This happen because
list_for_each_entry() stop once it reach the list head again, but as
the list head is not contained in a struct nvmem_cell the iteration
variable then contains an invalid value.

This is easily solved by using a variable to iterate over the list and
one to return the cell found.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f8c43da6f2ca..a2ad44104aa2 100644
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
2.20.1

