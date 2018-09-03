Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993D5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5994020868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5994020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeICVNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:13:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37838 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbeICVNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:13:22 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3ADB9CEE;
        Mon,  3 Sep 2018 16:52:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 3.18 51/56] s390/pci: fix out of bounds access during irq setup
Date:   Mon,  3 Sep 2018 18:49:41 +0200
Message-Id: <20180903164926.631274020@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Ott <sebott@linux.ibm.com>

commit 866f3576a72b2233a76dffb80290f8086dc49e17 upstream.

During interrupt setup we allocate interrupt vectors, walk the list of msi
descriptors, and fill in the message data. Requesting more interrupts than
supported on s390 can lead to an out of bounds access.

When we restrict the number of interrupts we should also stop walking the
msi list after all supported interrupts are handled.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/pci/pci.c |    2 ++
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


