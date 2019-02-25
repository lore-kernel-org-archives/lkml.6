Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBE1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF96B20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129919;
	bh=S6jsJMZ3tdT2rGL2uMCqPH4UqgQdqBJfLJkPxlevlyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TQ3IbNQke6RJ329F4pK7B1DqDiklOHiQAlINDtXsjCrwiv+nSX60VIWjzNhp+yrLc
	 PH4Aty93cng4I/CqxhP0ZtDTeao/oA9bs6HSI0EYnxbCh7uwYI62yTxGAWsBFkzENO
	 k+fByYu6qpBgQOIGOweYl73uCbwYgzl9wWB+uC7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfBYVZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731346AbfBYVZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:25:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7577B2084D;
        Mon, 25 Feb 2019 21:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129910;
        bh=S6jsJMZ3tdT2rGL2uMCqPH4UqgQdqBJfLJkPxlevlyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kP5F53S+x4A+LdQxUCCnjd5ZowvRMqhnRdMnGh5meDhCuMa5NzLq9t+dmMeUrTq3e
         JBZfpdxiqh+e1oAf3N2S9ggAwBEtmH61X74lqx+4PwLPRAd/U73kX9kAX/kQd5zT8F
         caR/tJclCsubxhB8h8IaJRm9AhgjtKt/UD8GqRh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jane Chu <jane.chu@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/152] acpi/nfit: Fix race accessing memdev in nfit_get_smbios_id()
Date:   Mon, 25 Feb 2019 22:10:51 +0100
Message-Id: <20190225195047.559587234@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index ea59c01ce8db0..f530d35412428 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -719,6 +719,7 @@ int nfit_get_smbios_id(u32 device_handle, u16 *flags)
 	struct acpi_nfit_memory_map *memdev;
 	struct acpi_nfit_desc *acpi_desc;
 	struct nfit_mem *nfit_mem;
+	u16 physical_id;
 
 	mutex_lock(&acpi_desc_lock);
 	list_for_each_entry(acpi_desc, &acpi_descs, list) {
@@ -726,10 +727,11 @@ int nfit_get_smbios_id(u32 device_handle, u16 *flags)
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



