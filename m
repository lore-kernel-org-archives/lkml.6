Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14224C46465
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C202C2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYFDXvVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C202C2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbeKFHsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:48:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35045 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388210AbeKFHsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:48:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so5150991plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6VDjqPjW8rYmef6qwOzmJfwOTegdIgPPYLUTUP0LGhs=;
        b=QYFDXvVSGN6LV+stDAwrCDGj9RxxLZ/v07EkMeyefL4pYyg/93L5e/jrywDko1ENl3
         9lhlhhW5uCqMQqnDMSmPgQq5j5JV29srtOEiHyju3pg35Fx4aP+bXeOUy22cOs/6/V/6
         Fp415Hkxk5GQQYkforfhPaLOd8ZJQAMGeGhF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6VDjqPjW8rYmef6qwOzmJfwOTegdIgPPYLUTUP0LGhs=;
        b=Ohm37BQuQz8Q3hWjqlYHmjEW7oFclJzBdDR1J1HNw7E+f+Pgbu3HfgKOxArR1pi8i3
         /4DjdK5eaW5FdR4ixyHqphukw3NvGNfwkk1PGtdK+SE4DhXwaLJlxRmVg1lgwqyWcES3
         FkjTXv6gLFEz1+TZiKNWy2DZmdIlb8ipTBZmZsCcbYJDNGALPnI66a0bV9KoFWzFYESu
         9RnE1vgSMvKrA9+mp2IfUl6fMoCbYwcJVM9xjUS2txaTE++EaUi9nNSeafM6XzHOV69t
         d0ylrzCF6W5U4HxrSfpuwsHsE1sNAajvtucR9adDYqSRRYcl0YgVjApR26h9WEHYpEey
         O42w==
X-Gm-Message-State: AGRZ1gLQ1EVzSUv58PGPZ7tSCL2vAEj6kuiDmYaAOugqGkVEIbeUu4kC
        6we7AKpDrAt0ovmR/wSdOoHjyA==
X-Google-Smtp-Source: AJdET5ch1DWUwxwsNDP/DF1buIJPFQqJPZ3g1IriR1G50B6nQir2/g8l3+WawNcOiwGvdj5GK99M/w==
X-Received: by 2002:a17:902:8608:: with SMTP id f8-v6mr18529767plo.95.1541456798236;
        Mon, 05 Nov 2018 14:26:38 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q26-v6sm58669804pfi.165.2018.11.05.14.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 14:26:37 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] coresight: etm3x: Release CLAIM tag when operated from perf
Date:   Mon,  5 Nov 2018 15:26:30 -0700
Message-Id: <1541456790-28282-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch deals with the release of the CLAIM tag when the ETM is
operated from perf.  Otherwise the tag is left asserted and subsequent
requests to use the device fail.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index fd5c4cca7db5..000796394662 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -603,6 +603,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	 */
 	etm_set_pwrdwn(drvdata);
 
+	coresight_disclaim_device_unlocked(drvdata->base);
+
 	CS_LOCK(drvdata->base);
 }
 
-- 
2.7.4

