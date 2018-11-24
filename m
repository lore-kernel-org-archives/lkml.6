Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A23C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAF621104
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifqjpRui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAF621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbeKXPwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 10:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731284AbeKXPwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 10:52:07 -0500
Received: from garbanzo.lan (c-73-71-40-85.hsd1.ca.comcast.net [73.71.40.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC4E2082F;
        Sat, 24 Nov 2018 05:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543035904;
        bh=hGNPsxBcuz5V5Q5yWcMr9PfILeRt9z8UEVP9fzetqE8=;
        h=From:To:Cc:Subject:Date:From;
        b=ifqjpRuiQ9JTBlVuR6pu5uHVSWPigTp0s8wpPIwCNidCSj6tFuNnV/jflCcOMIJ8m
         zjzkx+Kletdpm7XNQijAtomXgaaYlwVlEWi1Ew+rV7QcO5fOFthRJ3UJD51VyPyXTR
         ZIvcY69UULpWpDs/HEKqTGuBI0GbD45ldJawI7ys=
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org
Cc:     rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] test_kmod: fix rmmod double free
Date:   Fri, 23 Nov 2018 21:05:00 -0800
Message-Id: <20181124050500.5257-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We double free the misc device string twice on rmmod, fix this.
Without this we cannot remove the module without crashing.

Cc: <stable@vger.kernel.org>      # for v4.12 and up
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_kmod.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index e3ddd836491f..d82d022111e0 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1214,7 +1214,6 @@ void unregister_test_dev_kmod(struct kmod_test_device *test_dev)
 
 	dev_info(test_dev->dev, "removing interface\n");
 	misc_deregister(&test_dev->misc_dev);
-	kfree(&test_dev->misc_dev.name);
 
 	mutex_unlock(&test_dev->config_mutex);
 	mutex_unlock(&test_dev->trigger_mutex);
-- 
2.19.1

