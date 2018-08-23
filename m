Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A11C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA85208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA85208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbeHWMju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:39:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbeHWMjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:39:49 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 37BCA93C;
        Thu, 23 Aug 2018 09:11:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zachary Zhang <zhangzg@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.18 16/22] PCI: aardvark: Size bridges before resources allocation
Date:   Thu, 23 Aug 2018 09:56:42 +0200
Message-Id: <20180823074800.223437041@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074759.234685844@linuxfoundation.org>
References: <20180823074759.234685844@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/pci/controller/pci-aardvark.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -952,6 +952,7 @@ static int advk_pcie_probe(struct platfo
 
 	bus = bridge->bus;
 
+	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
 
 	list_for_each_entry(child, &bus->children, node)


