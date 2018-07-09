Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA23C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908B02089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908B02089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933712AbeGIPmR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:42:17 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45086 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932881AbeGIPmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:42:11 -0400
Received: by mail-oi0-f66.google.com with SMTP id q11-v6so11139551oic.12;
        Mon, 09 Jul 2018 08:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NI/NAiVamX5JscPMOlLTMlvmZPXKGe3fL9XuOVxkFH8=;
        b=uboHKQ1LE7s7uCE8h8/8F6U1jY6Bd6Gqq1Gn21ZjdIGN1Hxp5dyveyflXqmq3ByDQv
         VpVc1LwmdGhUKiSSCKZkYCe75FTvrrCq+bZ7VEo7hHvOmrvlr/biM1gOr2XAepQuyKyk
         GZWiDWy76PZ79LaujCFWPOvPx7v4JNbiAMXgROjGUK0+IrNQKVykHyNGpd56nDUPSp4B
         MAr5NtwMG0/eu8E39+53WHNSytoMDUyEsS3rmubeioigSmkcJACClzomUY7vrxXD30Q3
         u59E2yznh7NHvZK1LHwUU6GCjDgFphelgeXO4X1IyeSJPDg490WEqFWFgl1wG5/NaWM9
         CNiQ==
X-Gm-Message-State: APt69E3I7Lgcp0ykxSdUkbiZW5JKZmv9sQ1yzMctkGTGDPHBFauqh73/
        Pb9eUv+63riGS7dtJBPT/w==
X-Google-Smtp-Source: AAOMgpfPXmNuOE/RsdfYGgFbw3rnUYhEV5H4BhnYdt8YaD0R9u7PdfwmcuRJaPgOiVESYBOF1tXozg==
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr26095324oif.71.1531150930783;
        Mon, 09 Jul 2018 08:42:10 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id z196-v6sm30759391oig.12.2018.07.09.08.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 08:42:10 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v4 6/6] PM / Domains: Stop deferring probe at the end of initcall
Date:   Mon,  9 Jul 2018 09:41:53 -0600
Message-Id: <20180709154153.15742-7-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709154153.15742-1-robh@kernel.org>
References: <20180709154153.15742-1-robh@kernel.org>
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

Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
 - Add Rafael's ack

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
