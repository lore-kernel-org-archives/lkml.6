Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A182C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0120F2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT2bQWSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0120F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389469AbeKLJN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389187AbeKLIU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:56 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64765216FD;
        Sun, 11 Nov 2018 22:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975459;
        bh=9h7M42/pgQdq6K4FIgrkuatacWY7fz5/4/HfVmn4DIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HT2bQWSIJfFwl7jUO1YRylEigR0WAuGSZD4MCLkIk52I9H3St3iEaZOgC8zJ8oIBE
         6yutjRO9nCNIV6akVqDSQdZQ8mI9axtSHU6N7dP9vNgRckd+VKfmkJdtn7s9j0YheH
         u+ocXIM1JrA0QAWPenX7w5WNeF1fxXnu23ezodi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Jon Derrick:" <jonathan.derrick@intel.com>,
        "Heitke, Kenneth" <kenneth.heitke@intel.com>
Subject: [PATCH 4.18 234/350] PCI: vmd: White list for fast interrupt handlers
Date:   Sun, 11 Nov 2018 14:21:38 -0800
Message-Id: <20181111221717.824435165@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit a7f58b9ecfd3c0f63703ec10f4a592cc38dbd1b8 upstream.

Devices with slow interrupt handlers are significantly harming
performance when their interrupt vector is shared with a fast device.

Create a class code white list for devices with known fast interrupt
handlers and let all other devices share a single vector so that they
don't interfere with performance.

At the moment, only the NVM Express class code is on the list, but more
may be added if VMD users desire to use other low-latency devices in
these domains.

Signed-off-by: Keith Busch <keith.busch@intel.com>
[lorenzo.pieralisi@arm.com: changelog]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Jon Derrick: <jonathan.derrick@intel.com>
Cc: "Heitke, Kenneth" <kenneth.heitke@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/vmd.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -197,9 +197,20 @@ static struct vmd_irq_list *vmd_next_irq
 	int i, best = 1;
 	unsigned long flags;
 
-	if (pci_is_bridge(msi_desc_to_pci_dev(desc)) || vmd->msix_count == 1)
+	if (vmd->msix_count == 1)
 		return &vmd->irqs[0];
 
+	/*
+	 * White list for fast-interrupt handlers. All others will share the
+	 * "slow" interrupt vector.
+	 */
+	switch (msi_desc_to_pci_dev(desc)->class) {
+	case PCI_CLASS_STORAGE_EXPRESS:
+		break;
+	default:
+		return &vmd->irqs[0];
+	}
+
 	raw_spin_lock_irqsave(&list_lock, flags);
 	for (i = 1; i < vmd->msix_count; i++)
 		if (vmd->irqs[i].count < vmd->irqs[best].count)


