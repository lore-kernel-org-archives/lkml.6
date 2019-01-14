Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47901C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12951206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xt/1jw4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfANQfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:35:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41750 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfANQfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:35:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so23600762wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fpr0EFghkVyQH0EiyG1VDE5LspytkbV2ayoT+IrLjlk=;
        b=Xt/1jw4waa3lxjlieWv0tTk3gDceBhD3HUc7luQtVdqZVtK0ir4846YNAijauV6u+F
         wH3v0lRb/1OC+duPFMPoVhmthEhaqmlHb6Tm57SIAEX0kyeb4SDmrGHFQe5BGeyxZ+1J
         s8yn8lxne1kmnT2AUdV+GDk0CxDaUKMnuyYCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fpr0EFghkVyQH0EiyG1VDE5LspytkbV2ayoT+IrLjlk=;
        b=blMS/8QDr2a86o0MEhk53NxwD8k6bwO+UTd/BIR1Huz06rhmYkwyEBGW401DOOuXq2
         /PJu2KqpKwVen0UDsWlkWHUHkrwL+qggnv/kIf/3Vi8g+dRgLK0/8tvzqyd2vQ23VkJb
         EFMfqWMM3oE+8jRvUapxY/08/74kYy5Zde8qksICzodhfII3GPY+h07+SUKmwMHJgAVZ
         iZpzYN/HHlrkW5+LjIbuO7V0I89JAagpFNzwLF5O8XYDe8Y6bpEihTx1pBZCPIiFwl9t
         NZ+xzcndgZPJmhj8uP6FA2c9HK43dPOBmSvUs/wWI4yq2WpMY8yqFnEp4xOB0DgTAbka
         bhIg==
X-Gm-Message-State: AJcUukcabUs9yvmFARjZhtEAI5whqTxglmolWuFkY9+CUMRvy2HJSZ3t
        k2zAFupftO9HkhxXZT5OycYqtu7k515MSg==
X-Google-Smtp-Source: ALg8bN43Uf7vBoXQ6dtcNgCxMFAYVTr7hrdeoH3nJIhlUZ26zED6ERY0Wvvoxeu5vDsovLf0fX5r8A==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr24266430wrm.238.1547483721699;
        Mon, 14 Jan 2019 08:35:21 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id h17sm70337170wrt.59.2019.01.14.08.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:35:20 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling device
Date:   Mon, 14 Jan 2019 22:04:52 +0530
Message-Id: <cover.1547481320.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to be used by cpufreq drivers to tell cpufreq core to
auto-register themselves as a thermal cooling device.

There series converts over all the drivers except arm_big_little.c.
Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
others. 

Things needing fixing:
 - Look at how to detect that we're not in IKS mode in arm_big_little's
   .ready callback.
 - The other pending issue is to fix allmodconfig that leaves us with
   CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
   references for functions defined in cpu_cooling.c

Amit Kucheria (10):
  cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
  cpufreq: Add a flag to auto-register a cooling device
  cpufreq: Replace open-coded << with BIT()
  cpufreq: qcom-hw: Register as a cpufreq cooling device
  cpufreq: imx6q: Use auto-registration of thermal cooling device
  cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
  cpufreq: mediatek: Use auto-registration of thermal cooling device
  cpufreq: qoriq: Use auto-registration of thermal cooling device
  cpufreq: scmi: Use auto-registration of thermal cooling device
  cpufreq: scpi: Use auto-registration of thermal cooling device

 drivers/cpufreq/cpufreq-dt.c       | 14 ++----------
 drivers/cpufreq/cpufreq.c          | 17 ++++++++++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 18 ++-------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++----------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-----------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++----------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++----------
 include/linux/cpufreq.h            | 36 ++++++++++++++++++++----------
 9 files changed, 55 insertions(+), 90 deletions(-)

-- 
2.17.1

