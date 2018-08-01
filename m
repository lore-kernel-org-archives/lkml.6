Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7148BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BF020841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BF020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbeHAUSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:18:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404209AbeHATDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A2CAFCC;
        Wed,  1 Aug 2018 16:58:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 113/336] soc: qcom: smem: fix qcom_smem_set_global_partition()
Date:   Wed,  1 Aug 2018 18:47:28 +0200
Message-Id: <20180801165033.473444756@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Elder <elder@linaro.org>

[ Upstream commit 8fa1a21409da6abfe890f66532f9fcd8d2c25a3d ]

If there is at least one entry in the partition table, but no global
entry, the qcom_smem_set_global_partition() should return an error
just like it does if there are no partition table entries.

It turns out the function still returns an error in this case, but
it waits to do so until it has mistakenly treated the last entry in
the table as if it were the global entry found.

Fix the function to return immediately if no global entry is found
in the table.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/smem.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -695,9 +695,10 @@ static u32 qcom_smem_get_item_count(stru
 static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 {
 	struct smem_partition_header *header;
-	struct smem_ptable_entry *entry = NULL;
+	struct smem_ptable_entry *entry;
 	struct smem_ptable *ptable;
 	u32 host0, host1, size;
+	bool found = false;
 	int i;
 
 	ptable = qcom_smem_get_ptable(smem);
@@ -709,11 +710,13 @@ static int qcom_smem_set_global_partitio
 		host0 = le16_to_cpu(entry->host0);
 		host1 = le16_to_cpu(entry->host1);
 
-		if (host0 == SMEM_GLOBAL_HOST && host0 == host1)
+		if (host0 == SMEM_GLOBAL_HOST && host0 == host1) {
+			found = true;
 			break;
+		}
 	}
 
-	if (!entry) {
+	if (!found) {
 		dev_err(smem->dev, "Missing entry for global partition\n");
 		return -EINVAL;
 	}


