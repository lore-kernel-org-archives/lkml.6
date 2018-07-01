Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50464C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0303425089
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0303425089
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeGAQPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:15:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933160AbeGAQPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:15:47 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9DF304A3;
        Sun,  1 Jul 2018 16:15:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.4 021/105] libata: zpodd: make arrays cdb static, reduces object code size
Date:   Sun,  1 Jul 2018 18:01:31 +0200
Message-Id: <20180701153150.939665855@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-zpodd.c |    4 ++--
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


