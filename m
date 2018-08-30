Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9581820835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mj6mfJqM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H0lTUcCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9581820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeH3WlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:41:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47508 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeH3WlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:41:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6F9D36063F; Thu, 30 Aug 2018 18:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535654271;
        bh=K8GAZT3kkg3J0iJdVGjiqEA+BBBiKPMOzzGAS4x4D5U=;
        h=From:To:Cc:Subject:Date:From;
        b=mj6mfJqMC3FviP6zUqeBfT58s8njeL7B2cx2/S5YacRmIcLGm0FmEsEz2CYkN7YMS
         PPcX9uEdG/G81Q0x6isLIfXL8poHX/fBt6z7wfet649sQviYa/+VUTicOZD2MJlWjq
         Ypckb+UEtRA9Jq9q5htbudCoNCjq9c9gnmHyT0wA=
Received: from controller.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED1856038E;
        Thu, 30 Aug 2018 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535654270;
        bh=K8GAZT3kkg3J0iJdVGjiqEA+BBBiKPMOzzGAS4x4D5U=;
        h=From:To:Cc:Subject:Date:From;
        b=H0lTUcCom+OW3VjBLaRwjtbYhcTa/iHnJtKa9Zqouvi34mmxLwbupTPhx84tLx/EW
         dHbpiEh/zN/9vs/kRP+kcBB8O8QF5/bnNMm+WHpUqdb21bQCJpSnOPN50/NqEOOcVU
         4tv7Esj64VZ0HOR2TqZJNb8/IpslDuOveQzOBk3k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED1856038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   Fan Wu <wufan@codeaurora.org>
To:     mchehab@kernel.org
Cc:     bp@alien8.de, james.morse@arm.com, baicar.tyler@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, john.garry@huawei.com,
        toshi.kani@hpe.com, Fan Wu <wufan@codeaurora.org>
Subject: [PATCH v2] EDAC, ghes: use CPER module handles to locate DIMMs
Date:   Thu, 30 Aug 2018 18:37:46 +0000
Message-Id: <1535654266-40053-1-git-send-email-wufan@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For platforms whose firmwares provide valid module handles
(SMBIOS type 17) in error records, this patch uses the module
handles to locate corresponding DIMMs and enables per-DIMM
error counter update.

Signed-off-by: Fan Wu <wufan@codeaurora.org>
---

Changes from v1:
*  Changed the new function name to get_dimm_smbios_index
*  Removed unnecessary checks inside get_dimm_smbios_index
*  Reverted the change of the DMI handle print
*  Updated commit message

---
 drivers/edac/ghes_edac.c | 25 +++++++++++++++++++++++++
 include/linux/edac.h     |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 473aeec..949f603 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -81,6 +81,20 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
+static int get_dimm_smbios_index(u16 handle)
+{
+	struct mem_ctl_info *mci;
+	int i;
+
+	mci = ghes_pvt->mci;
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
@@ -177,6 +191,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 				entry->total_width, entry->data_width);
 		}
 
+		dimm->smbios_handle = entry->handle;
+
 		dimm_fill->count++;
 	}
 }
@@ -327,12 +343,21 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		const char *bank = NULL, *device = NULL;
+		int index = -1;
+
 		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
 		if (bank != NULL && device != NULL)
 			p += sprintf(p, "DIMM location:%s %s ", bank, device);
 		else
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
+
+		index = get_dimm_smbios_index(mem_err->mem_dev_handle);
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

