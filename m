Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641336-2-15029845621257273642
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
    t=1520641336; b=Z6448RcfZJ0YSLB68HT0iEt4wulKOlLWxUbMqMpXn9JNDBc
    n6yNVOalIe/cEMuoiDP71ZKZLUH9/InfW5o73SmZgvBMPf0g0Zea7AY+y+Xa/zUL
    ZOm1ybdlqHTh2MMA7/1TLpF4Figm6Ia0X6HWZ5/+ss4WhHIrzqSo3FSjbu2Vv8Ks
    SDbKCmRea0w9aqIv5mwVKHL95tjPuC/LqL8YgwkGdI3QGeUegt9n6bmw2jvk9Fks
    ZuTwO7e/+E98+0kx6/RR6f2HHMMmlShqHVJyZzdhFvuv2DH+qAJTu67DniyjmJg8
    UanyDcPWiua/ABeEKzQOgxiWjCjyFlnCEeWP8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641336; bh=cO3wMsrQzYabcGoct5HPdQUB6a
    DasaCGsYYVsECeYD0=; b=LE/v+cwDGIYwfRinFO/zXVou6fcLIYYKu7yb4M/aob
    opyq8drDwLLZEw7Au1xMXVfBxLtQzw0M3nqYLWe/TS+EMev27nRIVxq8JVV9shJc
    aFQmO88bsd4NeLaDyscaPwQ2e4svGECo4fAhZ6rc8ZZE0A0x8j65ip68njTX972K
    9ybXgX9t5QV9L138ADih+WP39daoAgHiN/UTsqIb/arMfHqEQqAh9qdjlF1V+6IB
    1hz/xiuG7JAHtpsDt2/X+urOXuI6ni0t/vBS0E+1QrP6NehDW5wQXAgoZVQINray
    8SFtG3sktk95esp7w9cNMqo9GLax4ZUVPJQjOU3Sccfg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933832AbeCJAWK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:22:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39874 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933511AbeCJAWH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:22:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.9 24/65] PCI/ASPM: Deal with missing root ports in link state handling
Date: Fri,  9 Mar 2018 16:18:24 -0800
Message-Id: <20180310001826.826066317@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit ee8bdfb6568d86bb93f55f8d99c4c643e77304ee upstream.

Even though it is unconventional, some PCIe host implementations omit the
root ports entirely, and simply consist of a host bridge (which is not
modeled as a device in the PCI hierarchy) and a link.

When the downstream device is an endpoint, our current code does not seem
to mind this unusual configuration. However, when PCIe switches are
involved, the ASPM code assumes that any downstream switch port has a
parent, and blindly dereferences the bus->parent->self field of the pci_dev
struct to chain the downstream link state to the link state of the root
port. Given that the root port is missing, the link is not modeled at all,
and nor is the link state, and attempting to access it results in a NULL
pointer dereference and a crash.

Avoid this by allowing the link state chain to terminate at the downstream
port if no root port exists.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pcie/aspm.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -526,10 +526,14 @@ static struct pcie_link_state *alloc_pci
 
 	/*
 	 * Root Ports and PCI/PCI-X to PCIe Bridges are roots of PCIe
-	 * hierarchies.
+	 * hierarchies.  Note that some PCIe host implementations omit
+	 * the root ports entirely, in which case a downstream port on
+	 * a switch may become the root of the link state chain for all
+	 * its subordinate endpoints.
 	 */
 	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
-	    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE) {
+	    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE ||
+	    !pdev->bus->parent->self) {
 		link->root = link;
 	} else {
 		struct pcie_link_state *parent;
