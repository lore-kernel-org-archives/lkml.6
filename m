Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9002ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB72075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaKAX217"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEB72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeJYWw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbeJYWwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:55 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A5320848;
        Thu, 25 Oct 2018 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477198;
        bh=lzQ1ep5K0E4tagyxO+amRAnZmXoPLH/IoixOiwh8RJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FaKAX217fh6gifa7sGq8mxtzTENf6zUeWXPyaWCi6WP8Cl8i7NSRMI5OYFG5t61U1
         cyaNspn4yEe4NE0bd4DcxhQVA1ltgM1hhhNjISfwBz8q1846TeL9DyYEb3aRwsh1t3
         NPRF1XjMpKgs/5fww2J+SNLF94eve4ajOwR4/FYI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        vincent.weaver@maine.edu, jolsa@redhat.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 43/98] perf/rapl: Fix sysfs_show() initialization for RAPL PMU
Date:   Thu, 25 Oct 2018 10:17:58 -0400
Message-Id: <20181025141853.214051-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

[ Upstream commit 433678bdc6ed39f053c55da96b51de5bf0aeebb1 ]

This patch fixes a problem with the initialization of the
sysfs_show() routine for the RAPL PMU.

The current code was wrongly relying on the EVENT_ATTR_STR()
macro which uses the events_sysfs_show() function in the x86
PMU code. That function itself was relying on the x86_pmu data
structure. Yet RAPL and the core PMU (x86_pmu) have nothing to
do with each other. They should therefore not interact with
each other.

The x86_pmu structure is initialized at boot time based on
the host CPU model. When the host CPU is not supported, the
x86_pmu remains uninitialized and some of the callbacks it
contains are NULL.

The false dependency with x86_pmu could potentially cause crashes
in case the x86_pmu is not initialized while the RAPL PMU is. This
may, for instance, be the case in virtualized environments.

This patch fixes the problem by using a private sysfs_show()
routine for exporting the RAPL PMU events.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20150113225953.GA21525@thinkpad
Cc: vincent.weaver@maine.edu
Cc: jolsa@redhat.com
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/perf_event_intel_rapl.c | 44 +++++++++++++++------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_intel_rapl.c b/arch/x86/kernel/cpu/perf_event_intel_rapl.c
index 611d821eac1a..040915c87cb6 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_rapl.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_rapl.c
@@ -103,6 +103,13 @@ static struct kobj_attribute format_attr_##_var =		\
 
 #define RAPL_CNTR_WIDTH 32 /* 32-bit rapl counters */
 
+#define RAPL_EVENT_ATTR_STR(_name, v, str)				\
+static struct perf_pmu_events_attr event_attr_##v = {			\
+	.attr		= __ATTR(_name, 0444, rapl_sysfs_show, NULL),	\
+	.id		= 0,						\
+	.event_str	= str,						\
+};
+
 struct rapl_pmu {
 	spinlock_t	 lock;
 	int		 hw_unit;  /* 1/2^hw_unit Joule */
@@ -383,23 +390,36 @@ static struct attribute_group rapl_pmu_attr_group = {
 	.attrs = rapl_pmu_attrs,
 };
 
-EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
-EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
-EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
-EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
+static ssize_t rapl_sysfs_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr = \
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	if (pmu_attr->event_str)
+		return sprintf(page, "%s", pmu_attr->event_str);
+
+	return 0;
+}
+
+RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
+RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
+RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
+RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
 
-EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
-EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
-EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
-EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
 
 /*
  * we compute in 0.23 nJ increments regardless of MSR
  */
-EVENT_ATTR_STR(energy-cores.scale, rapl_cores_scale, "2.3283064365386962890625e-10");
-EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890625e-10");
-EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
-EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-cores.scale, rapl_cores_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
 
 static struct attribute *rapl_events_srv_attr[] = {
 	EVENT_PTR(rapl_cores),
-- 
2.17.1

