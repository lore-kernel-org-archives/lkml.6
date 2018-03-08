Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965149AbeCHJhE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:37:04 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35888 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935582AbeCHJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:37:00 -0500
X-Google-Smtp-Source: AG47ELvb5DomfKH7RV/JTVlJT0zIcJA3/pR9N9IcXMxhaMlajO6VHKttENDB9F0Gntwg8/3sdp5A6Q==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 1/2] rpmsg: glink: use put_device() if device_register fail
Date: Thu,  8 Mar 2018 15:06:07 +0530
Message-Id: <3bf53792e96a3889604dde687627a04a06ff3a6e.1520501519.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
References: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
References: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if device_register() returned an error! Always use put_device()
to give up the reference initialized. And unregister device for
other return error.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/rpmsg/qcom_glink_smem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index 892f2b9..3fa9d43 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -217,6 +217,7 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 	ret = device_register(dev);
 	if (ret) {
 		pr_err("failed to register glink edge\n");
+		put_device(dev);
 		return ERR_PTR(ret);
 	}
 
@@ -299,7 +300,7 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 	return glink;
 
 err_put_dev:
-	put_device(dev);
+	device_unregister(dev);
 
 	return ERR_PTR(ret);
 }
-- 
1.9.1
