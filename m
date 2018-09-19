Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997DDECE567
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F462146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fha9ep2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F462146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbeITEAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:00:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34461 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733245AbeITEAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:00:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so3357982pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WirGS/aOSjVS/D7R/G1/ncvS7OJ05Sy4IF/d4iCNwD8=;
        b=fha9ep2Y2vw9rRqF09AyZZ8ZlWVXYyqZM5Q1h0q2YhrXNxungj8Mdm1ZHZySaVzJhc
         J+Ri+e9fLBrHNL2/yyYo0LthjssGM3j1zS4ucn4QdKyXKt7VlCj9ciQV4SZYwySjCJsA
         HGSoI8N3t286OoUVhOaHKirL8HjtFU3cDhem4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WirGS/aOSjVS/D7R/G1/ncvS7OJ05Sy4IF/d4iCNwD8=;
        b=fcGJNoBtL+KzMjcUOIE4Xb0PrfmHHJ5FJnk9Z4j96/2l0orm+dlSi1nNP5FjgxCBG+
         c3vE0hsy7d0A8ZmwNqBk2yJvMxOb8ljeTYHRiQ9UBWCJfv8c7JMqmCZsU2d1/I8Z5BVl
         J09ypXnyqYD/V2B02LwfcxsJd4PH+xLWP06UaUuYkN9rVRQ2B01KeDbi17PUPFFPNgKo
         Ll5ekcMzwBpHoMKTuE/qCzYXb7kJ+EtGmX9wUV2c+R9oNyIMJ7kWtsTAQ9EfArLkjrxa
         EWchUbehaFjDjEYDRaKSNqfTTb3EASH9CQOK0WtrnITqfUMNbPu/IFV7GDo1UXpNZSb0
         tFFA==
X-Gm-Message-State: APzg51CaAuUYMcMxYQ/CeoehL9k9pPrkZZSDHlpyZ6UKFhKns/fl6hxO
        VgQGuTjDarJOZuJFZKv7TbIyVA==
X-Google-Smtp-Source: ANB0VdYBlfUiAgO95AoyLc7rDgHGLPz2TRMUsI9I8ldKBN8RuVJtEU0WvP6A1zPXW4WEFouZExmthg==
X-Received: by 2002:a63:5204:: with SMTP id g4-v6mr33813789pgb.274.1537395651939;
        Wed, 19 Sep 2018 15:20:51 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id w16-v6sm53798471pfi.101.2018.09.19.15.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 06/12] OPP: Don't take OPP table's kref for static OPPs
Date:   Wed, 19 Sep 2018 15:20:25 -0700
Message-Id: <0ad8c623907c27f4b8572d36c4ba73ea103e3108.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference count is only required to be incremented for every call
that may lead to adding the OPP table. For static OPPs the same should
be done from the parent routine which adds all static OPPs together and
so only one refcount for all static OPPs.

Update code to reflect that.

The refcount is incremented every time a dynamic OPP is created (as that
can lead to creating the OPP table) and the same is dropped when the OPP
is removed.

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 332748adc262..2a6976265580 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -919,7 +919,6 @@ static void _opp_kref_release(struct kref *kref)
 	kfree(opp);
 
 	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
 }
 
 void dev_pm_opp_get(struct dev_pm_opp *opp)
@@ -963,11 +962,15 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 
 	if (found) {
 		dev_pm_opp_put(opp);
+
+		/* Drop the reference taken by dev_pm_opp_add() */
+		dev_pm_opp_put_opp_table(opp_table);
 	} else {
 		dev_warn(dev, "%s: Couldn't find OPP with freq: %lu\n",
 			 __func__, freq);
 	}
 
+	/* Drop the reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
@@ -1085,9 +1088,6 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	new_opp->opp_table = opp_table;
 	kref_init(&new_opp->kref);
 
-	/* Get a reference to the OPP table */
-	_get_opp_table_kref(opp_table);
-
 	ret = opp_debug_create_one(new_opp, opp_table);
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
@@ -1566,8 +1566,9 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 		return -ENOMEM;
 
 	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
+	if (ret)
+		dev_pm_opp_put_opp_table(opp_table);
 
-	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
-- 
2.14.1

