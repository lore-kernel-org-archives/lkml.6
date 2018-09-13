Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2211BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB36B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB36B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeIMSns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:43:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeIMSns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:43:48 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 474DBCF3;
        Thu, 13 Sep 2018 13:34:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH 4.4 57/60] mei: me: allow runtime pm for platform with D0i3
Date:   Thu, 13 Sep 2018 15:31:04 +0200
Message-Id: <20180913131748.210662112@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

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

Cc: <stable@vger.kernel.org> v4.13+
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/pci-me.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -230,8 +230,11 @@ static int mei_me_probe(struct pci_dev *
 	if (!pci_dev_run_wake(pdev))
 		mei_me_set_pm_domain(dev);
 
-	if (mei_pg_is_enabled(dev))
+	if (mei_pg_is_enabled(dev)) {
 		pm_runtime_put_noidle(&pdev->dev);
+		if (hw->d0i3_supported)
+			pm_runtime_allow(&pdev->dev);
+	}
 
 	dev_dbg(&pdev->dev, "initialization successful.\n");
 


