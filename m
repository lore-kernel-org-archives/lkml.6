Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04192C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67D020843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67D020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeIDDIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 23:08:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:28872 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeIDDIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 23:08:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 15:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,326,1531810800"; 
   d="scan'208";a="67268784"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga007.fm.intel.com with ESMTP; 03 Sep 2018 15:45:46 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        stable@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [stable v4.4.y 1/2] mei: me: allow runtime pm for platform with D0i3
Date:   Tue,  4 Sep 2018 01:43:03 +0300
Message-Id: <20180903224304.15989-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit cc365dcf0e56271bedf3de95f88922abe248e951 upstream.

>From the pci power documentation:
"The driver itself should not call pm_runtime_allow(), though. Instead,
it should let user space or some platform-specific code do that (user space
can do it via sysfs as stated above)..."

However, the S0ix residency cannot be reached without MEI device getting
into low power state. Hence, for mei devices that support D0i3, it's better
to make runtime power management mandatory and not rely on the system
integration such as udev rules.
This policy cannot be applied globally as some older platforms
were found to have broken power management.

Cc: <stable@vger.kernel.org> # 4.4
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/pci-me.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index adab5bbb642a..d5b84d68f988 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -230,8 +230,11 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!pci_dev_run_wake(pdev))
 		mei_me_set_pm_domain(dev);
 
-	if (mei_pg_is_enabled(dev))
+	if (mei_pg_is_enabled(dev)) {
 		pm_runtime_put_noidle(&pdev->dev);
+		if (hw->d0i3_supported)
+			pm_runtime_allow(&pdev->dev);
+	}
 
 	dev_dbg(&pdev->dev, "initialization successful.\n");
 
-- 
2.14.4

