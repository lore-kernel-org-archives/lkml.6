Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AEEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D265B2151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D265B2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbeHGVLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:11:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33714 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388913AbeHGVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:11:15 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7CE80D01;
        Tue,  7 Aug 2018 18:55:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH 4.9 09/17] ACPI / PCI: Bail early in acpi_pci_add_bus() if there is no ACPI handle
Date:   Tue,  7 Aug 2018 20:51:45 +0200
Message-Id: <20180807172342.641811274@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172342.071526922@linuxfoundation.org>
References: <20180807172342.071526922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit a0040c0145945d3bd203df8fa97f6dfa819f3f7d upstream.

Hyper-V instances support PCI pass-through which is implemented through PV
pci-hyperv driver. When a device is passed through, a new root PCI bus is
created in the guest. The bus sits on top of VMBus and has no associated
information in ACPI. acpi_pci_add_bus() in this case proceeds all the way
to acpi_evaluate_dsm(), which reports

  ACPI: \: failed to evaluate _DSM (0x1001)

While acpi_pci_slot_enumerate() and acpiphp_enumerate_slots() are protected
against ACPI_HANDLE() being NULL and do nothing, acpi_evaluate_dsm() is not
and gives us the error. It seems the correct fix is to not do anything in
acpi_pci_add_bus() in such cases.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci-acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -567,7 +567,7 @@ void acpi_pci_add_bus(struct pci_bus *bu
 	union acpi_object *obj;
 	struct pci_host_bridge *bridge;
 
-	if (acpi_pci_disabled || !bus->bridge)
+	if (acpi_pci_disabled || !bus->bridge || !ACPI_HANDLE(bus->bridge))
 		return;
 
 	acpi_pci_slot_enumerate(bus);


