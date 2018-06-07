Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bLGFAw7KGFupbgAAmS7hNA
	; Thu, 07 Jun 2018 06:00:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E4EB46089E; Thu,  7 Jun 2018 06:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528351245;
	bh=aA7bqeSOOUF3BUrIQqIpCUBg1hb8kHsbo9eT0bOM/aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f69rsoOGLW5a9P6Sk/956y3llr/0t1MrZA4hwagm209fi0VCx8Z0RgZtLfceTQvo7
	 KXm34oXxUmB45V6BF6gCkzIEKJaL5KqWqGDGRY/R+++dfkbM8pPabiHVun7jiOuGDV
	 gmuLv7czMl6UotbXXj/QRlBRGQIIgKxjq/WkKQvE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 61484602FC;
	Thu,  7 Jun 2018 06:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61484602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbeFGGAn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:00:43 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:20156 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751513AbeFGGAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:00:38 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="4326796"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jun 2018 23:00:38 -0700
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg02-sd.qualcomm.com with ESMTP; 06 Jun 2018 23:00:36 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id D61681F2C; Thu,  7 Jun 2018 02:00:35 -0400 (EDT)
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
Subject: [PATCH NEXT 3/6] PCI/ERR: Cleanup ERR_FATAL of error broadcast
Date: Thu,  7 Jun 2018 02:00:31 -0400
Message-Id: <1528351234-26914-3-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
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
index 00d2875..3998ed7 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -259,15 +259,10 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		/*
 		 * If the error is reported by an end point, we think this
 		 * error is related to the upstream link of the end point.
+		 * The error is non fatal so the bus is ok, just invoke
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
