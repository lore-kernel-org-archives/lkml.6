Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64072C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346AD206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KxlJt7VQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfAGG7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:59:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45361 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGG7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 01:59:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so20310596pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 22:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPcQQ3g+VFcLyuhwjnxAyzEpHmVwskJ1oHM3n1Kx1ls=;
        b=KxlJt7VQvW8gSUxmmibJiBl+6oBaF5cV7NHkopfC7jQgfmUlPcQ4xmPvePXaoTjNW1
         WiHIIYt6/bt7UWZEEyBIWmxbiya1mYyoLde1avWUX+gMPvFSSUbOXZAYmAmN1j19Ecif
         sLj1lT/Ondkx2oziZ2PnlligrZW7o9UQzrlk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPcQQ3g+VFcLyuhwjnxAyzEpHmVwskJ1oHM3n1Kx1ls=;
        b=JJD3klB+P9unoOEJAnsZ1yE56mj+v22/7jBWLWO1Ig67I0q94901+O5F3SYyZboWIB
         86qsO72UAv086qmgfLPQnZFc0IeM9/14WTt1FbHkeEXTGE6qRi+SmdhQFsO8EZpjIxwr
         Eqja8gwYlU8SQS9E1/dZZdQROqxuA1p0mru0uZFFXOVrjHQBiZGB+iQXuj0LqDE8EwB9
         msrhI1U7XvWrVlAZ+FR/Gu+6z9b6/SmxN5RxRMDz5oroS/0GtOS9kNI0ZZwHG616nTa+
         NnJOVLeakwd99yuTDHW2cF2AAFrZGnLotsYxoKAw2JIoHUAGadPIP9sfTGb2hpyvBYNt
         VRUw==
X-Gm-Message-State: AJcUukc9D5aqXKtvm1xSQDAjPpPzonhYH5cD7DR1agUQvjPgO4aE6t6j
        jXgIRxfUjixfNocaZDjqvcQHFg==
X-Google-Smtp-Source: ALg8bN7P7n+53nMd07uwhlI+CcnkCohOY1YCqjcQHQHrRcFeMSQD/jFFPzCkUOdc12ADAt/Q0UCxYA==
X-Received: by 2002:a63:f615:: with SMTP id m21mr10174823pgh.428.1546844340557;
        Sun, 06 Jan 2019 22:59:00 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id h129sm117827620pfb.110.2019.01.06.22.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 22:58:59 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Don't update new_policy on failures
Date:   Mon,  7 Jan 2019 12:28:54 +0530
Message-Id: <af05a5d2d3ef76402f54448a66cbd20ee98bceb8.1546844324.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable "new_policy" isn't getting used in the error path
since the commit f9f41e3ef99a ("cpufreq: Remove policy create/remove
notifiers"). Don't update it in error path.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7aa3dcad2175..9a5f82ef40e8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1305,8 +1305,6 @@ static int cpufreq_online(unsigned int cpu)
 	if (ret) {
 		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
 		       __func__, cpu, ret);
-		/* cpufreq_policy_free() will notify based on this */
-		new_policy = false;
 		goto out_destroy_policy;
 	}
 
-- 
2.19.1.568.g152ad8e3369a

