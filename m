Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCB2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9163F20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9163F20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbeHAUYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:24:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45742 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403771AbeHATDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:32 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD590FD2;
        Wed,  1 Aug 2018 16:58:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 114/336] soc: qcom: smem: byte swap values properly
Date:   Wed,  1 Aug 2018 18:47:29 +0200
Message-Id: <20180801165033.512127963@linuxfoundation.org>
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

[ Upstream commit 04a512fea333369cc0b550f3b90df0d638e34d00 ]

Two places report an error when a partition header is found to
not contain the right canary value.  The error messages do not
properly byte swap the host ids.  Fix this, and adjust the format
specificier to match the 16-bit unsigned data type.

Move the error handling for a bad canary value to the end of
qcom_smem_alloc_private().  This avoids some long lines, and
reduces the distraction of handling this unexpected problem.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/smem.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -362,13 +362,8 @@ static int qcom_smem_alloc_private(struc
 	cached = phdr_to_last_cached_entry(phdr);
 
 	while (hdr < end) {
-		if (hdr->canary != SMEM_PRIVATE_CANARY) {
-			dev_err(smem->dev,
-				"Found invalid canary in hosts %d:%d partition\n",
-				phdr->host0, phdr->host1);
-			return -EINVAL;
-		}
-
+		if (hdr->canary != SMEM_PRIVATE_CANARY)
+			goto bad_canary;
 		if (le16_to_cpu(hdr->item) == item)
 			return -EEXIST;
 
@@ -397,6 +392,11 @@ static int qcom_smem_alloc_private(struc
 	le32_add_cpu(&phdr->offset_free_uncached, alloc_size);
 
 	return 0;
+bad_canary:
+	dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
+		le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
+
+	return -EINVAL;
 }
 
 static int qcom_smem_alloc_global(struct qcom_smem *smem,
@@ -560,8 +560,8 @@ static void *qcom_smem_get_private(struc
 	return ERR_PTR(-ENOENT);
 
 invalid_canary:
-	dev_err(smem->dev, "Found invalid canary in hosts %d:%d partition\n",
-			phdr->host0, phdr->host1);
+	dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
+			le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
 
 	return ERR_PTR(-EINVAL);
 }


