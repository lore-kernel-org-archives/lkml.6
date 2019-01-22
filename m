Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BFFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CC3217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170632;
	bh=1Aj3YCEataN9QBHBaY/Us+DbXKs7RxzlYEOjTLFBVVU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=m3kzybRWBQACESilcceKjlVxSgThVF4iPojG9Tvl5HkcNAF5P+DPrwoKmCfTZi831
	 G0FRGVbdA6lTqTXzA8txMfacg8C6T/7dLc367EtHWvEcibju2PBHkI6UAzmqXkM5xd
	 OVyQL40aHMGyg6WxU07A+Hem5xwQhkX6yyvViyQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfAVPXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbfAVPXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1104217D6;
        Tue, 22 Jan 2019 15:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170628;
        bh=1Aj3YCEataN9QBHBaY/Us+DbXKs7RxzlYEOjTLFBVVU=;
        h=From:To:Cc:Subject:Date:From;
        b=sGRWCi0/M8EIlfFmxt0IH6UwnrJzhC2QA6xC9YoGFfvJ5cDS/+WqIVlxglj3jvkPc
         tgtvJ8bcSU1YAh0XyK0Xfda5uAnuN3WXsXBNEQ1E9qLaNpyubkQoWFxPH7JnmvoP/8
         xT9Gnqnc9hD+JkKn41zNSAvAGWmFd0wA9MogrudU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: qos: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:47 +0100
Message-Id: <20190122152151.16139-48-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/power/qos.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index b7a82502857a..9d22131afc1e 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -582,10 +582,8 @@ static int register_pm_qos_misc(struct pm_qos_object *qos, struct dentry *d)
 	qos->pm_qos_power_miscdev.name = qos->name;
 	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
 
-	if (d) {
-		(void)debugfs_create_file(qos->name, S_IRUGO, d,
-					  (void *)qos, &pm_qos_debug_fops);
-	}
+	debugfs_create_file(qos->name, S_IRUGO, d, (void *)qos,
+			    &pm_qos_debug_fops);
 
 	return misc_register(&qos->pm_qos_power_miscdev);
 }
@@ -685,8 +683,6 @@ static int __init pm_qos_power_init(void)
 	BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
 
 	d = debugfs_create_dir("pm_qos", NULL);
-	if (IS_ERR_OR_NULL(d))
-		d = NULL;
 
 	for (i = PM_QOS_CPU_DMA_LATENCY; i < PM_QOS_NUM_CLASSES; i++) {
 		ret = register_pm_qos_misc(pm_qos_array[i], d);
-- 
2.20.1

