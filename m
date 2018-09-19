Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD05BECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB482146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhjieuyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB482146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbeITEBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:01:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43307 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387544AbeITEBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:01:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id q19-v6so2534221pgn.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=44j3swOjLZRMj7KYCCHURncUQcQCot+MmDdSGHfeDPA=;
        b=hhjieuyCFF5O3dZJ7hBHeN+t4o6LV6wzvk0nAfJBO0tOBLRhitxoGt/uNlyTwgFAuj
         kiEIPcaxjMAEuTNiHupwpORBRBSIM7YeX/KHhHiOdiowaviDkLmFjis0/ewTbtRkZHdz
         B12lgvkMKp8upAfDAPVWxk8hzgd7wJ8l19sXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=44j3swOjLZRMj7KYCCHURncUQcQCot+MmDdSGHfeDPA=;
        b=e8MP1wr3LAe9RO+NfGIIXfBV4G9By6mXax3QLFOn7VvJQ0FjF6qPo5zlyrJKq2OTpo
         nn+wpHoH6odyems/GYRLpS01wjg92rWkzkPo0P7lXPpbnTCrFssWSiNjBEi+8xciP1Iq
         8yvujPYtrEEs0+eQj4EavUeLaW9DllE4F45J4/nfScFrGtT7ii/R+NgAk915rAlDtma8
         joO5qJ5idT2Ht8TgYaKZPTTRlI5Qh98PP8q5An0ZBGCI7fZZnjKVSC4RL8rHdSCYD/HC
         w59pExCNPwtV63QkM820xLHSNo0wZU4D0hTVPfqBVsKusZ/0vV9R0+6TuXZYLk/Wx3Ux
         z/5w==
X-Gm-Message-State: APzg51DQ5V85/OovEAV5jK9CDU2alCVN8RQpc1Om7Ah7KBkv8YWIImPC
        SXIK2z0CtUkZXFwpWBokjT2Q9A==
X-Google-Smtp-Source: ANB0VdbjJ9xAe5zBsb00IxYeJqEf6204GfVsA0SNWBo269V/4sNaY1PSco7MQreU5cge9kqf/KAHsg==
X-Received: by 2002:a63:8648:: with SMTP id x69-v6mr32605489pgd.268.1537395661604;
        Wed, 19 Sep 2018 15:21:01 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id h130-v6sm27647724pgc.88.2018.09.19.15.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:21:00 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 12/12] OPP: Pass OPP table to _of_add_opp_table_v{1|2}()
Date:   Wed, 19 Sep 2018 15:20:31 -0700
Message-Id: <9ea47a1cc5f08797e6c854c234acbe269b98405a.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both _of_add_opp_table_v1() and _of_add_opp_table_v2() contain similar
code to get the OPP table and their parent routine also parses the DT to
find the OPP table's node pointer. This can be simplified by getting the
OPP table in advance and then passing it as argument to these routines.

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 68 +++++++++++++++++++++++---------------------------------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1ddef52c27fd..a71ff3acca0f 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -399,18 +399,12 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 }
 
 /* Initializes OPP tables based on new bindings */
-static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
-				int index)
+static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 {
 	struct device_node *np;
-	struct opp_table *opp_table;
 	int ret, count = 0, pstate_count = 0;
 	struct dev_pm_opp *opp;
 
-	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
-	if (!opp_table)
-		return -ENOMEM;
-
 	/* OPP table is already initialized for the device */
 	if (opp_table->parsed_static_opps) {
 		kref_get(&opp_table->list_kref);
@@ -420,7 +414,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 	kref_init(&opp_table->list_kref);
 
 	/* We have opp-table node now, iterate over it and add OPPs */
-	for_each_available_child_of_node(opp_np, np) {
+	for_each_available_child_of_node(opp_table->np, np) {
 		count++;
 
 		ret = _opp_add_static_v2(opp_table, dev, np);
@@ -458,15 +452,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 
 put_list_kref:
 	_put_opp_list_kref(opp_table);
-	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
 
 /* Initializes OPP tables based on old-deprecated bindings */
-static int _of_add_opp_table_v1(struct device *dev)
+static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 {
-	struct opp_table *opp_table;
 	const struct property *prop;
 	const __be32 *val;
 	int nr, ret = 0;
@@ -487,10 +479,6 @@ static int _of_add_opp_table_v1(struct device *dev)
 		return -EINVAL;
 	}
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return -ENOMEM;
-
 	kref_init(&opp_table->list_kref);
 
 	val = prop->value;
@@ -503,7 +491,6 @@ static int _of_add_opp_table_v1(struct device *dev)
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
 			_put_opp_list_kref(opp_table);
-			dev_pm_opp_put_opp_table(opp_table);
 			return ret;
 		}
 		nr -= 2;
@@ -531,24 +518,24 @@ static int _of_add_opp_table_v1(struct device *dev)
  */
 int dev_pm_opp_of_add_table(struct device *dev)
 {
-	struct device_node *opp_np;
+	struct opp_table *opp_table;
 	int ret;
 
+	opp_table = dev_pm_opp_get_opp_table_indexed(dev, 0);
+	if (!opp_table)
+		return -ENOMEM;
+
 	/*
-	 * OPPs have two version of bindings now. The older one is deprecated,
-	 * try for the new binding first.
+	 * OPPs have two version of bindings now. Also try the old (v1)
+	 * bindings for backward compatibility with older dtbs.
 	 */
-	opp_np = dev_pm_opp_of_get_opp_desc_node(dev);
-	if (!opp_np) {
-		/*
-		 * Try old-deprecated bindings for backward compatibility with
-		 * older dtbs.
-		 */
-		return _of_add_opp_table_v1(dev);
-	}
+	if (opp_table->np)
+		ret = _of_add_opp_table_v2(dev, opp_table);
+	else
+		ret = _of_add_opp_table_v1(dev, opp_table);
 
-	ret = _of_add_opp_table_v2(dev, opp_np, 0);
-	of_node_put(opp_np);
+	if (ret)
+		dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
@@ -575,28 +562,29 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
  */
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 {
-	struct device_node *opp_np;
+	struct opp_table *opp_table;
 	int ret, count;
 
-again:
-	opp_np = _opp_of_get_opp_desc_node(dev->of_node, index);
-	if (!opp_np) {
+	if (index) {
 		/*
 		 * If only one phandle is present, then the same OPP table
 		 * applies for all index requests.
 		 */
 		count = of_count_phandle_with_args(dev->of_node,
 						   "operating-points-v2", NULL);
-		if (count == 1 && index) {
-			index = 0;
-			goto again;
-		}
+		if (count != 1)
+			return -ENODEV;
 
-		return -ENODEV;
+		index = 0;
 	}
 
-	ret = _of_add_opp_table_v2(dev, opp_np, index);
-	of_node_put(opp_np);
+	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
+	if (!opp_table)
+		return -ENOMEM;
+
+	ret = _of_add_opp_table_v2(dev, opp_table);
+	if (ret)
+		dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
-- 
2.14.1

