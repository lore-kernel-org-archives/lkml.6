Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF4EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E847420856
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hNevkkvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfACACe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:02:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42815 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfACACd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:02:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so15121223plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 16:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KNywLRoSIC3WF7SFL6cHozalavq2mS2jb+SaSoSvo1o=;
        b=hNevkkvgZ/miT3VrcbK5BnJVSimrGMO9Ws0uC/sdp4owNsipySa2R49Imb+9CFaL4J
         Qn6F+ObcHEGAKOV/f6mm38tG1wuPgf8iQIcyfHwS0AebeuQK6FW99HIL4rp8Z0FGHcbv
         8hvrNmdEdj/32Saikd4e11SlJppurRgeBj/lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KNywLRoSIC3WF7SFL6cHozalavq2mS2jb+SaSoSvo1o=;
        b=BLJCoqF2szNDH90cxWG3kJAoK/z0OzlTVmqZgXpeVrX0X1DURTe/i5oQfAkqduoy1q
         QRv2GMDvFWbmfUYpK3drHgyTd3vg3atvN5u8r6wON+oYBUox7u9CLsrHk8OB4ginhcu6
         Tl3p/bW386xXLFD1B9LgSq2X4wHFtjYn2ovAKURWPGyTO0BU1SCs1ffVt4Hqlrg1K2MG
         2aIXzMx2z5Y50BessGS5PKFZZYVKxAwfzxNWzL8eHxqbzFcTmoZ6P6FLMt0L6isX8Tj4
         RHR/yegC/KfeXZLlvkhTkUCRgfoAUZSj5cnX+YcUooH4C71HweCNeNNukHnh+Ie7yZx1
         Zuwg==
X-Gm-Message-State: AJcUukcR4HeyLjeWGIon7oxGUdA+luxAtf5d0rMFUO17Z9JEH6fUYp2g
        WDVwAvo/qUY/3Zj1VwuTa7tJ9g==
X-Google-Smtp-Source: ALg8bN6f+0wpHiiK7okfMe6+oyWBTpT1+WsT8C6wxdVmnB86H1s570wbuGa27VR1YaIGw/8CZ13nug==
X-Received: by 2002:a17:902:4624:: with SMTP id o33mr44299497pld.289.1546473752652;
        Wed, 02 Jan 2019 16:02:32 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id u6sm60291199pgr.79.2019.01.02.16.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 16:02:31 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] soc: qcom: rmtfs-mem: Add class to enable uevents
Date:   Wed,  2 Jan 2019 16:02:12 -0800
Message-Id: <20190103000213.230652-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190103000213.230652-1-evgreen@chromium.org>
References: <20190103000213.230652-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the qcom_rmtfs_memN devices are entirely invisible to the udev world.
Add a class to the rmtfs device so that uevents fire when the device is added.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in v3:
- Removed spurious whitespace changes (Brian, Bjorn)

Changes in v2:
- Moved class registration/deregistration into init/exit routines (Brian)

 drivers/soc/qcom/rmtfs_mem.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 97bb5989aa211..b2fa8fc8016c0 100644
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
@@ -199,6 +204,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 	dev_set_name(&rmtfs_mem->dev, "qcom_rmtfs_mem%d", client_id);
 	rmtfs_mem->dev.id = client_id;
+	rmtfs_mem->dev.class = &rmtfs_class;
 	rmtfs_mem->dev.devt = MKDEV(MAJOR(qcom_rmtfs_mem_major), client_id);
 
 	ret = cdev_device_add(&rmtfs_mem->cdev, &rmtfs_mem->dev);
@@ -277,32 +283,42 @@ static struct platform_driver qcom_rmtfs_mem_driver = {
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

