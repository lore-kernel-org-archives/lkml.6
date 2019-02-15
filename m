Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F80C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A252073D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197507;
	bh=CT2K/sexOaZGPjsh/47ydH1F+Sm//8tD4a4Ha/lGCw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OF2nws6pmu2BdrC3VyEGh/D+aeixgz+cv2U4mkiBElYmHPV7Tl8Q7thZts4omojkl
	 pbUqmg932S1P4cOcyKdsK+dTJiAqsjZPduzdhsmKG69LmocdCMnZnW1maiE4t7+ZSr
	 nVwq0uNx7diYqjvmaN7IEAyCmyBRvgOQ8ybGMsyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfBOCZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405066AbfBOCOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BA6B206BA;
        Fri, 15 Feb 2019 02:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196849;
        bh=CT2K/sexOaZGPjsh/47ydH1F+Sm//8tD4a4Ha/lGCw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jv8Ft6sJjGNw2EqshkcnwZc5GTJp8MtNZqwhryfUvEGDYmZhf4GRao+C3TGN9YzpC
         Ld5X/i6SuCUO3JBY6GZPBOSD3WSCwugYMu0IrgCarcO5zOlesPKGn/hAVb7qsb5YPl
         oj4vZSEZ5SE+PRraDbDOoJCqey+lGRYCNdMgYp9k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Edward Cree <ecree@solarflare.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 31/40] sfc: suppress duplicate nvmem partition types in efx_ef10_mtd_probe
Date:   Thu, 14 Feb 2019 21:13:04 -0500
Message-Id: <20190215021313.178476-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edward Cree <ecree@solarflare.com>

[ Upstream commit 3366463513f544c12c6b88c13da4462ee9e7a1a1 ]

Use a bitmap to keep track of which partition types we've already seen;
 for duplicates, return -EEXIST from efx_ef10_mtd_probe_partition() and
 thus skip adding that partition.
Duplicate partitions occur because of the A/B backup scheme used by newer
 sfc NICs.  Prior to this patch they cause sysfs_warn_dup errors because
 they have the same name, causing us not to expose any MTDs at all.

Signed-off-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/ef10.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 09352ee43b55..cc3be94d0562 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -5852,22 +5852,25 @@ static const struct efx_ef10_nvram_type_info efx_ef10_nvram_types[] = {
 	{ NVRAM_PARTITION_TYPE_LICENSE,		   0,    0, "sfc_license" },
 	{ NVRAM_PARTITION_TYPE_PHY_MIN,		   0xff, 0, "sfc_phy_fw" },
 };
+#define EF10_NVRAM_PARTITION_COUNT	ARRAY_SIZE(efx_ef10_nvram_types)
 
 static int efx_ef10_mtd_probe_partition(struct efx_nic *efx,
 					struct efx_mcdi_mtd_partition *part,
-					unsigned int type)
+					unsigned int type,
+					unsigned long *found)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_NVRAM_METADATA_IN_LEN);
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_NVRAM_METADATA_OUT_LENMAX);
 	const struct efx_ef10_nvram_type_info *info;
 	size_t size, erase_size, outlen;
+	int type_idx = 0;
 	bool protected;
 	int rc;
 
-	for (info = efx_ef10_nvram_types; ; info++) {
-		if (info ==
-		    efx_ef10_nvram_types + ARRAY_SIZE(efx_ef10_nvram_types))
+	for (type_idx = 0; ; type_idx++) {
+		if (type_idx == EF10_NVRAM_PARTITION_COUNT)
 			return -ENODEV;
+		info = efx_ef10_nvram_types + type_idx;
 		if ((type & ~info->type_mask) == info->type)
 			break;
 	}
@@ -5880,6 +5883,13 @@ static int efx_ef10_mtd_probe_partition(struct efx_nic *efx,
 	if (protected)
 		return -ENODEV; /* hide it */
 
+	/* If we've already exposed a partition of this type, hide this
+	 * duplicate.  All operations on MTDs are keyed by the type anyway,
+	 * so we can't act on the duplicate.
+	 */
+	if (__test_and_set_bit(type_idx, found))
+		return -EEXIST;
+
 	part->nvram_type = type;
 
 	MCDI_SET_DWORD(inbuf, NVRAM_METADATA_IN_TYPE, type);
@@ -5908,6 +5918,7 @@ static int efx_ef10_mtd_probe_partition(struct efx_nic *efx,
 static int efx_ef10_mtd_probe(struct efx_nic *efx)
 {
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_NVRAM_PARTITIONS_OUT_LENMAX);
+	DECLARE_BITMAP(found, EF10_NVRAM_PARTITION_COUNT);
 	struct efx_mcdi_mtd_partition *parts;
 	size_t outlen, n_parts_total, i, n_parts;
 	unsigned int type;
@@ -5936,11 +5947,13 @@ static int efx_ef10_mtd_probe(struct efx_nic *efx)
 	for (i = 0; i < n_parts_total; i++) {
 		type = MCDI_ARRAY_DWORD(outbuf, NVRAM_PARTITIONS_OUT_TYPE_ID,
 					i);
-		rc = efx_ef10_mtd_probe_partition(efx, &parts[n_parts], type);
-		if (rc == 0)
-			n_parts++;
-		else if (rc != -ENODEV)
+		rc = efx_ef10_mtd_probe_partition(efx, &parts[n_parts], type,
+						  found);
+		if (rc == -EEXIST || rc == -ENODEV)
+			continue;
+		if (rc)
 			goto fail;
+		n_parts++;
 	}
 
 	rc = efx_mtd_add(efx, &parts[0].common, n_parts, sizeof(*parts));
-- 
2.19.1

