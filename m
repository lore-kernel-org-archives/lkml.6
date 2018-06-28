Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239FFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFACF25D63
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ha83AOvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFACF25D63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeF1Cd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:33:26 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41475 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeF1CdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:33:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so1976394ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 19:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5Ei8DfUbEj09xKrPzL9OuN846n3Yz2bUT6zLG6DznuQ=;
        b=ha83AOvDWC60d7qhTitImB8kHqm52M8oEFIhq4PGUaniUa33OgGdTTwMDVtl/O6nyi
         fbJ9JvsZlbcSyhQN2TEH/hfJBnORVp527dTWbPNKwKRrJFG1JxMAoRso27AWknaWsnAQ
         lQ/NPs/8P9VGbPT8/Pb5h9xfHxcGl+xblEbCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Ei8DfUbEj09xKrPzL9OuN846n3Yz2bUT6zLG6DznuQ=;
        b=fkZo7hwps83vJKDn5vbp30joQDVwlUHTKdBp9p9+Gms5KVNt8yZ90g7vbnP4DCckeu
         DPV9BnQVvIa7+ZKRwRqKm4zxdMtJQitDkBFVp5lM3cQ9lsV31E+ulABPk+Z5bjZdISDi
         DbN+SbIZYK+Ll2FCUDJ8A8rODk1ZHGAp18SnlvX0K9GQ6e+gLNJALeGX0tmgHxyX4VKT
         N60kYKkN1djxj3uDm2ZWPxzO4JEyYwAWDoBsz+ahCP0mufa4MRwhN31X+zEbz2mK6qW2
         D+XTDn7htFbsPPg/DQhRT6/2vkT1a1fbVLaFxkdLfE/4rh39uq1oOfG5w383Uyf0O2/E
         dVLQ==
X-Gm-Message-State: APt69E2jNqS70gtZZL0Njph+zlYfEE6DJSyoFs2I7UC1ALsSFe9lYpxq
        0Ow0RpQYWI+dnlN52U2vbEOlng==
X-Google-Smtp-Source: ADUXVKJT0MV+/OGbIJumTfurvbtaYAIO9SRADzmNiJ5kxvC9r/zXVrA+908elIHTFJCgmBkVriV5/A==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59-v6mr8370387plp.36.1530153204170;
        Wed, 27 Jun 2018 19:33:24 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id n9-v6sm10139289pgu.77.2018.06.27.19.33.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 19:33:23 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     broonie@kernel.org, dan.carpenter@oracle.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH] hwspinlock: Fix incorrect return pointers
Date:   Thu, 28 Jun 2018 10:32:21 +0800
Message-Id: <782fc498b4f4c6e8130d64face93023eb3dc9866.1530152980.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 4f1acd758b08 ("hwspinlock: Add devm_xxx() APIs to request/free
hwlock") introduces one bug, that will return one error pointer if failed
to request one hwlock, but we expect NULL pointer on error for consumers.
This patch will fix this issue.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index e16d648..2bad40d 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -877,10 +877,10 @@ struct hwspinlock *devm_hwspin_lock_request(struct device *dev)
 
 	ptr = devres_alloc(devm_hwspin_lock_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	hwlock = hwspin_lock_request();
-	if (!IS_ERR(hwlock)) {
+	if (hwlock) {
 		*ptr = hwlock;
 		devres_add(dev, ptr);
 	} else {
@@ -913,10 +913,10 @@ struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
 
 	ptr = devres_alloc(devm_hwspin_lock_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	hwlock = hwspin_lock_request_specific(id);
-	if (!IS_ERR(hwlock)) {
+	if (hwlock) {
 		*ptr = hwlock;
 		devres_add(dev, ptr);
 	} else {
-- 
1.7.9.5

