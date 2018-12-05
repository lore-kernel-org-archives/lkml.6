Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20677C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1FA2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DQ10LFPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1FA2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeLERGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:06:31 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:51830 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeLERGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:06:30 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EE2EC10C1235;
        Wed,  5 Dec 2018 09:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544029590; bh=9nT6QQ5rsRwRFBO/YR35P7pf9IgPgW+HcfNTXboufWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQ10LFPo6/uRWTTfKM8mAhzMdIgHJ2e7Jv+UebyQMSrYyVG5kllOmJoZAjPhR5niX
         R8ZyvitgsgrWWIn8WG+Q3aJhevzUkyU34CBrYShGbrsBcJZ+oFq6t+ByI7YCbdH8al
         et2UURT/6RHnr3o0ERaFGQemxHyNB4l4y5c5VrspWdBNv2SebLAxyCvy/CsYpyv07Z
         licK2zefjC/xvFmSq2scBkd5vmcAeFj0eDvIkSEUGZdN4FTDC9p+xxBM9Pj1l8QNUb
         ha4YNH71Upy4UP70deb4R3V9LTZQw5H8k/eay2uGf0iVqWaOxX7KrG/Ia9MRUGnxLU
         K74Vc6YbD0pdA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8E3445912;
        Wed,  5 Dec 2018 09:06:26 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/5] ARC: perf: introduce Kernel PMU events support
Date:   Wed,  5 Dec 2018 20:06:06 +0300
Message-Id: <20181205170609.18690-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export all available ARC architected hardware events as
kernel PMU events to make non-generic events accessible.

ARC PMU HW allow us to read the list of all available
events names. So we generate kernel PMU event list
dynamically in arc_pmu_device_probe() using
human-readable events names we got from HW instead of
using pre-defined events list.

-------------------------->8--------------------------
$ perf list
  [snip]
  arc_pmu/bdata64/                  [Kernel PMU event]
  arc_pmu/bdcstall/                 [Kernel PMU event]
  arc_pmu/bdslot/                   [Kernel PMU event]
  arc_pmu/bfbmp/                    [Kernel PMU event]
  arc_pmu/bfirqex/                  [Kernel PMU event]
  arc_pmu/bflgstal/                 [Kernel PMU event]
  arc_pmu/bflush/                   [Kernel PMU event]
-------------------------->8--------------------------

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/perf_event.c | 107 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 811a07a2ca21..97b88b00c418 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -22,12 +22,28 @@
 /* HW holds 8 symbols + one for null terminator */
 #define ARCPMU_EVENT_NAME_LEN	9
 
+enum arc_pmu_attr_groups {
+	ARCPMU_ATTR_GR_EVENTS,
+	ARCPMU_ATTR_GR_FORMATS,
+	ARCPMU_NR_ATTR_GR
+};
+
+struct arc_pmu_raw_event_entry {
+	char name[ARCPMU_EVENT_NAME_LEN];
+};
+
 struct arc_pmu {
 	struct pmu	pmu;
 	unsigned int	irq;
 	int		n_counters;
+	int		n_events;
 	u64		max_period;
 	int		ev_hw_idx[PERF_COUNT_ARC_HW_MAX];
+
+	struct arc_pmu_raw_event_entry	*raw_entry;
+	struct attribute		**attrs;
+	struct perf_pmu_events_attr	*attr;
+	const struct attribute_group	*attr_groups[ARCPMU_NR_ATTR_GR + 1];
 };
 
 struct arc_pmu_cpu {
@@ -196,6 +212,17 @@ static int arc_pmu_event_init(struct perf_event *event)
 			 (int)hwc->config, arc_pmu_ev_hw_map[ret]);
 		return 0;
 
+	case PERF_TYPE_RAW:
+		if (event->attr.config >= arc_pmu->n_events)
+			return -ENOENT;
+
+		hwc->config |= event->attr.config;
+		pr_debug("init raw event with idx %lld \'%s\'\n",
+			 event->attr.config,
+			 arc_pmu->raw_entry[event->attr.config].name);
+
+		return 0;
+
 	default:
 		return -ENOENT;
 	}
@@ -446,6 +473,68 @@ static void arc_cpu_pmu_irq_init(void *data)
 	write_aux_reg(ARC_REG_PCT_INT_ACT, 0xffffffff);
 }
 
