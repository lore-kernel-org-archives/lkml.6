Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805951-2-2919145758506731396
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805950; b=WBc+0b4eEfVDJKLNmXtyvUAyQCKhe6zznMEWNilYjxmb1IZ
    bb7zrBwYzBKXADOiTDBPKLX9MVf5CFst3fuHdNrkjLMZJRzp9VH4DX7E0G59c2wZ
    J/UewYyWFb/rakJtr8XoATO2S9k7M7cKkoB0jIPUqHiwFOmmKj6PyK3Ybe4CYvEQ
    8ambQGV5+HJi2Og+whejXAUFv6/n7i0wYHy5ia2aIAk3udh+IgYibGn3byO1r9HQ
    9B9Dm8H/DvniDo26ywa8qr4PKBAOWANuhztkTiZ4L32hnS3BnLdlntgfbc5j7/B5
    MoGpJprIDTABdG0X0cOUNDGqGzoRKHhq5miUvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805950; bh=AYJW8WWVBFOywXsPHFtBBS1pBV
    NElhHEWnJsr1mu80s=; b=PP6oZaRWXjAve8sMAeLRUhYrVwF5hBQf9cumF1xP0H
    ttSpHDHIYmOgumsRF2X3t+kTaQHiaME1doy5iaEvh8kjs4e3vW3eBD3TYDFjJq3n
    p9WJ1bZvJaGIooUKCAWb/7Z9jYOGXvTD+tH+kCN0BtBcLF0vtNRPbuAiUL3WVpJp
    JT5hH/lXkD6Bh61J9upnn1jIYc+CB++cn3VGaHR/pVNhE42QtJwq5kabKQ1hbYHq
    zZMH71YrfWc4xp7ELF3p4OiRgPpkQEmPMsuhF8yM/EpyBLHnt1gv52z3i4Qzb11F
    mJXPvyqQ/slT0RSV+nkcNOeLFpJLsam7oTGYdq1FM9sw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeCWLwL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:52:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38196 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753611AbeCWKCG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 45/77] PCI: designware-ep: Fix ->get_msi() to check MSI_EN bit
Date: Fri, 23 Mar 2018 10:54:19 +0100
Message-Id: <20180323094145.278923010@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kishon Vijay Abraham I <kishon@ti.com>


[ Upstream commit a134a457ed985dca8cce7ac4ea66129ea70eba73 ]

->get_msi() now checks MSI_EN bit in the MSI CAPABILITY register to
find whether the host supports MSI instead of using the
MSI ADDRESS in the MSI CAPABILITY register.

This fixes the issue with the following sequence
  'modprobe pci_endpoint_test' enables MSI
  'rmmod pci_endpoint_test' disables MSI but MSI address (in EP's
	capability register) has a valid value
  'modprobe pci_endpoint_test no_msi=1' - Since MSI address (in EP's
	capability register) has a valid value (set during the previous
	insertion of the module), EP thinks host supports MSI.

Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/dwc/pcie-designware-ep.c |   12 +++---------
 drivers/pci/dwc/pcie-designware.h    |    1 +
 2 files changed, 4 insertions(+), 9 deletions(-)

--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -197,20 +197,14 @@ static int dw_pcie_ep_map_addr(struct pc
 static int dw_pcie_ep_get_msi(struct pci_epc *epc)
 {
 	int val;
-	u32 lower_addr;
-	u32 upper_addr;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	val = dw_pcie_readb_dbi(pci, MSI_MESSAGE_CONTROL);
-	val = (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
-
-	lower_addr = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
-	upper_addr = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_U32);
-
-	if (!(lower_addr || upper_addr))
+	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
+	if (!(val & MSI_CAP_MSI_EN_MASK))
 		return -EINVAL;
 
+	val = (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
 	return val;
 }
 
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -101,6 +101,7 @@
 #define MSI_MESSAGE_CONTROL		0x52
 #define MSI_CAP_MMC_SHIFT		1
 #define MSI_CAP_MME_SHIFT		4
+#define MSI_CAP_MSI_EN_MASK		0x1
 #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
 #define MSI_MESSAGE_ADDR_L32		0x54
 #define MSI_MESSAGE_ADDR_U32		0x58
