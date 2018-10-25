Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABE6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5705D208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO7icAXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5705D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbeJYWxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729507AbeJYWxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:19 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2F920848;
        Thu, 25 Oct 2018 14:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477221;
        bh=QIRQztWzFMnjKGrvX95JHXgGOlWEWWd+caGT0ukZnkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KO7icAXfRuYz5/Def+DkHSi9m7i5xc30FkRNhMuGLYNGLb/4QMQ5NEAcRSKDs/ehu
         wRfSvwzXhYykJvPWs+WgEPhpaViL1zevBtmr9nQxbQEXrPXNXo5Hmcw9jOk5CWWWtU
         m5DKhqHeozZENzROgoxCOX+4TANpa10RQolsr2tA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 57/98] of/pci: Remove duplicate kfree in of_pci_get_host_bridge_resources()
Date:   Thu, 25 Oct 2018 10:18:12 -0400
Message-Id: <20181025141853.214051-57-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[ Upstream commit feb28979c137ba3f649ad36fc27c85c64c111f78 ]

Commit d2be00c0fb5a ("of/pci: Free resources on failure in
of_pci_get_host_bridge_resources()") fixed the error path so it frees
everything on the "resources" list.  That list includes the bus_range, so
we should not free it again.

Remove the superfluous free of bus_range.

[bhelgaas: changelog]
Fixes: d2be00c0fb5a ("of/pci: Free resources on failure in of_pci_get_host_bridge_resources()")
Reported-by: Jiang Liu <jiang.liu@linux.intel.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/of_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index ecc5fa5640d2..8a74b1d399a1 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -229,7 +229,6 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	list_for_each_entry(window, resources, list)
 		kfree(window->res);
 	pci_free_resource_list(resources);
-	kfree(bus_range);
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
-- 
2.17.1

