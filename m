Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98977C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AB720660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AB720660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbeKZWII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:08:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32926 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbeKZWIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:08:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6809391A;
        Mon, 26 Nov 2018 03:14:19 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0853F5AF;
        Mon, 26 Nov 2018 03:14:14 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-s390@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
Subject: [PATCH v2 11/20] drivers/perf: perf/core: advertise PMU exclusion capability
Date:   Mon, 26 Nov 2018 11:12:27 +0000
Message-Id: <1543230756-15319-12-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm_pse PMU has the capability to exclude events based on
context. Let's advertise that we support the PERF_PMU_CAP_EXCLUDE
capability to ensure that perf doesn't prevent us from handling
events where any exclusion flags are set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 54ec278..a09c38a 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -902,7 +902,8 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
 
 	spe_pmu->pmu = (struct pmu) {
 		.module = THIS_MODULE,
-		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
+		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE |
+				  PERF_PMU_CAP_EXCLUDE,
 		.attr_groups	= arm_spe_pmu_attr_groups,
 		/*
 		 * We hitch a ride on the software context here, so that
-- 
2.7.4

