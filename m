Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7099ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F34521523
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXitjeAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F34521523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeITEAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:00:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41893 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeITEAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:00:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so3343686pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/7A+jgDIUZCGxGLhoGYTieLMUMpj5eaMcqaxJhDr4YA=;
        b=BXitjeAafq8N0RjL/QUGy9m5AifOy3d1uuIkG/hOfeQrnNf1WzTljTy2lUbyaBJPfO
         KWqpu6n98jyuWmA6R4w0PI0OnZNlmgjAe6EbRFKFcFfc9UYON/AX0QI+KcTeF2k123a9
         dNbuUEn9RMaKtaFqrXV+FqWr/1kr/Im2EfI5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/7A+jgDIUZCGxGLhoGYTieLMUMpj5eaMcqaxJhDr4YA=;
        b=bjc0rKBmEH9u/MOLxA2YpCKcdjzTTpmXKeYcccQ47LDIoBlaJpfIpfU9JWgOHrO4qJ
         wRreMb5w+dZsEtt9ctx8gl7SJU0ItAJB0XeH7sMruoka6PIEf8vkBbBk5YRemJ7q3P9/
         IrLvkizu7/bRnAA29j14s8GgtOtf2l566KJlV3eHnF7vzUhvH9/cGLcI3fViFOQQ8t+R
         Bu9yBB+748QT7EWWvomlK2UFjrRLwxpyoNjPxC73sRu9uN4ZH1fLWIrzXizYxZC1WB5F
         kdPWchpaf+f6mSCNnBR203yljf0SpoFU4bxvp+mj4oQOPMtsLtPGcDT4drD0ZMBdddOH
         o7pw==
X-Gm-Message-State: APzg51D4v5QYkwAwHZIH30YWOv9S7ceacgMGR4oHoAP4Ku4gmICHX6fQ
        65jlhblPuMfUWezA4YF7dCIdnA==
X-Google-Smtp-Source: ANB0VdYoOb/IDfKIIbejCcQMN92UlhOUzEVXI/WLLAFIsZoi93FrFweNXjnxTo7Y0Njtsls2q1pGhw==
X-Received: by 2002:a65:5284:: with SMTP id y4-v6mr32790902pgp.283.1537395644376;
        Wed, 19 Sep 2018 15:20:44 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id f13-v6sm21489306pgq.63.2018.09.19.15.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:43 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "4 . 18" <stable@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/12] OPP: Free OPP table properly on performance state irregularities
Date:   Wed, 19 Sep 2018 15:20:20 -0700
Message-Id: <2fbb8670b4ff4454f1c0de510f788d737edc4b90.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP table was freed, but not the individual OPPs which is done from
_dev_pm_opp_remove_table(). Fix it by calling _dev_pm_opp_remove_table()
as well.

Cc: 4.18 <stable@vger.kernel.org> # v4.18
Fixes: 3ba98324e81a ("PM / OPP: Get performance state using genpd helper")
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 7af0ddec936b..20988c426650 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -425,6 +425,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
 		ret = -ENOENT;
+		_dev_pm_opp_remove_table(opp_table, dev, false);
 		goto put_opp_table;
 	}
 
-- 
2.14.1

