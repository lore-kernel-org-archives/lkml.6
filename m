Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2F2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55687206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBPlUGoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfAIJR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:17:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35130 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfAIJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:17:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so6720214edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRJXMxvFMWyixydozmc0U/Ai31AkqICeM57j02nd6jc=;
        b=nBPlUGoBCD2pQwnqhJQ2TFataT2S3cSl6A5z9KqLY6eTQClEryoN/hVZR6sKzJcDPZ
         Vy8WezGfEfeBgkzdCJFkLufqEbhYBY7rzISKV72DsSJkVpT5UBTXhq4bIc3xvrod4OMU
         1vDNdapSy1bOVq7x1TX6+Q1EbPM1G0TjBDKJTQyxsSWJNAeu99VaISBJZSPvp8BDDIra
         9zpFIaci+e8lQYJwl9AYaMpjXAvYigRwH/rb3iEpE18yTvLILdkn3igUEmspl+Iynmmm
         qMydthh8weHba+vZ2apbTcBt5rUZJbswV4Ti9m0NUM45t2M3Ew0BLfsWUMcvpJQkxZf9
         IwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gRJXMxvFMWyixydozmc0U/Ai31AkqICeM57j02nd6jc=;
        b=LzjM8aVK1XV/W2XWsp+WKpUA/07NaSkceFFi04DD/JS/WpjUFcSICeTB1mxpLuZd9z
         6tUYhx1VXTi0Fu7d00Tixageg1y0pKi8Qf4LKpJbcR71aSPLU+ZKpbeMz+TRk2hCWADl
         3IloW97GPy/nff16gLrfueMXMLpiSwg+0mBHG1Mn1Hf4pD497II+Nw0EOPf3U13lAgoz
         yDXNPpDNlRvWWENUv+MX0qtTEo8H+w00Qixtrq6oD7JYevGz+WEs1jT/cUsM47w+WBUv
         91Or/n/uBMUK2DmPSQUskiuDryUM36cvepOuRkzSDyp59MfVoJ8dhqiup26KVKHXLHx+
         58Lg==
X-Gm-Message-State: AJcUukcLHtQCrOtGxwn8bs71z+rfkT8vu3p1jAbd6OpVcA+d2ylm7Pyv
        PEzkcjThb0IzZAldzZZODRs=
X-Google-Smtp-Source: ALg8bN5LDXo7Y3TJzNyoM+P7fDxiMJglb/r3uGQWLvfN3uPfOP6jygDYlPrEE/NK1YmIQev0R9rIcw==
X-Received: by 2002:a17:906:a984:: with SMTP id jr4-v6mr4747029ejb.90.1547025474011;
        Wed, 09 Jan 2019 01:17:54 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id x10sm938160edb.58.2019.01.09.01.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 01:17:53 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        joe@perches.com, yuzibode@126.com
Subject: [PATCH V5 2/2] kobject: drop newline from msg string
Date:   Wed,  9 Jan 2019 04:17:48 -0500
Message-Id: <db8c353e82b944654fec17beb99d96bebff91864.1547024167.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1547024167.git.tsu.yubo@gmail.com>
References: <cover.1547024167.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently a missing terminating newline in non-switch case
match when msg == NULL

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
Changes in V4:
Recovery originly declaration, requested by Greg.

Change in V3:
Improve the commit log, requested by Rafael.

Changes in V2:
Drop newline from msg according to Joe's suggestion.
---
 lib/kobject_uevent.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index c87a96c4800e..f05802687ba4 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -200,7 +200,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 
 	r = kobject_action_type(buf, count, &action, &action_args);
 	if (r) {
-		msg = "unknown uevent action string\n";
+		msg = "unknown uevent action string";
 		goto out;
 	}
 
@@ -212,7 +212,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 	r = kobject_action_args(action_args,
 				count - (action_args - buf), &env);
 	if (r == -EINVAL) {
-		msg = "incorrect uevent action arguments\n";
+		msg = "incorrect uevent action arguments";
 		goto out;
 	}
 
@@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 out:
 	if (r) {
 		devpath = kobject_get_path(kobj, GFP_KERNEL);
-		pr_warn("synth uevent: %s: %s",
+		pr_warn("synth uevent: %s: %s\n",
 		       devpath ?: "unknown device",
 		       msg ?: "failed to send uevent");
 		kfree(devpath);
-- 
2.11.0

