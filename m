Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE261C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B696D21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ejuOFVtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391853AbeLUUKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:10:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46615 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389969AbeLUUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:10:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so2943928ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 12:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lt9FvTpgStJOyqqnXY0Wnnce4CRGicf9dMiO13VI9JY=;
        b=ejuOFVtbK32V6TO4vzGgC/EgWIZFLUjeSRG/4iv2psFeXf6vnQPhzvBY2h4p9WovLt
         uEQSQ6e8ZKhS7krSI26Xzf8HuAYPhiXz/NJfM81LogUDs88j7m6IBXf2bBvoxqN8Nsgv
         s1iTvdSfcaIP0djcN/E2J228rtUSUnRVSFfs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lt9FvTpgStJOyqqnXY0Wnnce4CRGicf9dMiO13VI9JY=;
        b=gXJ5eZ6bX9XOXLWqX/calbunTzbh2PUgkhWuobPCjMjwBM04s9EwtiXiuejcdiM6W1
         smOCc6OYvyeYqD31rxxrdZXF+/Qol51o1yGbtvn37eO5l4yVbH5SEkN72JjHXaQAUcGb
         Ef+smLCV3cMScQ/aqpE575HeMnIXhAgoA241NcQwdx7WZVFO15d00Mta0QheJlJxjxvJ
         +sIffcsAPNvxL6YNvl1NzRsCHVqHZdBJUVPJlFjXxtrtsDzGQBP77Wfc6xklNv/VSCFJ
         4neWZnYotm/mWWFADsv1+rnhC6tkBR3vsuEwk3B/mEVm4urs9ZZBg18pYMy7nBaELnJc
         FiaA==
X-Gm-Message-State: AJcUukc2T0jERN6iKWXyvXpUnCbI0yVAsyStxgv65X2fYkRxZZVCALux
        M2Ym4F5MfwRDfpyG9evAAC8imw==
X-Google-Smtp-Source: ALg8bN7UovACwqAuu/438jnBRkm904vff5vgv7E7nzPEVB9WRPmdX/ukoIFO5Vc0XNLlt1MUuyMp0w==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr3869361plt.2.1545423016252;
        Fri, 21 Dec 2018 12:10:16 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id o1sm35300406pgn.63.2018.12.21.12.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Dec 2018 12:10:15 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] soc: qcom: rmtfs-mem: Add class to enable uevents
Date:   Fri, 21 Dec 2018 12:10:00 -0800
Message-Id: <20181221201001.160613-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181221201001.160613-1-evgreen@chromium.org>
References: <20181221201001.160613-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the qcom_rmtfs_memN devices are entirely invisible to the udev world.
Add a class to the rmtfs device so that uevents fire when the device is added.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
- Moved class registration/deregistration into init/exit routines (Brian)

 drivers/soc/qcom/rmtfs_mem.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 97bb5989aa211..99a1363ece254 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -132,6 +132,11 @@ static int qcom_rmtfs_mem_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static struct class rmtfs_class = {
+	.owner          = THIS_MODULE,
+	.name           = "rmtfs",
+};
+
 static const struct file_operations qcom_rmtfs_mem_fops = {
 	.owner = THIS_MODULE,
 	.open = qcom_rmtfs_mem_open,
@@ -199,8 +204,8 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 	dev_set_name(&rmtfs_mem->dev, "qcom_rmtfs_mem%d", client_id);
 	rmtfs_mem->dev.id = client_id;
+	rmtfs_mem->dev.class = &rmtfs_class;
 	rmtfs_mem->dev.devt = MKDEV(MAJOR(qcom_rmtfs_mem_major), client_id);
-
 	ret = cdev_device_add(&rmtfs_mem->cdev, &rmtfs_mem->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add cdev: %d\n", ret);
@@ -239,7 +244,6 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
 put_device:
 	put_device(&rmtfs_mem->dev);
-
 	return ret;
 }
 
@@ -258,7 +262,6 @@ static int qcom_rmtfs_mem_remove(struct platform_device *pdev)
 
 	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
 	put_device(&rmtfs_mem->dev);
-
 	return 0;
 }
 
@@ -277,32 +280,42 @@ static struct platform_driver qcom_rmtfs_mem_driver = {
 	},
 };
 
-static int qcom_rmtfs_mem_init(void)
+static int __init qcom_rmtfs_mem_init(void)
 {
 	int ret;
 
+	ret = class_register(&rmtfs_class);
+	if (ret)
+		return ret;
+
 	ret = alloc_chrdev_region(&qcom_rmtfs_mem_major, 0,
 				  QCOM_RMTFS_MEM_DEV_MAX, "qcom_rmtfs_mem");
 	if (ret < 0) {
 		pr_err("qcom_rmtfs_mem: failed to allocate char dev region\n");
-		return ret;
+		goto unregister_class;
 	}
 
 	ret = platform_driver_register(&qcom_rmtfs_mem_driver);
 	if (ret < 0) {
 		pr_err("qcom_rmtfs_mem: failed to register rmtfs_mem driver\n");
-		unregister_chrdev_region(qcom_rmtfs_mem_major,
-					 QCOM_RMTFS_MEM_DEV_MAX);
+		goto unregister_chrdev;
 	}
 
+	return 0;
+
+unregister_chrdev:
+	unregister_chrdev_region(qcom_rmtfs_mem_major, QCOM_RMTFS_MEM_DEV_MAX);
+unregister_class:
+	class_unregister(&rmtfs_class);
 	return ret;
 }
 module_init(qcom_rmtfs_mem_init);
 
-static void qcom_rmtfs_mem_exit(void)
+static void __exit qcom_rmtfs_mem_exit(void)
 {
 	platform_driver_unregister(&qcom_rmtfs_mem_driver);
 	unregister_chrdev_region(qcom_rmtfs_mem_major, QCOM_RMTFS_MEM_DEV_MAX);
+	class_unregister(&rmtfs_class);
 }
 module_exit(qcom_rmtfs_mem_exit);
 
-- 
2.18.1

