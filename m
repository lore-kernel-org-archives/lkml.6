Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81A5C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8979321473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aO9aKLH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8979321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeJDLII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:08:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46064 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeJDLIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:08:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23-v6so2689797pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 21:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3QJUvhl8nGSVXoryOyi2C2kj4Aa4ByPO+MXzdk10tAg=;
        b=aO9aKLH2SfmEOHKra6+bLGLaNm9o7XO34U2tZaF3phoKTqJa7DuOY5Cr0zV0Fsa+yx
         2gkJL2LgOog5CJXmQ0TbbJDP6C2tQMsZajIPaR4O/53PKLArqSam6X4WTD715Ojs4zpT
         K2WV/NA3s2Xs+3h9OxbSbX6zWSlxczsMLd0+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3QJUvhl8nGSVXoryOyi2C2kj4Aa4ByPO+MXzdk10tAg=;
        b=GCM/Vi2bzgce8xO5+mCj4IFP5cVrAPSHyNCqUzk/vE1ThknZBiyXl5naIZu+iqPrsu
         z9vqpD2XA7YN3GA1EbX4M/k26ltCdpLfi/H3YdA1YTjHTPblojAjvxkcjXAOrikLi4qQ
         vJjIt6jNtywfTt0qL0gIMf3twQdLnO5Uev797FLfzwp5I5eGztpB4C/+TIKsugRFy7Hb
         uN57RblJFHfrXOb1CKYSyzas8MwEygeDwE7ouWFU4LahTXMZmueCmnugn5WK0BmirQZ1
         RtuXERKSVXZOzJoe36uz4FCLnMwqZloiFKFDPiJPyYetVPZZnFWrQhe/PWzsdD+9QXeU
         c7Hg==
X-Gm-Message-State: ABuFfognmaZEf3y/PNo4M+3dpqBe7J9znzxoNjuCBZ0iwa6MyG2/7CmZ
        m0uLl6P0DDUakrDjQ6PPCaDyPQ==
X-Google-Smtp-Source: ACcGV600D1JW9sb/lzcvFxeZjc9+j0Vjv0Fwp3kmOaVvbtmxz87XuA+86gTA+y+V4Oa1JqjfBfU6RQ==
X-Received: by 2002:a63:f80a:: with SMTP id n10-v6mr4069559pgh.57.1538626608560;
        Wed, 03 Oct 2018 21:16:48 -0700 (PDT)
Received: from localhost ([122.172.76.11])
        by smtp.gmail.com with ESMTPSA id k86-v6sm446236pfb.167.2018.10.03.21.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 21:16:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        d-gerlach@ti.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] OPP: Return error on error from dev_pm_opp_get_opp_count()
Date:   Thu,  4 Oct 2018 09:46:21 +0530
Message-Id: <09f662f95306f3e3d47ab6842bc4b0bb868a80ad.1538625101.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1538625101.git.viresh.kumar@linaro.org>
References: <cover.1538625101.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return error number instead of 0 on failures.

Fixes: a1e8c13600bf ("PM / OPP: "opp-hz" is optional for power domains")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cdf918aaac34..2c2df4e4fc14 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -318,7 +318,7 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 		count = PTR_ERR(opp_table);
 		dev_dbg(dev, "%s: OPP table not found (%d)\n",
 			__func__, count);
-		return 0;
+		return count;
 	}
 
 	count = _get_opp_count(opp_table);
-- 
2.18.0.rc1.242.g61856ae69a2c

