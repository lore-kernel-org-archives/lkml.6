Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B693C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37F7218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfBFSuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:50:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34623 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfBFSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so3301680pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 10:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQbxrapc2NPnl+P0Ls8p326l329nCPDkPd21a4zaEEI=;
        b=uWDmKirEOJ7xSwgM4Z749YCN52ApoQozqjAEuK6PnZAbapQxRhUBRroCCinGzFUh9P
         Z4fGB1xw08XKY+z0pRazskX5LD4+ORcxTD1td3shB2wKO0EtZNnpIDeR/vd86UYRlS2r
         aSWeoRFxMdGl6iyTscmojod84VJLEpe6kabdGmcedtzFtzxx9AFpdNXA0uqsHPOD/5fb
         O6QWW8XkoDrWnXwjKKVweuie41s1X+Amk1OcBUuyPspZhgg+RiA5TwV/6doFRsz+yOWb
         o+R6fwbWOFTES0n/tpAkdb98lnwUB8uTY5CZG4eHFYSPKaZ2HWMVkfrluX5G0H5SsyUA
         2CMA==
X-Gm-Message-State: AHQUAuYVddFJE2/W96hMljRkgUdZ8S6SZSY0yOR9HytZHXv0jv9f/Fhh
        WdWN/48ZQ1Y28np5nmDqgHa8wg==
X-Google-Smtp-Source: AHgI3IafxK7A45j7DPk2dDGMnhfEgfmvvN1wJQ5fhQLgtS8AFXMRxB/QDJlbg44k6TcxL6vBpcS/KQ==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr694144pgj.410.1549479019745;
        Wed, 06 Feb 2019 10:50:19 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d21sm10393015pfo.162.2019.02.06.10.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 10:50:19 -0800 (PST)
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
Subject: [PATCH v2] cpufreq: mediatek: Register an Energy Model
Date:   Wed,  6 Feb 2019 10:50:04 -0800
Message-Id: <20190206185004.54779-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
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
Changes in v2:
- register the EM after setting the cpumask
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index eb8920d398181..5250df762814e 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -465,6 +465,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
 
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	return 0;
 }
 
-- 
2.20.1.611.gfbb209baf1-goog

