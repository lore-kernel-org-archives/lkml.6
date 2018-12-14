Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA28C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6432080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uw/P9maD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6432080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeLNKPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:15:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41231 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbeLNKPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:15:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so2613222pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LwDno6pPq3+62WWHDum9qZ80rXO5n5aGPdUmxZHq/s=;
        b=Uw/P9maDkd8VqTiGsuCXmhrm+JkG2Noyk0z/Jgyk1x2hz0BnnLzjDvJV6QgYGzd8kR
         Rsm0s6bTTIeIOJXgXQBmW3VFkYiEU1Qj3b5uWSCYFoFYcxi7WP4q0/ZCI0I879BwlNIo
         fQV/3AQ36xDGa68tMmkM5gISuDLbxbB5py6+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LwDno6pPq3+62WWHDum9qZ80rXO5n5aGPdUmxZHq/s=;
        b=Jwb7Z7kQeZlcFvhFzyTif1L0UjDfsqLFYRe+/yLY7g7Og1YN1naxu90aBwNNGPsWik
         zvggMZQWm4Ii0CPMZbbqacQ0ayU5VGqyL2OsjnF9jXT4nz1tul3mO7UEzKmjfUcdO/e6
         a5HjycK1y/WoOUASY1kxBrttF56vNOKwCQCbVs7nL7i1dgLdtgm2NjfxKjD8zTAxU+tN
         vEL4aDZco5WnBdEdnlCkpZbcpUJnLMxQEj5U//6V7tCRqc2BXOsifE9VxqHYztYqWobP
         22jZZ91wGx4hjBXKwU0r6q2Hm2vmXYszutIaP+rqy0DAKlb9X57RPGHraYioNOeVE5FR
         Q8Vw==
X-Gm-Message-State: AA+aEWYTrXJmhmQPZRikqTtdNGCW0muUWkZPTpzmC8L/4BPormUOCcfP
        GWmmpEQZg3eYFRh60MstQ+C1Qw==
X-Google-Smtp-Source: AFSGD/Ue3jg3aHJUZwxOYHKhxS7+zQIfHnj6T/Ym7kpvsbFQBolSZk8UXMrjkCNCbmZ4RRsggvmqLw==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr2243734pgs.166.1544782544631;
        Fri, 14 Dec 2018 02:15:44 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id c81sm13095642pfb.107.2018.12.14.02.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 02:15:44 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/7] OPP: Improve _find_table_of_opp_np()
Date:   Fri, 14 Dec 2018 15:45:28 +0530
Message-Id: <184bbc28f982752cc040f0b9286516c3897e2808.1544782279.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544782279.git.viresh.kumar@linaro.org>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
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

