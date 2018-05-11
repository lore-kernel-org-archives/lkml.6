Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeEKJTN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:19:13 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33495 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeEKJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:19:11 -0400
X-Google-Smtp-Source: AB8JxZpTbyC1wDS/1BHfDlYm1q63z6ofzfT3HJ3NamB0/+PApEq6KVYjfwFLApOTrbJHdU9p/2IgaA==
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>,
        Larry Finger <larry.finger@lwfinger.net>,
        Matt Redfearn <matt.redfearn@mips.com>
Cc: linux-wireless@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/2] Revert "ssb: Prevent build of PCI host features in module"
Date: Fri, 11 May 2018 11:17:14 +0200
Message-Id: <20180511091715.1989-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This reverts commit 882164a4a928bcaa53280940436ca476e6b1db8e.

Above commit added "SSB = y" dependency to the wrong symbol
SSB_DRIVER_PCICORE_POSSIBLE and prevented SSB_DRIVER_PCICORE from being
selected when needed. PCI core driver for core running in clienthost
mode is important for bus initialization. It's perfectly valid scenario
to have ssb built as module and use it with buses on PCI cards.

This fixes regression that affected all *module* users with PCI cards.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1572349
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/ssb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index 9371651d8017..b3f5cae98ea6 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -117,7 +117,7 @@ config SSB_SERIAL
 
 config SSB_DRIVER_PCICORE_POSSIBLE
 	bool
-	depends on SSB_PCIHOST && SSB = y
+	depends on SSB_PCIHOST
 	default y
 
 config SSB_DRIVER_PCICORE
-- 
2.13.6
