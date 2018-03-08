Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935679AbeCHJhU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:37:20 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:40580 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755238AbeCHJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:37:03 -0500
X-Google-Smtp-Source: AG47ELsX4NNGOYXV3pfj58HSaNfg+FdHJhe1YAfIowlERZY8TAcZHEpDkWAV/2Nu1LYOYCcdwxwEmA==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 2/2] rpmsg: smd: use put_device() if device_register fail
Date: Thu,  8 Mar 2018 15:06:08 +0530
Message-Id: <340cac8a81a84cf3054f8adcdb169f740b212c34.1520501519.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
References: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
References: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if device_register() returned an error! Always use put_device()
to give up the reference initialized. unregister device for
other return error.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/rpmsg/qcom_smd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 92d0c6a..ff8101a 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1408,6 +1408,7 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
 	ret = device_register(&edge->dev);
 	if (ret) {
 		pr_err("failed to register smd edge\n");
+		put_device(&edge->dev);
 		return ERR_PTR(ret);
 	}
 
@@ -1428,7 +1429,7 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
 	return edge;
 
 unregister_dev:
-	put_device(&edge->dev);
+	device_unregister(&edge->dev);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(qcom_smd_register_edge);
-- 
1.9.1
