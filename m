Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66F6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F45020664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWAxYNMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F45020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeJ3BM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:12:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39156 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbeJ3BMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:12:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so9381597wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5ufvLgLeByEO3l1UMVwBEPg+2O2CRJCS4nN3+quaAgs=;
        b=bWAxYNMgwh3WOp4jxA+QzoPwtxiZJBrZk0mz4ubZnGzLvRsRMwWfraYDmuCHwo2k9E
         4+Eumo/hsz3pbTdQEzdWNoNAOY3y+xu9Wzs1W2G0T6zUJ1+w2LN11cpvcSEunEE6WpAa
         hyGGJY+n/3ZzEN0H+4avT6F4PWq5n6sfj9IUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5ufvLgLeByEO3l1UMVwBEPg+2O2CRJCS4nN3+quaAgs=;
        b=CP6zz0Ymsw9fmQUm0YJskfnplsXenCst0/55FgS9XvN3TNPs7mEv2anIWDyOWpVB39
         5YLEAW5QslhNA5mIdeUCDhlzaLqq+FRkZPgJ+MDwd8V2/Mnd6eW+S++051bXMtmZf9dg
         WHHdOxB/iV9gXwHDQ5OC9N2k88Q42R+2nW85CnphDPbNZW9HMTdhk9x544bsmKfVuVxf
         KUMLi6B2S+joOEqXEwsnWVnB1NQ1LyqG45mfuIEVjImZjOSyAHQSA6S1Lx/3ElTcM/2G
         LMO0cZql0AO2+jvynpw5fcGiqgIU0+vpJZ6ngYsz94Hd5vp+4b5DDkRFYaPWeh4NAfb1
         iHtg==
X-Gm-Message-State: AGRZ1gKAl27dW+QEs5Me9/AZ+fVz2Fdaqxs9tFV8BrKZJhTPpwcCqip9
        CIj7d0uJ5vRhn/ZNhkKJj8uGTa+4poM=
X-Google-Smtp-Source: AJdET5ejLnv/fKgHz2+mchAHsi95AQnpgQblU4dwMp0HkHCYxyBedHhOO6CQ3WNxmIHrsKdxNiUkzg==
X-Received: by 2002:a5d:4609:: with SMTP id t9-v6mr3508033wrq.198.1540830216438;
        Mon, 29 Oct 2018 09:23:36 -0700 (PDT)
Received: from localhost.localdomain (137.55.88.92.rev.sfr.net. [92.88.55.137])
        by smtp.gmail.com with ESMTPSA id y19-v6sm28150499wra.60.2018.10.29.09.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 09:23:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/4] base/drivers/arch_topology: Remove useless check
Date:   Mon, 29 Oct 2018 17:23:17 +0100
Message-Id: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function 'register_cpufreq_notifier' registers the
init_cpu_capacity_notifier() only if raw_capacity is not NULL.

Hence init_cpu_capacity_notifier() can not be called with raw_capacity
set to NULL, it is pointless to check it.

Remove the check.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/base/arch_topology.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6..204ed10 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -181,9 +181,6 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 	int cpu;
 
-	if (!raw_capacity)
-		return 0;
-
 	if (val != CPUFREQ_NOTIFY)
 		return 0;
 
-- 
2.7.4

