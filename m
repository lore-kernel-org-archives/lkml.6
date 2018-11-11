Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4639C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B452080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B452080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbeKLGFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53156 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730727AbeKLGFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:53 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000lM-QA; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001Py-TL; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Evgeniy Polyakov" <zbr@ioremap.net>, "NeilBrown" <neilb@suse.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.440163028@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 049/366] w1: support auto-load of w1_bq27000 module.
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

From: NeilBrown <neilb@suse.de>

commit 4b7e4f8289c1ca60accb6c1baf31984f69bc2771 upstream.

1/ change request_module call to zero-pad single digit
   family numbers.  This appears to be the intention of
   the code, but not what it actually does.

   This means that the alias created for W1_FAMILY_SMEM_01
   might actually be useful.

2/ Define a family name for the BQ27000 battery charge monitor.
   Unfortunately this is the same number as W1_FAMILY_SMEM_01
   so if both a compiled on a system, one module might need to
   be blacklisted.

3/ Add a MODULE_ALIAS for the bq27000.

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/w1/slaves/w1_bq27000.c | 4 ++--
 drivers/w1/w1.c                | 2 +-
 drivers/w1/w1_family.h         | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/w1/slaves/w1_bq27000.c
+++ b/drivers/w1/slaves/w1_bq27000.c
@@ -88,7 +88,7 @@ static struct w1_family_ops w1_bq27000_f
 };
 
 static struct w1_family w1_bq27000_family = {
-	.fid = 1,
+	.fid = W1_FAMILY_BQ27000,
 	.fops = &w1_bq27000_fops,
 };
 
@@ -111,7 +111,7 @@ module_exit(w1_bq27000_exit);
 
 module_param(F_ID, int, S_IRUSR);
 MODULE_PARM_DESC(F_ID, "1-wire slave FID for BQ device");
-
+MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_BQ27000));
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Texas Instruments Ltd");
 MODULE_DESCRIPTION("HDQ/1-wire slave driver bq27000 battery monitor chip");
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -727,7 +727,7 @@ int w1_attach_slave_device(struct w1_mas
 
 	/* slave modules need to be loaded in a context with unlocked mutex */
 	mutex_unlock(&dev->mutex);
-	request_module("w1-family-0x%0x", rn->family);
+	request_module("w1-family-0x%02x", rn->family);
 	mutex_lock(&dev->mutex);
 
 	spin_lock(&w1_flock);
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -27,6 +27,7 @@
 #include <linux/atomic.h>
 
 #define W1_FAMILY_DEFAULT	0
+#define W1_FAMILY_BQ27000	0x01
 #define W1_FAMILY_SMEM_01	0x01
 #define W1_FAMILY_SMEM_81	0x81
 #define W1_THERM_DS18S20 	0x10

