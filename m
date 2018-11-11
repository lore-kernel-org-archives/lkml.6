Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B46C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700F020818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzZDherA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700F020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389362AbeKLIwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:52:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390632AbeKLIW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:29 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E79FF223C8;
        Sun, 11 Nov 2018 22:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975552;
        bh=TdUL3f4ZnQXiBnUF/vYXUnasufPZnLV+dDvdw1oYLAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzZDherAdBl55PlEcG8KMcnlGxVLEu7TG36QiMZmdrt09Hnhz7WNCtahdWME+uzcg
         gjnRI1jg3sYlQlsMevcGKMlMhDIb9VJCGenXSLKzVqNkgFUHtx0gb5TsCVZMh925xT
         7EcNqo2l7fSnG12vndEqyrGWlC53119mxE2Q3fb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 094/222] PCI/MSI: Warn and return error if driver enables MSI/MSI-X twice
Date:   Sun, 11 Nov 2018 14:23:11 -0800
Message-Id: <20181111221656.357476112@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/msi.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -958,7 +958,6 @@ static int __pci_enable_msix(struct pci_
 			}
 		}
 	}
-	WARN_ON(!!dev->msix_enabled);
 
 	/* Check whether driver already requested for MSI irq */
 	if (dev->msi_enabled) {
@@ -1028,8 +1027,6 @@ static int __pci_enable_msi_range(struct
 	if (!pci_msi_supported(dev, minvec))
 		return -EINVAL;
 
-	WARN_ON(!!dev->msi_enabled);
-
 	/* Check whether driver already requested MSI-X irqs */
 	if (dev->msix_enabled) {
 		dev_info(&dev->dev,
@@ -1040,6 +1037,9 @@ static int __pci_enable_msi_range(struct
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	if (WARN_ON_ONCE(dev->msi_enabled))
+		return -EINVAL;
+
 	nvec = pci_msi_vec_count(dev);
 	if (nvec < 0)
 		return nvec;
@@ -1088,6 +1088,9 @@ static int __pci_enable_msix_range(struc
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	if (WARN_ON_ONCE(dev->msix_enabled))
+		return -EINVAL;
+
 	for (;;) {
 		if (affd) {
 			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);


