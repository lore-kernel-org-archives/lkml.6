Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7266FC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2842148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789097;
	bh=NKIlcCtcJSna1lPcLdO86HJt13VRN3oMTVYTVR3sCaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=stLFR6s9zEKeUeHiG4lNXtshGDjTO1T2XTF/cKiM1i+MyOevoSAehyQvF7j40scsj
	 WOD1B/sdgYYB6Rm5u8yT77ynQIGZb6abZPy1qkTwq9UAxaFw+RQjr2c2blBoi+8B3Q
	 54gfFiOdmyWQCgwiRnCiWLZqySbHI+8T3OM3Rmb0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2842148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbeLNMEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:04:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730564AbeLNMEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02C221486;
        Fri, 14 Dec 2018 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789091;
        bh=NKIlcCtcJSna1lPcLdO86HJt13VRN3oMTVYTVR3sCaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpOJBv8fIi5WhbY0PfSOC2nh9j6G6d/cttxjk2/tzHjU3SlPDeveULuFYDX09DLTX
         n4HH63bvHmrjUzXOu2UyMN6yBgyr4SzSdT3CKY1jl8Ghsv3cMgrhMeYpJmTl84Sh2g
         jVQDoPjqBmeECn3+xI3ILw/jMUY8J2FkQ4XJyyWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 090/142] thunderbolt: Prevent root port runtime suspend during NVM upgrade
Date:   Fri, 14 Dec 2018 12:59:35 +0100
Message-Id: <20181214115750.652229713@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



