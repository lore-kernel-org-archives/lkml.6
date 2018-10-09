Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBA8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C652086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C652086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeJIML7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:11:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:36606 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbeJIML6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:11:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 21:56:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,359,1534834800"; 
   d="scan'208";a="93473618"
Received: from wwanmoha-ilbpg1.png.intel.com ([10.88.227.84])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2018 21:53:10 -0700
From:   wan.ahmad.zainie.wan.mohamad@intel.com
To:     hdegoede@redhat.com, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH] usb: roles: intel_xhci: Fix Unbalanced pm_runtime_enable
Date:   Tue,  9 Oct 2018 12:52:47 +0800
Message-Id: <1539060767-12858-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

Add missing pm_runtime_disable() to remove(), in order to avoid
an Unbalanced pm_runtime_enable when the module is removed and
re-probed.

Error log:
root@intel-corei7-64:~# modprobe -r intel_xhci_usb_role_switch
root@intel-corei7-64:~# modprobe intel_xhci_usb_role_switch
intel_xhci_usb_sw intel_xhci_usb_sw: Unbalanced pm_runtime_enable!

Fixes: cb2968468605 (usb: roles: intel_xhci: Enable runtime PM)
Cc: <stable@vger.kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 drivers/usb/roles/intel-xhci-usb-role-switch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 1fb3dd0f1dfa..277de96181f9 100644
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -161,6 +161,8 @@ static int intel_xhci_usb_remove(struct platform_device *pdev)
 {
 	struct intel_xhci_usb_data *data = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	usb_role_switch_unregister(data->role_sw);
 	return 0;
 }
-- 
1.9.1

