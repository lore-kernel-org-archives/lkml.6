Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F188EC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9B920811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfBERws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:52:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43931 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfBERwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:52:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so1688083pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 09:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lE5yLqTeGGzTuTS9U9D6qCeOCCp6sDjOXNtuvEolMxk=;
        b=LsGbOzWZ5u4ixB0/FfjVgAisoP5ueRAT97xbzSdM0N+vcoD43Fefq4pWP236tAFiS8
         3Y9iJpORKqf+NOtfJ5a3emu6DuRgFqoujtJhNT4kkRuRKmOTLPwgdmb33BKkaXhVbnvi
         QmnUzRwmTEjDxehNSF2OwJjn77CUZfxmKGg6zaH7G201GQCv4/L/66p38Z9WtuHQqIjo
         hgP0DKySyWXwFrg06xTpPu8jdb+kaC+sUqL/qd17z28Li6QE7f5vkG4L62y/69lTW3O/
         eWkVDU+6n6iNs/R8aX7P1onq2NOlMBQKiBqUjugPeSkBzc3G9gg+QaH6mJmxPEkkXOAv
         uwIg==
X-Gm-Message-State: AHQUAuaddLoKJX1630JdfqRd4JCZ4ORQje98ccEHzKGgcUPVoFqPPxr6
        RtEaBzteUbK7pIvH1fHMDnT/Eg==
X-Google-Smtp-Source: AHgI3Ibt+4FhFR95YadQ/0Wt8EUUFAo7LV3Q9O8AHSTCYnFhrRQqz1N2Dxc8bQw0LXsxw7UzzitZqQ==
X-Received: by 2002:a63:571f:: with SMTP id l31mr2796053pgb.91.1549389163752;
        Tue, 05 Feb 2019 09:52:43 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 85sm6030280pfw.17.2019.02.05.09.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 09:52:42 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Quentin Perret <quentin.perret@arm.com>,
        Taniya Das <tdas@codeaurora.org>, CK Hu <ck.hu@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] cpufreq: mediatek: Register an Energy Model
Date:   Tue,  5 Feb 2019 09:52:25 -0800
Message-Id: <20190205175225.25923-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
In-Reply-To: <20190205175225.25923-1-mka@chromium.org>
References: <20190205175225.25923-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try and register an Energy Model from mediatek-cpufreq to allow
interested subsystems like the task scheduler to use the provided
information.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index eb8920d398181..e6168ee582783 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -460,6 +460,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	cpumask_copy(policy->cpus, &info->cpus);
 	policy->freq_table = freq_table;
 	policy->driver_data = info;
-- 
2.20.1.611.gfbb209baf1-goog

