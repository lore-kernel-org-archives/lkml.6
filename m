Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BD6C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CA425739
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CA425739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031027AbeGARol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:44:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030938AbeGAQeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:34:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4EF2CACC;
        Sun,  1 Jul 2018 16:34:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.14 079/157] PCI: Add ACS quirk for Intel 7th & 8th Gen mobile
Date:   Sun,  1 Jul 2018 18:22:31 +0200
Message-Id: <20180701160856.540746939@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Williamson <alex.williamson@redhat.com>

commit e8440f4bfedc623bee40c84797ac78d9303d0db6 upstream.

The specification update indicates these have the same errata for
implementing non-standard ACS capabilities.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4377,11 +4377,24 @@ static int pci_quirk_qcom_rp_acs(struct
  * 0xa290-0xa29f PCI Express Root port #{0-16}
  * 0xa2e7-0xa2ee PCI Express Root port #{17-24}
  *
+ * Mobile chipsets are also affected, 7th & 8th Generation
+ * Specification update confirms ACS errata 22, status no fix: (7th Generation
+ * Intel Processor Family I/O for U/Y Platforms and 8th Generation Intel
+ * Processor Family I/O for U Quad Core Platforms Specification Update,
+ * August 2017, Revision 002, Document#: 334660-002)[6]
+ * Device IDs from I/O datasheet: (7th Generation Intel Processor Family I/O
+ * for U/Y Platforms and 8th Generation Intel ® Processor Family I/O for U
+ * Quad Core Platforms, Vol 1 of 2, August 2017, Document#: 334658-003)[7]
+ *
+ * 0x9d10-0x9d1b PCI Express Root port #{1-12}
+ *
  * [1] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
  * [2] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
  * [3] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
  * [4] http://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-spec-update.html
  * [5] http://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-datasheet-vol-1.html
+ * [6] https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-u-y-processor-lines-i-o-spec-update.html
+ * [7] https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-u-y-processor-lines-i-o-datasheet-vol-1.html
  */
 static bool pci_quirk_intel_spt_pch_acs_match(struct pci_dev *dev)
 {
@@ -4391,6 +4404,7 @@ static bool pci_quirk_intel_spt_pch_acs_
 	switch (dev->device) {
 	case 0xa110 ... 0xa11f: case 0xa167 ... 0xa16a: /* Sunrise Point */
 	case 0xa290 ... 0xa29f: case 0xa2e7 ... 0xa2ee: /* Union Point */
+	case 0x9d10 ... 0x9d1b: /* 7th & 8th Gen Mobile */
 		return true;
 	}
 


