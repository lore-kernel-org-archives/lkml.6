Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617D7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A082148C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A082148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeJLQFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:05:50 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48206 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbeJLQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:05:33 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAstc-0005TY-LB; Fri, 12 Oct 2018 09:34:08 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAstc-00052Y-4N; Fri, 12 Oct 2018 09:34:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/8] usbnet: smsc95xx: add kconfig for turbo mode
Date:   Fri, 12 Oct 2018 09:33:59 +0100
Message-Id: <20181012083405.19246-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012083405.19246-1-ben.dooks@codethink.co.uk>
References: <20181012083405.19246-1-ben.dooks@codethink.co.uk>
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
 drivers/net/usb/Kconfig    | 13 +++++++++++++
 drivers/net/usb/smsc95xx.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 418b0904cecb..c3ebc43a6582 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -351,6 +351,19 @@ config USB_NET_SMSC95XX
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
+	  There are some systems where the turbo mode causes higher
+	  soft-irq load, thus making it useful to default the option
+	  off for these.
+
 config USB_NET_GL620A
 	tristate "GeneSys GL620USB-A based cables"
 	depends on USB_USBNET
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 401ec9feb495..cb19aea139d3 100644
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
2.19.1

