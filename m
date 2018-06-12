Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C7CFEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77477208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4KoHSuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77477208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933499AbeFLDmu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:42:50 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42007 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932503AbeFLDms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:42:48 -0400
Received: by mail-pf0-f194.google.com with SMTP id w7-v6so11334770pfn.9;
        Mon, 11 Jun 2018 20:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZECmV7coQBKdO4msRKtJQllCjuxoRrIsJWgrieczf3k=;
        b=A4KoHSuCaeHHu+RKb9Cky4Q0r543yHyWluqLQUQ4JGvBMdpwCvKhy8OK694cvUmbnN
         AwvfDY3zR+P7HOrRGuTeXWUtdpG8GYSlH1sMY28ppwGbab4PL64I2/wT04B8/4k92M6U
         Tv/aR5bYXnr1eXs+6WLQaeNyEDBv0oIGqmTyw5U1vb4h87QBBUI1iH8bN42QSyfepwM6
         4fktQc+JBkbkhncdCW1UnzlEg8TJ0hQ0V1jK9Or6lupmrq3BR9JVFWJveL5hGkJ8+eIH
         A9LPGeuJudCGlExtfhfnrYXWZuVE+kRvOLGW/522W5PLKDeK0zXOP4VMqzuzjUdI5zVN
         51iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZECmV7coQBKdO4msRKtJQllCjuxoRrIsJWgrieczf3k=;
        b=Sr9ByTQJsmnnkunKmG0yNZjZtzqLnBvJmnDvPj9CjJSrxuF1o8rE06XdRzoaJgmvt2
         mZj9aBQVZaD3gr2R7wVBJ45AWQC0oS0KO3mfwHnBApCXFTyiM3RnSu4NrjKHlJIB5i9J
         HLp7ARZ65SweRZlj3oKCOvgNfFHqDVmy7G2G3qASlSG/XNVRt8gwQ0rWQprsEaC7uIM0
         xAmkErDMwjl1lW+JClVs9vCzRICsUY2fJNZvOGd5fxpZquJJ0uqVl80+pqystGmgk8t5
         LtbHPkxAHTlSWfItTJbBlQlrHIWHsmTkfMzoM1dFaKzIQzwr8XUye1amYLmGE3efBSTq
         mp8g==
X-Gm-Message-State: APt69E1pEsCsUktNbc+NzKLWvSaAXpZyt8sXpclCLYdIlZUNt9DBac1z
        quD3pSs1ncnAzKUB+DzUydA=
X-Google-Smtp-Source: ADUXVKL/4sxwtt7X2o4sOHaVrmlLXPWLh9SogJqFsVZlepuvJvKi9ndHsK7o8GryMRSNxw+bUUe/4g==
X-Received: by 2002:a62:1656:: with SMTP id 83-v6mr1962056pfw.61.1528774967993;
        Mon, 11 Jun 2018 20:42:47 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id r30-v6sm29595910pgn.58.2018.06.11.20.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:42:47 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: xen-scsifront: add error handling for xenbus_printf
Date:   Tue, 12 Jun 2018 11:42:42 +0800
Message-Id: <1528774962-39173-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When xenbus_printf fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling xenbus_printf.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/scsi/xen-scsifront.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 36f59a1..3d858ac 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -654,10 +654,17 @@ static int scsifront_dev_reset_handler(struct scsi_cmnd *sc)
 static int scsifront_sdev_configure(struct scsi_device *sdev)
 {
 	struct vscsifrnt_info *info = shost_priv(sdev->host);
+	struct xenbus_device *dev = info->dev;
+	int err;
 
-	if (info && current == info->curr)
-		xenbus_printf(XBT_NIL, info->dev->nodename,
+	if (info && current == info->curr) {
+		err = xenbus_printf(XBT_NIL, info->dev->nodename,
 			      info->dev_state_path, "%d", XenbusStateConnected);
+		if (err) {
+			dev_err(&dev->dev, "writing dev_state_path\n");
+			return err;
+		}
+	}
 
 	return 0;
 }
@@ -665,10 +672,15 @@ static int scsifront_sdev_configure(struct scsi_device *sdev)
 static void scsifront_sdev_destroy(struct scsi_device *sdev)
 {
 	struct vscsifrnt_info *info = shost_priv(sdev->host);
+	struct xenbus_device *dev = info->dev;
+	int err;
 
-	if (info && current == info->curr)
-		xenbus_printf(XBT_NIL, info->dev->nodename,
+	if (info && current == info->curr) {
+		err = xenbus_printf(XBT_NIL, info->dev->nodename,
 			      info->dev_state_path, "%d", XenbusStateClosed);
+		if (err)
+			dev_err(&dev->dev, "writing dev_state_path\n");
+	}
 }
 
 static struct scsi_host_template scsifront_sht = {
@@ -1003,9 +1015,11 @@ static void scsifront_do_lun_hotplug(struct vscsifrnt_info *info, int op)
 
 			if (scsi_add_device(info->host, chn, tgt, lun)) {
 				dev_err(&dev->dev, "scsi_add_device\n");
-				xenbus_printf(XBT_NIL, dev->nodename,
+				err = xenbus_printf(XBT_NIL, dev->nodename,
 					      info->dev_state_path,
 					      "%d", XenbusStateClosed);
+				if (err)
+					dev_err(&dev->dev, "writing dev_state_path\n");
 			}
 			break;
 		case VSCSIFRONT_OP_DEL_LUN:
@@ -1019,10 +1033,13 @@ static void scsifront_do_lun_hotplug(struct vscsifrnt_info *info, int op)
 			}
 			break;
 		case VSCSIFRONT_OP_READD_LUN:
-			if (device_state == XenbusStateConnected)
-				xenbus_printf(XBT_NIL, dev->nodename,
+			if (device_state == XenbusStateConnected) {
+				err = xenbus_printf(XBT_NIL, dev->nodename,
 					      info->dev_state_path,
 					      "%d", XenbusStateConnected);
+				if (err)
+					dev_err(&dev->dev, "writing dev_state_path\n");
+			}
 			break;
 		default:
 			break;
-- 
2.7.4

