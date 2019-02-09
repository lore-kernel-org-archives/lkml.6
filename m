Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85754C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4919C21929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738093;
	bh=gdFFga7h/iqfP0WDSc2HBhpsTd+JS/x1oNY3LxbUDYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cxv1z/OoZEpZb+CnEn0OaGnClXBXB/7TlldI+80xXS5DjgANTBBrUTCBRzVDL9+ZL
	 vzBcIJqdH12nQ9gSasonoYpr9f+Z9eYWgYPmxWQpeN6pZFLgWCCwAovXwOXW0+T0Rw
	 dijzjSE0skviBHTpmf2DYQPD9HTRXeNvzdNeSM0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfBISsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:48:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfBISsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF4320821;
        Sat,  9 Feb 2019 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738081;
        bh=gdFFga7h/iqfP0WDSc2HBhpsTd+JS/x1oNY3LxbUDYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DW1pvgF2NqeymIxxkldm1ae2gBHbP1G+/66EBEyj1C6V6+/UDv4PUDJ75ntid1I9f
         WOITORLcZfCz83UrWX++ByfTJY8d9lHD+ZsmAtM67p29BLAk82jTT80KTuXr59RD7X
         rTME7kLpn904q2oi08pwkm4HsZ/zikp08ikRMqQw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 24/42] nvme: pad fake subsys NQN vid and ssvid with zeros
Date:   Sat,  9 Feb 2019 13:47:16 -0500
Message-Id: <20190209184734.125935-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit 3da584f57133e51aeb84aaefae5e3d69531a1e4f ]

We need to preserve the leading zeros in the vid and ssvid when generating
a unique NQN. Truncating these may lead to naming collisions.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 962012135b62..971ca6754959 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2095,7 +2095,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
-			"nqn.2014.08.org.nvmexpress:%4x%4x",
+			"nqn.2014.08.org.nvmexpress:%04x%04x",
 			le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
 	memcpy(subsys->subnqn + off, id->sn, sizeof(id->sn));
 	off += sizeof(id->sn);
-- 
2.19.1

