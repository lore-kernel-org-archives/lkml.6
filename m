Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D951C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4226920839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cp/5Dlox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4226920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeLLK5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:57:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35244 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLLK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:57:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so8712279pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LwDno6pPq3+62WWHDum9qZ80rXO5n5aGPdUmxZHq/s=;
        b=cp/5DloxzSyYYKEYpPoupB7nKkWCn4Y797pFKu1xK54mYGiDFdvKKl5Mc6insysd36
         dQIJINwWf2ynGwlxCPYmYwBERSB8Z1gGGj1N3qcA3KYKgNFYtEd5HbhuxjvLuZRdswVR
         WaWiqyaUOC+dzreOlCz1L92A1pAlDQvAHmFMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LwDno6pPq3+62WWHDum9qZ80rXO5n5aGPdUmxZHq/s=;
        b=XSz/of3QCWfiMWvco9tmGGIv+zhbyALumUl/Hl53NMOrkHhRausZja3DI6JlzrO7mT
         cxYH7u+0OHfVfvlLGVyptwsNF3N2fuxi/ACNvDTNVY+DXb6yxFCgXXRc4AheP98R6vOk
         mH3EFDXxN9TBDY3ez+jpFNPB6Hvqji9+hi8SpRw72jTtBhnKv/gui7pU+5SyzGtZ7ZwJ
         7gVd3Ozt/pflmW5Np5WyUF8EdMcCypMJozMa0WrpG4tIPjgGGJ0O5O4HByWPwXSiFp4l
         bYDlXFkNqYrLcjrC/i0WzMAMyjNm8Lpc7Lu+e9/y6rsoLP0U1a8CdxqY/VMhhVROf1Zj
         yIOA==
X-Gm-Message-State: AA+aEWYITSsR1Bkv3V/95FUzB8J3L8SMwPPbi0cGZKEVlSjoR6bj/+o0
        2IHclGzejNRltFaUbubqlrHD/A==
X-Google-Smtp-Source: AFSGD/Xoa2R5QFFdBRMOAhcvoUCOBPteC6bQPZ0pUoMmXRgIQYe7g1t3R5JquUK3oa6CtIZ8QmLYRA==
X-Received: by 2002:a63:7c13:: with SMTP id x19mr17597162pgc.45.1544612272831;
        Wed, 12 Dec 2018 02:57:52 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id 4sm38982244pfq.10.2018.12.12.02.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 02:57:52 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/6] OPP: Improve _find_table_of_opp_np()
Date:   Wed, 12 Dec 2018 16:27:25 +0530
Message-Id: <184bbc28f982752cc040f0b9286516c3897e2808.1544611890.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544611890.git.viresh.kumar@linaro.org>
References: <cover.1544611890.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make _find_table_of_opp_np() more efficient by using of_get_parent() to
find the parent OPP table node.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 3ef7f38c0986..8e57d257be77 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -114,19 +114,25 @@ static struct device_node *of_parse_required_opp(struct device_node *np,
 static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *opp;
+	struct device_node *opp_table_np;
 
 	lockdep_assert_held(&opp_table_lock);
 
+	opp_table_np = of_get_parent(opp_np);
+	if (!opp_table_np)
+		goto err;
+
+	/* It is safe to put the node now as all we need now is its address */
+	of_node_put(opp_table_np);
+
 	list_for_each_entry(opp_table, &opp_tables, node) {
-		opp = _find_opp_of_np(opp_table, opp_np);
-		if (opp) {
-			dev_pm_opp_put(opp);
+		if (opp_table_np == opp_table->np) {
 			_get_opp_table_kref(opp_table);
 			return opp_table;
 		}
 	}
 
+err:
 	return ERR_PTR(-ENODEV);
 }
 
-- 
2.19.1.568.g152ad8e3369a

