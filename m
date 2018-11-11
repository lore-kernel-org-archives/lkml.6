Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70CBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A4820869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A4820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbeKLG30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:29:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49510 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729974AbeKLFsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000lG-CE; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001UF-Gc; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Colin Ian King" <colin.king@canonical.com>,
        "Tejun Heo" <tj@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.777985776@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 093/366] libata: zpodd: make arrays cdb static,
 reduces object code size
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

From: Colin Ian King <colin.king@canonical.com>

commit 795ef788145ed2fa023efdf11e8d5d7bedc21462 upstream.

Don't populate the arrays cdb on the stack, instead make them static.
Makes the object code smaller by 230 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   3797	    240	      0	   4037	    fc5	drivers/ata/libata-zpodd.o

After:
   text	   data	    bss	    dec	    hex	filename
   3407	    400	      0	   3807	    edf	drivers/ata/libata-zpodd.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-zpodd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -34,7 +34,7 @@ struct zpodd {
 static int eject_tray(struct ata_device *dev)
 {
 	struct ata_taskfile tf;
-	const char cdb[] = {  GPCMD_START_STOP_UNIT,
+	static const char cdb[] = {  GPCMD_START_STOP_UNIT,
 		0, 0, 0,
 		0x02,     /* LoEj */
 		0, 0, 0, 0, 0, 0, 0,
@@ -55,7 +55,7 @@ static enum odd_mech_type zpodd_get_mech
 	unsigned int ret;
 	struct rm_feature_desc *desc = (void *)(buf + 8);
 	struct ata_taskfile tf;
-	char cdb[] = {  GPCMD_GET_CONFIGURATION,
+	static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
 			2,      /* only 1 feature descriptor requested */
 			0, 3,   /* 3, removable medium feature */
 			0, 0, 0,/* reserved */

