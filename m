Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA21ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD72220850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIh8FsfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD72220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbeGRUYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbeGRUYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:24:08 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9D12084E;
        Wed, 18 Jul 2018 19:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531943086;
        bh=YUo7/kHOGtfB3qn/rWY+Y/8GchpMynmdIqbaHOGlDmg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OIh8FsfJapVBZV5XTcXKYX+Ty5sG/r+FwvhdJIyRPohXGdFVHVf04ygxIM/sxbZeB
         Ea8Wyl0I3u4GrTBD50lkWf2zg46w6qmHb92FXo0j/9R1wg8nIMFGS0OlVUy6XQphcw
         s7X4oiF3FcNAXYy+cPcGPsLbyIhTEN5SubOEJC1M=
Subject: [PATCH v3 4/7] PCI/AER: Remove ERR_FATAL code from ERR_NONFATAL path
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Oza Pawandeep <poza@codeaurora.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 18 Jul 2018 14:44:44 -0500
Message-ID: <153194308474.191586.9278078670184747650.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oza Pawandeep <poza@codeaurora.org>

broadcast_error_message() is only used for ERR_NONFATAL events, when the
state is always pci_channel_io_normal, so remove the unused alternate path.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/err.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 0539518f9861..638eda5c1d79 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -259,15 +259,10 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		/*
 		 * If the error is reported by an end point, we think this
 		 * error is related to the upstream link of the end point.
+		 * The error is non fatal so the bus is ok; just invoke
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

