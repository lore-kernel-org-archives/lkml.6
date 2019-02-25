Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ACF21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130281;
	bh=0nTbpr+zA2IUbW9xHpt3KlpJBbmDBzpDwpcH3akLwUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=er8qgoS1Bo9ZRUqWJirKni2TstJNMuMDGWOBLQP+KZ8YGc7fJKV/SXCqdG+XexaBV
	 Rh7SHisuXbkAGV5gZDvrnCr+hdZVmbYsungdkO12+g+lWqVzGPShIaxn6skxYnn4fo
	 Z2jtLjM5Ax0+uV6uAFoCLFSpL+1wVyWPSiG3WF9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfBYVbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:31:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbfBYVbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A5421841;
        Mon, 25 Feb 2019 21:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130275;
        bh=0nTbpr+zA2IUbW9xHpt3KlpJBbmDBzpDwpcH3akLwUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDp/dQNVAyeKQfUq2U7ifaFckqRimDGKUgz+CDJIT6BcmcvHURw6qfdyRvd+asTbE
         N2tpnkT/DG2/hl1fuggsn8Fi5ahqxFkXiP+A2JsADWeL1yp0nJNxNykG6EFOsRQPFz
         zUChy7L3ml34Yv5AVjXy4Xvr5a12quGl0vIWiokI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jane Chu <jane.chu@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 070/183] acpi/nfit: Fix race accessing memdev in nfit_get_smbios_id()
Date:   Mon, 25 Feb 2019 22:10:43 +0100
Message-Id: <20190225195106.285580384@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 8535e7999769b..2a2d7ec772526 100644
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



