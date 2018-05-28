Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165903AbeE1Ome (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161148AbeE1Kal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:30:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 100/329] irqchip/gic-v3: Ignore disabled ITS nodes
Date: Mon, 28 May 2018 12:00:29 +0200
Message-Id: <20180528100251.144536062@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <sboyd@codeaurora.org>

[ Upstream commit 95a2562590c2f64a0398183f978d5cf3db6d0284 ]

On some platforms there's an ITS available but it's not enabled
because reading or writing the registers is denied by the
firmware. In fact, reading or writing them will cause the system
to reset. We could remove the node from DT in such a case, but
it's better to skip nodes that are marked as "disabled" in DT so
that we can describe the hardware that exists and use the status
property to indicate how the firmware has configured things.

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c               |    2 ++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c          |    2 ++
 drivers/irqchip/irq-gic-v3-its.c                       |    2 ++
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |    2 ++
 4 files changed, 8 insertions(+)

--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -133,6 +133,8 @@ static int __init its_pci_of_msi_init(vo
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -80,6 +80,8 @@ static int __init its_pmsi_init(void)
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1807,6 +1807,8 @@ static int __init its_of_probe(struct de
 
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller")) {
 			pr_warn("%s: no msi-controller property, ITS ignored\n",
 				np->full_name);
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -75,6 +75,8 @@ int __init its_fsl_mc_msi_init(void)
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
