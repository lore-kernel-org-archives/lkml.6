Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2489C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84D0222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025304;
	bh=EHKHFXrbKdK8wAs5O22yOtWYD1HLyR02FuxiFdINdw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bM7yE/TSBgdNyL/OByhMz9UhpHlJVKLctIJ6HjbL4UWpW/vAkjwjATejU7m6Eakwe
	 f8mpde6FkFhID29jjBnn0UfMVeVf2bKJ94vrEJ0jQ9aRX4XRdUqiOM5zy4I1jMW1Gy
	 g3XfbjTluHxxT2r43RHJObIy27EJOaxso1JNoYWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbfBMCfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387855AbfBMCe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2906F222CE;
        Wed, 13 Feb 2019 02:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025297;
        bh=EHKHFXrbKdK8wAs5O22yOtWYD1HLyR02FuxiFdINdw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6CDgMYAvkPtbcmCQa3t6QLboqf66V3Vv4pHuZAybX2zi9tU+tqbCOaycBYiVUYPM
         oA9qQMJMDPjvzJzuXesRCCDx5MyzMtDgooip4G0KRIDyZ4PALAec7MySLaJ/o1WufZ
         vyIyCer0W6zFupnyvNeD1fFSNoyk/9QBtw2jYNiI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 052/105] acpi/nfit: Fix race accessing memdev in nfit_get_smbios_id()
Date:   Tue, 12 Feb 2019 21:32:43 -0500
Message-Id: <20190213023336.19019-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 0919871ac37fdcf46c7657da0f1742efe096b399 ]

Possible race accessing memdev structures after dropping the
mutex. Dan Williams says this could race against another thread
that is doing:

 # echo "ACPI0012:00" > /sys/bus/acpi/drivers/nfit/unbind

Reported-by: Jane Chu <jane.chu@oracle.com>
Fixes: 23222f8f8dce ("acpi, nfit: Add function to look up nvdimm...")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 8535e7999769..2a2d7ec77252 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -724,6 +724,7 @@ int nfit_get_smbios_id(u32 device_handle, u16 *flags)
 	struct acpi_nfit_memory_map *memdev;
 	struct acpi_nfit_desc *acpi_desc;
 	struct nfit_mem *nfit_mem;
+	u16 physical_id;
 
 	mutex_lock(&acpi_desc_lock);
 	list_for_each_entry(acpi_desc, &acpi_descs, list) {
@@ -731,10 +732,11 @@ int nfit_get_smbios_id(u32 device_handle, u16 *flags)
 		list_for_each_entry(nfit_mem, &acpi_desc->dimms, list) {
 			memdev = __to_nfit_memdev(nfit_mem);
 			if (memdev->device_handle == device_handle) {
+				*flags = memdev->flags;
+				physical_id = memdev->physical_id;
 				mutex_unlock(&acpi_desc->init_mutex);
 				mutex_unlock(&acpi_desc_lock);
-				*flags = memdev->flags;
-				return memdev->physical_id;
+				return physical_id;
 			}
 		}
 		mutex_unlock(&acpi_desc->init_mutex);
-- 
2.19.1

