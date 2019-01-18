Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C612086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfARQAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:00:47 -0500
Received: from foss.arm.com ([217.140.101.70]:60324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfARQAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:00:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4FBEEBD;
        Fri, 18 Jan 2019 08:00:44 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6766A3F557;
        Fri, 18 Jan 2019 08:00:42 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, Grant Likely <Grant.Likely@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: [PATCH 2/3] cpufreq: update headers to use STUB_UNLESS macro
Date:   Fri, 18 Jan 2019 16:00:29 +0000
Message-Id: <1547827230-55132-3-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the STUB_UNLESS macro to simplify function declaration.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 include/linux/cpufreq.h | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c86d6d8..2c53cae 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -159,21 +159,12 @@ struct cpufreq_policy {
 #define CPUFREQ_SHARED_TYPE_ALL	 (2) /* All dependent CPUs should set freq */
 #define CPUFREQ_SHARED_TYPE_ANY	 (3) /* Freq can be set from any dependent CPU*/
 
-#ifdef CONFIG_CPU_FREQ
-struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
-struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
-void cpufreq_cpu_put(struct cpufreq_policy *policy);
-#else
-static inline struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
-{
-	return NULL;
-}
-static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
-{
-	return NULL;
-}
-static inline void cpufreq_cpu_put(struct cpufreq_policy *policy) { }
-#endif
+STUB_UNLESS(CONFIG_CPU_FREQ, return NULL,
+struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu));
+STUB_UNLESS(CONFIG_CPU_FREQ, return NULL,
+struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu));
+STUB_UNLESS(CONFIG_CPU_FREQ,
+void cpufreq_cpu_put(struct cpufreq_policy *policy));
 
 static inline bool policy_is_shared(struct cpufreq_policy *policy)
 {
-- 
2.7.4

