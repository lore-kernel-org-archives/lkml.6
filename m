Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947BBC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526C0208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675441;
	bh=VtmxsQOw5VAcY9RfDsztRuMW6P8oIW2qGcxlASVTjK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M64YJ2+kkCRuSYVrD4VkntbTcNaGhs5X1scduU5fvnqclc/xQNUuVvWRDV+7CO1ma
	 0jqNyFuOUDtzD9IOyqLJEp/qeQIDmXTGHZGJ5vKuuuOxZsqXEm5mNtFn0LEMDcEgee
	 BIlYearL0c2tlsQzrSs6NhkM92VDwwgg+SP0wsWk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526C0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeLMEak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:30:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbeLMEag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA98320672;
        Thu, 13 Dec 2018 04:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675435;
        bh=VtmxsQOw5VAcY9RfDsztRuMW6P8oIW2qGcxlASVTjK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqXwiadnEbgKjzrH5W4n/hRNv/aCKDFlVJtsR2rasjlt6VF6UkxWg6VPajtH4HmqL
         GBEtHie5M2+0Vy6h8N2bt7YV6KbR4ymgbx7y94pqjIiEadPunQMeJWRu9ga+E8FyIy
         j/FsQWQ56xaWwJTQlcpvUx8kmtg/7GvClLCZ09uo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 61/73] acpi/nfit: Fix user-initiated ARS to be "ARS-long" rather than "ARS-short"
Date:   Wed, 12 Dec 2018 23:28:26 -0500
Message-Id: <20181213042838.75160-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit b5fd2e00a60248902315fb32210550ac3cb9f44c ]

A "short" ARS (address range scrub) instructs the platform firmware to
return known errors. In contrast, a "long" ARS instructs platform
firmware to arrange every data address on the DIMM to be read / checked
for poisoned data.

The conversion of the flags in commit d3abaf43bab8 "acpi, nfit: Fix
Address Range Scrub completion tracking", changed the meaning of passing
'0' to acpi_nfit_ars_rescan(). Previously '0' meant "not short", now '0'
is ARS_REQ_SHORT. Pass ARS_REQ_LONG to restore the expected scrub-type
behavior of user-initiated ARS sessions.

Fixes: d3abaf43bab8 ("acpi, nfit: Fix Address Range Scrub completion tracking")
Reported-by: Jacek Zloch <jacek.zloch@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index c5d15752dfb3..75b331f8a16a 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1303,7 +1303,7 @@ static ssize_t scrub_store(struct device *dev,
 	if (nd_desc) {
 		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-		rc = acpi_nfit_ars_rescan(acpi_desc, 0);
+		rc = acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
 	}
 	device_unlock(dev);
 	if (rc)
-- 
2.19.1

