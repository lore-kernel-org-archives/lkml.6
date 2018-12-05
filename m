Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074BCC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9DA20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0kfYbWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9DA20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeLEJkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeLEJkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:40:09 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4152084C;
        Wed,  5 Dec 2018 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002808;
        bh=LeTFRI4vJ2y7oEI14y9B9N6ZpfoZ29or4D0xxeMJf9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0kfYbWAGBvxvy8CzJGX8uUXQlP1kduQs25t41AWtZnDaWD057gd9oqR7mobTFBQj
         zbkXZI9KYjR4TShYQGzLvQib1rDlMJbATvJpwSjnzmEwvK/BbLnQL1FKXqkPHUdefH
         Bd7O41WNo3+rg2nnrRBm8CgO9Fqea1Zi9ZggRU3E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 073/123] thunderbolt: Prevent root port runtime suspend during NVM upgrade
Date:   Wed,  5 Dec 2018 04:35:05 -0500
Message-Id: <20181205093555.5386-73-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 1830b6eeda1fed42d85f2388f79c926331a9b2d0 ]

During NVM upgrade process the host router is hot-removed for a short
while. During this time it is possible that the root port is moved into
D3cold which would be fine if the root port could trigger PME on itself.
However, many systems actually do not implement it so what happens is
that the root port goes into D3cold and never wakes up unless userspace
does PCI config space access, such as running 'lscpi'.

For this reason we explicitly prevent the root port from runtime
suspending during NVM upgrade.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/switch.c | 40 ++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 7442bc4c6433..dd9ae6f5d19c 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -864,6 +864,30 @@ static ssize_t key_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR(key, 0600, key_show, key_store);
 
+static void nvm_authenticate_start(struct tb_switch *sw)
+{
+	struct pci_dev *root_port;
+
+	/*
+	 * During host router NVM upgrade we should not allow root port to
+	 * go into D3cold because some root ports cannot trigger PME
+	 * itself. To be on the safe side keep the root port in D0 during
+	 * the whole upgrade process.
+	 */
+	root_port = pci_find_pcie_root_port(sw->tb->nhi->pdev);
+	if (root_port)
+		pm_runtime_get_noresume(&root_port->dev);
+}
+
+static void nvm_authenticate_complete(struct tb_switch *sw)
+{
+	struct pci_dev *root_port;
+
+	root_port = pci_find_pcie_root_port(sw->tb->nhi->pdev);
+	if (root_port)
+		pm_runtime_put(&root_port->dev);
+}
+
 static ssize_t nvm_authenticate_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
@@ -913,10 +937,18 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 
 		sw->nvm->authenticating = true;
 
-		if (!tb_route(sw))
+		if (!tb_route(sw)) {
+			/*
+			 * Keep root port from suspending as long as the
+			 * NVM upgrade process is running.
+			 */
+			nvm_authenticate_start(sw);
 			ret = nvm_authenticate_host(sw);
-		else
+			if (ret)
+				nvm_authenticate_complete(sw);
+		} else {
 			ret = nvm_authenticate_device(sw);
+		}
 		pm_runtime_mark_last_busy(&sw->dev);
 		pm_runtime_put_autosuspend(&sw->dev);
 	}
@@ -1336,6 +1368,10 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
 	if (ret <= 0)
 		return ret;
 
+	/* Now we can allow root port to suspend again */
+	if (!tb_route(sw))
+		nvm_authenticate_complete(sw);
+
 	if (status) {
 		tb_sw_info(sw, "switch flash authentication failed\n");
 		tb_switch_set_uuid(sw);
-- 
2.17.1

