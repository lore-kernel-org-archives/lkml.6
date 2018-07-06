Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7119C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A25B23FFC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A25B23FFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933683AbeGFN27 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:28:59 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34491 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933156AbeGFN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:28:53 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M5IbP-1gJm6p2EZz-00zaJY; Fri, 06 Jul 2018 15:28:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: avoid format-overflow warning
Date:   Fri,  6 Jul 2018 15:28:32 +0200
Message-Id: <20180706132843.51206-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:67fAmhG4BXLgjXhZS+i3M+P5K0STs1gZMZ2cTV3wx0GFnSmMPGZ
 gSfb5Z225epl/DXVIAV+u83VDYHAhUcNnmCmV9E9Bu82YUi3SLbKNgDtV3aRBUlPHBvErCi
 ZUy4pLrhKC6XYzJXbnj1EJvMUHeFlZvt3cxQKNptSpKV9kj7Ow6cZx1vGOoBD9R1YNukPIO
 KnExyYawPqBcAi0Gn0RNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X5X8Ya6nl2w=:bahXS9MR84LA6ruL6kOmBF
 65DRrqcxvapBWvvT3pIUCMLnWoZTxQrQR26pEx6Np+4HaqeGdaVrLIccYi1CmcqADG/p9KS/s
 DaX20GlbFNMAn3I9q/zFvg8UqiBOtpIm2L5+G2BCAsh0Wcawb3Qz7cBfzLh36RACPomXGm6Dg
 BOjVU5kvSLrHXU9ADTyczU9q8bk9DeQLZS9xxU6NYgTJu2Renm46RaRQylYWC15OVRd94+iVW
 F7z/wxGdwEBfOMivkzsRbmIKhDCgGClbjXaUE0CEsG7BxT7pjKqCSKdi//bHLKmd71frlOGKT
 toQgzsLpCl0BJRE74G4D64Vq3nH/7iD5/Gw8SDc0X+RjClhkjqRUH/vx2QuiLwZbt4J+z0Mgp
 vn0BKFzPlfOj+sdRV3GqJO8RHRTCvsjK6JeqPG4MtimFKWAeBVJRjeFWuRQ2sCn86G6TK18jQ
 YukkgJy/aWevkXy7/V/hKWwfWSktN3zHJ5cpK8x73TjM2iuCKvRDJYvAC+ui/ZkrWx7FU3LWu
 rQDMyy3ZAJQ8NeBcD1oaRErZwx0rHgULpdXHnHOncJDEZD5jQG1m0ko1qmcz3d3lo5wTKCcoD
 6F5tHbAzyTREr0BRbFSnZedijtGjhJjGsV9eIg4TcsKL33StPxYJk+5dcKK9nJQP2DWCAQ466
 eV+c4hH0lkLjYKa0awZ2GopA1TL8vYyGoomBH/qbqCL1+3oduL0T+i4eO27im2SuIqKs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 points out that the fix-byte buffer might be too small if
desc->mode is a three-digit number:

drivers/usb/typec/class.c: In function 'typec_register_altmode':
drivers/usb/typec/class.c:502:32: error: '%d' directive writing between 1 and 3 bytes into a region of size 2 [-Werror=format-overflow=]
  sprintf(alt->group_name, "mode%d", desc->mode);
                                ^~
drivers/usb/typec/class.c:502:27: note: directive argument in the range [0, 255]
  sprintf(alt->group_name, "mode%d", desc->mode);
                           ^~~~~~~~
drivers/usb/typec/class.c:502:2: note: 'sprintf' output between 6 and 8 bytes into a destination of size 6
  sprintf(alt->group_name, "mode%d", desc->mode);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I assume this cannot happen in practice, but we can simply make the
string long enough to avoid the warning. This uses the two padding
bytes that already exist after the string.

Fixes: 4ab8c18d4d67 ("usb: typec: Register a device for every mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/typec/bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
index 62aaf8b56bde..db40e61d8b72 100644
--- a/drivers/usb/typec/bus.h
+++ b/drivers/usb/typec/bus.h
@@ -16,7 +16,7 @@ struct altmode {
 	enum typec_port_data		roles;
 
 	struct attribute		*attrs[5];
-	char				group_name[6];
+	char				group_name[8];
 	struct attribute_group		group;
 	const struct attribute_group	*groups[2];
 
-- 
2.9.0

