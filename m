Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3903220858
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uR+Coumv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3903220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeGOTB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 15:01:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43241 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeGOTB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 15:01:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so6660377pgr.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NSoI7M5r6h5czpmheaHTGVFjUJ0LVL2/Y/ABrU1nW6E=;
        b=uR+Coumv8fvEfrptPv3+Jo7okk4QgS13FMrCGAnR7NU0tl65ofddLA82BxmR5htz9O
         rFNV2EtFJsICXPkdgHampnJFOkLAvGH5Wr1vRmF3Knofb1S8oOt7GMQvTRkANSpDgg0U
         6v6IXdgsNgY8dcayfMJPR6VaQcQ7JKwe9Og8zNu+e/nmvEyjDJdAairEV5FZMsOPFq9S
         o0fuxYJ0x7+nTOEZR/FAnvD0yMrN4vLZekGaTl5QfVVQ/hdxynUk+A03lYP2wWZpJcSm
         sDLJDCII25XYspmxzBefWTfj3EKFf0pd38rDzjCpZFCy5ILF2rMJOUy7y1wMRaUpQqiA
         F9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NSoI7M5r6h5czpmheaHTGVFjUJ0LVL2/Y/ABrU1nW6E=;
        b=Pn1AheHij8ZDygg7aK5xQDIbq0GV/gcef26GRBoRIHd8ynrS6up/vdVWqKjKzSv+cl
         EmGjnADuSWJfMq0duLKCnXAhSaa+fhccstHtFWSHwS4yM3rSdwcWfkZ+RWtNu3ZSIOAq
         aZCuOan2oc5HmS2waraWiTyHH/7YrHOzkoqqfO49NJq7YQ09onKNWV9VKQI0b+W8nae3
         0n4mZj9eglM38FqX4QcS5ON6FVARQpT4oC51Z4JuluQdXoKUEdVjeB0rE83bAsAw7Svd
         sNhfuT/8FgnJkGD1rysmO/7s1lSMwSJ/7+8h2WwzRX6LVEryLj8OaIOVWq8MXBg+JEEl
         05Sw==
X-Gm-Message-State: AOUpUlGdbpZx5nY2GQg13O0gRPp5uAgAsKaxvYB3jKWapOQV5MgoKOkk
        radFuN+wynHy1ZeoSrt5EtI=
X-Google-Smtp-Source: AAOMgpf47HOk3sqgGVb2xkDDPMe8EMMrOvlyxGCJhbCPrn8llF/TPaBvoKBsQoFjaninfAQK8jK2dw==
X-Received: by 2002:a62:9683:: with SMTP id s3-v6mr15099096pfk.191.1531679861358;
        Sun, 15 Jul 2018 11:37:41 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d23-v6sm62868178pfe.2.2018.07.15.11.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 11:37:40 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH resend] staging: gasket: gasket_open use container_of()
Date:   Sun, 15 Jul 2018 11:37:21 -0700
Message-Id: <20180715183721.190676-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use container_of(), drop unnecessary NULL check.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 20da6bdb7a73..4ac239c33ea3 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1088,12 +1088,9 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	const struct gasket_driver_desc *driver_desc;
 	struct gasket_ownership *ownership;
 	char task_name[TASK_COMM_LEN];
-	struct gasket_cdev_info *dev_info = gasket_cdev_get_info(inode->i_cdev);
+	struct gasket_cdev_info *dev_info =
+	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
 
-	if (!dev_info) {
-		gasket_nodev_error("Unable to retrieve device data");
-		return -EINVAL;
-	}
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 	ownership = &dev_info->ownership;
-- 
2.18.0.203.gfac676dfb9-goog

Resending, extracted from the previous stack of patches that needs
other cleanups.
