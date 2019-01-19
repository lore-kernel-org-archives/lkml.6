Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07A0C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F2A205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spm1FEZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfASQFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:05:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36982 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfASQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:05:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so8098545pfb.4;
        Sat, 19 Jan 2019 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=igiS7JY9Tkj0t+DmCwo3tZOgXVjRsJpaBhsfH2U83Tk=;
        b=Spm1FEZb+BK5b0ThVBclsti0DUS08YWPw4T5H4EbwM6l0I3ScjPqv4jE/JZ+7I1It2
         EdlpVdKqoRFsTWVjQQ8c1PXS6yXo3Lr9dcuMRODmWaRs5ZIc2etzR+G0TFSkQ0Mf0rE0
         9L+SjcFvyjxrvE1P5+e7H55VgSRbHDkSBzimKHPCANYkFdC8khrqVRzT7W5mrDr0DO/B
         Tqy85FcB5a39A478ur0RjWSM17+NrSgyvgnOwEp2fMg0NSnoEXoropi42gpxhWUWnGhy
         tWJ01tt3sekFXdvxGSt2D68Jl5SYjaHZVliJ6TrfW3JeqRBo+8F6RajHkTzhJpK8VL14
         G+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=igiS7JY9Tkj0t+DmCwo3tZOgXVjRsJpaBhsfH2U83Tk=;
        b=SWQ7C2PdNsNur5y7cGJGWr47Obs0gLKbhc9TkCI6IUmYSW9yUJS59NzkCxajs65KVg
         L9lLhpEY4Ps3VgFDfxDatxMM8nu9f02wzVW2Bm3Ywr3kf3OtnshWX6OJKKsiMY32YC8W
         TkUzCw5mRSOV8icsPOrQWlgxkwDZoGjHCtVESSBYcy+UUe0drj8jLE+djGSQbPl3imeS
         wDTIbgWvN61xzWblgQ/df9gp3PTeHlAn2tqFKmQd17kpagToQtf533Rz8OqMcMCd9ilB
         zEGy08xF1PXI8EBpDJMXRV8vYluPIflcLvKsQBjJSw8yJKozl8PgKxiNroVohr1r8DeF
         fw1Q==
X-Gm-Message-State: AJcUukcArwHuby9I6JL0gLlz26xMNMmDkSWJyEoddKszTolAYghXbQym
        9Xzipmw4A7aQEGsQPf7/SLU=
X-Google-Smtp-Source: ALg8bN5PjATru91+wMlLSq2l4BO4hRMODmPEfcYUsM+BFmU6sD88cDBIUruZ9x9SFsS011ovFvQIlw==
X-Received: by 2002:a63:2c82:: with SMTP id s124mr21491137pgs.73.1547913905322;
        Sat, 19 Jan 2019 08:05:05 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t5sm15786032pfb.60.2019.01.19.08.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 08:05:04 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/3] PM / devfreq: fix mem leak in devfreq_add_device()
Date:   Sat, 19 Jan 2019 11:04:54 -0500
Message-Id: <20190119160454.23151-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190119160454.23151-1-tiny.windzz@gmail.com>
References: <20190119160454.23151-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'devfreq' is malloced in devfreq_add_device() and should be freed in
the error handling cases, otherwise it will cause memory leak.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 923889229a0b..fe6c157cb7e0 100644
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
 
-- 
2.17.0

