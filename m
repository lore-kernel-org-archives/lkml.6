Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C401CECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC31214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdY7h6gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC31214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJIXnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:43:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40908 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeJIXnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:43:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id b4-v6so2290317qtc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zIbq74SHzUmAAn9beXqSbIF0xv76+VwJaPbFBIeIe1U=;
        b=kdY7h6gD1j1ZOLtPzQxEfbc4s3OD13OAN015eqld8teNR3+nmmjs/yTd5FpiU0di87
         qpUqMO8Ns1pedoP0cGypsMgs2UXMZqoWFLcxwWAjKO6dfseK3ibqVv3MH+mTC/ttnPl+
         8bAduK1OBfF087dvUgV/UImLxOwwIHScBIC9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zIbq74SHzUmAAn9beXqSbIF0xv76+VwJaPbFBIeIe1U=;
        b=so5ZN5aLRFWvi/3D6ImffHKuHuAiYPa9UI5+mavPS4pVl8H9CQ6R/fsv04DRR9Z5Bb
         dzaRWxeGQGf1OhUB4iWymU2K8Lkr7hDrAlw3UHV8qCoJ6cKCE/7UQ6EwiykL0hXZBr32
         wq6H1WDtpGBiwkcTvc8SE0AxDveMPrcV6+IUf5SOUTJxfkCAHjBs/pkuDZb60d4nIzGG
         AXV7tdgvqONajHfevLq8r8gw4Ul8WVevds/6Ck0FEwGUlAu8OfmxIqxYkJLTmCqrP6gY
         NEdcE3vjPvCl6CuTlIziwZ3olMQsEt5cSqcnUtvZbkTw1DE0yJUnNxWhR69ByEbdFsFZ
         GUZg==
X-Gm-Message-State: ABuFfogDpMF8RshqJjw3+Q1J7XowIPekZ3Ai8y4whfQNqOTBhIHD64mJ
        zQrLlHPjFoESqcpClC78dPJDhGdhcHMbkw==
X-Google-Smtp-Source: ACcGV602XfqXVNPD/Eg/092xZk0PMy7jAlLchI99z3G11vY0KKo70lEW4tCqakEIbaPNLs+84lDBbg==
X-Received: by 2002:aed:3342:: with SMTP id u60-v6mr20271131qtd.177.1539102315988;
        Tue, 09 Oct 2018 09:25:15 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm10441169qkc.67.2018.10.09.09.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 09:25:15 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: [RFC PATCH 6/7] sched/fair: update cpu_capcity to reflect thermal pressure
Date:   Tue,  9 Oct 2018 12:25:01 -0400
Message-Id: <1539102302-9057-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_capacity relflects the maximum available capacity of a cpu. Thermal
pressure on a cpu means this maximum available capacity is reduced. This
patch reduces the average thermal pressure for a cpu from its maximum
available capacity so that cpu_capacity reflects the actual
available capacity.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7deb1d0..8651e55 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7497,6 +7497,7 @@ static unsigned long scale_rt_capacity(int cpu)
 
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
+	used += READ_ONCE(rq->avg_thermal.load_avg);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.1.4

