Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A42C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4205C20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MYqUP1PX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4205C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933077AbeFTRYA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:24:00 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38654 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbeFTRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:20 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so481904lfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w6707zj46IMqt6XCkQl3eda+NnYi5j11bRFglc+AHIo=;
        b=MYqUP1PX6RNA8Jk/XK94dyVhwN3dNQK/vBGc7ZQbpt3uVK887zAsAYYjKClORu8hYZ
         YCval1UFbciw6q+Jf6WI/auuiDVzqnHaK29+Xwx4KQX80gN7FPLwOPneN3N5nWLlWJNn
         dnX/Cen42KgPaYzK2lzR+hKcvFi1RzNlQuXLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w6707zj46IMqt6XCkQl3eda+NnYi5j11bRFglc+AHIo=;
        b=Jp7RvQyY3YSti1qu14qTPgp//LLbmo86E5yZsqvUGybF9vkya8DM1Q93Uv33WW7tzo
         7M5ornG5C5ZZMsPwbN9oqh71TLldDtI7D79dOrqrjdoHvMupDZ/kc8WX19gk6j9jnAzp
         nbGd2YOuD+EG4Bgy410G4RlULppVGQdCUWMM/Hx82LUzpj9VRZo4uZz0zbGrhGy8GC63
         Ik7+SQDn1Y7fxtshE29UcSBmdyD3H5ufIS0FBmurh5omfncm43WN1y+IsdpL+wq846gk
         1q4UtEg+v4LGMbjK5Gimf/CdKPYUqvt02xdPTUjUn34KaCYjKr4BmHSGdGZeJCC5yn8N
         Awyg==
X-Gm-Message-State: APt69E3NYCGlfyyTfSK/ztGIrODiiaBVDtkGLPead1l9xr/mIpoT8UoO
        R1n4UxF4Jh/unJFextJ5g4lp6g==
X-Google-Smtp-Source: ADUXVKKO7UQ2hkCEVdaK5Yf4srm6bzhJGEXUFWekAvaP3L9+qrqsnljNOBZe+oStCJOAS8uRawZ5tA==
X-Received: by 2002:a19:428c:: with SMTP id p134-v6mr12790102lfa.4.1529515399164;
        Wed, 20 Jun 2018 10:23:19 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:23:18 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 24/26] drivers: firmware: psci: Deal with CPU hotplug when using OSI mode
Date:   Wed, 20 Jun 2018 19:22:24 +0200
Message-Id: <20180620172226.15012-25-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To deal with CPU hotplug when OSI mode is used, the CPU device needs to be
detached from its PM domain (genpd) when putting it offline, otherwise the
CPU becomes considered as being in use from genpd and runtime PM point of
view. Obviously, then we also need to re-attach the CPU device when bring
the CPU back online, so let's do this.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 700e0e995871..e649673d71f0 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -190,6 +190,10 @@ static int psci_cpu_off(u32 state)
 	int err;
 	u32 fn;
 
+	/* If running OSI mode, detach the CPU device from its PM domain. */
+	if (psci_osi_mode_enabled)
+		of_genpd_detach_cpu(smp_processor_id());
+
 	fn = psci_function_id[PSCI_FN_CPU_OFF];
 	err = invoke_psci_fn(fn, state, 0, 0);
 	return psci_to_linux_errno(err);
@@ -204,6 +208,10 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
 	/* Clear the domain state to start fresh. */
 	psci_set_domain_state(0);
+
+	if (!err && psci_osi_mode_enabled)
+		of_genpd_attach_cpu(cpuid);
+
 	return psci_to_linux_errno(err);
 }
 
-- 
2.17.1

