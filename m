Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0B7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB78B20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB78B20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbeKLGYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:24:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49932 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730203AbeKLFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:13 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0000lG-6C; Sun, 11 Nov 2018 19:58:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001iL-3t; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Jiri Kosina" <jkosina@suse.cz>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.831966854@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 242/366] HID: hiddev: fix potential Spectre v1
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

commit 4f65245f2d178b9cba48350620d76faa4a098841 upstream.

uref->field_index, uref->usage_index, finfo.field_index and cinfo.index can be
indirectly controlled by user-space, hence leading to a potential exploitation
of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/hid/usbhid/hiddev.c:473 hiddev_ioctl_usage() warn: potential spectre issue 'report->field' (local cap)
drivers/hid/usbhid/hiddev.c:477 hiddev_ioctl_usage() warn: potential spectre issue 'field->usage' (local cap)
drivers/hid/usbhid/hiddev.c:757 hiddev_ioctl() warn: potential spectre issue 'report->field' (local cap)
drivers/hid/usbhid/hiddev.c:801 hiddev_ioctl() warn: potential spectre issue 'hid->collection' (local cap)

Fix this by sanitizing such structure fields before using them to index
report->field, field->usage and hid->collection

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/usbhid/hiddev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -35,6 +35,7 @@
 #include <linux/hiddev.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/nospec.h>
 #include "usbhid.h"
 
 #ifdef CONFIG_USB_DYNAMIC_MINORS
@@ -478,10 +479,14 @@ static noinline int hiddev_ioctl_usage(s
 
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
 
@@ -508,6 +513,8 @@ static noinline int hiddev_ioctl_usage(s
 
 			if (uref->field_index >= report->maxfield)
 				goto inval;
+			uref->field_index = array_index_nospec(uref->field_index,
+							       report->maxfield);
 
 			field = report->field[uref->field_index];
 
@@ -761,6 +768,8 @@ static long hiddev_ioctl(struct file *fi
 
 		if (finfo.field_index >= report->maxfield)
 			break;
+		finfo.field_index = array_index_nospec(finfo.field_index,
+						       report->maxfield);
 
 		field = report->field[finfo.field_index];
 		memset(&finfo, 0, sizeof(finfo));
@@ -801,6 +810,8 @@ static long hiddev_ioctl(struct file *fi
 
 		if (cinfo.index >= hid->maxcollection)
 			break;
+		cinfo.index = array_index_nospec(cinfo.index,
+						 hid->maxcollection);
 
 		cinfo.type = hid->collection[cinfo.index].type;
 		cinfo.usage = hid->collection[cinfo.index].usage;

