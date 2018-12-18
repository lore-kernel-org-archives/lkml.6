Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26113C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A67214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nIkEvDVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeLRAJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:09:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44258 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeLRAJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:09:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so7167797pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nKA343VWfqT0i6llLCv/qR9rGyeHc6kj4MhGFMqq5pQ=;
        b=nIkEvDVT0DKbehtvUeKxjag7iF8MH/Lq9uKi66Gmu2QH3j5Wr2QhofqaIJ3zrihtj1
         AW8CGeFJELP6CSTObw+J/o3z+tj8DHOuOpB54bUgX4JP/RAmoudFVPiuHqd6ybegLScq
         ta67mJ4C92Wgn8b+uy/JinVpRJMUS7wxbfc3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nKA343VWfqT0i6llLCv/qR9rGyeHc6kj4MhGFMqq5pQ=;
        b=rXCiczhg6ygqHDDFPjMtn10QCV4LuflmtovVWpFqTuw4MJzrptH7E1/U5+Bkx+cELH
         cuUgKpgX7zk2m6Q5Uou87L/VdlrMO22UkwioP3qd8XooDspbZXHbLaLRLkcQ1HjWrR7q
         zaVIudAPgPSFtEZbBrcogV5Y3azL21j/F3XLSYbCNdzzzS40oK6UpD/6FpOQYgZHFIEK
         PkLdrlYFy5X3751Iu6CSqQGmrK9BdA+hRDMJBlBKbPRo3FZUKcQZGVAtHPUEdwuQy3kN
         VpTaVbIL10IvFy0biZnytEO8rvGLTe9pMgtzGYNklD1/PJjpfLCPEHCoxIAk+tntVdTm
         pTfQ==
X-Gm-Message-State: AA+aEWasYnsNSvUCqO9ZcEHE1Ts7R5rmdIe9pCc3AwsZVeMdVqvslOrh
        UDi5Wja491rZflr3mXl3h6mb8+vo1Ek=
X-Google-Smtp-Source: AFSGD/V9R2ngeQ/UVOD9iyHh71lEuLWY6Eq71OW1YqMguCSTiKdVXN/ZxQ8HA+sjfWr5mvInAsaH2g==
X-Received: by 2002:a62:5716:: with SMTP id l22mr15114407pfb.16.1545091743883;
        Mon, 17 Dec 2018 16:09:03 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id m65sm21734424pfg.180.2018.12.17.16.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 16:09:03 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] soc: qcom: rmtfs-mem: Add class to enable uevents
Date:   Mon, 17 Dec 2018 16:08:33 -0800
Message-Id: <20181218000834.201748-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181218000834.201748-1-evgreen@chromium.org>
References: <20181218000834.201748-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the qcom_rmtfs_memN devices are entirely invisible to the udev world.
Add a class to the rmtfs device so that uevents fire when the device is added.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/soc/qcom/rmtfs_mem.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 97bb5989aa211..0bf800ee2a978 100644
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
@@ -173,9 +178,15 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 	}
 
+	ret  = class_register(&rmtfs_class);
+	if (ret)
+		return ret;
+
 	rmtfs_mem = kzalloc(sizeof(*rmtfs_mem), GFP_KERNEL);
-	if (!rmtfs_mem)
-		return -ENOMEM;
+	if (!rmtfs_mem) {
+		ret = -ENOMEM;
+		goto unregister_class;
+	}
 
 	rmtfs_mem->addr = rmem->base;
 	rmtfs_mem->client_id = client_id;
@@ -199,8 +210,8 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 	dev_set_name(&rmtfs_mem->dev, "qcom_rmtfs_mem%d", client_id);
 	rmtfs_mem->dev.id = client_id;
+	rmtfs_mem->dev.class = &rmtfs_class;
 	rmtfs_mem->dev.devt = MKDEV(MAJOR(qcom_rmtfs_mem_major), client_id);
-
 	ret = cdev_device_add(&rmtfs_mem->cdev, &rmtfs_mem->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add cdev: %d\n", ret);
@@ -235,11 +246,13 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 	return 0;
 
+
 remove_cdev:
 	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
 put_device:
 	put_device(&rmtfs_mem->dev);
-
+unregister_class:
+	class_unregister(&rmtfs_class);
 	return ret;
 }
 
@@ -258,7 +271,7 @@ static int qcom_rmtfs_mem_remove(struct platform_device *pdev)
 
 	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
 	put_device(&rmtfs_mem->dev);
-
+	class_unregister(&rmtfs_class);
 	return 0;
 }
 
-- 
2.18.1

