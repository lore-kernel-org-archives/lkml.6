Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBF6C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB8424838
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JGWzeq8u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bDHD74TK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB8424838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934582AbeFVTtt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:49:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934499AbeFVTtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:49:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9654C60B23; Fri, 22 Jun 2018 19:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529696959;
        bh=AH8T3jo+B+L+PGietlvIy1LRfolwVcoS5IPo5cxCCY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGWzeq8uQJy7/0v3EZceHlfBMoi7x5k6d/wajm9vKWArTBUEZVhXNPI5FRL1s48B6
         x1iW9mCMZwJF/rzWcahOJue34fCdZo0sO9RuZG+rBIB9ybygwtoCh++6OKlmu8jed9
         Bc2OaQWV1YK23Yp5cfHfcWG+hJYG5yo/IYRs7jGo=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3613A60B11;
        Fri, 22 Jun 2018 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529696958;
        bh=AH8T3jo+B+L+PGietlvIy1LRfolwVcoS5IPo5cxCCY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDHD74TKvYxzrGrDPBBTHkQflI6j5OlTsPUn0xYDAiEuPtnLSrho4Cs2b6H1smQJ2
         T5DeGCC5lppfA9zvLKG18tSxOvtvHo8cRCXCzDHV5t6CQnMzaBZvDaJ5sCe7axIoRR
         XCxZ3XxViEyp9vYJk2NxT8fwUrm13FtCqtaF/qek=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3613A60B11
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From:   Agustin Vega-Frias <agustinv@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     timur@codeaurora.org, agustinv@codeaurora.org
Subject: [RFC V3 2/3] arm_pmu: acpi: add support for CPU PMU variant detection
Date:   Fri, 22 Jun 2018 15:49:07 -0400
Message-Id: <1529696948-16991-2-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529696948-16991-1-git-send-email-agustinv@codeaurora.org>
References: <1529696948-16991-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT allows CPU PMU variant detection via the PMU device compatible
property. ACPI does not have an equivalent mechanism so we introduce
a probe table to allow this via a device nested inside the CPU device
in the DSDT:

Device (CPU0)
{
    Name (_HID, "ACPI0007" /* Processor Device */)
    ...
    Device (PMU0)
    {
        Name (_HID, "QCOM8150") /* Qualcomm Falkor PMU device */

        /*
         * The device might also contain _DSD properties to indicate other
         * IMPLEMENTATION DEFINED PMU features.
         */
        Name (_DSD, Package ()
        {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package ()
            {
                ...
            }
        })
    }
}

With this in place we can declare the variant:

    ACPI_DECLARE_PMU_VARIANT(qcom_falkor, "QCOM8150", falkor_pmu_init);

The init function is called after the default PMU initialization and is
passed a pointer to the arm_pmu structure and a pointer to the PMU device.
The init function can then override arm_pmu callbacks and attributes and
query more properties from the PMU device.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/perf/arm_pmu_acpi.c       | 27 +++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/acpi.h              | 11 +++++++++++
 include/linux/perf/arm_pmu.h      |  1 +
 4 files changed, 40 insertions(+)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 0f19751..6b0ca71 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -220,6 +220,26 @@ static int arm_pmu_acpi_cpu_starting(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * Check if the given child device of the CPU device matches a PMU variant
+ * device declared with ACPI_DECLARE_PMU_VARIANT, if so, pass the arm_pmu
+ * structure and the matching device for further initialization.
+ */
+static int arm_pmu_variant_init(struct device *dev, void *data)
+{
+	extern struct acpi_device_id ACPI_PROBE_TABLE(pmu);
+	unsigned int cpu = *((unsigned int *)data);
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(&ACPI_PROBE_TABLE(pmu), dev);
+	if (id) {
+		armpmu_acpi_init_fn fn = (armpmu_acpi_init_fn)id->driver_data;
+
+		return fn(per_cpu(probed_pmus, cpu), dev);
+	}
+	return 0;
+}
+
 int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 {
 	int pmu_idx = 0;
@@ -240,6 +260,7 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct arm_pmu *pmu = per_cpu(probed_pmus, cpu);
+		struct device *dev = get_cpu_device(cpu);
 		char *base_name;
 
 		if (!pmu || pmu->name)
@@ -254,6 +275,10 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 			return ret;
 		}
 
+		ret = device_for_each_child(dev, &cpu, arm_pmu_variant_init);
+		if (ret == -ENODEV)
+			pr_warn("Failed PMU re-init, fallback to plain PMUv3");
+
 		base_name = pmu->name;
 		pmu->name = kasprintf(GFP_KERNEL, "%s_%d", base_name, pmu_idx++);
 		if (!pmu->name) {
@@ -290,3 +315,5 @@ static int arm_pmu_acpi_init(void)
 	return ret;
 }
 subsys_initcall(arm_pmu_acpi_init)
+
+ACPI_DECLARE_PMU_SENTINEL();
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5894049..f1be62a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -600,6 +600,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
+	ACPI_PROBE_TABLE(pmu)						\
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 15bfb15..9c410cf 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1153,6 +1153,17 @@ struct acpi_probe_entry {
 					  (&ACPI_PROBE_TABLE_END(t) -	\
 					   &ACPI_PROBE_TABLE(t)));	\
 	})
+
+#define ACPI_DECLARE_PMU_VARIANT(name, hid, init_fn)			\
+	static const struct acpi_device_id __acpi_probe_##name		\
+		__used __section(__pmu_acpi_probe_table)		\
+		= { .id = hid, .driver_data = (kernel_ulong_t)init_fn }
+
+#define ACPI_DECLARE_PMU_SENTINEL()					\
+	static const struct acpi_device_id __acpi_probe_sentinel	\
+		__used __section(__pmu_acpi_probe_table_end)		\
+		= { .id = "", .driver_data = 0 }
+
 #else
 static inline int acpi_dev_get_property(struct acpi_device *adev,
 					const char *name, acpi_object_type type,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 40036a5..ff43d65 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -123,6 +123,7 @@ int armpmu_map_event(struct perf_event *event,
 		     u32 raw_event_mask);
 
 typedef int (*armpmu_init_fn)(struct arm_pmu *);
+typedef int (*armpmu_acpi_init_fn)(struct arm_pmu *, struct device *);
 
 struct pmu_probe_info {
 	unsigned int cpuid;
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

