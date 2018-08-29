Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA17C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCCD20657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fXQitN6K";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fXQitN6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCCD20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeH2WcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:32:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeH2WcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:32:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E35FB6055B; Wed, 29 Aug 2018 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535567636;
        bh=umWvDB2GUgXjzPQxybvq5exqOnvpeZPtmBMZgUyFah0=;
        h=From:To:Cc:Subject:Date:From;
        b=fXQitN6Kxv/htbwcCHs0BkuU79L9xM6WpQvMVNIlwz3oQM7cHvlp8ELU42dztwW3u
         UkyWMVFtGI1elzd+e+uKG5J5I1FTjP7tRtJWPypD6U6fqPb9ZDvb3OhMGFxykuqNBc
         rqOFik+vhkvGuO+N1aC/S0hfI7PrFsUNtw3K9ByY=
Received: from controller.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52F91602AE;
        Wed, 29 Aug 2018 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535567636;
        bh=umWvDB2GUgXjzPQxybvq5exqOnvpeZPtmBMZgUyFah0=;
        h=From:To:Cc:Subject:Date:From;
        b=fXQitN6Kxv/htbwcCHs0BkuU79L9xM6WpQvMVNIlwz3oQM7cHvlp8ELU42dztwW3u
         UkyWMVFtGI1elzd+e+uKG5J5I1FTjP7tRtJWPypD6U6fqPb9ZDvb3OhMGFxykuqNBc
         rqOFik+vhkvGuO+N1aC/S0hfI7PrFsUNtw3K9ByY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52F91602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   Fan Wu <wufan@codeaurora.org>
To:     mchehab@kernel.org
Cc:     bp@alien8.de, james.morse@arm.com, baicar.tyler@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Fan Wu <wufan@codeaurora.org>
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
Date:   Wed, 29 Aug 2018 18:33:52 +0000
Message-Id: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ghes_edac driver does not update per-dimm error
counters when reporting memory errors, because there is no
platform-independent way to find DIMMs based on the error
information provided by firmware. This patch offers a solution
for platforms whose firmwares provide valid module handles
(SMBIOS type 17) in error records. In this case ghes_edac will
use the module handles to locate DIMMs and thus makes per-dimm
error reporting possible.

Signed-off-by: Fan Wu <wufan@codeaurora.org>
---
 drivers/edac/ghes_edac.c | 36 +++++++++++++++++++++++++++++++++---
 include/linux/edac.h     |  2 ++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 473aeec..db527f0 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -81,6 +81,26 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
+static int ghes_edac_dimm_index(u16 handle)
+{
+	struct mem_ctl_info *mci;
+	int i;
+
+	if (!ghes_pvt)
+		return -1;
+
+	mci = ghes_pvt->mci;
+
+	if (!mci)
+		return -1;
+
+	for (i = 0; i < mci->tot_dimms; i++) {
+		if (mci->dimms[i]->smbios_handle == handle)
+			return i;
+	}
+	return -1;
+}
+
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 {
 	struct ghes_edac_dimm_fill *dimm_fill = arg;
@@ -177,6 +197,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 				entry->total_width, entry->data_width);
 		}
 
+		dimm->smbios_handle = entry->handle;
+
 		dimm_fill->count++;
 	}
 }
@@ -327,12 +349,20 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		const char *bank = NULL, *device = NULL;
+		int index = -1;
+
 		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
+		p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
+			     mem_err->mem_dev_handle);
 		if (bank != NULL && device != NULL)
 			p += sprintf(p, "DIMM location:%s %s ", bank, device);
-		else
-			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
-				     mem_err->mem_dev_handle);
+
+		index = ghes_edac_dimm_index(mem_err->mem_dev_handle);
+		if (index >= 0) {
+			e->top_layer = index;
+			e->enable_per_layer_report = true;
+		}
+
 	}
 	if (p > e->location)
 		*(p - 1) = '\0';
diff --git a/include/linux/edac.h b/include/linux/edac.h
index bffb978..a45ce1f 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -451,6 +451,8 @@ struct dimm_info {
 	u32 nr_pages;			/* number of pages on this dimm */
 
 	unsigned csrow, cschannel;	/* Points to the old API data */
+
+	u16 smbios_handle;              /* Handle for SMBIOS type 17 */
 };
 
 /**
-- 
2.7.4

