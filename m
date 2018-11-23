Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD8EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A44120672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJsKdtTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A44120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501978AbeKWQA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 11:00:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36387 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501910AbeKWQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 11:00:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so2829308pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 21:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrGF4Pn0d98pLUFr05KPUGiIPnRW8D0Q9xw+2xE4GC0=;
        b=MJsKdtTedsWF16VgfZJ+CUjONmM2B5JosVsewpkSkoIj0iHvMVIMyTGI7f9316OBwL
         09zV8tkqmhkLqJm0+X3POECtb86Q+3zDJrevm3s31mCCHrG+ywKV8ennAYzQdKaaNggu
         eVd4JDThnPbF+EkEbjLBvwSvz21g13Mi16o/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrGF4Pn0d98pLUFr05KPUGiIPnRW8D0Q9xw+2xE4GC0=;
        b=YYlrr5uto3Xqm4h3C7+W2getIAIdLifFQV8rUKTyMHJ5ZCrPvRXz2BD69M/TSXaUZp
         XGY/jnsxC8pS/G+d2vBBJXgHhpwA75R3gf9hflOii8bJsIzC167wvUPUwZ42gK89XiRO
         4o3XDizctg/VjUxMOVoHqD/dTr7hqqSXrq9BG6ezNZVfhpowsic8EgwNe1kw0R7QgNln
         A/KlFEB0i5SMxa0VZGAiWf91gzaIo4xzyIEfJhuIc9fNsS+FnZhGxOYE8+f1GF0TxjEM
         JKKU7aujYciecPPuM0GqZq/wzg7+VR2ZTQ47ICho445qIUd2gc86xlmzha5/ZaIB9n6T
         +SEw==
X-Gm-Message-State: AA+aEWb9Eu4h1XCrEYEEWHwDF6mEzFIPqkyvDqu/h/yAGgzqscDdnKtL
        MjuU87hwEN+xgGx9Fc+q5Z1EBQ==
X-Google-Smtp-Source: AFSGD/VrY+mgarUy2O6S7KKBaLUL5JK0TyicIkoOxaIGiSSROFUem9dfA3Ns+J2U3i+P0CxE6NKIdw==
X-Received: by 2002:a63:e545:: with SMTP id z5mr12769946pgj.195.1542950268056;
        Thu, 22 Nov 2018 21:17:48 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id i123sm34900075pfg.164.2018.11.22.21.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 21:17:47 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Fix parsing of multiple phandles in "operating-points-v2" property
Date:   Fri, 23 Nov 2018 10:47:30 +0530
Message-Id: <3e27c79c4b121a64e85f26ab8957e5d0a09ff28e.1542950247.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently return error if more than one phandle is present in the
"operating-points-v2" property, which is incorrect. We only want to
check the count of phandles here and set index to 0 if only one phandle
is present.

Fix it.

Fixes: 5ed4cecd75e9 ("OPP: Pass OPP table to _of_add_opp_table_v{1|2}()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 5a4b47958073..38a08805a30c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -579,10 +579,8 @@ int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 		 */
 		count = of_count_phandle_with_args(dev->of_node,
 						   "operating-points-v2", NULL);
-		if (count != 1)
-			return -ENODEV;
-
-		index = 0;
+		if (count == 1)
+			index = 0;
 	}
 
 	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
-- 
2.19.1.568.g152ad8e3369a

