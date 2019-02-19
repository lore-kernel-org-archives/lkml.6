Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ADAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A670321908
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfBSUBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:01:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:8744 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbfBSUA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918083"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:00:59 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 05/10] perf/x86/intel/domain: Add new domain type for die
Date:   Tue, 19 Feb 2019 12:00:06 -0800
Message-Id: <1550606411-5313-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Starts from CLX-AP, some uncore and RAPL counters are die scope.

Add a new domain type DIE_DOMAIN for die scope counters.

To distinguish different die among package, unique die id is used as
domain id.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/domain.c | 11 +++++++++++
 arch/x86/events/domain.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/events/domain.c b/arch/x86/events/domain.c
index bd24c5b..1f572a5 100644
--- a/arch/x86/events/domain.c
+++ b/arch/x86/events/domain.c
@@ -17,6 +17,10 @@ int domain_type_init(struct domain_type *type)
 	case CORE_DOMAIN:
 		type->postfix = "core";
 		return 0;
+	case DIE_DOMAIN:
+		type->max_domains = topology_max_packages() * boot_cpu_data.x86_max_dies;
+		type->postfix = "die";
+		return 0;
 	default:
 		return -1;
 	}
@@ -31,6 +35,8 @@ const struct cpumask *get_domain_cpu_mask(int cpu, struct domain_type *type)
 		return topology_die_cpumask(cpu);
 	case CORE_DOMAIN:
 		return topology_sibling_cpumask(cpu);
+	case DIE_DOMAIN:
+		return topology_core_cpumask(cpu);
 	default:
 		return NULL;
 	}
@@ -47,6 +53,9 @@ int get_domain_id(unsigned int cpu, struct domain_type *type)
 	case PACKAGE_DOMAIN:
 		/* Domain id is the same as logical package id */
 		return topology_logical_package_id(cpu);
+	case DIE_DOMAIN:
+		/* Domain id is the same as logical unique die id */
+		return topology_unique_die_id(cpu);
 	default:
 		return -1;
 	}
@@ -63,6 +72,8 @@ int get_domain_id_from_group_id(int id, struct domain_type *type)
 	case PACKAGE_DOMAIN:
 		/* group id is physical pkg id*/
 		return topology_phys_to_logical_pkg(id);
+	case DIE_DOMAIN:
+		return id;
 	default:
 		return -1;
 	}
diff --git a/arch/x86/events/domain.h b/arch/x86/events/domain.h
index c787816..7815aea 100644
--- a/arch/x86/events/domain.h
+++ b/arch/x86/events/domain.h
@@ -9,6 +9,7 @@
 enum domain_types {
 	PACKAGE_DOMAIN = 0,
 	CORE_DOMAIN,
+	DIE_DOMAIN,
 
 	DOMAIN_TYPE_MAX,
 };
-- 
2.7.4

