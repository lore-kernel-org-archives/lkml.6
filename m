Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B265CC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9C020833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS98BdT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9C020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbeGYTNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbeGYTNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:13:38 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12A1E20852;
        Wed, 25 Jul 2018 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541652;
        bh=wfJAaYPoBAJhyNw09B8YsVB2PfMazpBY0GcZG40hgM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gS98BdT/+0kRf8xDx70WYsdbkcQVjqOtMJmVhWkIjl/jKXdGJbmWro9tGy6qlKqAu
         7ctWtmnsSwcZElATZzd9sp8M1MxBBRdtarhB76hT4jnPPEQSR1qJyWh4+R7Vfct4Si
         fhyViuv7+rUBPx4iXXtdEifTG8gf886/6pjspKzk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/27] Revert "perf list: Add s390 support for detailed/verbose PMU event description"
Date:   Wed, 25 Jul 2018 14:59:39 -0300
Message-Id: <20180725180001.15108-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

This reverts commit 038586c34301578e538f6c5aa79ca82bce1b9152.

Fix the support of detailed/verbose PMU event description by using the
"Unit": keyword in the json files to address event names refering to the
/sys/devices/cpum_[cs]f devices.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180621080452.61012-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3ba6a1742f91..afd68524ffa9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -652,12 +652,6 @@ static int is_arm_pmu_core(const char *name)
 	if (stat(path, &st) == 0)
 		return 1;
 
-	/* Look for cpu sysfs (specific to s390) */
-	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s",
-		  sysfs, name);
-	if (stat(path, &st) == 0 && !strncmp(name, "cpum_", 5))
-		return 1;
-
 	return 0;
 }
 
-- 
2.14.4

