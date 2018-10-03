Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDF4C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C18B20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C18B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJCQrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:47:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58482 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeJCQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:47:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g7dwj-0007zV-EW; Wed, 03 Oct 2018 09:59:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jon Flatley <jflat@chromium.org>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][usb-next] usb: core: fix memory leak on port_dev_path allocation
Date:   Wed,  3 Oct 2018 10:59:57 +0100
Message-Id: <20181003095957.3395-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the allocation of port_dev_path from the call to
kobject_get_path is not being kfree'd, causing a memory leak. Fix
this by kfree'ing this at the end of the function. Add an extra
error exit path to fix one of the early leaks when envp[0] fails
to be allocated.

Detected by CoverityScan, CID#1473771 ("Resource Leak")

Fixes: 201af55da8a3 ("usb: core: added uevent for over-current")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/core/hub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 7801bb30bdba..8ae781ce1a80 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5168,7 +5168,7 @@ static void port_over_current_notify(struct usb_port *port_dev)
 
 	envp[0] = kasprintf(GFP_KERNEL, "OVER_CURRENT_PORT=%s", port_dev_path);
 	if (!envp[0])
-		return;
+		goto exit_path;
 
 	envp[1] = kasprintf(GFP_KERNEL, "OVER_CURRENT_COUNT=%u",
 			port_dev->over_current_count);
@@ -5180,6 +5180,8 @@ static void port_over_current_notify(struct usb_port *port_dev)
 	kfree(envp[1]);
 exit:
 	kfree(envp[0]);
+exit_path:
+	kfree(port_dev_path);
 }
 
 static void port_event(struct usb_hub *hub, int port1)
-- 
2.17.1

