Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C274621533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C274621533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeI0Ptr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:49:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57138 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeI0Ptq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:49:46 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 863DC1132;
        Thu, 27 Sep 2018 09:32:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zachary Zhang <zhangzg@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.9 42/44] PCI: aardvark: Size bridges before resources allocation
Date:   Thu, 27 Sep 2018 11:04:31 +0200
Message-Id: <20180927090124.477768188@linuxfoundation.org>
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

From: Zachary Zhang <zhangzg@marvell.com>

commit 91a2968e245d6ba616db37001fa1a043078b1a65 upstream.

The PCIE I/O and MEM resource allocation mechanism is that root bus
goes through the following steps:

1. Check PCI bridges' range and computes I/O and Mem base/limits.

2. Sort all subordinate devices I/O and MEM resource requirements and
   allocate the resources and writes/updates subordinate devices'
   requirements to PCI bridges I/O and Mem MEM/limits registers.

Currently, PCI Aardvark driver only handles the second step and lacks
the first step, so there is an I/O and MEM resource allocation failure
when using a PCI switch. This commit fixes that by sizing bridges
before doing the resource allocation.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller
driver")
Signed-off-by: Zachary Zhang <zhangzg@marvell.com>
[Thomas: edit commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/pci/host/pci-aardvark.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -976,6 +976,7 @@ static int advk_pcie_probe(struct platfo
 		return -ENOMEM;
 	}
 
+	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
 
 	list_for_each_entry(child, &bus->children, node)


