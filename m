Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272A9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD7E24D8A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD7E24D8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbeF1UoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:44:21 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33859 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936067AbeF1UoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:44:02 -0400
Received: by mail-yw0-f193.google.com with SMTP id n187-v6so2645494ywd.1;
        Thu, 28 Jun 2018 13:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ea/NpiLT+Qun81NMw+9SpKXGfmMaznin7WyFr0FNcM=;
        b=fw9UnT/oIrOSIYaa86uTbrnuZ6jmB7IJTYPpS30G2dQO4159Cwe+aB3HemjYRlduiz
         MHnwu61CjbOBDbjbBrZrAkIH8uTGXAD2jPSBTADBGgsE5F487TT1s4Yuu5v3xL6+pOwS
         pVu0LZIq+1N7+QMnzH0yWTqISXhp6JW+piUBBMEhkToBsTtYc1yDVNxGzWmgLubJMLEB
         jdvu3vJ4a2ytzARFoeB5g76q4uVQWMNJIREQQ25naPKvEINyzhhH+UoLS4S15PGFTB1r
         TOymzbhCHLFcGiKrPvCKkGgrs+GLPu4li369IF6q/W/lXlg1ggnJCty+PZ37nwtFsfNq
         Jx6g==
X-Gm-Message-State: APt69E04ZhENeaxFCDEsSNpE5M6+Rbb5YJ8ntSW57PUtWVbl7yv2NOS8
        C7CiYvqrkU/5XZFRD1C7K6Svam0=
X-Google-Smtp-Source: AAOMgpc7sGKJyL9mkQHR5iJBbJB1ZYKWvbOASHKWz5eYzdFqL5kE+modm7Z02SW0KHJ/nqj6qU5CzQ==
X-Received: by 2002:a81:4d41:: with SMTP id a62-v6mr1844020ywb.343.1530218642003;
        Thu, 28 Jun 2018 13:44:02 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm427913ywi.32.2018.06.28.13.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 13:44:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v3 6/6] PM / Domains: Stop deferring probe at the end of initcall
Date:   Thu, 28 Jun 2018 14:43:44 -0600
Message-Id: <20180628204344.13973-7-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628204344.13973-1-robh@kernel.org>
References: <20180628204344.13973-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All PM domain drivers must be built-in (at least those using DT), so
there is no point deferring probe after initcalls are done. Continuing
to defer probe may prevent booting successfully even if managing PM
domains is not required. This can happen if the user failed to enable
the driver or if power-domains are added to a platform's DT, but there
is not yet a driver (e.g. a new DTB with an old kernel).

Call the driver core function driver_deferred_probe_check_init_done()
instead of just returning -EPROBE_DEFER to stop deferring probe when
initcalls are done.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
  - Update to new function name

 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4925af5c4cf0..8c12213875c6 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2253,7 +2253,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return -EPROBE_DEFER;
+		return driver_deferred_probe_check_state(dev);
 	}

 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
--
2.17.1
