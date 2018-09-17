Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65B7ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33002146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33002146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbeIREcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:32:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48514 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeIREcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:32:03 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5E879C49;
        Mon, 17 Sep 2018 23:02:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 057/126] ata: libahci: Allow reconfigure of DEVSLP register
Date:   Tue, 18 Sep 2018 00:41:45 +0200
Message-Id: <20180917211708.207983842@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 11c291461b6ea8d1195a96d6bba6673a94aacebc ]

There are two modes in which DEVSLP can be entered. The OS initiated or
hardware autonomous.

In hardware autonomous mode, BIOS configures the AHCI controller and the
device to enable DEVSLP. But they may not be ideal for all cases. So in
this case, OS should be able to reconfigure DEVSLP register.

Currently if the DEVSLP is already enabled, we can't set again as it will
simply return. There are some systems where the firmware is setting high
DITO by default, in this case we can't modify here to correct settings.
With the default in several seconds, we are not able to transition to
DEVSLP.

This change will allow reconfiguration of devslp register if DITO is
different.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libahci.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2096,7 +2096,7 @@ static void ahci_set_aggressive_devslp(s
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ata_device *dev = ap->link.device;
-	u32 devslp, dm, dito, mdat, deto;
+	u32 devslp, dm, dito, mdat, deto, dito_conf;
 	int rc;
 	unsigned int err_mask;
 
@@ -2120,8 +2120,15 @@ static void ahci_set_aggressive_devslp(s
 		return;
 	}
 
-	/* device sleep was already enabled */
-	if (devslp & PORT_DEVSLP_ADSE)
+	dm = (devslp & PORT_DEVSLP_DM_MASK) >> PORT_DEVSLP_DM_OFFSET;
+	dito = devslp_idle_timeout / (dm + 1);
+	if (dito > 0x3ff)
+		dito = 0x3ff;
+
+	dito_conf = (devslp >> PORT_DEVSLP_DITO_OFFSET) & 0x3FF;
+
+	/* device sleep was already enabled and same dito */
+	if ((devslp & PORT_DEVSLP_ADSE) && (dito_conf == dito))
 		return;
 
 	/* set DITO, MDAT, DETO and enable DevSlp, need to stop engine first */
@@ -2129,11 +2136,6 @@ static void ahci_set_aggressive_devslp(s
 	if (rc)
 		return;
 
-	dm = (devslp & PORT_DEVSLP_DM_MASK) >> PORT_DEVSLP_DM_OFFSET;
-	dito = devslp_idle_timeout / (dm + 1);
-	if (dito > 0x3ff)
-		dito = 0x3ff;
-
 	/* Use the nominal value 10 ms if the read MDAT is zero,
 	 * the nominal value of DETO is 20 ms.
 	 */


