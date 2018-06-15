Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CE634C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853B620891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853B620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965435AbeFOCKE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:10:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:54467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965072AbeFOCKB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:10:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 19:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="49141588"
Received: from skl.sh.intel.com ([10.239.161.125])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2018 19:09:59 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        me@kylehuey.com
Cc:     Linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        will.deacon@arm.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping leaked kernel samples
Date:   Fri, 15 Jun 2018 18:03:22 +0800
Message-Id: <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing sampling, for example:

perf record -e cycles:u ...

On workloads that do a lot of kernel entry/exits we see kernel
samples, even though :u is specified. This is due to skid existing.

This might be a security issue because it can leak kernel addresses even
though kernel sampling support is disabled.

One patch "perf/core: Drop kernel samples even though :u is specified"
was posted in last year but it was reverted because it introduced a
regression issue that broke the rr-project, which used sampling
events to receive a signal on overflow. These signals were critical
to the correct operation of rr.

See '6a8a75f32357 ("Revert "perf/core: Drop kernel samples even
though :u is specified"")' for detail.

Now the idea is to use sysctl to control the dropping of leaked
kernel samples.

/sys/devices/cpu/perf_allow_sample_leakage:

0 - default, drop the leaked kernel samples.
1 - don't drop the leaked kernel samples.

For rr it can write 1 to /sys/devices/cpu/perf_allow_sample_leakage.

For example,

root@skl:/tmp# cat /sys/devices/cpu/perf_allow_sample_leakage
0
root@skl:/tmp# perf record -e cycles:u ./div
root@skl:/tmp# perf report --stdio

........  .......  .............  ................

    47.01%  div      div            [.] main
    20.74%  div      libc-2.23.so   [.] __random_r
    15.59%  div      libc-2.23.so   [.] __random
     8.68%  div      div            [.] compute_flag
     4.48%  div      libc-2.23.so   [.] rand
     3.50%  div      div            [.] rand@plt
     0.00%  div      ld-2.23.so     [.] do_lookup_x
     0.00%  div      ld-2.23.so     [.] memcmp
     0.00%  div      ld-2.23.so     [.] _dl_start
     0.00%  div      ld-2.23.so     [.] _start

There is no kernel symbol reported.

root@skl:/tmp# echo 1 > /sys/devices/cpu/perf_allow_sample_leakage
root@skl:/tmp# cat /sys/devices/cpu/perf_allow_sample_leakage
1
root@skl:/tmp# perf record -e cycles:u ./div
root@skl:/tmp# perf report --stdio

........  .......  ................  .............

    47.53%  div      div               [.] main
    20.62%  div      libc-2.23.so      [.] __random_r
    15.32%  div      libc-2.23.so      [.] __random
     8.66%  div      div               [.] compute_flag
     4.53%  div      libc-2.23.so      [.] rand
     3.34%  div      div               [.] rand@plt
     0.00%  div      [kernel.vmlinux]  [k] apic_timer_interrupt
     0.00%  div      libc-2.23.so      [.] intel_check_word
     0.00%  div      ld-2.23.so        [.] brk
     0.00%  div      [kernel.vmlinux]  [k] page_fault
     0.00%  div      ld-2.23.so        [.] _start

We can see the kernel symbols apic_timer_interrupt and page_fault.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 kernel/events/core.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80cca2b..7867541 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7721,6 +7721,28 @@ int perf_event_account_interrupt(struct perf_event *event)
 	return __perf_event_account_interrupt(event, 1);
 }
 
+static int perf_allow_sample_leakage __read_mostly;
+
+static bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
+{
+	int allow_leakage = READ_ONCE(perf_allow_sample_leakage);
+
+	if (allow_leakage)
+		return true;
+
+	/*
+	 * Due to interrupt latency (AKA "skid"), we may enter the
+	 * kernel before taking an overflow, even if the PMU is only
+	 * counting user events.
+	 * To avoid leaking information to userspace, we must always
+	 * reject kernel samples when exclude_kernel is set.
+	 */
+	if (event->attr.exclude_kernel && !user_mode(regs))
+		return false;
+
+	return true;
+}
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -7742,6 +7764,12 @@ static int __perf_event_overflow(struct perf_event *event,
 	ret = __perf_event_account_interrupt(event, throttle);
 
 	/*
+	 * For security, drop the skid kernel samples if necessary.
+	 */
+	if (!sample_is_allowed(event, regs))
+		return ret;
+
+	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
 	 */
@@ -9500,9 +9528,39 @@ perf_event_mux_interval_ms_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
 
+static ssize_t
+perf_allow_sample_leakage_show(struct device *dev,
+			       struct device_attribute *attr, char *page)
+{
+	int allow_leakage = READ_ONCE(perf_allow_sample_leakage);
+
+	return snprintf(page, PAGE_SIZE-1, "%d\n", allow_leakage);
+}
+
+static ssize_t
+perf_allow_sample_leakage_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int allow_leakage, ret;
+
+	ret = kstrtoint(buf, 0, &allow_leakage);
+	if (ret)
+		return ret;
+
+	if (allow_leakage != 0 && allow_leakage != 1)
+		return -EINVAL;
+
+	WRITE_ONCE(perf_allow_sample_leakage, allow_leakage);
+
+	return count;
+}
+static DEVICE_ATTR_RW(perf_allow_sample_leakage);
+
 static struct attribute *pmu_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_perf_event_mux_interval_ms.attr,
+	&dev_attr_perf_allow_sample_leakage.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(pmu_dev);
-- 
2.7.4

