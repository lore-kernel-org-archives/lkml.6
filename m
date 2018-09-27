Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01467C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84A921533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84A921533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeI0PsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:48:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57026 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeI0PsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:48:18 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1380B1133;
        Thu, 27 Sep 2018 09:30:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.9 16/44] Revert "PCI: Add ACS quirk for Intel 300 series"
Date:   Thu, 27 Sep 2018 11:04:05 +0200
Message-Id: <20180927090120.128021337@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090117.997362691@linuxfoundation.org>
References: <20180927090117.997362691@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 50ca031b51106b1b46162d4e9ecccb7edc95682f upstream.

This reverts f154a718e6cc ("PCI: Add ACS quirk for Intel 300 series").

It turns out that erratum "PCH PCIe* Controller Root Port (ACSCTLR) Appear
As Read Only" has been fixed in 300 series chipsets, even though the
datasheet [1] claims otherwise.  To make ACS work properly on 300 series
root ports, revert the faulty commit.

[1] https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/300-series-c240-series-chipset-pch-spec-update.pdf

Fixes: f154a718e6cc ("PCI: Add ACS quirk for Intel 300 series")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org	# v4.18+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4236,11 +4236,6 @@ static int pci_quirk_qcom_rp_acs(struct
  *
  * 0x9d10-0x9d1b PCI Express Root port #{1-12}
  *
- * The 300 series chipset suffers from the same bug so include those root
- * ports here as well.
- *
- * 0xa32c-0xa343 PCI Express Root port #{0-24}
- *
  * [1] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
  * [2] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
  * [3] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
@@ -4258,7 +4253,6 @@ static bool pci_quirk_intel_spt_pch_acs_
 	case 0xa110 ... 0xa11f: case 0xa167 ... 0xa16a: /* Sunrise Point */
 	case 0xa290 ... 0xa29f: case 0xa2e7 ... 0xa2ee: /* Union Point */
 	case 0x9d10 ... 0x9d1b: /* 7th & 8th Gen Mobile */
-	case 0xa32c ... 0xa343:				/* 300 series */
 		return true;
 	}
 


