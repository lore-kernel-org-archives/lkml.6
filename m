Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D58C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F04720862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQpurh9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F04720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbeGZXqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:46:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38424 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731521AbeGZXqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:46:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id a4-v6so2256728lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QfSMIH9qvOZIUIIIM+Fz4GDtMrQxsyQ5z5I74zumA7k=;
        b=fQpurh9FLoh8n3Y83/hZBzi6fQUlQ7w2l9v1uIFfRfoMfb0Q/8R3/3rwtsxJusjSkk
         ccbYRrfWEgtxq+VYPFSi3Mg1UHdAJW7Pv11G70Trumm/DeGOPkob7csFHPYMtbq53Wem
         z4M2fCnqEnwIPTLTtiw5FuWwrJ0MAS5BH27AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QfSMIH9qvOZIUIIIM+Fz4GDtMrQxsyQ5z5I74zumA7k=;
        b=LjPYBh/FZq8KwoFQtn6irgzHh6eCHteqjiaRK3YhWU1o8Qy3Kmhh5COi09gIekMBez
         efZE4JDNHvjKq5PZMntOXgO0GJDceSd04a4RUxnjaVMWut9G5L4tdq6Mx3eENozwhaxW
         tm0/tZtb+Ogrp9e9JhsuC9DH3Ku5KovhrNCHLK6M9yj3Ntn+aNJUs8M5ReKhZQbDtaOU
         gZVnqzMsgN9AgYd/Dz9fhny20szRVfeCIWQ3DG053uE+DfOw5edzagWCaBFDntEui3We
         1boDhjC8ELiXXR24PPFghzh7zPkGVnjFymjuxheHCfLHnNdfbtjBzbA1tvSGyW6l5ScD
         EVKw==
X-Gm-Message-State: AOUpUlE8HwhOst/ViQIaOBReES5UYbUV8jTVhxBUPLzl8wimiIDocBiw
        qWcWz0eHYgHpvxBgyoDBL9Am1A==
X-Google-Smtp-Source: AAOMgpfcXvl5BMF1ZLiZPLUJVPhsYNY2dxFLl86eMsRXVGBrX1YsrGuldsYFB9FTInxYKWsZgrw/Vw==
X-Received: by 2002:a19:988f:: with SMTP id a137-v6mr2592798lfe.128.1532644047364;
        Thu, 26 Jul 2018 15:27:27 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id h9-v6sm330480lfc.47.2018.07.26.15.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 15:27:26 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     gregory.clement@bootlin.com, sboyd@kernel.org,
        mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] clk: mvebu: armada-37xx-periph: Remove unused var num_parents
Date:   Fri, 27 Jul 2018 00:27:21 +0200
Message-Id: <20180726222721.5787-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building armada-37xx-periph, num_parents isn't used in function
clk_pm_cpu_get_parent:
drivers/clk/mvebu/armada-37xx-periph.c: In function ‘clk_pm_cpu_get_parent’:
drivers/clk/mvebu/armada-37xx-periph.c:419:6: warning: unused variable ‘num_parents’ [-Wunused-variable]
  int num_parents = clk_hw_get_num_parents(hw);
      ^~~~~~~~~~~
Remove the declaration of num_parents to dispose the warning.

Fixes: 616bf80d381d ("clk: mvebu: armada-37xx-periph: Fix wrong return value in get_parent")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 287e98a7cff4..499f5962c8b0 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -416,7 +416,6 @@ static unsigned int armada_3700_pm_dvfs_get_cpu_parent(struct regmap *base)
 static u8 clk_pm_cpu_get_parent(struct clk_hw *hw)
 {
 	struct clk_pm_cpu *pm_cpu = to_clk_pm_cpu(hw);
-	int num_parents = clk_hw_get_num_parents(hw);
 	u32 val;
 
 	if (armada_3700_pm_dvfs_is_enabled(pm_cpu->nb_pm_base)) {
-- 
2.18.0

