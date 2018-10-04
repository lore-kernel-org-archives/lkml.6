Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E7C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA372098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2F/LP2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA372098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJDLIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:08:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35940 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeJDLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:08:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id f18-v6so2535135pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 21:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=osHUwuiO0Yt9WNQtlpO1yAjh4ObC+ZQbro/V9Mp9LXI=;
        b=A2F/LP2jGLnAGdxdQguLbKk9fjbn+UtRFhwsAdUi42XvqiwNBZGDzefFKJw9QkCBGX
         rCN4ckiV29lETBHTzwIpDP5PE8zZN0HenREVYIizIRFcQGrXSKHQ+E/RkI5B1u6bCAIo
         C3D8i5DB2nGBhc9sqqHylUXBwjEO/ovIM9v1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=osHUwuiO0Yt9WNQtlpO1yAjh4ObC+ZQbro/V9Mp9LXI=;
        b=YbaoO/371tCGnzIL0BExZBcxvHE0Ioib7uAwaa1SEX4O2heW9RCi41SVK/T1yD/fWw
         Es83cHNjZY1m52clv9AUuYFuYjc5f+bssPPd40bWEH+sAms5TfB7ha5frnoVcKI2+H6Q
         +XxAbFqfoyoVNz6Jg2W3KEGLUT1X7EB2OCO3uT7d+861YHG8tQ+2ZJlvWtpSwqOeVj7A
         eb1RsezLa8AUYYXZMkln9pi3i/XJIBJhVKGAuphrWr4EbT+szztQjlSO0RrPzycD+Vlr
         pUqKSOQvsvLFyj62o8L682cR3BgYXYNEOLOaah3Mlc/nnuK8T8Kuc7kEdpZ418IendDD
         yXPg==
X-Gm-Message-State: ABuFfoic8ybhVOEaiA4r2YxLBC+fADq87YQJiyCzEKLCzk6/ke9fpxIg
        IOXIe6PH76z25MzK6xa5KkAYgg==
X-Google-Smtp-Source: ACcGV607c9hILgbmxSA7zkzVphS625EdNlH1B/zJCeGDBsvYvXR7YQxZvpIRzIolSDjdTLi9PT/d3g==
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr4055386pgp.334.1538626614909;
        Wed, 03 Oct 2018 21:16:54 -0700 (PDT)
Received: from localhost ([122.172.76.11])
        by smtp.gmail.com with ESMTPSA id w13-v6sm2882577pgs.89.2018.10.03.21.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 21:16:54 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        d-gerlach@ti.com, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/4] PM / OPP: _of_add_opp_table_v2(): increment count only if OPP is added
Date:   Thu,  4 Oct 2018 09:46:23 +0530
Message-Id: <deac8703da5faafce96be3f91c668dcd5da931a5.1538625101.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1538625101.git.viresh.kumar@linaro.org>
References: <cover.1538625101.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Currently the _of_add_opp_table_v2 call loops through the OPP nodes in
the operating-points-v2 table in the device tree and calls
_opp_add_static_v2 for each to add them to the table. It counts each
iteration through this loop as an added OPP, however there are cases
where _opp_add_static_v2() returns 0 but no new OPP is added to the
list.

This can happen while adding duplicate OPP or if the OPP isn't supported
by hardware.

Because of this the count variable will contain the number of OPP nodes
in the table in device tree but not necessarily the ones that are
actually added.

As this count value is what is checked to determine if there are any
valid OPPs, if a platform has an operating-points-v2 table with all OPP
nodes containing opp-supported-hw values that are not currently
supported, then _of_add_opp_table_v2 will fail to abort as it should due
to an empty table.

Additionally, since commit 3ba98324e81a ("PM / OPP: Get
performance state using genpd helper"), the same count variable is
compared against the number of OPPs containing performance states and
requires that either all or none have pstates set, however in the case
of any opp table that has any entries that do not get added by
_opp_add_static_v2 due to incompatible opp-supported-hw fields, these
numbers will not match and _of_add_opp_table_v2 will incorrectly fail.

We need to clearly identify all the three cases (success, failure,
unsupported/duplicate OPPs) and then increment count only on success
case. Change return type of _opp_add_static_v2() to return the pointer
to the newly added OPP instead of an integer. This routine now returns a
valid pointer if the OPP is really added, NULL for unsupported or
duplicate OPPs, and error value cased as a pointer on errors.

Ideally the fixes tag in this commit should point back to the commit
that introduced OPP v2 initially, as that's where we started incorrectly
accounting for duplicate OPPs:

commit 274659029c9d ("PM / OPP: Add support to parse "operating-points-v2" bindings")

But it wasn't a real problem until recently as the count was only used
to check if any OPPs are added or not. And so this commit points to a
rather recent commit where we added more code that depends on the value
of "count".

Fixes: 3ba98324e81a ("PM / OPP: Get performance state using genpd helper")
Reported-by: Dave Gerlach <d-gerlach@ti.com>
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Dave already sent V1 for this sometime back and I am sending the
  updated patch now as he isn't around and other folks are facing these
  issues as well.
- Update _opp_add_static_v2() to return the OPP pointer which can now be
  used to distinguish all the cases properly.

 drivers/opp/of.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 67a384c8ead2..5a4b47958073 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -297,15 +297,21 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
  * removed by dev_pm_opp_remove.
  *
  * Return:
- * 0		On success OR
+ * Valid OPP pointer:
+ *		On success
+ * NULL:
  *		Duplicate OPPs (both freq and volt are same) and opp->available
- * -EEXIST	Freq are same and volt are different OR
+ *		OR if the OPP is not supported by hardware.
+ * ERR_PTR(-EEXIST):
+ *		Freq are same and volt are different OR
  *		Duplicate OPPs (both freq and volt are same) and !opp->available
- * -ENOMEM	Memory allocation failure
- * -EINVAL	Failed parsing the OPP node
+ * ERR_PTR(-ENOMEM):
+ *		Memory allocation failure
+ * ERR_PTR(-EINVAL):
+ *		Failed parsing the OPP node
  */
-static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
-			      struct device_node *np)
+static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
+		struct device *dev, struct device_node *np)
 {
 	struct dev_pm_opp *new_opp;
 	u64 rate = 0;
@@ -315,7 +321,7 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 
 	new_opp = _opp_allocate(opp_table);
 	if (!new_opp)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	ret = of_property_read_u64(np, "opp-hz", &rate);
 	if (ret < 0) {
@@ -390,12 +396,12 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	 * frequency/voltage list.
 	 */
 	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADD, new_opp);
-	return 0;
+	return new_opp;
 
 free_opp:
 	_opp_free(new_opp);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /* Initializes OPP tables based on new bindings */
@@ -415,14 +421,15 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_table->np, np) {
-		count++;
-
-		ret = _opp_add_static_v2(opp_table, dev, np);
-		if (ret) {
+		opp = _opp_add_static_v2(opp_table, dev, np);
+		if (IS_ERR(opp)) {
+			ret = PTR_ERR(opp);
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
 			of_node_put(np);
 			goto put_list_kref;
+		} else if (opp) {
+			count++;
 		}
 	}
 
-- 
2.18.0.rc1.242.g61856ae69a2c

