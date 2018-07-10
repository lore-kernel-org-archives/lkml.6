Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E92C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7152083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7152083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbeGJS3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:29:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732459AbeGJS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:29:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 66782EA8;
        Tue, 10 Jul 2018 18:28:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.4 33/47] HID: hiddev: fix potential Spectre v1
Date:   Tue, 10 Jul 2018 20:24:57 +0200
Message-Id: <20180710182338.536117000@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

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

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/usbhid/hiddev.c |   11 +++++++++++
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


