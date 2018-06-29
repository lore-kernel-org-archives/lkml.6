Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61503C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC30280A8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC30280A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936791AbeF2WJC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 18:09:02 -0400
Received: from gateway20.websitewelcome.com ([192.185.49.40]:28423 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936761AbeF2WJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 18:09:01 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id AC76E400D8206
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:08:59 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Z1ZNfDsGfaSeyZ1ZVftBl8; Fri, 29 Jun 2018 17:08:59 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=49300 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fZ1ZN-002uFN-3a; Fri, 29 Jun 2018 17:08:45 -0500
Date:   Fri, 29 Jun 2018 17:08:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] HID: hiddev: fix potential Spectre v1
Message-ID: <20180629220844.GA13823@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fZ1ZN-002uFN-3a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:49300
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uref->field_index, uref->usage_index, finfo.field_index and
cinfo.index can be indirectly controlled by user-space, hence
leading to a potential exploitation of the Spectre variant 1
vulnerability.

This issue was detected with the help of Smatch:

drivers/hid/usbhid/hiddev.c:473 hiddev_ioctl_usage() warn: potential
spectre issue 'report->field' (local cap)
drivers/hid/usbhid/hiddev.c:477 hiddev_ioctl_usage() warn: potential
spectre issue 'field->usage' (local cap)
drivers/hid/usbhid/hiddev.c:757 hiddev_ioctl() warn: potential spectre
issue 'report->field' (local cap)
drivers/hid/usbhid/hiddev.c:801 hiddev_ioctl() warn: potential spectre
issue 'hid->collection' (local cap)

Fix this by sanitizing such structure fields before using them to index
report->field, field->usage and hid->collection

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hid/usbhid/hiddev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index e3ce233..23872d0 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -36,6 +36,7 @@
 #include <linux/hiddev.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/nospec.h>
 #include "usbhid.h"
 
 #ifdef CONFIG_USB_DYNAMIC_MINORS
@@ -469,10 +470,14 @@ static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd,
 
 		if (uref->field_index >= report->maxfield)
 			goto inval;
+		uref->field_index = array_index_nospec(uref->field_index,
+						       report->maxfield);
 
 		field = report->field[uref->field_index];
 		if (uref->usage_index >= field->maxusage)
 			goto inval;
+		uref->usage_index = array_index_nospec(uref->usage_index,
+						       field->maxusage);
 
 		uref->usage_code = field->usage[uref->usage_index].hid;
 
@@ -499,6 +504,8 @@ static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd,
 
 			if (uref->field_index >= report->maxfield)
 				goto inval;
+			uref->field_index = array_index_nospec(uref->field_index,
+							       report->maxfield);
 
 			field = report->field[uref->field_index];
 
@@ -753,6 +760,8 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 		if (finfo.field_index >= report->maxfield)
 			break;
+		finfo.field_index = array_index_nospec(finfo.field_index,
+						       report->maxfield);
 
 		field = report->field[finfo.field_index];
 		memset(&finfo, 0, sizeof(finfo));
@@ -797,6 +806,8 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 		if (cinfo.index >= hid->maxcollection)
 			break;
+		cinfo.index = array_index_nospec(cinfo.index,
+						 hid->maxcollection);
 
 		cinfo.type = hid->collection[cinfo.index].type;
 		cinfo.usage = hid->collection[cinfo.index].usage;
-- 
2.7.4

