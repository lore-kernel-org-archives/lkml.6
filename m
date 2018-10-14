Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A575C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9022087D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9022087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeJNXM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36434 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728264AbeJNXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:08 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLu-0004cH-CK; Sun, 14 Oct 2018 16:30:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000SH-D9; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Eliot Blennerhassett" <eliot@blennerhassett.gen.nz>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.481148884@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 217/366] ALSA: asihpi: used parts of message/response
 are zeroed before use
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

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

commit 51e6f47dd2e3463dac6f37128fd7b7cb40c500de upstream.

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/asihpi/hpimsginit.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/sound/pci/asihpi/hpimsginit.c
+++ b/sound/pci/asihpi/hpimsginit.c
@@ -1,7 +1,7 @@
 /******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -37,11 +37,15 @@ static u16 gwSSX2_bypass;
 static void hpi_init_message(struct hpi_message *phm, u16 object,
 	u16 function)
 {
-	memset(phm, 0, sizeof(*phm));
+	u16 size;
+
 	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX))
-		phm->size = msg_size[object];
+		size = msg_size[object];
 	else
-		phm->size = sizeof(*phm);
+		size = sizeof(*phm);
+
+	memset(phm, 0, size);
+	phm->size = size;
 
 	if (gwSSX2_bypass)
 		phm->type = HPI_TYPE_SSX2BYPASS_MESSAGE;
@@ -60,12 +64,16 @@ static void hpi_init_message(struct hpi_
 void hpi_init_response(struct hpi_response *phr, u16 object, u16 function,
 	u16 error)
 {
-	memset(phr, 0, sizeof(*phr));
-	phr->type = HPI_TYPE_RESPONSE;
+	u16 size;
+
 	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX))
-		phr->size = res_size[object];
+		size = res_size[object];
 	else
-		phr->size = sizeof(*phr);
+		size = sizeof(*phr);
+
+	memset(phr, 0, sizeof(*phr));
+	phr->size = size;
+	phr->type = HPI_TYPE_RESPONSE;
 	phr->object = object;
 	phr->function = function;
 	phr->error = error;
@@ -86,7 +94,7 @@ void hpi_init_message_response(struct hp
 static void hpi_init_messageV1(struct hpi_message_header *phm, u16 size,
 	u16 object, u16 function)
 {
-	memset(phm, 0, sizeof(*phm));
+	memset(phm, 0, size);
 	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX)) {
 		phm->size = size;
 		phm->type = HPI_TYPE_REQUEST;
@@ -100,7 +108,9 @@ static void hpi_init_messageV1(struct hp
 void hpi_init_responseV1(struct hpi_response_header *phr, u16 size,
 	u16 object, u16 function)
 {
-	memset(phr, 0, sizeof(*phr));
+	(void)object;
+	(void)function;
+	memset(phr, 0, size);
 	phr->size = size;
 	phr->version = 1;
 	phr->type = HPI_TYPE_RESPONSE;

