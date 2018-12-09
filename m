Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4CDC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B2320661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B2320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeLIWGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:06:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37054 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbeLIWGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:06:11 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73C-0002iZ-7v; Sun, 09 Dec 2018 21:55:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003Ot-Ni; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Sebastian Ott" <sebott@linux.ibm.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.185934825@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 143/328] s390/pci: fix out of bounds access during
 irq setup
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Ott <sebott@linux.ibm.com>

commit 866f3576a72b2233a76dffb80290f8086dc49e17 upstream.

During interrupt setup we allocate interrupt vectors, walk the list of msi
descriptors, and fill in the message data. Requesting more interrupts than
supported on s390 can lead to an out of bounds access.

When we restrict the number of interrupts we should also stop walking the
msi list after all supported interrupts are handled.

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -397,6 +397,8 @@ int arch_setup_msi_irqs(struct pci_dev *
 	hwirq = 0;
 	list_for_each_entry(msi, &pdev->msi_list, list) {
 		rc = -EIO;
+		if (hwirq >= msi_vecs)
+			break;
 		irq = irq_alloc_desc(0);	/* Alloc irq on node 0 */
 		if (irq < 0)
 			goto out_msi;

