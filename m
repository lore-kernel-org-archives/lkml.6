Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DADC6369F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673882087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUUR1vXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfASFDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 00:03:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35048 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfASFDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 00:03:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so7247560plo.2;
        Fri, 18 Jan 2019 21:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3/Snpyih4xmGjMkVJWyCg5M/HlR3AsZUTEyMtROheFs=;
        b=tUUR1vXgU6yrt+lnrhISmeP5/mYJQTF93vr/8lBKsbLt8fdvNWwHTiS65iW8wGP0uF
         wxG9G8NPdsXh4EBneNMgP+QIS96pZsKWcbYnnBuU9+19ES1RGMfB04l70JsHNllWuE8r
         CY9OlzNpQ6q85lbtTHNORSMae2YiFxjVF7vy6hE8a07W5JpTck9syd+CAWxfn//VauCQ
         DrjSF1FHe16tdTXKfIVagP/h2oyrRnYdkFLnClFi8nF5QMrWi51RNO/IjFhLVNfexpBN
         WwO/RKoZ2jb8lUSWqwe3nQGKxGQdPjKzDaR4aT3bI2E0bDiw7CikoRPxozBcEOPi+RVp
         a3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3/Snpyih4xmGjMkVJWyCg5M/HlR3AsZUTEyMtROheFs=;
        b=mvsK1tKum2t2yzXMtT4fdBjSRWbg6z7GP4fSzqIYh1W5UrrG3dh9zBnpyzFmNkPILJ
         5H/hszCbzrUhev0POJybZpemrNZaTeSVeaw29R1L4p4Z693ke8ZWTznPHjrKGFKd/hR4
         iXY3Xrg4/wXQfn5Vt7+33K7DfPT+/jQuepzy/qytxlh18HG/XrIb730EQafOVqbck/fN
         pd/8WlAqCMJZvQulvU16YDuaYOU9CdrtXLjQni980CC40q2yB2GBz4nCmW2SFP6XIwuL
         /XhVDXqCueg4wBUVIy1DpIoPWyusGeu+Wdn8uvwy4E0IaUvEwn5YdvK6YR3a3v3lKEmA
         hSXg==
X-Gm-Message-State: AJcUukcIjfi+CrEuzcp7DYIlE0o5VtLKhJhGmDj+BoTiF/tWCf1gfQG6
        W+vbuFQjj8d6mpgohiAcm0U=
X-Google-Smtp-Source: ALg8bN48Jl4XN3jmzmPrOsiiYNsMtE6dLa4lFUkl8PUZ2zmOMlqlOLbNTFXiCjXEK8iGVpurXftWQQ==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr21782414plz.110.1547874179505;
        Fri, 18 Jan 2019 21:02:59 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 4sm8040214pfq.10.2019.01.18.21.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 21:02:58 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / devfreq: fix mem leak and missing check of return value in devfreq_add_device()
Date:   Sat, 19 Jan 2019 00:02:56 -0500
Message-Id: <20190119050256.22520-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'devfreq' is malloced in devfreq_add_device() and should be freed in
the error handling cases, otherwise it will cause memory leak.

devm_kzalloc() could fail, so insert a check of its return value. And
if it fails, returns -ENOMEM.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/devfreq.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..fe6c157cb7e0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -651,7 +651,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
-			goto err_out;
+			goto err_dev;
 		mutex_lock(&devfreq->lock);
 	}
 
@@ -683,16 +683,27 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table =
-		devm_kzalloc(&devfreq->dev,
-			     array3_size(sizeof(unsigned int),
-					 devfreq->profile->max_state,
-					 devfreq->profile->max_state),
-			     GFP_KERNEL);
+	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
+					    array3_size(sizeof(unsigned int),
+					    devfreq->profile->max_state,
+					    devfreq->profile->max_state),
+					    GFP_KERNEL);
+	if (!devfreq->trans_table) {
+		mutex_unlock(&devfreq->lock);
+		err = -ENOMEM;
+		goto err_devfreq;
+	}
+
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
-						devfreq->profile->max_state,
-						sizeof(unsigned long),
-						GFP_KERNEL);
+					      devfreq->profile->max_state,
+					      sizeof(unsigned long),
+					      GFP_KERNEL);
+	if (!devfreq->time_in_state) {
+		mutex_unlock(&devfreq->lock);
+		err = -ENOMEM;
+		goto err_devfreq;
+	}
+
 	devfreq->last_stat_updated = jiffies;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
@@ -726,7 +737,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 err_init:
 	mutex_unlock(&devfreq_list_lock);
-
+err_devfreq:
 	devfreq_remove_device(devfreq);
 	devfreq = NULL;
 err_dev:
-- 
2.17.0

