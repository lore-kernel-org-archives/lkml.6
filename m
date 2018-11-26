Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82896C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1992086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1992086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeKZUlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:41:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:56312 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeKZUlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:41:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 01:47:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,281,1539673200"; 
   d="scan'208";a="111531984"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 26 Nov 2018 01:47:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 15D8586; Mon, 26 Nov 2018 11:47:47 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] thunderbolt: Prevent root port runtime suspend during NVM upgrade
Date:   Mon, 26 Nov 2018 12:47:46 +0300
Message-Id: <20181126094746.65030-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181126094746.65030-1-mika.westerberg@linux.intel.com>
References: <20181126094746.65030-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During NVM upgrade process the host router is hot-removed for a short
while. During this time it is possible that the root port is moved into
D3cold which would be fine if the root port could trigger PME on itself.
However, many systems actually do not implement it so what happens is
that the root port goes into D3cold and never wakes up unless userspace
does PCI config space access, such as running 'lscpi'.

For this reason we explicitly prevent the root port from runtime
suspending during NVM upgrade.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 40 ++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 52ff854f0d6c..cd96994dc094 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -863,6 +863,30 @@ static ssize_t key_store(struct device *dev, struct device_attribute *attr,
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
@@ -912,10 +936,18 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 
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
@@ -1334,6 +1366,10 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
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
2.19.1

