Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50006ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214B6204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214B6204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeJVBYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 21:24:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58567 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJVBX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 21:23:59 -0400
Received: from [111.196.56.27] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1gEHDn-0005bZ-4L; Sun, 21 Oct 2018 17:08:59 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     aaron.ma@canonical.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: xhci: fix timeout for transition from RExit to U0
Date:   Mon, 22 Oct 2018 01:08:45 +0800
Message-Id: <1540141725-13047-2-git-send-email-aaron.ma@canonical.com>
X-Mailer: git-send-email 1.8.5.5
In-Reply-To: <1540141725-13047-1-git-send-email-aaron.ma@canonical.com>
References: <1540141725-13047-1-git-send-email-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This definition is used by msecs_to_jiffies in milliseconds.
According to the comments, max rexit timeout should be 20ms.
Align with the comments to properly calculate the delay.

Verified on Sunrise Point-LP and Cannon Lake.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/usb/host/xhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6230a578324c..30225c53be1c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1678,7 +1678,7 @@ struct xhci_bus_state {
  * It can take up to 20 ms to transition from RExit to U0 on the
  * Intel Lynx Point LP xHCI host.
  */
-#define	XHCI_MAX_REXIT_TIMEOUT	(20 * 1000)
+#define	XHCI_MAX_REXIT_TIMEOUT	20
 
 static inline unsigned int hcd_index(struct usb_hcd *hcd)
 {
-- 
2.19.1

