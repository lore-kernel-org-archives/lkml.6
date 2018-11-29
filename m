Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0F3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C1721104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlPyEsAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C1721104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbeK3Exn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45474 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbeK3Exm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so2508493ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jX+qyQO49fWmt2xQpGUjw4NJQ/8bkzUinDH9qdTMnUA=;
        b=AlPyEsAyB5TTJCSeRQDcqsvnIKB/rMfm0oTmlQA7hqOgZ6aMDexyWveeYmPE2QdbmV
         BmJIUeVUEo68Z1RYBp5Q7w/uSp5wPfc9ZHJqQtiE1cMsCCV0zIMnnI1fU3CrzA3sf76y
         BhqVyyrcH5tH2VK3YAUp3EhPfLgCuB7n6fgBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jX+qyQO49fWmt2xQpGUjw4NJQ/8bkzUinDH9qdTMnUA=;
        b=HRZVkWDvu35c4VPj7lfbDnA5WtaEd/bzvu/11J3ZlfS4jeLEe6irTFawl/VmJSIq8/
         2BCc4j/IZVC5KHyauzBN8mal7zkD5lo9lHmV/TyjOgrgBl00NhFjOWgtGAAkI1dWbcW6
         WjPCD5CHWuoTCwhSCDoeLV+htO9D0TH94A/MsZqWq38Nv1N5Lc9N0SzrJKuJbAvTLwQi
         ZR7yGSB4j4j56u7f3S8ehCnLyQbju8OgWbgF7q8NNaIBohudPi+QI6X4hxbbPbrphu+D
         7bwm2Ar4qvPik7aYtvma8nbSGwTVOzzYrJiQPVa9Sy8+qGoBkVJuEI1cmML2jVJpijvf
         Isgg==
X-Gm-Message-State: AA+aEWbWKEuCQpcsQZ84cZOu1PamlfGM3SERcoxsUzuW2lOcB+MlYpvO
        qzrN5+ZefjMD0rZZhusA+duqbQ==
X-Google-Smtp-Source: AFSGD/WMXNnYmUDhhw+Xfxe6yvJ/i67+Rv4G+K+ZK1l5/jdsO6I8LilxuZCD2yTIfDMQsHofrPEMgw==
X-Received: by 2002:a2e:5b93:: with SMTP id m19-v6mr1512841lje.115.1543513651192;
        Thu, 29 Nov 2018 09:47:31 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:30 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v10 13/27] drivers: firmware: psci: Support hierarchical CPU idle states
Date:   Thu, 29 Nov 2018 18:46:46 +0100
Message-Id: <20181129174700.16585-14-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Currently CPU's idle states are represented in a flattened model, via the
"cpu-idle-states" binding from within the CPU's device nodes.

Support the hierarchical layout, simply by converting to calling the new OF
helper, of_get_cpu_state_node().

Cc: Lina Iyer <ilina@codeaurora.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- None.

---
 drivers/firmware/psci/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cbfc936d251c..631e20720a22 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -300,7 +300,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		return -ENOMEM;
 
 	for (i = 0; i < num_state_nodes; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = of_get_cpu_state_node(cpu_node, i);
 		if (!state_node)
 			break;
 
-- 
2.17.1

