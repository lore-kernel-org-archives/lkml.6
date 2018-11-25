Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4C12084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M44vy3tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4C12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeKZGjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:39:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43858 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZGje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:39:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so16729864wrs.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 11:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q98asrd6qZLflby5d4Te9hX18XU2nPazWMrKaUkGomg=;
        b=M44vy3tnjhBA9vMOWg/eQuUK4cRCseAXlLZwYv3eDXYTijbFy+3eZdzHnIZFD0NMC5
         MpIccxRF0I3tPnhfhuHpKO2gwEUPPx5dYDcOljEJNJ7/cgYKaeTiX3x1pxtUoy+dsyvs
         VnpDsnmnf1CCB2qPh5m5ulvvserfmPn9gSyq30SMfb2rsGDl9e938vM9DNzJ5n/HtiBK
         12RmSkD30PsI5jDCOyu3TZvnzvmObw4+FysiWl1HBcqr6T6EfjBZknXCD5nzGC58xs+V
         aUwi2FEmUBSgQVtFF3BlSv/33pxHHGEZimlL1ZbWetUmn7JXQ/XcnW+mLECfWGPpZMqv
         vCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q98asrd6qZLflby5d4Te9hX18XU2nPazWMrKaUkGomg=;
        b=mSHZosyvqTVdyerxQ6B+NL+J7cPV3g3AmCvRHNPchTVq9hYO8FzgdmCOwAcPvtRdZ0
         X04Epmh/+BicUk+6sny2Ovu7/qIraCtrUZpLcKZED5P4cdOUJyrWfLO90Zgwn/Yvgnea
         hwFOaQp9Ajuo1lynxHd8UQhlf9i8caPmKUa1oI7F+rRtrw+Vr93ftSYgV9FQe8NLS3e1
         4X6ATdZXgMzX1Se1g305GP1lSEE9QINAJK8z4Z65IKyOzCZhsnTXgrATasRaynikjlPZ
         5nAlJyKbFLAB7lemRI1G+6AJ8X7kaLQepsLuhc7wkmaVHQGrjz8zCHj2DwutOnJ6oPf1
         eeCA==
X-Gm-Message-State: AA+aEWaQjUEBzYZWOh9fNnIAN40HEByXbbh5LCo+rjlBuPU6ehTrBLCC
        Y5vbRDFlAqs83EwChbd/nCY=
X-Google-Smtp-Source: AFSGD/W1GjJXlH+xNEXcZIWLO2X6QNy31zsQgVRrH/JhgzEwVgND/UHLp91BCgfCoTIljfYvQT3MdQ==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr20714928wrm.143.1543175265176;
        Sun, 25 Nov 2018 11:47:45 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id y138sm15744436wmc.16.2018.11.25.11.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 11:47:44 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/6] char: lp: use tabs instead of spaces
Date:   Sun, 25 Nov 2018 19:47:35 +0000
Message-Id: <20181125194737.5591-4-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
References: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the checkpatch error:
ERROR: code indent should use tabs where possible

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 4153c6f5683a..15d03aa55a1a 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -262,7 +262,7 @@ static int lp_check_status(int minor)
 		error = -EIO;
 	} else {
 		last = 0; /* Come here if LP_CAREFUL is set and no
-                             errors are reported. */
+			     errors are reported. */
 	}
 
 	lp_table[minor].last_error = last;
@@ -295,7 +295,7 @@ static int lp_wait_ready(int minor, int nonblock)
 }
 
 static ssize_t lp_write(struct file * file, const char __user * buf,
-		        size_t count, loff_t *ppos)
+			size_t count, loff_t *ppos)
 {
 	unsigned int minor = iminor(file_inode(file));
 	struct parport *port = lp_table[minor].dev->port;
@@ -325,8 +325,8 @@ static ssize_t lp_write(struct file * file, const char __user * buf,
 		goto out_unlock;
 	}
 
- 	/* Claim Parport or sleep until it becomes available
- 	 */
+	/* Claim Parport or sleep until it becomes available
+	 */
 	lp_claim_parport_or_block (&lp_table[minor]);
 	/* Go to the proper mode. */
 	lp_table[minor].current_mode = lp_negotiate (port,
@@ -406,7 +406,7 @@ static ssize_t lp_write(struct file * file, const char __user * buf,
 out_unlock:
 	mutex_unlock(&lp_table[minor].port_mutex);
 
- 	return retv;
+	return retv;
 }
 
 #ifdef CONFIG_PARPORT_1284
@@ -545,8 +545,8 @@ static int lp_open(struct inode * inode, struct file * file)
 	/* Determine if the peripheral supports ECP mode */
 	lp_claim_parport_or_block (&lp_table[minor]);
 	if ( (lp_table[minor].dev->port->modes & PARPORT_MODE_ECP) &&
-             !parport_negotiate (lp_table[minor].dev->port,
-                                 IEEE1284_MODE_ECP)) {
+	     !parport_negotiate (lp_table[minor].dev->port,
+				 IEEE1284_MODE_ECP)) {
 		printk (KERN_INFO "lp%d: ECP mode\n", minor);
 		lp_table[minor].best_mode = IEEE1284_MODE_ECP;
 	} else {
@@ -650,8 +650,8 @@ static int lp_do_ioctl(unsigned int minor, unsigned int cmd,
 						sizeof(struct lp_stats));
 			break;
 #endif
- 		case LPGETFLAGS:
- 			status = LP_F(minor);
+		case LPGETFLAGS:
+			status = LP_F(minor);
 			if (copy_to_user(argp, &status, sizeof(int)))
 				return -EFAULT;
 			break;
-- 
2.11.0

