Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51117C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087692083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087692083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbeHAUPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:15:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404274AbeHATDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F849FCA;
        Wed,  1 Aug 2018 16:58:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 111/336] PCI: Prevent sysfs disable of device while driver is attached
Date:   Wed,  1 Aug 2018 18:47:26 +0200
Message-Id: <20180801165033.403130732@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 6f5cdfa802733dcb561bf664cc89d203f2fd958f ]

Manipulating the enable_cnt behind the back of the driver will wreak
complete havoc with the kernel state, so disallow it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Acked-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-sysfs.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -288,13 +288,16 @@ static ssize_t enable_store(struct devic
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!val) {
-		if (pci_is_enabled(pdev))
-			pci_disable_device(pdev);
-		else
-			result = -EIO;
-	} else
+	device_lock(dev);
+	if (dev->driver)
+		result = -EBUSY;
+	else if (val)
 		result = pci_enable_device(pdev);
+	else if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
+	else
+		result = -EIO;
+	device_unlock(dev);
 
 	return result < 0 ? result : count;
 }


