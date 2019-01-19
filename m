Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A43AC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9AD2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwyJrhRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfASQFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:05:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41268 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfASQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:05:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so8081808pfi.8;
        Sat, 19 Jan 2019 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HhgKdS56P2I78qNU/oYmWmiGlWeN03CHUf47z15UwlQ=;
        b=AwyJrhRcycp3KuhCxqymWMWG4P/3y7ES2et1N/KSI7Q6acV3/v86UsWf0q7dPc9oqK
         h/t8Hkf/rKOvHlFC8u57RCEvdAf4N+FhIxxkc3dQCZdzKkGnUzL46j2Khiuk1htCq5Nz
         XyX586/6fqX1GkXGMd9UxAaWZryHkAl7L/kqIkAanli2luotXH3rnV+ECAWjOzv248JE
         UITSxcB50ablV5ifPYHPHTkc1aHuZoK61elryoXAebL2iV9mPeLj+nNvJ5CEgnJZ6rku
         yiN+lTQVH0NGNeUMLanN0Uj0Tth+t63oAJaIjjOEBphbSV/1IOuP23bZ1eW50ku04XBM
         +Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HhgKdS56P2I78qNU/oYmWmiGlWeN03CHUf47z15UwlQ=;
        b=HAAfmbYzVCX1TGWw/6XHRVxtVuMOANSCuYpFhx08K9w/MeznrHkxNIH8AavUX/vJln
         CDbRUy33ig1exFXTy1ZqukSG7YkG01PHscUGvcyZgQWehCbSEhBTyAHxY0pCENTpMQEE
         42ZHcMFtbQs/E12U/6rb7uXVIAOLMgDOZPLsp0Mo5+bc+bqhX8NPESMiBEb+MUJjT0T8
         tC0kS0xlV7jHR2lyIh9s0vc+l+6l40KHvxjkLwDibOrLWZdn/2OQxEZIqmPbchsoXxvy
         OiFQS9NSwrLuYmlVKNF6S6VAmNyGQgNtbNkrZTE6qEm81WtOHDYHqA+o6ImtQ5SuD7TG
         89oA==
X-Gm-Message-State: AJcUukdVQQraGGNA3RjxHRy65D3/RbozvEe4ZlOL+Zf+Tj7lCeXvg2Jh
        /daBJEv9QKZ2n2I4x7UJ54U=
X-Google-Smtp-Source: ALg8bN4hcF2k73qHmyD9Xg/fa1MNSQwFmyuViDni0ZxlQdY0JLtf9cvTC/cnLHGOM8MVhKDmiqOX7g==
X-Received: by 2002:a63:1321:: with SMTP id i33mr22322084pgl.380.1547913902761;
        Sat, 19 Jan 2019 08:05:02 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e187sm10850686pfa.130.2019.01.19.08.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 08:05:01 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/3] PM / devfreq: fix missing check of return value in devfreq_add_device()
Date:   Sat, 19 Jan 2019 11:04:53 -0500
Message-Id: <20190119160454.23151-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190119160454.23151-1-tiny.windzz@gmail.com>
References: <20190119160454.23151-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kzalloc() could fail, so insert a check of its return value. And
if it fails, returns -ENOMEM.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/devfreq.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 076b1c2f40a4..923889229a0b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -688,10 +688,22 @@ struct devfreq *devfreq_add_device(struct device *dev,
 					    devfreq->profile->max_state,
 					    devfreq->profile->max_state),
 					    GFP_KERNEL);
+	if (!devfreq->trans_table) {
+		mutex_unlock(&devfreq->lock);
+		err = -ENOMEM;
+		goto err_devfreq;
+	}
+
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
 					      devfreq->profile->max_state,
 					      sizeof(unsigned long),
 					      GFP_KERNEL);
+	if (!devfreq->time_in_state) {
+		mutex_unlock(&devfreq->lock);
+		err = -ENOMEM;
+		goto err_devfreq;
+	}
+
 	devfreq->last_stat_updated = jiffies;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
@@ -725,7 +737,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 err_init:
 	mutex_unlock(&devfreq_list_lock);
-
+err_devfreq:
 	devfreq_remove_device(devfreq);
 	devfreq = NULL;
 err_dev:
-- 
2.17.0

