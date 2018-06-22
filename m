Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9327C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3F123FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3F123FCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeFVJ6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:58:24 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:37788 "EHLO
        wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeFVJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:58:20 -0400
X-IronPort-AV: E=Sophos;i="5.51,256,1526367600"; 
   d="scan'208";a="346278387"
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by wolverine01.qualcomm.com with ESMTP; 22 Jun 2018 02:58:19 -0700
X-IronPort-AV: E=McAfee;i="5900,7806,8931"; a="186149719"
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg03-sd.qualcomm.com with ESMTP; 22 Jun 2018 02:58:18 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id 3FE391F32; Fri, 22 Jun 2018 05:58:18 -0400 (EDT)
From:   Oza Pawandeep <poza@codeaurora.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc:     Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v2 3/6] PCI/ERR: Cleanup ERR_FATAL of error broadcast
Date:   Fri, 22 Jun 2018 05:58:11 -0400
Message-Id: <1529661494-20936-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERR_FATAL is handled by resetting the Link in software, skipping the
driver pci_error_handlers callbacks, removing the devices from the PCI
subsystem, and re-enumerating, so now no more ERR_FATAL handling is
required inside pci_broadcast_error_message()

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 00d2875..404bb69 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -259,15 +259,10 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		/*
 		 * If the error is reported by an end point, we think this
 		 * error is related to the upstream link of the end point.
+		 * the error is non fatal so the bus is ok, just invoke
+		 * the callback for the function that logged the error.
 		 */
-		if (state == pci_channel_io_normal)
-			/*
-			 * the error is non fatal so the bus is ok, just invoke
-			 * the callback for the function that logged the error.
-			 */
-			cb(dev, &result_data);
-		else
-			pci_walk_bus(dev->bus, cb, &result_data);
+		cb(dev, &result_data);
 	}
 
 	return result_data.result;
-- 
2.7.4

