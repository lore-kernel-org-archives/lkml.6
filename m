Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77267C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E99521470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbrIFdzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E99521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJDAHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:08 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42517 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:08 -0400
Received: by mail-pg1-f201.google.com with SMTP id s15-v6so2672956pgv.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IyjGsLryGxdotLAunE8r37MYaDlSnqnj1ZA2+El2HNc=;
        b=nbrIFdzEps6Bp1ufQQC+utkbBQnjzg4YHhD5i2MFCmYDeeYUUyPYggH0OfY/qOPQy3
         n/D/G7+BN/mlWVu6MJqSl9nxN6pe7xV7WHf2KJmf8ZI7ro/VejrUA6WUij2nhA4CvQYa
         Dv2kBgzXZCrtlbBJtkACKXlEqPVcpHvVnT0215awT1QGGaE9x+0tlRpHKv19wEMhh+5V
         juMPTSSitWz83Ffq7ahMwUNDEY+pBpHxyjac7vZ9qUWO261uARYMYz9IDo+IdvxSLlPX
         XY4nUBK+Ewb0MUtiRBKB6AYr2GABbSJCMG24x1ULG3Gy/N/Xj3wgPSMhV0La59Bn3P5R
         oW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IyjGsLryGxdotLAunE8r37MYaDlSnqnj1ZA2+El2HNc=;
        b=jreiKkOG7mlAeqPlMO0cMzJY8P3YxSvWeaOuHac4o6/gIBOul1k1iJoiO+dbXRPlET
         wAPgDhtRKGQJ+PQGo8iidpECAUnTrHUKv31vsMdnsjyxbBVsq+5zWmpFdf4JbW1KN3dT
         R6R00u2jiHSTGCBOUocse4O3vRLOxU16s68QOqWEzv+Vr2PXqMsv1EClYfh2+cLFHhww
         wdU7v47N7oA2My9WHs+kDWQCYHeSJ6qZ4As1UKTVl5QgwVCeYC1hU25EDZ1F+ODUUKWc
         gsseMmYyhFq348cxxyTWmH2IQ70uMHADTezk5l4kR27O5t3wMOL73WyAB+v2rVg1If4F
         +EKg==
X-Gm-Message-State: ABuFfoj5ZO5BbWwpIcMZBZm5qmTJBYYmGQpz7RZUY3sn6OUC6YKyp+jp
        6+zwnuIcdhEj2oBrkELwaHBlmWuL
X-Google-Smtp-Source: ACcGV63OtmBIB0UBJ63c0F950NGVd15G4qxSsLGFsL2dSxqDhuyFCtW7apc+EMRoTOHETuhvKKAEW7S/
X-Received: by 2002:a62:488f:: with SMTP id q15-v6mr1098325pfi.1.1538587069826;
 Wed, 03 Oct 2018 10:17:49 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:07 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-2-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 02/15] platform: goldfish: pipe: Move the file-scope
 goldfish_pipe_miscdev variable into the driver state
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

This is a series of patches to move mutable file-scope variables
into the driver state. This change will help to introduce another
version of the pipe driver (with different state) for the older
host interface or having several instances of this device.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - Updated the commit message.

 drivers/platform/goldfish/goldfish_pipe.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index ba9aede17d57..8ca709b45e1f 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -211,6 +211,8 @@ struct goldfish_pipe_dev {
 
 	/* an irq tasklet to run goldfish_interrupt_task */
 	struct tasklet_struct irq_tasklet;
+
+	struct miscdevice miscdev;
 };
 
 static struct goldfish_pipe_dev goldfish_pipe_dev;
@@ -785,11 +787,14 @@ static const struct file_operations goldfish_pipe_fops = {
 	.release = goldfish_pipe_release,
 };
 
-static struct miscdevice goldfish_pipe_miscdev = {
-	.minor = MISC_DYNAMIC_MINOR,
-	.name = "goldfish_pipe",
-	.fops = &goldfish_pipe_fops,
-};
+static void init_miscdevice(struct miscdevice *miscdev)
+{
+	memset(miscdev, 0, sizeof(*miscdev));
+
+	miscdev->minor = MISC_DYNAMIC_MINOR;
+	miscdev->name = "goldfish_pipe";
+	miscdev->fops = &goldfish_pipe_fops;
+}
 
 static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 {
@@ -815,7 +820,8 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 		return err;
 	}
 
-	err = misc_register(&goldfish_pipe_miscdev);
+	init_miscdevice(&dev->miscdev);
+	err = misc_register(&dev->miscdev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to register v2 device\n");
 		return err;
@@ -860,7 +866,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 
 static void goldfish_pipe_device_deinit(struct platform_device *pdev)
 {
-	misc_deregister(&goldfish_pipe_miscdev);
+	misc_deregister(&goldfish_pipe_dev.miscdev);
 	tasklet_kill(&goldfish_pipe_dev.irq_tasklet);
 	kfree(goldfish_pipe_dev.pipes);
 	free_page((unsigned long)goldfish_pipe_dev.buffers);
-- 
2.19.0.605.g01d371f741-goog

