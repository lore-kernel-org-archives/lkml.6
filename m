Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B91ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE3A21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcfCNg+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE3A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbeJSCB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbeJSCB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:01:28 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D909D21476;
        Thu, 18 Oct 2018 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885562;
        bh=tOidYsrbvzWGdohuUBvwktXVtb9jaquL69Ey8pG/YbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcfCNg+dY1MLA9KXDbkH5xyEbc3vh3HuwuROjn/AVVJjmXuJd8SHqHanFMfiv9cdb
         rpkeTWwTL3i3iIswLdxJjGtxcKqv+QQy9xXgY9Mk9GdewzpWyFHBO/jIyFf+o+Do+z
         W9ar0E7NUQYMqUWltJaHRGxinKhFhvP8Gbzd/T2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 48/53] iommu/amd: Return devid as alias for ACPI HID devices
Date:   Thu, 18 Oct 2018 19:54:41 +0200
Message-Id: <20181018175424.840403669@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arindam Nath <arindam.nath@amd.com>

[ Upstream commit 5ebb1bc2d63d90dd204169e21fd7a0b4bb8c776e ]

ACPI HID devices do not actually have an alias for
them in the IVRS. But dev_data->alias is still used
for indexing into the IOMMU device table for devices
being handled by the IOMMU. So for ACPI HID devices,
we simply return the corresponding devid as an alias,
as parsed from IVRS table.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
Fixes: 2bf9a0a12749 ('iommu/amd: Add iommu support for ACPI HID devices')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/amd_iommu.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -246,7 +246,13 @@ static u16 get_alias(struct device *dev)
 
 	/* The callers make sure that get_device_id() does not fail here */
 	devid = get_device_id(dev);
+
+	/* For ACPI HID devices, we simply return the devid as such */
+	if (!dev_is_pci(dev))
+		return devid;
+
 	ivrs_alias = amd_iommu_alias_table[devid];
+
 	pci_for_each_dma_alias(pdev, __last_alias, &pci_alias);
 
 	if (ivrs_alias == pci_alias)