+/* Event field occupies the bottom 15 bits of our config field */
+PMU_FORMAT_ATTR(event, "config:0-14");
+static struct attribute *arc_pmu_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group arc_pmu_format_attr_gr = {
+	.name = "format",
+	.attrs = arc_pmu_format_attrs,
+};
+
+static ssize_t
+arc_pmu_events_sysfs_show(struct device *dev,
+			  struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sprintf(page, "event=0x%04llx\n", pmu_attr->id);
+}
+
+/*
+ * We don't add attrs here as we don't have pre-defined list of perf events.
+ * We will generate and add attrs dynamically in probe() after we read HW
+ * configuration.
+ */
+static struct attribute_group arc_pmu_events_attr_gr = {
+	.name = "events",
+};
+
+static void arc_pmu_add_raw_event_attr(int j, char *str)
+{
+	memmove(arc_pmu->raw_entry[j].name, str, ARCPMU_EVENT_NAME_LEN - 1);
+	arc_pmu->attr[j].attr.attr.name = arc_pmu->raw_entry[j].name;
+	arc_pmu->attr[j].attr.attr.mode = VERIFY_OCTAL_PERMISSIONS(0444);
+	arc_pmu->attr[j].attr.show = arc_pmu_events_sysfs_show;
+	arc_pmu->attr[j].id = j;
+	arc_pmu->attrs[j] = &(arc_pmu->attr[j].attr.attr);
+}
+
+static int arc_pmu_raw_alloc(struct device *dev)
+{
+	arc_pmu->attr = devm_kmalloc_array(dev, arc_pmu->n_events + 1,
+		sizeof(struct perf_pmu_events_attr), GFP_KERNEL | __GFP_ZERO);
+	if (!arc_pmu->attr)
+		return -ENOMEM;
+
+	arc_pmu->attrs = devm_kmalloc_array(dev, arc_pmu->n_events + 1,
+		sizeof(*arc_pmu->attrs), GFP_KERNEL | __GFP_ZERO);
+	if (!arc_pmu->attrs)
+		return -ENOMEM;
+
+	arc_pmu->raw_entry = devm_kmalloc_array(dev, arc_pmu->n_events,
+		sizeof(struct arc_pmu_raw_event_entry),
+		GFP_KERNEL | __GFP_ZERO);
+	if (!arc_pmu->raw_entry)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int arc_pmu_device_probe(struct platform_device *pdev)
 {
 	struct arc_reg_pct_build pct_bcr;
@@ -477,6 +566,11 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	if (!arc_pmu)
 		return -ENOMEM;
 
+	arc_pmu->n_events = cc_bcr.c;
+
+	if (arc_pmu_raw_alloc(&pdev->dev))
+		return -ENOMEM;
+
 	has_interrupts = is_isa_arcv2() ? pct_bcr.i : 0;
 
 	arc_pmu->n_counters = pct_bcr.c;
@@ -508,8 +602,14 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 				arc_pmu->ev_hw_idx[i] = j;
 			}
 		}
+
+		arc_pmu_add_raw_event_attr(j, cc_name.str);
 	}
 
+	arc_pmu_events_attr_gr.attrs = arc_pmu->attrs;
+	arc_pmu->attr_groups[ARCPMU_ATTR_GR_EVENTS] = &arc_pmu_events_attr_gr;
+	arc_pmu->attr_groups[ARCPMU_ATTR_GR_FORMATS] = &arc_pmu_format_attr_gr;
+
 	arc_pmu->pmu = (struct pmu) {
 		.pmu_enable	= arc_pmu_enable,
 		.pmu_disable	= arc_pmu_disable,
@@ -519,6 +619,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 		.start		= arc_pmu_start,
 		.stop		= arc_pmu_stop,
 		.read		= arc_pmu_read,
+		.attr_groups	= arc_pmu->attr_groups,
 	};
 
 	if (has_interrupts) {
@@ -540,7 +641,11 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	} else
 		arc_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
 
-	return perf_pmu_register(&arc_pmu->pmu, pdev->name, PERF_TYPE_RAW);
+	/*
+	 * perf parser doesn't really like '-' symbol in events name, so let's
+	 * use '_' in arc pmu name as it goes to kernel PMU event prefix.
+	 */
+	return perf_pmu_register(&arc_pmu->pmu, "arc_pmu", PERF_TYPE_RAW);
 }
 
 #ifdef CONFIG_OF
-- 
2.14.5

