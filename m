Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD91C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508862086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gXlWnFBP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KKb/fCXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508862086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeIDIOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:14:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeIDIOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 04:14:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B016660708; Tue,  4 Sep 2018 03:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536033061;
        bh=WNxFlAjiXtNw0S3ADpsV0WUgw3N9yMarJU/lCZLCnu4=;
        h=From:To:Cc:Subject:Date:From;
        b=gXlWnFBP2dVGejmKebbj+5B8h8OGs9OkxlPaEGeCoVetGUNOVDNdVQflbSuTj20CX
         2eHcoLpUCqSRqkdUi7gjbsksGcU7a7CYBKeJqAFwYEBiUG5e04RFJIuPYKsRuvbD/f
         6Jki2IUV7HI5xQVPWo27/DGSDTz6R/t2a63qmYD0=
Received: from controller.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F9D1603D2;
        Tue,  4 Sep 2018 03:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536033060;
        bh=WNxFlAjiXtNw0S3ADpsV0WUgw3N9yMarJU/lCZLCnu4=;
        h=From:To:Cc:Subject:Date:From;
        b=KKb/fCXAHSMZrYYTaxxH03RmEUXsyIisqby77ofqXPvjsDtxTHm/AALr4eC3OKPny
         lL4/zgJkXFLgnmIAX0RfL8KvOTMOvtpguh2cho8YHSvCrzVGsM29D06zpnfpVdA8P+
         V3micJlAcAvTNacRQc2HtN+obYXlSVQ+K+mFSrkQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F9D1603D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   Fan Wu <wufan@codeaurora.org>
To:     mchehab@kernel.org
Cc:     bp@alien8.de, james.morse@arm.com, baicar.tyler@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, john.garry@huawei.com,
        toshi.kani@hpe.com, tanxiaofei@huawei.com, wanghuiqiang@huawei.com,
        shiju.jose@huawei.com, Fan Wu <wufan@codeaurora.org>
Subject: [PATCH v3] EDAC, ghes: use CPER module handles to locate DIMMs
Date:   Tue,  4 Sep 2018 03:50:55 +0000
Message-Id: <1536033055-25522-1-git-send-email-wufan@codeaurora.org>
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
Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
Tested-by: Toshi Kani <toshi.kani@hpe.com>
Reviewed-by: Borislav Petkov <bp@alien8.de>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: tanxiaofei <tanxiaofei@huawei.com>
---

Changes from v2:
* Fixed coding style glitch
* Added Tested-by/Reviewed-by

Changes from v1:
*  Changed the new function name to get_dimm_smbios_index
*  Removed unnecessary checks inside get_dimm_smbios_index
*  Reverted the change of the DMI handle print
*  Updated commit message

---
 drivers/edac/ghes_edac.c | 23 +++++++++++++++++++++++
 include/linux/edac.h     |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 473aeec..ba46160 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -81,6 +81,18 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
+static int get_dimm_smbios_index(u16 handle)
+{
+	int i;
+	struct mem_ctl_info *mci = ghes_pvt->mci;
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
@@ -177,6 +189,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 				entry->total_width, entry->data_width);
 		}
 
+		dimm->smbios_handle = entry->handle;
+
 		dimm_fill->count++;
 	}
 }
@@ -327,12 +341,21 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
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

