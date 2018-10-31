Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCE5ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1674720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7yLNZMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1674720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbeKAISm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731801AbeKAILl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7028A2081B;
        Wed, 31 Oct 2018 23:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027489;
        bh=aTUpDGa/pUkkqbgzQRRdUvjAQP5tBV/ne0HVUPoccGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7yLNZMWbquxS4MjF0WbIqKf5pzrqJoQY9Yk+ZqICODlnHcghFNvRQhCRjriFiDTo
         RwOD0xcvLC/AypBSdfIGPkDQXE16GqrFHXKIW0FiOOGpYwXvhpgG4zSWghdH3SIQjb
         zxEDjjH28w9AsWcxeoyCC04M/ILty/x2PJvNmkEo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 39/48] PCI/MSI: Warn and return error if driver enables MSI/MSI-X twice
Date:   Wed, 31 Oct 2018 19:10:45 -0400
Message-Id: <20181031231054.29333-39-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

[ Upstream commit 4c1ef72e9b71a19fb405ebfcd37c0a5e16fa44ca ]

It is a serious driver defect to enable MSI or MSI-X more than once.  Doing
so may panic the kernel as in the stack trace below:

  Call Trace:
    sysfs_add_one+0xa5/0xd0
    create_dir+0x7c/0xe0
    sysfs_create_subdir+0x1c/0x20
    internal_create_group+0x6d/0x290
    sysfs_create_groups+0x4a/0xa0
    populate_msi_sysfs+0x1cd/0x210
    pci_enable_msix+0x31c/0x3e0
    igbuio_pci_open+0x72/0x300 [igb_uio]
    uio_open+0xcc/0x120 [uio]
    chrdev_open+0xa1/0x1e0
    [...]
    do_sys_open+0xf3/0x1f0
    SyS_open+0x1e/0x20
    system_call_fastpath+0x16/0x1b
    ---[ end trace 11042e2848880209 ]---
    Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ffffffffa056b4fa

We want to keep the WARN_ON() and stack trace so the driver can be fixed,
but we can avoid the kernel panic by returning an error.  We may still get
warnings like this:

  Call Trace:
    pci_enable_msix+0x3c9/0x3e0
    igbuio_pci_open+0x72/0x300 [igb_uio]
    uio_open+0xcc/0x120 [uio]
    chrdev_open+0xa1/0x1e0
    [...]
    do_sys_open+0xf3/0x1f0
    SyS_open+0x1e/0x20
    system_call_fastpath+0x16/0x1b
    ------------[ cut here ]------------
    WARNING: at fs/sysfs/dir.c:526 sysfs_add_one+0xa5/0xd0()
    sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:03.0/0000:01:00.1/msi_irqs'

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
[bhelgaas: changelog, fix patch whitespace, remove !!]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/msi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0e9a9dbeb184..37f393f27efc 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -981,7 +981,6 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 			}
 		}
 	}
-	WARN_ON(!!dev->msix_enabled);
 
 	/* Check whether driver already requested for MSI irq */
 	if (dev->msi_enabled) {
@@ -1068,8 +1067,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (!pci_msi_supported(dev, minvec))
 		return -EINVAL;
 
-	WARN_ON(!!dev->msi_enabled);
-
 	/* Check whether driver already requested MSI-X irqs */
 	if (dev->msix_enabled) {
 		dev_info(&dev->dev,
@@ -1080,6 +1077,9 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	if (WARN_ON_ONCE(dev->msi_enabled))
+		return -EINVAL;
+
 	nvec = pci_msi_vec_count(dev);
 	if (nvec < 0)
 		return nvec;
@@ -1138,6 +1138,9 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	if (WARN_ON_ONCE(dev->msix_enabled))
+		return -EINVAL;
+
 	for (;;) {
 		if (affinity) {
 			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
-- 
2.17.1

