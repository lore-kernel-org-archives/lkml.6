Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36EC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B7521929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738088;
	bh=3w/TlQ//xRWYnpDfJVfrrkeTYwjK0ZZ0UUtN1F24KTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GdkqZbiPf/v3cpzfSTBot0GPuGL3J94+LlDjpG4GZpKGapkyczgoehCrUteE44cWk
	 xcAjy0s2zz8pQr8p8Fh7q3cohFndPKs3zh6v2/yUChYmGQdG12Wawdm0EShLEaQk0g
	 JdVP4RqydDT7WoL7n2qoh7itce1ZWgnfpE6AGjdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfBISsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbfBISsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D0921916;
        Sat,  9 Feb 2019 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738082;
        bh=3w/TlQ//xRWYnpDfJVfrrkeTYwjK0ZZ0UUtN1F24KTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkUkMXlWNHMSh5Ge7YYqCq/GyXGHdO3raw/U4SqunmbIWBwiGcEgiMsVM5u1jVUcG
         2JM94AfBEHwKA5JQ4L53bGHykTIlI0LtDv8Y1M2GlhNiwElz4usgAOuDoF+GcQKeaa
         WB19pivX8KWSjxsyFX/Nna9P76/cAWoJE8S+kzc0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Dingwall <james@dingwall.me.uk>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 25/42] nvme: introduce NVME_QUIRK_IGNORE_DEV_SUBNQN
Date:   Sat,  9 Feb 2019 13:47:17 -0500
Message-Id: <20190209184734.125935-25-sashal@kernel.org>
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

From: James Dingwall <james@dingwall.me.uk>

[ Upstream commit 6299358d198a0635da2dd3c4b3ec37789e811e44 ]

If a device provides an NQN it is expected to be globally unique.
Unfortunately some firmware revisions for Intel 760p/Pro 7600p devices did
not satisfy this requirement.  In these circumstances if a system has >1
affected device then only one device is enabled.  If this quirk is enabled
then the device supplied subnqn is ignored and we fallback to generating
one as if the field was empty.  In this case we also suppress the version
check so we don't print a warning when the quirk is enabled.

Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: James Dingwall <james@dingwall.me.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 16 +++++++++-------
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  |  2 ++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 971ca6754959..5f9a5ef93969 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2084,14 +2084,16 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 	size_t nqnlen;
 	int off;
 
-	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
-	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
-		return;
-	}
+	if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
+		nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
+		if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
+			strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
+			return;
+		}
 
-	if (ctrl->vs >= NVME_VS(1, 2, 1))
-		dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
+		if (ctrl->vs >= NVME_VS(1, 2, 1))
+			dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
+	}
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 081cbdcce880..6ffa99a10a60 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -90,6 +90,11 @@ enum nvme_quirks {
 	 * Set MEDIUM priority on SQ creation
 	 */
 	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
+
+	/*
+	 * Ignore device provided subnqn.
+	 */
+	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 47597046c14f..c0d01048ce4d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2700,6 +2700,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_MEDIUM_PRIO_SQ },
+	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-- 
2.19.1

