Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28007C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7BE20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571641;
	bh=p3+vdAdl7wApy6BDvWsZHJGWmLHsAQTzJNSJFWy/ysE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=itL3PE2HQaYgHxcNDpz5PprZ7m9itaGCDTmZGUbvu1pFeYRYW3y+aWo+wESQydDOs
	 aPmklzHOQp4lgFBcO4r5kttRhb+N++Yny2MP4BsngmNEk6Cspt06tcfd3+LYGjmJrS
	 f4Fvh9U+lhy5c6GDmDCla+4UW3ELd7zSLlvG//W0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbfAORAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:00:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732088AbfAOQiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1538F20873;
        Tue, 15 Jan 2019 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570304;
        bh=p3+vdAdl7wApy6BDvWsZHJGWmLHsAQTzJNSJFWy/ysE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xa7xSRA0utzxLmFJEH7yVbybeqZ0kMmzi3dJnA8O0VfWwQZObjULezfrZchgvZ1u2
         4V9KOBi6RPJObfsBMGvs3nYy1wkxJcZnsAP5mp05efgpigeGvFfWPTq8GUQObr4pxU
         o38BCtpXU24iT+MdLgKzb+qBxD1XntVMhG3OaRIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Claudius Heine <claudius.heine.ext@siemens.com>
Subject: [PATCH 4.4 43/51] PCI: altera: Poll for link up status after retraining the link
Date:   Tue, 15 Jan 2019 17:35:39 +0100
Message-Id: <20190115154853.398742826@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ley Foon Tan <lftan@altera.com>

commit 3a928e98a833e1a470a60d2fedf3c55502185fb7 upstream.

Some PCIe devices take a long time to reach link up state after retrain.
Poll for link up status after retraining the link.  This is to make sure
the link is up before we access configuration space.

[bhelgaas: changelog]
Signed-off-by: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Claudius Heine <claudius.heine.ext@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pcie-altera.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -61,6 +61,8 @@
 #define TLP_LOOP			500
 #define RP_DEVFN			0
 
+#define LINK_UP_TIMEOUT			5000
+
 #define INTX_NUM			4
 
 #define DWORD_MASK			3
@@ -101,6 +103,7 @@ static void altera_pcie_retrain(struct p
 {
 	u16 linkcap, linkstat;
 	struct altera_pcie *pcie = dev->bus->sysdata;
+	int timeout =  0;
 
 	if (!altera_pcie_link_is_up(pcie))
 		return;
@@ -115,9 +118,16 @@ static void altera_pcie_retrain(struct p
 		return;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
-	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB)
+	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
 		pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
 					 PCI_EXP_LNKCTL_RL);
+		while (!altera_pcie_link_is_up(pcie)) {
+			timeout++;
+			if (timeout > LINK_UP_TIMEOUT)
+				break;
+			udelay(5);
+		}
+	}
 }
 DECLARE_PCI_FIXUP_EARLY(0x1172, PCI_ANY_ID, altera_pcie_retrain);
 


