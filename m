Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2513FC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDB020876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDB020876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeJNXNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:13:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36380 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728246AbeJNXMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:06 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLu-0004cg-8i; Sun, 14 Oct 2018 16:30:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000SN-FZ; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.802320502@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 218/366] ALSA: asihpi: Hardening for potential Spectre v1
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f9d94b57e30fd1575b4935045b32d738668aa74b upstream.

As recently Smatch suggested, a couple of places in ASIHPI driver may
expand the array directly from the user-space value with speculation:
  sound/pci/asihpi/hpimsginit.c:70 hpi_init_response() warn: potential spectre issue 'res_size' (local cap)
  sound/pci/asihpi/hpioctl.c:189 asihpi_hpi_ioctl() warn: potential spectre issue 'adapters'

This patch puts array_index_nospec() for hardening against them.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/asihpi/hpimsginit.c | 13 +++++++++----
 sound/pci/asihpi/hpioctl.c    |  4 +++-
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/sound/pci/asihpi/hpimsginit.c
+++ b/sound/pci/asihpi/hpimsginit.c
@@ -23,6 +23,7 @@
 
 #include "hpi_internal.h"
 #include "hpimsginit.h"
+#include <linux/nospec.h>
 
 /* The actual message size for each object type */
 static u16 msg_size[HPI_OBJ_MAXINDEX + 1] = HPI_MESSAGE_SIZE_BY_OBJECT;
@@ -39,10 +40,12 @@ static void hpi_init_message(struct hpi_
 {
 	u16 size;
 
-	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX))
+	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX)) {
+		object = array_index_nospec(object, HPI_OBJ_MAXINDEX + 1);
 		size = msg_size[object];
-	else
+	} else {
 		size = sizeof(*phm);
+	}
 
 	memset(phm, 0, size);
 	phm->size = size;
@@ -66,10 +69,12 @@ void hpi_init_response(struct hpi_respon
 {
 	u16 size;
 
-	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX))
+	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX)) {
+		object = array_index_nospec(object, HPI_OBJ_MAXINDEX + 1);
 		size = res_size[object];
-	else
+	} else {
 		size = sizeof(*phr);
+	}
 
 	memset(phr, 0, sizeof(*phr));
 	phr->size = size;
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -35,6 +35,7 @@ Common Linux HPI ioctl and module probe/
 #include <linux/pci.h>
 #include <linux/stringify.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 
 #ifdef MODULE_FIRMWARE
 MODULE_FIRMWARE("asihpi/dsp5000.bin");
@@ -182,7 +183,8 @@ long asihpi_hpi_ioctl(struct file *file,
 		struct hpi_adapter *pa = NULL;
 
 		if (hm->h.adapter_index < ARRAY_SIZE(adapters))
-			pa = &adapters[hm->h.adapter_index];
+			pa = &adapters[array_index_nospec(hm->h.adapter_index,
+							  ARRAY_SIZE(adapters))];
 
 		if (!pa || !pa->adapter || !pa->adapter->type) {
 			hpi_init_response(&hr->r0, hm->h.object,

