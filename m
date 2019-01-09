Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178CCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E614020859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfAITCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:02:43 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.210]:40501 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbfAITCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:02:42 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id D9929400D6ABC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 13:02:41 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hJ7hgAmU7dnCehJ7hgGZnV; Wed, 09 Jan 2019 13:02:41 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=45770 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghJ7g-000MPi-KO; Wed, 09 Jan 2019 13:02:41 -0600
Date:   Wed, 9 Jan 2019 13:02:36 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] char/mwave: fix potential Spectre v1 vulnerability
Message-ID: <20190109190236.GA19068@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghJ7g-000MPi-KO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:45770
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipcnum is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/char/mwave/mwavedd.c:299 mwave_ioctl() warn: potential spectre issue 'pDrvData->IPCs' [w] (local cap)

Fix this by sanitizing ipcnum before using it to index pDrvData->IPCs.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/char/mwave/mwavedd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/mwave/mwavedd.c b/drivers/char/mwave/mwavedd.c
index b5e3103c1175..e43c876a9223 100644
--- a/drivers/char/mwave/mwavedd.c
+++ b/drivers/char/mwave/mwavedd.c
@@ -59,6 +59,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/serial_8250.h>
+#include <linux/nospec.h>
 #include "smapi.h"
 #include "mwavedd.h"
 #include "3780i.h"
@@ -289,6 +290,8 @@ static long mwave_ioctl(struct file *file, unsigned int iocmd,
 						ipcnum);
 				return -EINVAL;
 			}
+			ipcnum = array_index_nospec(ipcnum,
+						    ARRAY_SIZE(pDrvData->IPCs));
 			PRINTK_3(TRACE_MWAVE,
 				"mwavedd::mwave_ioctl IOCTL_MW_REGISTER_IPC"
 				" ipcnum %x entry usIntCount %x\n",
@@ -317,6 +320,8 @@ static long mwave_ioctl(struct file *file, unsigned int iocmd,
 						" Invalid ipcnum %x\n", ipcnum);
 				return -EINVAL;
 			}
+			ipcnum = array_index_nospec(ipcnum,
+						    ARRAY_SIZE(pDrvData->IPCs));
 			PRINTK_3(TRACE_MWAVE,
 				"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC"
 				" ipcnum %x, usIntCount %x\n",
@@ -383,6 +388,8 @@ static long mwave_ioctl(struct file *file, unsigned int iocmd,
 						ipcnum);
 				return -EINVAL;
 			}
+			ipcnum = array_index_nospec(ipcnum,
+						    ARRAY_SIZE(pDrvData->IPCs));
 			mutex_lock(&mwave_mutex);
 			if (pDrvData->IPCs[ipcnum].bIsEnabled == true) {
 				pDrvData->IPCs[ipcnum].bIsEnabled = false;
-- 
2.20.1

