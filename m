Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66812C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBF520879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfAJNyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:54:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35316 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfAJNyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:54:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 721041650;
        Thu, 10 Jan 2019 05:54:04 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BAE93F5AF;
        Thu, 10 Jan 2019 05:53:59 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, Michael Ellerman <mpe@ellerman.id.au>
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-alpha@vger.kernel.org
Subject: [PATCH v5 04/12] alpha: perf/core: strengthen exclude checks with PERF_PMU_CAP_NO_EXCLUDE
Date:   Thu, 10 Jan 2019 13:53:26 +0000
Message-Id: <1547128414-50693-5-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547128414-50693-1-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-1-git-send-email-andrew.murray@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the Alpha PMU doesn't support context exclusion let's advertise
the PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

This change means that __hw_perf_event_init will now also
indicate that it doesn't support exclude_host and exclude_guest and
will now implicitly return -EINVAL instead of -EPERM. This is likely
more desirable as -EPERM will result in a kernel.perf_event_paranoid
related warning from the perf userspace utility.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/alpha/kernel/perf_event.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 5613aa37..4341ccf 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -630,12 +630,6 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return ev;
 	}
 
-	/* The EV67 does not support mode exclusion */
-	if (attr->exclude_kernel || attr->exclude_user
-			|| attr->exclude_hv || attr->exclude_idle) {
-		return -EPERM;
-	}
-
 	/*
 	 * We place the event type in event_base here and leave calculation
 	 * of the codes to programme the PMU for alpha_pmu_enable() because
@@ -771,6 +765,7 @@ static struct pmu pmu = {
 	.start		= alpha_pmu_start,
 	.stop		= alpha_pmu_stop,
 	.read		= alpha_pmu_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 
-- 
2.7.4

