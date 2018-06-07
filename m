Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eLGFAw7KGFupbgAAmS7hNA
	; Thu, 07 Jun 2018 06:01:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A3A8B608BA; Thu,  7 Jun 2018 06:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528351306;
	bh=FtZo1Gzz3Q24lVGnhKL1+IDRwTbHVvfvkeywiyYcrks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K4XKLog8n7AcoZrPDoRNyLyt0bS6W+g+MdsNFOg+PjkZYFITuXvYJjTl9i39dOckV
	 FFW6ikT3PHCSNE8tLydeRKR/AXuxjVbrT4+2wGsjXX+UFrzzLxj/Z7PDg9ahOLNB9v
	 E0N8qCnrtbtuhr8f1YSZUFWIGTaYDT9OJ8f9SQbQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4026B602FC;
	Thu,  7 Jun 2018 06:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4026B602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeFGGBp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:01:45 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:20156 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751631AbeFGGAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:00:39 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="4326799"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jun 2018 23:00:38 -0700
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg02-sd.qualcomm.com with ESMTP; 06 Jun 2018 23:00:36 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id 03E9D1F31; Thu,  7 Jun 2018 02:00:35 -0400 (EDT)
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH NEXT 5/6] PCI/AER: Clear correctable status bits in device register
Date: Thu,  7 Jun 2018 02:00:33 -0400
Message-Id: <1528351234-26914-5-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of correctable error Device Status Register sets
Correctable Error Detected, which should be cleared after handling
the error

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 95e9828..0e4e99a 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -271,6 +271,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 		if (pos)
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
+		pci_cleanup_aer_error_device_status(dev);
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_nonfatal_recovery(dev);
 	else if (info->severity == AER_FATAL)
-- 
2.7.4
