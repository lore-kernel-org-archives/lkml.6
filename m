Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769C3C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479E820878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479E820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeJBQJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:09:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50406 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeJBQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:09:12 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g7Gx6-0002zZ-BU; Tue, 02 Oct 2018 10:26:48 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1g7Gx6-0000Ja-3D; Tue, 02 Oct 2018 10:26:48 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/4] usbnet: smsc95xx: add kconfig for turbo mode
Date:   Tue,  2 Oct 2018 10:26:42 +0100
Message-Id: <20181002092645.1115-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
References: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a configuration option for the default state of turbo mode
on the smsc95xx networking driver. Some systems it is better
to default this to off as it causes significant increases in
soft-irq load.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/Kconfig    | 9 +++++++++
 drivers/net/usb/smsc95xx.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 418b0904cecb..a32f1a446ce9 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -351,6 +351,15 @@ config USB_NET_SMSC95XX
 	  This option adds support for SMSC LAN95XX based USB 2.0
 	  10/100 Ethernet adapters.
 
+config USB_NET_SMSC95XX_TURBO
+	bool "Use turbo receive mode by default"
+	depends on USB_NET_SMSC95XX
+	default y
+	help
+	  This options sets the default turbo mode settings for the
+	  driver's receive path. These can also be altered by the
+	  turbo_mode module parameter.
+
 config USB_NET_GL620A
 	tristate "GeneSys GL620USB-A based cables"
 	depends on USB_USBNET
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 06b4d290784d..fe13bef9579e 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -78,7 +78,7 @@ struct smsc95xx_priv {
 	struct usbnet *dev;
 };
 
-static bool turbo_mode = true;
+static bool turbo_mode = IS_ENABLED(CONFIG_USB_NET_SMSC95XX_TURBO);
 module_param(turbo_mode, bool, 0644);
 MODULE_PARM_DESC(turbo_mode, "Enable multiple frames per Rx transaction");
 
-- 
2.19.0

