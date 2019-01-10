Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1768BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5AB2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+d45++X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfAJABT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:01:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34541 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfAJABS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:01:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so9489305wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TWqA5aCCzVWoclWoRERTw4sDZ/VsY8UwV8+oCN/rO9o=;
        b=T+d45++XscdlCHWCAsA9SD95Y4D/qk4Cu1eJmM50dW38fYpqhoIf9X3ShJ+GkenZV0
         Qbev/fc4EiHLNYKs9WgVT/++JitLGeooodqcyzIcZrOC/12SFxVWMxpMhnUc+VGHV70e
         o1OWQUlBd5NGbQlwqS2lxTOlL3Ds9vkUv2AZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TWqA5aCCzVWoclWoRERTw4sDZ/VsY8UwV8+oCN/rO9o=;
        b=MVHCWbrj96pbdgwsrVCs0GxkupKpUYer4v2+8RXxfC6zFWUtwjRyJ1nDzXErSaHSj7
         615pBsbJZGb+TuivTO4S+2S/d1yjJj3n4ybL9koTdmvcOX3DniBGXX5X5sph8Jx3f3Vv
         kYRx3CxKzjmzM01c2R7gQi4IgMJpitBbC5UwYbYtnEWW/RZQF/hM7yelwumrA8KDw52G
         jbQkF0lMqFCC87iusS21ZOVYuZeMPMANgKK8muUMG1vOvwr7o9E3orxXjv218ajzPZLN
         rOGPQChv8iz29oC0lysR+3STMIo9Zzt46rjE69UL+Kp5Hm+5fA7nQXxAsAS/au2puCQW
         R47g==
X-Gm-Message-State: AJcUukd04iFj9pZ37HqbA227C+EkC3HwzezA/IgSBEjyysMYghI33vVb
        TmFaN8j6hHdN9rxj4szDrFYoKacZTI8=
X-Google-Smtp-Source: ALg8bN5GlqybYxQty34TMID1gr2PCkYXso64zj2MsyGHVrIPbs7dTapub/WhzCg6IJFQutk3Jpojig==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr6662240wrx.134.1547078476478;
        Wed, 09 Jan 2019 16:01:16 -0800 (PST)
Received: from localhost ([49.248.171.190])
        by smtp.gmail.com with ESMTPSA id a12sm63151563wro.18.2019.01.09.16.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:01:15 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v1 2/7] drivers: cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
Date:   Thu, 10 Jan 2019 05:30:51 +0530
Message-Id: <aadc9cff04dc310138b41979239ce51938afedce.1547078153.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several cpufreq drivers register themselves as thermal cooling devices.
Adding a pointer to struct cpufreq_policy removes the need for them to
store this pointer in a private data structure.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 include/linux/cpufreq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c86d6d8bdfed..2496549d7573 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -95,6 +95,8 @@ struct cpufreq_policy {
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
+	struct thermal_cooling_device *cooldev; /* Pointer to the cooling
+						 * device if used for thermal mitigation */
 	struct list_head        policy_list;
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
-- 
2.17.1

